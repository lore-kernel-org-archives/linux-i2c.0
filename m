From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [rtc-linux] Re: i2c/rtc init dependency problem
Date: Fri, 25 Sep 2009 08:58:43 +0200
Message-ID: <20090925065843.GA4125@pengutronix.de>
References: <152584230909240758h674ffe3cw4d5e6baef5efc9b8@mail.gmail.com> <20090924151953.GD3154@pengutronix.de> <8b192c78-6ebf-42ec-b334-756f56cc5400@g6g2000vbr.googlegroups.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8b192c78-6ebf-42ec-b334-756f56cc5400-kR2RjjGg49OEYCl0FQ7J0FYGCWtFR9XvQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I get the following error with this patch:
> IOP3xx-I2C: probe of IOP3xx-I2C.0 failed with error -5

Looking at the probe-routine, this means request_irq failed? Is there somet=
hing
else needed to get that irq?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq8aiMACgkQD27XaX1/VRvM/wCdH9haU2Tsdzx/t88Po7wydV/5
7FwAn1wRu0OUvZuYiRBnxTB3ld/6397y
=pnHe
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
