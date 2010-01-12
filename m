From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/pca: Don't use *_interruptible
Date: Tue, 12 Jan 2010 16:35:26 +0100
Message-ID: <20100112163526.30fbb981@hyperion.delvare>
References: <1263306460-24530-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1263306460-24530-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 12 Jan 2010 15:27:40 +0100, Wolfram Sang wrote:
> Unexpected signals can disturb the bus-handling and lock it up. Don't use
> interruptible in 'wait_event_*' and 'wake_*' as in commits
> dc1972d02747d2170fb1d78d114801f5ecb27506 (for cpm),
> 1ab082d7cbd0f34e39a5396cc6340c00bc5d66ef (for mpc),
> b7af349b175af45f9d87b3bf3f0a221e1831ed39 (for omap).
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
> Tested with custom hardware.
> 
>  drivers/i2c/busses/i2c-pca-isa.c      |    4 ++--
>  drivers/i2c/busses/i2c-pca-platform.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
> index 0ed68e2..f7346a9 100644
> --- a/drivers/i2c/busses/i2c-pca-isa.c
> +++ b/drivers/i2c/busses/i2c-pca-isa.c
> @@ -75,7 +75,7 @@ static int pca_isa_waitforcompletion(void *pd)
>  	unsigned long timeout;
>  
>  	if (irq > -1) {
> -		ret = wait_event_interruptible_timeout(pca_wait,
> +		ret = wait_event_timeout(pca_wait,
>  				pca_isa_readbyte(pd, I2C_PCA_CON)
>  				& I2C_PCA_CON_SI, pca_isa_ops.timeout);
>  	} else {
> @@ -96,7 +96,7 @@ static void pca_isa_resetchip(void *pd)
>  }
>  
>  static irqreturn_t pca_handler(int this_irq, void *dev_id) {
> -	wake_up_interruptible(&pca_wait);
> +	wake_up(&pca_wait);
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
> index c4df9d4..5b2213d 100644
> --- a/drivers/i2c/busses/i2c-pca-platform.c
> +++ b/drivers/i2c/busses/i2c-pca-platform.c
> @@ -84,7 +84,7 @@ static int i2c_pca_pf_waitforcompletion(void *pd)
>  	unsigned long timeout;
>  
>  	if (i2c->irq) {
> -		ret = wait_event_interruptible_timeout(i2c->wait,
> +		ret = wait_event_timeout(i2c->wait,
>  			i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
>  			& I2C_PCA_CON_SI, i2c->adap.timeout);
>  	} else {
> @@ -122,7 +122,7 @@ static irqreturn_t i2c_pca_pf_handler(int this_irq, void *dev_id)
>  	if ((i2c->algo_data.read_byte(i2c, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0)
>  		return IRQ_NONE;
>  
> -	wake_up_interruptible(&i2c->wait);
> +	wake_up(&i2c->wait);
>  
>  	return IRQ_HANDLED;
>  }

Applied, thanks.

-- 
Jean Delvare
