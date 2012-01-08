From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: convert gpio-i2cmux to use
 module_platform_driver()
Date: Sun, 8 Jan 2012 11:05:00 +0100
Message-ID: <20120108110500.34845281@endymion.delvare>
References: <1325986552.4442.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1325986552.4442.0.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 08 Jan 2012 09:35:52 +0800, Axel Lin wrote:
> This patch converts gpio-i2cmux to use the module_platform_driver() macro which
> makes the code smaller and a bit simpler.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/i2c/muxes/gpio-i2cmux.c |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/gpio-i2cmux.c b/drivers/i2c/muxes/gpio-i2cmux.c
> index 7b6ce62..e5fa695 100644
> --- a/drivers/i2c/muxes/gpio-i2cmux.c
> +++ b/drivers/i2c/muxes/gpio-i2cmux.c
> @@ -165,18 +165,7 @@ static struct platform_driver gpiomux_driver = {
>  	},
>  };
>  
> -static int __init gpiomux_init(void)
> -{
> -	return platform_driver_register(&gpiomux_driver);
> -}
> -
> -static void __exit gpiomux_exit(void)
> -{
> -	platform_driver_unregister(&gpiomux_driver);
> -}
> -
> -module_init(gpiomux_init);
> -module_exit(gpiomux_exit);
> +module_platform_driver(gpiomux_driver);
>  
>  MODULE_DESCRIPTION("GPIO-based I2C multiplexer driver");
>  MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard@barco.com>");

Applied, thanks!

-- 
Jean Delvare
