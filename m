From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed via
 Device Tree
Date: Fri, 14 Sep 2012 10:02:30 +0100
Message-ID: <20120914090228.GH3374@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
 <20120914084141.GA2630@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120914084141.GA2630-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> > > First, I'd like to have this patch squashed with "i2c: nomadik: A=
dd
> > > Device Tree support to the Nomadik I2C driver". I wanted to do th=
is on
> > > my own, but the patches do not apply to 3.6-rc5 (with or without
> > > regulator removal patch from Linus)?
> >=20
> > I'm really not keen on squashing all my patches together. They are
> > clearly have very different purposes. If you think they are closely
> > related, then pull them in sequentially, but please don't squash
> > all my work into a single patch for no other reason than convenienc=
e.
>=20
> I can't follow this reasoning. I never asked you to squash all patche=
s,
> only those two needed to get proper device tree support. Why would yo=
u
> want to let the device being detected via DT and not scan the child
> nodes immediately?

Ah, sorry. That's my fault for rushing though my ridiculously bloated p=
ost-
vacation inbox. I *stupidly* thought you wanted me to squash two differ=
ent
patches, rather than these two. As such I unreservedly retract my previ=
ous
statement. Yes, please squash.

> > > I can also take the I2C related changes to the devicetrees via my=
 tree.
> > > This is not uncommon. Some people prefer to do this via their soc=
-trees,
> > > though. I don't care much since this is not really a hard depende=
ncy
> > > causing build failures or merge conflicts, but just needs a littl=
e extra
> > > time until the patches are all there...
> >=20
> > It would be better for all the Device Tree changes go in as a singl=
e
> > patch-set. Again, I don't care where they go, so long as they go in
> > together. arm-soc seems like the most generic place for them to be
> > pulled into though.
>=20
> This reasoning I can follow, but how should I know you aimed for that=
? I
> only saw a patch [3/3] in one series making the driver probable via D=
T
> and a patch [12/19] in another series to scan the child nodes. That's
> all the infos I got. Some more context would have been helpful. Is th=
ere
> a branch somewhere with all the things collected?

There will be. I'm currently just Ack collecting.=20

In fact wait ...

<3 mins pass>

Now there is:
  git://git.linaro.org/people/ljones/linux-3.0-ux500.git preview-for-ne=
xt

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
