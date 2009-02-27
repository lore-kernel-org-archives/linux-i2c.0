From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V2 1/3] i2c/algo-pca: rework waiting for a free bus
Date: Fri, 27 Feb 2009 11:59:10 +0100
Message-ID: <20090227115910.55a2f164@hyperion.delvare>
References: <1235492536-31695-1-git-send-email-w.sang@pengutronix.de>
	<1235492536-31695-2-git-send-email-w.sang@pengutronix.de>
	<20090226181447.35775a21@hyperion.delvare>
	<20090227084412.GA3481@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090227084412.GA3481-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 27 Feb 2009 09:44:12 +0100, Wolfram Sang wrote:
> 
> Waiting for a free bus now accepts the timeout value in jiffies and does
> proper checking using time_before.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
> changes since V1:
> 
> * fix user sh7785lcr
> * break >80 chars
> 
>  arch/sh/boards/board-sh7785lcr.c |    2 +-
>  drivers/i2c/algos/i2c-algo-pca.c |   19 +++++++++++--------
>  drivers/i2c/busses/i2c-pca-isa.c |    2 +-
>  include/linux/i2c-pca-platform.h |    2 +-
>  4 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
> index 38a6496..6258c79 100644
> --- a/arch/sh/boards/board-sh7785lcr.c
> +++ b/arch/sh/boards/board-sh7785lcr.c
> @@ -229,7 +229,7 @@ static struct resource i2c_resources[] = {
>  static struct i2c_pca9564_pf_platform_data i2c_platform_data = {
>  	.gpio			= 0,
>  	.i2c_clock_speed	= I2C_PCA_CON_330kHz,
> -	.timeout		= 100,
> +	.timeout		= HZ,
>  };
>  
>  static struct platform_device i2c_device = {
> diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
> index a8e51bd..9e134fa 100644
> --- a/drivers/i2c/algos/i2c-algo-pca.c
> +++ b/drivers/i2c/algos/i2c-algo-pca.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/delay.h>
> +#include <linux/jiffies.h>
>  #include <linux/init.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
> @@ -186,14 +187,16 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
>  	int numbytes = 0;
>  	int state;
>  	int ret;
> -	int timeout = i2c_adap->timeout;
> +	unsigned long timeout = jiffies + i2c_adap->timeout;
>  
> -	while ((state = pca_status(adap)) != 0xf8 && timeout--) {
> -		msleep(10);
> -	}
> -	if (state != 0xf8) {
> -		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state);
> -		return -EAGAIN;
> +	while (pca_status(adap) != 0xf8) {
> +		if (time_before(jiffies, timeout)) {
> +			msleep(10);
> +		} else {
> +			dev_dbg(&i2c_adap->dev, "bus is not idle. status is "
> +				"%#04x\n", state);
> +			return -EAGAIN;
> +		}
>  	}
>  
>  	DEB1("{{{ XFER %d messages\n", num);
> diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
> index 8835de2..84d035c 100644
> --- a/drivers/i2c/busses/i2c-pca-isa.c
> +++ b/drivers/i2c/busses/i2c-pca-isa.c
> @@ -103,7 +103,7 @@ static struct i2c_adapter pca_isa_ops = {
>  	.owner          = THIS_MODULE,
>  	.algo_data	= &pca_isa_data,
>  	.name		= "PCA9564/PCA9665 ISA Adapter",
> -	.timeout	= 100,
> +	.timeout	= HZ,
>  };
>  
>  static int __devinit pca_isa_match(struct device *dev, unsigned int id)
> diff --git a/include/linux/i2c-pca-platform.h b/include/linux/i2c-pca-platform.h
> index 3d19187..aba3375 100644
> --- a/include/linux/i2c-pca-platform.h
> +++ b/include/linux/i2c-pca-platform.h
> @@ -6,7 +6,7 @@ struct i2c_pca9564_pf_platform_data {
>  				 * not supplied (negative value), but it
>  				 * cannot exit some error conditions then */
>  	int i2c_clock_speed;	/* values are defined in linux/i2c-algo-pca.h */
> -	int timeout;		/* timeout = this value * 10us */
> +	int timeout;		/* timeout in jiffies */
>  };
>  
>  #endif /* I2C_PCA9564_PLATFORM_H */
> 

Applied, thanks.

-- 
Jean Delvare
