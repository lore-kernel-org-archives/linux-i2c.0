From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: davinci: Rework racy ISR
Date: Thu, 12 Mar 2015 15:16:27 +0200
Message-ID: <550191AB.8000103@linaro.org>
References: <55003E64.2030701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55003E64.2030701-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/11/2015 03:08 PM, Alexander Sverdlin wrote:
> There is one big problem in the current design: ISR accesses the controller
> registers in parallel with i2c_davinci_xfer_msg() in process context. The whole
> logic is not obvious, many operations are performed in process context while
> ISR is always enabled and does something asynchronous even while it's not
> expected. We have faced these races on 4-cores Keystone chip. Some examples:
> 
> - when non-existing device is accessed first comes NAK IRQ, then ARDY IRQ. After
>    NAK we already jump out of wait_for_completion_timeout() and depending on how
>    lucky we are ARDY IRQ will access MDR register in the middle of some other
>    operation in process context;
> 
> - STOP condition is triggered in many places in the driver, in ISR, in
>    i2c_davinci_xfer_msg(), but there is no code which guarantees that STOP will
>    be really completed. We have seen many STOP conditions simply missing in
>    back-to-back transfers, when next i2c_davinci_xfer_msg() call simply overwrites
>    MDR register while STOP is still not generated.
> 
> So, make the design more robust and obvious:
> - leave hot path (buffers management) in ISR, remove other registers access from
>    ISR;
> - introduce second synchronization point, to make sure that STOP condition is
>    really generated and it's safe to begin next transfer;
> - simplify the state machine;
> - enable IRQs only when they are expected, disable them in ISR when transfer is
>    completed/failed;
> - STOP is normally set simultaneously with START condition (in case of last
>    message); only special case when STOP is additionally generated is received NAK
>    -- this case is handled separately.

I'm not sure about this change (- It's too significant and definitely will need more review & Tested-by.
We need to be careful with it, especially taking into account DAVINCI_I2C_MDR_RM mode and future
changes like https://lkml.org/lkml/2014/5/1/348.

May be you can split it?

> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-davinci.c |  219 ++++++++++++++++---------------------
>   1 files changed, 95 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 6dc7ff5..98759ae 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -72,10 +72,19 @@
>   #define DAVINCI_I2C_STR_BB	BIT(12)
>   #define DAVINCI_I2C_STR_RSFULL	BIT(11)
>   #define DAVINCI_I2C_STR_SCD	BIT(5)
> +#define DAVINCI_I2C_STR_ICXRDY	BIT(4)
> +#define DAVINCI_I2C_STR_ICRDRDY	BIT(3)
>   #define DAVINCI_I2C_STR_ARDY	BIT(2)
>   #define DAVINCI_I2C_STR_NACK	BIT(1)
>   #define DAVINCI_I2C_STR_AL	BIT(0)
>   
> +#define DAVINCI_I2C_STR_ALL	(DAVINCI_I2C_STR_SCD | \
> +				 DAVINCI_I2C_STR_ICXRDY | \
> +				 DAVINCI_I2C_STR_ICRDRDY | \
> +				 DAVINCI_I2C_STR_ARDY | \
> +				 DAVINCI_I2C_STR_NACK | \
> +				 DAVINCI_I2C_STR_AL)
> +
>   #define DAVINCI_I2C_MDR_NACK	BIT(15)
>   #define DAVINCI_I2C_MDR_STT	BIT(13)
>   #define DAVINCI_I2C_MDR_STP	BIT(11)
> @@ -98,12 +107,10 @@ struct davinci_i2c_dev {
>   	void __iomem		*base;
>   	struct completion	cmd_complete;
>   	struct clk              *clk;
> -	int			cmd_err;
> +	u32			cmd_stat;
>   	u8			*buf;
>   	size_t			buf_len;
>   	int			irq;
> -	int			stop;
> -	u8			terminate;
>   	struct i2c_adapter	adapter;
>   #ifdef CONFIG_CPU_FREQ
>   	struct completion	xfr_complete;
> @@ -256,9 +263,6 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>   	/* Take the I2C module out of reset: */
>   	davinci_i2c_reset_ctrl(dev, 1);
>   
> -	/* Enable interrupts */
> -	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, I2C_DAVINCI_INTR_ALL);
> -
>   	return 0;
>   }
>   
> @@ -293,6 +297,36 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
>   	return 0;
>   }
>   
> +static int i2c_davinci_wait_for_completion(struct davinci_i2c_dev *dev)
> +{
> +	int r;
> +
> +	r = wait_for_completion_timeout(&dev->cmd_complete, dev->adapter.timeout);
> +	if (r == 0) {
> +		/* Disable IRQ, sources were NOT masked by the handler */
> +		disable_irq(dev->irq);
> +
> +		dev_err(dev->dev, "controller timed out\n");
> +		davinci_i2c_recover_bus(dev);
> +		i2c_davinci_init(dev);
> +
> +		/* It's safe to enable IRQ after reset */
> +		enable_irq(dev->irq);
> +
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* If it wasn't a timeout, then the IRQs are masked */
> +
> +	if (r < 0) {
> +		dev_err(dev->dev, "abnormal termination buf_len=%i\n",
> +		        dev->buf_len);
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Low level master read/write transaction. This function is called
>    * from i2c_davinci_xfer.
> @@ -315,12 +349,10 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>   
>   	dev->buf = msg->buf;
>   	dev->buf_len = msg->len;
> -	dev->stop = stop;
>   
>   	davinci_i2c_write_reg(dev, DAVINCI_I2C_CNT_REG, dev->buf_len);
>   
>   	reinit_completion(&dev->cmd_complete);
> -	dev->cmd_err = 0;
>   
>   	/* Take I2C out of reset and configure it as master */
>   	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST;
> @@ -333,16 +365,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>   	if (msg->len == 0)
>   		flag |= DAVINCI_I2C_MDR_RM;
>   
> -	/* Enable receive or transmit interrupts */
> -	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> -	if (msg->flags & I2C_M_RD)
> -		w |= DAVINCI_I2C_IMR_RRDY;
> -	else
> -		w |= DAVINCI_I2C_IMR_XRDY;
> -	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
> -
> -	dev->terminate = 0;
> -
>   	/*
>   	 * Write mode register first as needed for correct behaviour
>   	 * on OMAP-L138, but don't set STT yet to avoid a race with XRDY
> @@ -350,6 +372,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>   	 */
>   	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>   
> +	/* Clear IRQ flags */
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_ALL);
> +
>   	/*
>   	 * First byte should be set here, not after interrupt,
>   	 * because transmit-data-ready interrupt can come before
> @@ -368,49 +393,48 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>   		flag |= DAVINCI_I2C_MDR_STP;
>   	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>   
> -	r = wait_for_completion_timeout(&dev->cmd_complete, dev->adapter.timeout);
> -	if (r == 0) {
> -		dev_err(dev->dev, "controller timed out\n");
> -		davinci_i2c_recover_bus(dev);
> -		i2c_davinci_init(dev);
> -		dev->buf_len = 0;
> -		return -ETIMEDOUT;
> -	}
> -	if (dev->buf_len) {
> -		/* This should be 0 if all bytes were transferred
> -		 * or dev->cmd_err denotes an error.
> -		 */
> -		if (r >= 0) {
> -			dev_err(dev->dev, "abnormal termination buf_len=%i\n",
> -				dev->buf_len);
> -			r = -EREMOTEIO;
> -		}
> -		dev->terminate = 1;
> -		wmb();
> -		dev->buf_len = 0;
> -	}
> -	if (r < 0)
> +	/* Enable status interrupts */
> +	w = I2C_DAVINCI_INTR_ALL;
> +	/* Enable receive or transmit interrupts */
> +	if (msg->flags & I2C_M_RD)
> +		w |= DAVINCI_I2C_IMR_RRDY;
> +	else
> +		w |= DAVINCI_I2C_IMR_XRDY;
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
> +
> +	r = i2c_davinci_wait_for_completion(dev);
> +	if (r)
>   		return r;
>   
> -	/* no error */
> -	if (likely(!dev->cmd_err))
> +	switch (dev->cmd_stat) {
> +	case DAVINCI_I2C_IVR_SCD:
> +	case DAVINCI_I2C_IVR_ARDY:
>   		return msg->len;
>   
> -	/* We have an error */
> -	if (dev->cmd_err & DAVINCI_I2C_STR_AL) {
> +	case DAVINCI_I2C_IVR_AL:
>   		i2c_davinci_init(dev);
>   		return -EIO;
>   	}
>   
> -	if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
> -		if (msg->flags & I2C_M_IGNORE_NAK)
> -			return msg->len;
> -		w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> -		w |= DAVINCI_I2C_MDR_STP;
> -		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> -		return -EREMOTEIO;
> -	}
> -	return -EIO;
> +	/* We are here because of NAK */
> +
> +	if (msg->flags & I2C_M_IGNORE_NAK)
> +		return msg->len;
> +
> +	reinit_completion(&dev->cmd_complete);
> +	/* Clear IRQ flags */
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_ALL);
> +	/* We going to wait for SCD IRQ */
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, I2C_DAVINCI_INTR_ALL);
> +
> +	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> +	w |= DAVINCI_I2C_MDR_STP;
> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> +
> +	r = i2c_davinci_wait_for_completion(dev);
> +	if (r)
> +		return r;
> +	return -EREMOTEIO;
>   }
>   
>   /*
> @@ -451,27 +475,6 @@ static u32 i2c_davinci_func(struct i2c_adapter *adap)
>   	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>   }
>   
> -static void terminate_read(struct davinci_i2c_dev *dev)
> -{
> -	u16 w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> -	w |= DAVINCI_I2C_MDR_NACK;
> -	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> -
> -	/* Throw away data */
> -	davinci_i2c_read_reg(dev, DAVINCI_I2C_DRR_REG);
> -	if (!dev->terminate)
> -		dev_err(dev->dev, "RDR IRQ while no data requested\n");
> -}
> -static void terminate_write(struct davinci_i2c_dev *dev)
> -{
> -	u16 w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> -	w |= DAVINCI_I2C_MDR_RM | DAVINCI_I2C_MDR_STP;
> -	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> -
> -	if (!dev->terminate)
> -		dev_dbg(dev->dev, "TDR IRQ while no data to send\n");
> -}
> -
>   /*
>    * Interrupt service routine. This gets called whenever an I2C interrupt
>    * occurs.
> @@ -491,49 +494,19 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>   		}
>   
>   		switch (stat) {
> -		case DAVINCI_I2C_IVR_AL:
> -			/* Arbitration lost, must retry */
> -			dev->cmd_err |= DAVINCI_I2C_STR_AL;
> -			dev->buf_len = 0;
> -			complete(&dev->cmd_complete);
> -			break;
> -
> -		case DAVINCI_I2C_IVR_NACK:
> -			dev->cmd_err |= DAVINCI_I2C_STR_NACK;
> -			dev->buf_len = 0;
> -			complete(&dev->cmd_complete);
> -			break;
> -
> -		case DAVINCI_I2C_IVR_ARDY:
> -			davinci_i2c_write_reg(dev,
> -				DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_ARDY);
> -			if (((dev->buf_len == 0) && (dev->stop != 0)) ||
> -			    (dev->cmd_err & DAVINCI_I2C_STR_NACK)) {
> -				w = davinci_i2c_read_reg(dev,
> -							 DAVINCI_I2C_MDR_REG);
> -				w |= DAVINCI_I2C_MDR_STP;
> -				davinci_i2c_write_reg(dev,
> -						      DAVINCI_I2C_MDR_REG, w);
> -			}
> -			complete(&dev->cmd_complete);
> -			break;
> -
>   		case DAVINCI_I2C_IVR_RDR:
>   			if (dev->buf_len) {
>   				*dev->buf++ =
>   				    davinci_i2c_read_reg(dev,
>   							 DAVINCI_I2C_DRR_REG);
>   				dev->buf_len--;
> -				if (dev->buf_len)
> -					continue;
> -
> -				davinci_i2c_write_reg(dev,
> -					DAVINCI_I2C_STR_REG,
> -					DAVINCI_I2C_IMR_RRDY);
> -			} else {
> -				/* signal can terminate transfer */
> -				terminate_read(dev);
> +				continue;
>   			}
> +
> +			/* Read transfer completed, mask the IRQ */
> +			w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> +			w &= ~DAVINCI_I2C_IMR_RRDY;
> +			davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
>   			break;
>   
>   		case DAVINCI_I2C_IVR_XRDY:
> @@ -541,24 +514,22 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>   				davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG,
>   						      *dev->buf++);
>   				dev->buf_len--;
> -				if (dev->buf_len)
> -					continue;
> -
> -				w = davinci_i2c_read_reg(dev,
> -							 DAVINCI_I2C_IMR_REG);
> -				w &= ~DAVINCI_I2C_IMR_XRDY;
> -				davinci_i2c_write_reg(dev,
> -						      DAVINCI_I2C_IMR_REG,
> -						      w);
> -			} else {
> -				/* signal can terminate transfer */
> -				terminate_write(dev);
> +				continue;
>   			}
> +
> +			/* Write transfer completed, mask the IRQ */
> +			w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> +			w &= ~DAVINCI_I2C_IMR_XRDY;
> +			davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
>   			break;
>   
> +		case DAVINCI_I2C_IVR_AL:
> +		case DAVINCI_I2C_IVR_NACK:
>   		case DAVINCI_I2C_IVR_SCD:
> -			davinci_i2c_write_reg(dev,
> -				DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_SCD);
> +		case DAVINCI_I2C_IVR_ARDY:
> +			dev->cmd_stat = stat;
> +			/* Mask all IRQs */
> +			davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, 0);
>   			complete(&dev->cmd_complete);
>   			break;
>   
> 


-- 
regards,
-grygorii
