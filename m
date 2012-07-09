From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
Date: Mon, 9 Jul 2012 13:07:35 +0200
Message-ID: <201207091307.35860.marex@denx.de>
References: <1341554956-17416-1-git-send-email-marex@denx.de> <20120709105338.GE1296@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120709105338.GE1296-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

[...]

> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index ee3778a..832d30a 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
[...]
> > @@ -428,6 +429,7 @@
> > 
> >  				compatible = "fsl,imx28-i2c";
> >  				reg = <0x8005a000 2000>;
> >  				interrupts = <110 69>;
> > 
> > +				clock-frequency = <400000>;
> 
> NACK on that. Not all slaves can do 400KHz, so this is not a sensible
> default.

How many of such chips are there and how many of the chips can do 400kHz ? I 
believe the majority shouldn't suffer because of minority.

[...]

Best regards,
Marek Vasut
