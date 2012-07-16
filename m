From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Mon, 16 Jul 2012 15:25:48 +0200
Message-ID: <20120716132548.GG17435@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <201207141409.38554.marex@denx.de>
 <20120716102151.GC17435@pengutronix.de>
 <201207161506.08147.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207161506.08147.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > > No, it doesn't. See above about small transfers. Consider the easy
> > > > > situation where you have sensor on one bus (so you do PIO because=
 you
> > > > > transfer small data) and you have EEPROM on other bus, where you =
use
> > > > > DMA because you transfer large data. And the mixed mode isn't the=
re
> > > > > yet.
> > > >=20
> > > > I fully understand what you want to configure. I did before. Yet,
> > > > devicetree bindings are not platform_data and shouldn't be used like
> > > > them.
> > >=20
> > > But then, how would you configure this detail on a per-bus basis? Well
> > > all
> >=20
> > This is a question for devicetree-discuss.
>=20
> Did you Cc it?

Well, I guess you already checked the mail headers and found out
yourself. The question behind the question probably is "Why didn't you
CC it?". The answer to that is that I didn't have much success by adding
it to $RANDOM_THREAD. It might be more efficient to answer starting a
new thread with explicit "[RFC] $THE_ISSUE". Since a conclusion there
won't make the next merge-window anyhow, I haven't done that now. That
put aside, it might be more efficient if someone with a bigger urge
might strive for a solution (yes, probably, but not necessarily you).
For me, it currently is just one task which needs to be scheduled
inbetween others.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAEFlwACgkQD27XaX1/VRvYHQCbBdHNmhRZZhXQC0IN4Aj1bSoJ
tuwAoJpn6Q9UdVkSxbw77BfKTIo3KpJK
=oX8T
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
