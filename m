From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Sat, 14 Jul 2012 14:09:38 +0200
Message-ID: <201207141409.38554.marex@denx.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de> <201207131410.29469.marex@denx.de> <20120714112929.GB29529@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120714112929.GB29529-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

[...]

> > That'd be cool. Some months ago, you promised to take a look. I tried it
> > recently again with not much luck.
> 
> Yes, I wanted to. I couldn't (see above). I do imagine that it really
> might not be possible to switch modes at runtime. This is why I was
> trying to get the patch into the next release without the
> mode-switching. But for that to happen, there was the binding issue. I
> came up with the module parameter as the easiest way to fix it. I am
> open to other solutions. Simply dropping the binding might be another
> idea if we pay attention that there are no regressions, going from
> PIOQUEUE to DMA.
> 
> I am also still interested to check the runtime switching, but it might
> take another month until I can really hack on it.

Good, there is some bit that probably needs to be flipped to allow this 
switching. I managed to get this working with SPI, not with i2c though. With 
i2c, if I restarted the controller inbetween each transaction, it worked ... 
which is not what I'd like to see there.

> > > Deprecated
> > > properties are also troublesome. Third, we don't really need this per
> > > instance, if somebody really has problems with DMA, it will apply to
> > > all i2c busses. Makes sense?
> > 
> > No, it doesn't. See above about small transfers. Consider the easy
> > situation where you have sensor on one bus (so you do PIO because you
> > transfer small data) and you have EEPROM on other bus, where you use DMA
> > because you transfer large data. And the mixed mode isn't there yet.
> 
> I fully understand what you want to configure. I did before. Yet,
> devicetree bindings are not platform_data and shouldn't be used like
> them.

But then, how would you configure this detail on a per-bus basis? Well all 
right, screw this, let's make it impotent and go for the module parameter. This 
patch actually fixes a real issue, I'd like to have it in ASAP and it's been 
aboue three months already, which sucks.

> Regards,
> 
>    Wolfram

Best regards,
Marek Vasut
