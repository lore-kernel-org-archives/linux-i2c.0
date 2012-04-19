From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Thu, 19 Apr 2012 13:16:35 +0200
Message-ID: <20120419111635.GE2206@pengutronix.de>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdbQRB37kYfCwn6+xUxBkVVo9f3RwUk5pstVPcfK8bivZw@mail.gmail.com>
 <CACRpkdafU2Awaxx-2dXT_Z8S+dySx6YoV174rxJvdix81TBBpg@mail.gmail.com>
 <20120417143901.GA22406@pengutronix.de>
 <CANqRtoTbW2ew9ZwYmdJAaiD5qujZ-43eCfT=myDQdeYScwiBzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANqRtoTbW2ew9ZwYmdJAaiD5qujZ-43eCfT=myDQdeYScwiBzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I'm a bit hesitant to ack because the runtime suspend/resume callbacks
> are used differently than we would do on arch/sh and
> arch/arm/mach-shmobile. This difference may or may not be a good
> thing. I'm afraid I know too little about the nomadik platform to say
> anything wise. =3D)

I take this as a not-NACK ;) I don't want to dive too much into the
nomadik power management as well, so I will trust the authors here.
Since the driver is only used on this platform, I guess a different PM
strategy can be fix later if needed.

Linus, can you resend the patch another time, please?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+P9BMACgkQD27XaX1/VRsxcACguaW6iSOtiJD0kq9FDyhaZWKm
iB0AoKpyqAS9nSx7qHcB/FCyxaZY5Z+G
=uS8t
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
