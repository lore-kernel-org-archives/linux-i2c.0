From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed
 via Device Tree
Date: Fri, 14 Sep 2012 10:41:42 +0200
Message-ID: <20120914084141.GA2630@pengutronix.de>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
 <20120912105202.GD2624@pengutronix.de>
 <20120914082754.GE3374@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120914082754.GE3374-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> > First, I'd like to have this patch squashed with "i2c: nomadik: Add
> > Device Tree support to the Nomadik I2C driver". I wanted to do this on
> > my own, but the patches do not apply to 3.6-rc5 (with or without
> > regulator removal patch from Linus)?
>=20
> I'm really not keen on squashing all my patches together. They are
> clearly have very different purposes. If you think they are closely
> related, then pull them in sequentially, but please don't squash
> all my work into a single patch for no other reason than convenience.

I can't follow this reasoning. I never asked you to squash all patches,
only those two needed to get proper device tree support. Why would you
want to let the device being detected via DT and not scan the child
nodes immediately?

> > I can also take the I2C related changes to the devicetrees via my tree.
> > This is not uncommon. Some people prefer to do this via their soc-trees,
> > though. I don't care much since this is not really a hard dependency
> > causing build failures or merge conflicts, but just needs a little extra
> > time until the patches are all there...
>=20
> It would be better for all the Device Tree changes go in as a single
> patch-set. Again, I don't care where they go, so long as they go in
> together. arm-soc seems like the most generic place for them to be
> pulled into though.

This reasoning I can follow, but how should I know you aimed for that? I
only saw a patch [3/3] in one series making the driver probable via DT
and a patch [12/19] in another series to scan the child nodes. That's
all the infos I got. Some more context would have been helpful. Is there
a branch somewhere with all the things collected?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBS7cUACgkQD27XaX1/VRusmgCgvS+/RdAsHiWc7cf8v/MggTwS
cTkAoKqzlhmQL0CEu3MbHA2RwEtio+y5
=PisS
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
