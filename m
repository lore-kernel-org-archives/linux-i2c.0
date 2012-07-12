From: guanxuetao@mprc.pku.edu.cn
Subject: Re: [PATCH 5/7] i2c-puv3: Use struct dev_pm_ops for power
     management
Date: Thu, 12 Jul 2012 11:24:54 +0800 (CST)
Message-ID: <50122.162.105.203.8.1342063494.squirrel@mprc.pku.edu.cn>
References: <201207112121.11046.rjw@sisk.pl>
    <201207112125.55418.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201207112125.55418.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-i2c@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Peter Korsgaard <jacmet@sunsite.dk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Vitaly Wool <vitalywool@gmail.com>, Colin Cross <ccross@android.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-i2c@vger.kernel.org

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Make the PKUnity-v3 SoC I2C controller driver define its suspend
> callback through a struct dev_pm_ops object rather than by using
> a legacy PM hook in struct platform_driver.  The empty resume
> callback is not necessary, so remove it.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks.

Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

> ---
>  drivers/i2c/busses/i2c-puv3.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> Index: linux/drivers/i2c/busses/i2c-puv3.c
> ===================================================================
> --- linux.orig/drivers/i2c/busses/i2c-puv3.c
> +++ linux/drivers/i2c/busses/i2c-puv3.c
> @@ -254,7 +254,7 @@ static int __devexit puv3_i2c_remove(str
>  }
>
>  #ifdef CONFIG_PM
> -static int puv3_i2c_suspend(struct platform_device *dev, pm_message_t
> state)
> +static int puv3_i2c_suspend(struct device *dev)
>  {
>  	int poll_count;
>  	/* Disable the IIC */
> @@ -267,23 +267,20 @@ static int puv3_i2c_suspend(struct platf
>  	return 0;
>  }
>
> -static int puv3_i2c_resume(struct platform_device *dev)
> -{
> -	return 0 ;
> -}
> +static SIMPLE_DEV_PM_OPS(puv3_i2c_pm, puv3_i2c_suspend, NULL);
> +#define PUV3_I2C_PM	(&puv3_i2c_pm)
> +
>  #else
> -#define puv3_i2c_suspend NULL
> -#define puv3_i2c_resume NULL
> +#define PUV3_I2C_PM	NULL
>  #endif
>
>  static struct platform_driver puv3_i2c_driver = {
>  	.probe		= puv3_i2c_probe,
>  	.remove		= __devexit_p(puv3_i2c_remove),
> -	.suspend	= puv3_i2c_suspend,
> -	.resume		= puv3_i2c_resume,
>  	.driver		= {
>  		.name	= "PKUnity-v3-I2C",
>  		.owner	= THIS_MODULE,
> +		.pm	= PUV3_I2C_PM,
>  	}
>  };
>
>
