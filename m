From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: remove_clientdata_to_null-branch
Date: Sat, 3 Apr 2010 20:22:07 +0200
Message-ID: <20100403182207.GC2190@pengutronix.de>
References: <20100403173646.GB2190@pengutronix.de> <20100403201317.1321b414@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100403201317.1321b414-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I've seen it, but it is something for the power subsystem maintainer
> (or akpm if there is none) to apply. I did kill drivers/i2c/chips for a
> reason.

Oops, sorry my failure then. I asked Anton Vorontsov (power-maintainer) if =
he
is fine with going this via the i2c-tree, so it will surely come after the
needed modification of the core. That is why he "only" acked it. (I still t=
hink
this sounds reasonable, the other cleaning-up patch should also go via i2c,
right? Or am I missing something?)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku3h08ACgkQD27XaX1/VRuGtgCfZGCjjAv5kUqNY8f6EA6m5tLB
FQcAnAnUAwa5/Cm9mCE9ntRlJJiPRcp5
=i6Un
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
