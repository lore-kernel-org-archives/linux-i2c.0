From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: convert drivers/i2c/* to use
 module_platform_driver()
Date: Sun, 27 Nov 2011 20:22:12 +0100
Message-ID: <20111127202212.44ebf4c4@endymion.delvare>
References: <1322374332.2226.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1322374332.2226.1.camel@phoenix>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Axel,

On Sun, 27 Nov 2011 14:12:12 +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/i2c/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
> Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>
> Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> Cc: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Lucas De Marchi <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-at91.c         |   17 ++---------------
>  drivers/i2c/busses/i2c-au1550.c       |   13 +------------
>  drivers/i2c/busses/i2c-cpm.c          |   13 +------------
>  drivers/i2c/busses/i2c-highlander.c   |   13 +------------
>  drivers/i2c/busses/i2c-ibm_iic.c      |   13 +------------
>  drivers/i2c/busses/i2c-iop3xx.c       |   16 +---------------
>  drivers/i2c/busses/i2c-isch.c         |   13 +------------
>  drivers/i2c/busses/i2c-ixp2000.c      |   13 +------------
>  drivers/i2c/busses/i2c-mpc.c          |   13 +------------
>  drivers/i2c/busses/i2c-mv64xxx.c      |   15 +--------------
>  drivers/i2c/busses/i2c-ocores.c       |   17 ++---------------
>  drivers/i2c/busses/i2c-octeon.c       |   16 +---------------
>  drivers/i2c/busses/i2c-pca-platform.c |   14 +-------------
>  drivers/i2c/busses/i2c-pmcmsp.c       |   17 ++---------------
>  drivers/i2c/busses/i2c-powermac.c     |   19 ++-----------------
>  drivers/i2c/busses/i2c-puv3.c         |   16 ++--------------
>  drivers/i2c/busses/i2c-sh7760.c       |   13 +------------
>  drivers/i2c/busses/i2c-simtec.c       |   20 ++------------------
>  drivers/i2c/busses/i2c-xiic.c         |   18 ++----------------
>  drivers/i2c/muxes/gpio-i2cmux.c       |   13 +------------
>  20 files changed, 27 insertions(+), 275 deletions(-)

Looks overall good. I'd rather let Ben apply it as most affected
drivers are for embedded platforms.

Just two minor comments:

> --- a/drivers/i2c/busses/i2c-simtec.c
> +++ b/drivers/i2c/busses/i2c-simtec.c
> @@ -156,12 +156,6 @@ static int simtec_i2c_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> -
> -/* device driver */

I see no good reason for removing that comment.

> -
> -/* work with hotplug and coldplug */
> -MODULE_ALIAS("platform:simtec-i2c");
> -
>  static struct platform_driver simtec_i2c_driver = {
>  	.driver		= {
>  		.name		= "simtec-i2c",
> @@ -171,19 +165,9 @@ static struct platform_driver simtec_i2c_driver = {
>  	.remove		= simtec_i2c_remove,
>  };
>  
> -static int __init i2c_adap_simtec_init(void)
> -{
> -	return platform_driver_register(&simtec_i2c_driver);
> -}
> -
> -static void __exit i2c_adap_simtec_exit(void)
> -{
> -	platform_driver_unregister(&simtec_i2c_driver);
> -}
> -
> -module_init(i2c_adap_simtec_init);
> -module_exit(i2c_adap_simtec_exit);
> +module_platform_driver(simtec_i2c_driver);
>  
>  MODULE_DESCRIPTION("Simtec Generic I2C Bus driver");
>  MODULE_AUTHOR("Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:simtec-i2c");

> (...)
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

This one would be better as a separate patch, as it touches a different
subdirectory, which I am responsible for.

-- 
Jean Delvare
