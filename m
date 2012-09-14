From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed via
 Device Tree
Date: Fri, 14 Sep 2012 11:15:44 +0100
Message-ID: <20120914101542.GT3374@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
 <20120914084141.GA2630@pengutronix.de>
 <20120914090228.GH3374@gmail.com>
 <20120914093945.GB2630@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120914093945.GB2630-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> > Now there is:
> >   git://git.linaro.org/people/ljones/linux-3.0-ux500.git preview-fo=
r-next
>=20
> OK from having a glimpse, I'd prefer to squash (or have squashed)
>=20
> 	i2c: nomadik: Add Device Tree support to the Nomadik I2C driver
> 	i2c-nomadik: Register sub-devices when passed via Device Tree

Sure, no problem

> 	Documentation: Device Tree binding information for i2c-nomadik drive=
r
> 		(Documentation should go along with the code)

I'm still not too sure about how this benefits anyone. You can ensure
the documentation is placed in an adjacent patch, so it's just as easy
to make reference to.

> into one patch and take that via the I2C tree. This will allow me to
> resolve the merge conflict in my tree on my own. I don't see a strong
> reason to have those go via arm-soc (like prevented build-failures or
> easier merges), if I missed such a reason, please let me know.

I don't have any good reasons for you not to take the patch(es) though
your tree. Please go ahead.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
