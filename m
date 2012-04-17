From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Tue, 17 Apr 2012 16:39:01 +0200
Message-ID: <20120417143901.GA22406@pengutronix.de>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdbQRB37kYfCwn6+xUxBkVVo9f3RwUk5pstVPcfK8bivZw@mail.gmail.com>
 <CACRpkdafU2Awaxx-2dXT_Z8S+dySx6YoV174rxJvdix81TBBpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdafU2Awaxx-2dXT_Z8S+dySx6YoV174rxJvdix81TBBpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> From: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> >>
> >> Turn off the clock and regulator to the I2C block using runtime
> >> PM.
> >>
> >> Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> >> Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> >> Signed-off-by: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> >> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >
> > Dooks, are you OK with merging this patch now?
>=20

As I understood, Mark acked it? I didn't dive into the details, so it would=
 be
nice for me to have an ACK (or at least a not NACK) from Magnus.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+NgIUACgkQD27XaX1/VRthyQCfa2TeA/mr2wSOpiFQE8AYZjrj
jjYAn1Hq4QHA7vVvA6l2hT0qOrFAPSC7
=26FJ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
