From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c: davinci: Fix smbus Oops with AIC33 usage
Date: Wed, 27 Jan 2010 15:03:41 +0000
Message-ID: <20100127150341.GA6090@fluff.org.uk>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
 <1264549293-25556-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1264549293-25556-2-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Dirk Behme <dirk.behme-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Alexander Vasiliev <alexvasiljev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 26, 2010 at 03:41:28PM -0800, Kevin Hilman wrote:
> From: Dirk Behme <dirk.behme-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> This fixes Oops at kernel startup while "scanning" for TLV320AIC23IDx
> addresses.
> 
> Signed-off-by: Alexander Vasiliev <alexvasiljev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |   29 +++++++++++++++++++++++++----
>  1 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index c89687a..444a9f2 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -112,6 +112,7 @@ struct davinci_i2c_dev {
>  	u8			*buf;
>  	size_t			buf_len;
>  	int			irq;
> +	int			stop;
>  	u8			terminate;
>  	struct i2c_adapter	adapter;
>  };
> @@ -249,9 +250,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	u16 w;
>  	int r;
>  
> -	if (msg->len == 0)
> -		return -EINVAL;
> -
>  	if (!pdata)
>  		pdata = &davinci_i2c_platform_data_default;
>  	/* Introduce a delay, required for some boards (e.g Davinci EVM) */
> @@ -263,6 +261,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  
>  	dev->buf = msg->buf;
>  	dev->buf_len = msg->len;
> +	dev->stop = stop;
>  
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CNT_REG, dev->buf_len);
>  
> @@ -280,6 +279,10 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  		flag |= DAVINCI_I2C_MDR_TRX;
>  	if (stop)
>  		flag |= DAVINCI_I2C_MDR_STP;
> +	if (msg->len == 0) {
> +		flag |= DAVINCI_I2C_MDR_RM;
> +		flag &= ~DAVINCI_I2C_MDR_STP;
> +	}
>  
>  	/* Enable receive or transmit interrupts */
>  	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> @@ -290,6 +293,16 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
>  
>  	dev->terminate = 0;
> +
> +	/* First byte should be set here, not after interrupt,
> +	 * because transmit-data-ready interrupt can come before
> +	 * NACK-interrupt during sending of previous message and
> +	 * ICDXR may have wrong data */
> +	if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
> +		dev->buf_len--;
> +	}
> +
>  	/* write the data into mode register */
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>  
> @@ -371,7 +384,7 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  static u32 i2c_davinci_func(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
>  
>  static void terminate_read(struct davinci_i2c_dev *dev)
> @@ -430,6 +443,14 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>  		case DAVINCI_I2C_IVR_ARDY:
>  			davinci_i2c_write_reg(dev,
>  				DAVINCI_I2C_STR_REG, DAVINCI_I2C_STR_ARDY);
> +			if (((dev->buf_len == 0) && (dev->stop != 0)) ||

technically you don't need () around simple tests...

> +			    (dev->cmd_err & DAVINCI_I2C_STR_NACK)) {
> +				w = davinci_i2c_read_reg(dev,
> +							 DAVINCI_I2C_MDR_REG);
> +				w |= DAVINCI_I2C_MDR_STP;
> +				davinci_i2c_write_reg(dev,
> +						      DAVINCI_I2C_MDR_REG, w);
> +			}
>  			complete(&dev->cmd_complete);
>  			break;
>  
> -- 
> 1.6.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
