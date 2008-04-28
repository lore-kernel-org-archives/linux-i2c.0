From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/5] I2C: DaVinci: fix signal handling bug
Date: Mon, 28 Apr 2008 19:13:32 +0200
Message-ID: <20080428191332.371e35e3@hyperion.delvare>
References: <1209142694-30046-1-git-send-email-troy.kisky@boundarydevices.com>
	<1209142694-30046-2-git-send-email-troy.kisky@boundarydevices.com>
	<1209142694-30046-3-git-send-email-troy.kisky@boundarydevices.com>
	<1209142694-30046-4-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1209142694-30046-4-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Troy,

On Fri, 25 Apr 2008 09:58:13 -0700, Troy Kisky wrote:
> If wait_for_completion_interruptible_timeout exits due
> to a signal, the i2c bus was locking up.

What kind of signal (coming from where) are you talking about?

If you don't want to be interrupted, why don't you simply use
wait_for_completion_timeout() instead of
wait_for_completion_interruptible_timeout()?

> 
> Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |   66 +++++++++++++++++++++++++++++++-------
>  1 files changed, 54 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index d9752ae..6719cdb 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -85,6 +85,7 @@
>  #define DAVINCI_I2C_MDR_MST	(1 << 10)
>  #define DAVINCI_I2C_MDR_TRX	(1 << 9)
>  #define DAVINCI_I2C_MDR_XA	(1 << 8)
> +#define DAVINCI_I2C_MDR_RM	(1 << 7)
>  #define DAVINCI_I2C_MDR_IRS	(1 << 5)
>  
>  #define DAVINCI_I2C_IMR_AAS	(1 << 6)
> @@ -112,6 +113,7 @@ struct davinci_i2c_dev {
>  	u8			*buf;
>  	size_t			buf_len;
>  	int			irq;
> +	u8			terminate;
>  	struct i2c_adapter	adapter;
>  };
>  
> @@ -283,20 +285,31 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  		MOD_REG_BIT(w, DAVINCI_I2C_IMR_XRDY, 1);
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
>  
> +	dev->terminate = 0;
>  	/* write the data into mode register */
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>  
>  	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
>  						      DAVINCI_I2C_TIMEOUT);
> -	dev->buf_len = 0;
> -	if (r < 0)
> -		return r;
> -
>  	if (r == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
>  		i2c_davinci_init(dev);
> +		dev->buf = NULL;
>  		return -ETIMEDOUT;
>  	}
> +	if (dev->buf_len) {
> +		/* signal may have aborted the transfer */
> +		if (r >= 0) {
> +			dev_err(dev->dev, "abnormal termination buf_len=%i\n",
> +				dev->buf_len);
> +			r = -EREMOTEIO;
> +		}
> +		dev->terminate = 1;
> +		wmb();
> +		dev->buf = NULL;
> +	}
> +	if (r < 0)
> +		return r;
>  
>  	/* no error */
>  	if (likely(!dev->cmd_err))
> @@ -353,6 +366,30 @@ static u32 i2c_davinci_func(struct i2c_adapter *adap)
>  	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
>  }
>  
> +static inline void terminate_read(struct davinci_i2c_dev *dev)
> +{
> +	if (dev->buf_len)
> +		dev->buf_len--;
> +	if (dev->buf_len) {

Please explain (in a comment) what you are doing here. Can't you just
test for (dev->buf_len > 1)?

> +		u16 w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> +		w |= DAVINCI_I2C_MDR_NACK;
> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> +	}
> +	/* Throw away data */
> +	davinci_i2c_read_reg(dev, DAVINCI_I2C_DRR_REG);
> +	if (!dev->terminate)
> +		dev_err(dev->dev, "RDR IRQ while no data requested\n");
> +}
> +static inline void terminate_write(struct davinci_i2c_dev *dev)
> +{
> +	u16 w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> +	w |= DAVINCI_I2C_MDR_RM|DAVINCI_I2C_MDR_STP;

Coding-style: spaces around |.

> +	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> +
> +	if (!dev->terminate)
> +		dev_err(dev->dev, "TDR IRQ while no data to send\n");
> +}

I don't see the point of inlining these functions explicitly... They
are only called in an unlikely event so this is certainly not
performance-critical.

> +
>  /*
>   * Interrupt service routine. This gets called whenever an I2C interrupt
>   * occurs.
> @@ -373,12 +410,15 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>  
>  		switch (stat) {
>  		case DAVINCI_I2C_IVR_AL:
> +			/* Arbitration lost, must retry */
>  			dev->cmd_err |= DAVINCI_I2C_STR_AL;
> +			dev->buf_len = 0;
>  			complete(&dev->cmd_complete);
>  			break;
>  
>  		case DAVINCI_I2C_IVR_NACK:
>  			dev->cmd_err |= DAVINCI_I2C_STR_NACK;
> +			dev->buf_len = 0;
>  			complete(&dev->cmd_complete);
>  			break;
>  
> @@ -389,7 +429,7 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>  			break;
>  
>  		case DAVINCI_I2C_IVR_RDR:
> -			if (dev->buf_len) {
> +			if (dev->buf && dev->buf_len) {
>  				*dev->buf++ =
>  				    davinci_i2c_read_reg(dev,
>  							 DAVINCI_I2C_DRR_REG);
> @@ -400,13 +440,14 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>  				davinci_i2c_write_reg(dev,
>  					DAVINCI_I2C_STR_REG,
>  					DAVINCI_I2C_IMR_RRDY);
> -			} else
> -				dev_err(dev->dev, "RDR IRQ while no "
> -					"data requested\n");
> +			} else {
> +				/* signal can terminate transfer */
> +				terminate_read(dev);
> +			}
>  			break;
>  
>  		case DAVINCI_I2C_IVR_XRDY:
> -			if (dev->buf_len) {
> +			if (dev->buf && dev->buf_len) {
>  				davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG,
>  						      *dev->buf++);
>  				dev->buf_len--;
> @@ -419,9 +460,10 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>  				davinci_i2c_write_reg(dev,
>  						      DAVINCI_I2C_IMR_REG,
>  						      w);
> -			} else
> -				dev_err(dev->dev, "TDR IRQ while no data to "
> -					"send\n");
> +			} else {
> +				/* signal can terminate transfer */
> +				terminate_write(dev);
> +			}
>  			break;
>  
>  		case DAVINCI_I2C_IVR_SCD:

Apparently you are using dev->buf_len = 0 and dev->buf = NULL to notify
particular conditions accross the driver? This should be clearly
documented, otherwise other developers are likely to break the driver
while working on it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
