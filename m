From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Replace dev_warn with printk in pca-algo
Date: Mon, 10 Mar 2008 22:03:07 +0100
Message-ID: <20080310220307.5a4463a5@hyperion.delvare>
References: <20080310132909.GA13941@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080310132909.GA13941-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: I2C Mailing List <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Mar 2008 14:29:09 +0100, Wolfram Sang wrote:
> Hello,
> 
> this patch needs to be applied on top of my patch
> 'i2c-pca-algo_extensions.diff'.
> 
> Bye,
> 
>    Wolfram
> 
> ===
> 
> Subject: Replace dev_warn with printk in pca-algo
> From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Replace dev_warn as it would be executed before the device is registered.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pca.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-playground/drivers/i2c/algos/i2c-algo-pca.c
> ===================================================================
> --- linux-playground.orig/drivers/i2c/algos/i2c-algo-pca.c	2008-03-10 14:10:59.000000000 +0100
> +++ linux-playground/drivers/i2c/algos/i2c-algo-pca.c	2008-03-10 14:15:36.000000000 +0100
> @@ -337,7 +337,9 @@
>  	struct i2c_algo_pca_data *pca_data = adap->algo_data;
>  
>  	if (pca_data->i2c_clock > 7) {
> -		dev_warn(&adap->dev, "Invalid I2C clock speed selected. Trying default.\n");
> +		printk(KERN_WARNING "%s: Invalid I2C clock speed selected. Trying default.\n",
> +			adap->name);
>  		pca_data->i2c_clock = I2C_PCA_CON_59kHz;
>  	}
>  

Folded into i2c-pca-02-extension-of-pca-algorithm.patch. I had to fix
the patch header to get it to apply, please pay attention next time...

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
