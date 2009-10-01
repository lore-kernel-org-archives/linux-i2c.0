From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: imx: check busy bit when START/STOP
Date: Thu, 1 Oct 2009 18:37:53 +0200
Message-ID: <20091001163753.GA20103@pengutronix.de>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com> <4e090d470910010103o611d9fb2t3acf93632216fc88@mail.gmail.com> <20091001083831.GD27039@pengutronix.de> <4e090d470910010211k4ce78763i1a5163ec6ea57fe8@mail.gmail.com> <20091001095239.GE27039@pengutronix.de> <4e090d470910010754r1ebc4455u6220ccfd803491b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4e090d470910010754r1ebc4455u6220ccfd803491b0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Ah, so 'make the driver work on i.MX51' is a good statement which should
> > be part of the commit message.
> Well, maybe I can mention it.
> But I think the good point is to present what you modified, not the side =
effect.

It is not the side effect but the intention :) As no code is changed withou=
t a
need, the reason really should be in the patch description.

> Yes. But I don't have multi-master system. So I can't say that.
> The code is just taken from Freescale latest code. Without it, It
> could also cause a device error. I forget the details.  Anyway, it
> doesn't make anything wrong.

Do you know where the details are explained?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrE2uEACgkQD27XaX1/VRumZQCeL4x9oaBKKjSKzJLlRrkfvvqg
nlEAoLpQdpI3TeKEvK13rs46kSZRDsZU
=7kM6
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
