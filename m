From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: legacy drivers in staging?
Date: Sun, 1 Mar 2009 20:26:15 +0100
Message-ID: <20090301192615.GB24892@pengutronix.de>
References: <20090301101306.GB23093@pengutronix.de> <20090301113641.33a462d2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090301113641.33a462d2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> I am not sure myself. I agree we don't want to delay the removal of the
> legacy binding just because of these drivers. But OTOH I see little
> point in having a staging directory [1] if drivers being placed there
> break as soon as there is a core kernel change. I guess we are supposed
> to update these drivers as we do for all other drivers.

My view is a bit like the comment found in staging/rt28[67]0/TODO:

=3D=3D=3D

Please send any patches or complaints about this driver to Greg
Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> and don't bother the upstream wireless
kernel developers about it, they want nothing to do with it.

=3D=3D=3D

> That being said I think that there is much more work needed on these
> drivers, on the V4L side.

As some of these drivers are not just ugly but also conceptually wrong
(epl for example), I would vote for not accepting any duties which come
=66rom them. Especially when it is a long awaited task like the removal of
the legacy binding.

> Bottom line is that, is these drivers are the last ones blocking the
> removal of the legacy i2c driver, I will either attempt to convert them
> the quick-and-dirty way, or I will mark them as broken and leave it to
> somebody else to fix them. They will not delay us.

That is nice to hear. I don't think you need to mark them as broken,
staging is per se broken :) And please don't spend time on fixing them ;)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmq4VcACgkQD27XaX1/VRspigCfVvOF8mS+iQtiBcIF9mTeHsk7
GK4AoKPQE8ocO4kiUyDrItqWI72eTjFR
=n9WT
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
