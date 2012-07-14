From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Sat, 14 Jul 2012 13:29:29 +0200
Message-ID: <20120714112929.GB29529@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
 <20120713082249.GF32184@pengutronix.de>
 <201207131410.29469.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207131410.29469.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marek,

> It'd be cool if someone complained earlier and the responses to new patch=
es=20
> would be faster. This series has been going on for more than two months a=
nd=20

I agree it would be cool to response faster. Maintaining being mostly my
priavte fun, I can't make guarantees, though. It just happened that I
didn't have much time for Linux in the last weeks. Actually, I am quite
happy that I managed to work through most of the backlog for the next
merge-window at all (in my holidays!). That's from my side, I can't tell
why other people didn't review; all being too busy is the most likely
guess.

> noone complained about this part until now. Instead I was made to documen=
t this=20
> and now I have to do it in completely different way? Decide already ...

When we decided to have the fallback mode as a configuration option, the
driver was still considering platform_data. That would have been no
problem...

>=20
> > For one reason, this is not a
> > hardware property or board specific, so not a good device tree property.
>=20
> Actually, there're still people who might benefit of doing PIOq only, sin=
ce they=20
> do small (eg. one byte) transfers. And this is good to have configurable =
per=20
> bus.

=2E.. but we are now on devicetree and things are different there, sadly.
"use-pio" is exposing a driver specific detail which is neither
describing the hardware nor it is OS agnostic. Other drivers from other
OS might not even have the seperation, because they might only use PIO
mode (not even PIOQUEUE). So, the binding is not acceptable AFAIK.
We can add devicetree-discuss to the CC-list.

> > Also, it is implicitly deprecated somehow since either we want DMA to
> > fully work
>=20
> And the DMA doesn't fully work?

It probably does. I was just stating the intention.

> > or, even better, somewhen be able to automatically switch
> > between PIOQUEUE and DMA depending on the i2c_msg size.
>=20
> That'd be cool. Some months ago, you promised to take a look. I tried it=
=20
> recently again with not much luck.

Yes, I wanted to. I couldn't (see above). I do imagine that it really
might not be possible to switch modes at runtime. This is why I was
trying to get the patch into the next release without the
mode-switching. But for that to happen, there was the binding issue. I
came up with the module parameter as the easiest way to fix it. I am
open to other solutions. Simply dropping the binding might be another
idea if we pay attention that there are no regressions, going from
PIOQUEUE to DMA.

I am also still interested to check the runtime switching, but it might
take another month until I can really hack on it.

> > Deprecated
> > properties are also troublesome. Third, we don't really need this per
> > instance, if somebody really has problems with DMA, it will apply to all
> > i2c busses. Makes sense?
>=20
> No, it doesn't. See above about small transfers. Consider the easy situat=
ion=20
> where you have sensor on one bus (so you do PIO because you transfer smal=
l data)=20
> and you have EEPROM on other bus, where you use DMA because you transfer =
large=20
> data. And the mixed mode isn't there yet.

I fully understand what you want to configure. I did before. Yet,
devicetree bindings are not platform_data and shouldn't be used like
them.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlABWBkACgkQD27XaX1/VRvAKwCfbUZME6AovbW9vGXR59tmRsUH
RzMAniI092rUjx08YpOZ3Yiqv/IpkItc
=XHR5
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
