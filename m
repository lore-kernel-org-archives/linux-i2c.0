From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 3/6] Minor typos in i2c/algos/Kconfig
Date: Wed, 23 Jan 2008 21:08:40 +0100
Message-ID: <20080123210840.3f4a78e6@hyperion.delvare>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143657.830988061@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080121143657.830988061-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 21 Jan 2008 15:20:13 +0100, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
> This patch corrects some minor typos. The term "below" in these paragraphs
> might also be replaced by "later" or something similar?

You're right, this is a remnant from the times where all the i2c
options were in a single menu. Nowadays, 'under "I2C Hardware Bus
support"' would be more appropriate. Or... nothing at all. After all,
the i2c "algorithm" modules are selected automatically whenever a
driver that relies on them is selected. They are visible in the menu
only so that one can enable them for an hypothetical out-of-tree driver
- but I doubt that this is terribly useful. So a 3rd option would be to
simply remove these items from the configuration menu.

> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/algos/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-playground/drivers/i2c/algos/Kconfig
> ===================================================================
> --- linux-playground.orig/drivers/i2c/algos/Kconfig	2008-01-21 11:04:53.000000000 +0100
> +++ linux-playground/drivers/i2c/algos/Kconfig	2008-01-21 11:35:19.000000000 +0100
> @@ -9,7 +9,7 @@
>  	help
>  	  This allows you to use a range of I2C adapters called bit-banging
>  	  adapters.  Say Y if you own an I2C adapter belonging to this class
> -	  and then say Y to the specific driver for you adapter below.
> +	  and then say Y to the specific driver for your adapter below.
>  
>  	  This support is also available as a module.  If so, the module 
>  	  will be called i2c-algo-bit.
> @@ -19,7 +19,7 @@
>  	help
>  	  This allows you to use a range of I2C adapters called PCF adapters.
>  	  Say Y if you own an I2C adapter belonging to this class and then say
> -	  Y to the specific driver for you adapter below.
> +	  Y to the specific driver for your adapter below.
>  
>  	  This support is also available as a module.  If so, the module 
>  	  will be called i2c-algo-pcf.
> @@ -29,7 +29,7 @@
>  	help
>  	  This allows you to use a range of I2C adapters called PCA adapters.
>  	  Say Y if you own an I2C adapter belonging to this class and then say
> -	  Y to the specific driver for you adapter below.
> +	  Y to the specific driver for your adapter below.
>  
>  	  This support is also available as a module.  If so, the module 
>  	  will be called i2c-algo-pca.
> 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
