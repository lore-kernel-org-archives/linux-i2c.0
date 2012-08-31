From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
Date: Fri, 31 Aug 2012 13:04:15 +0100
Message-ID: <20120831120411.GB5962@gmail.com>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
 <20120831112258.GA2624@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120831112258.GA2624-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> Is there some dependency other than updating the dts files? If not, I=
'd
> like to pick up the patch via I2C.

There's no other dependency. Feel free to take them into your tree.

> > +static void nmk_i2c_of_probe(struct device_node *np,
> > +			struct nmk_i2c_controller *pdata)
> > +{
> > +	/* Provide the default configuration as a base. */
> > +	pdata =3D &u8500_i2c;
>=20
> ?????? I wonder how that could work... have you tested the patch?

Wow, that's a great spot!

I have tested the patch, but I don't have any i2c devices, so can't
test full functionality. I, wrongly it seems, assumed there would be
a complaint from the I2C subsystem if any of the values seemed wrong.
What I will do before next submission is print out the entire pdata
structure to ensure it's populated in the correct way.

> > +
> > +	of_property_read_u32(np, "clock-frequency", (u32*)&pdata->clk_fre=
q);
>=20
> Might be worth changing clk_freq to u32?

Yes, makes sense.=20

> > +
> > +	/* This driver only supports 'standard' and 'fast' modes of opera=
tion. */
> > +	if (pdata->clk_freq <=3D 100000)
> > +		pdata->sm =3D I2C_FREQ_MODE_STANDARD;
>=20
> Is standard =3D=3D 100000 Hz?

Well it depends on how you interpret the comments in:
     include/linux/platform_data/i2c-nomadik.h

enum i2c_freq_mode {
        I2C_FREQ_MODE_STANDARD,         /* up to 100 Kb/s */
        I2C_FREQ_MODE_FAST,             /* up to 400 Kb/s */
        I2C_FREQ_MODE_HIGH_SPEED,       /* up to 3.4 Mb/s */
        I2C_FREQ_MODE_FAST_PLUS,        /* up to 1 Mb/s */
};

I guess your guess would be better than mine.

> > +	else
> > +		pdata->sm =3D I2C_FREQ_MODE_FAST;
>=20
> If those two are fixed frequencies, you should omit a warning if the
> devicetree has a different frequency set and report which one is goin=
g
> to be used actually.

Well, again by the comments above I would say that in between values
were valid, but I'm willing to bow down to your knowledge if you think
they are fixed values?

Thanks for reviewing.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
