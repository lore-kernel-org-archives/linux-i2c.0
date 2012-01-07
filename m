From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c: convert drivers/i2c/* to use
 module_platform_driver()
Date: Sat, 7 Jan 2012 16:00:18 +0100
Message-ID: <20120107160018.43c9d7fe@endymion.delvare>
References: <1322374332.2226.1.camel@phoenix>
	<20111127202212.44ebf4c4@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111127202212.44ebf4c4@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jochen Friedrich <jochen@scram.de>, Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <w.sang@pengutronix.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Manuel Lauss <manuel.lauss@googlemail.com>, Barry Song <21cnbao@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Yong Zhang <yong.zhang0@gmail.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Grant Likely <grant.likely@secretlab.ca>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Axel,

On Sun, 27 Nov 2011 20:22:12 +0100, Jean Delvare wrote:
> On Sun, 27 Nov 2011 14:12:12 +0800, Axel Lin wrote:
> > diff --git a/drivers/i2c/muxes/gpio-i2cmux.c b/drivers/i2c/muxes/gpio-i2cmux.c
> > index 7b6ce62..e5fa695 100644
> > --- a/drivers/i2c/muxes/gpio-i2cmux.c
> > +++ b/drivers/i2c/muxes/gpio-i2cmux.c
> > @@ -165,18 +165,7 @@ static struct platform_driver gpiomux_driver = {
> >  	},
> >  };
> >  
> > -static int __init gpiomux_init(void)
> > -{
> > -	return platform_driver_register(&gpiomux_driver);
> > -}
> > -
> > -static void __exit gpiomux_exit(void)
> > -{
> > -	platform_driver_unregister(&gpiomux_driver);
> > -}
> > -
> > -module_init(gpiomux_init);
> > -module_exit(gpiomux_exit);
> > +module_platform_driver(gpiomux_driver);
> 
> This one would be better as a separate patch, as it touches a different
> subdirectory, which I am responsible for.

You resent a v2 of the patch without muxes/gpio-i2cmux.c, which is
good, but I never received the suggested separate patch for
muxes/gpio-i2cmux.c. Did I miss it somehow? Please send it quickly if
you want it to make it into kernel 3.3.

-- 
Jean Delvare
