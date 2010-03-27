From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: removing set_clientdata(NULL)
Date: Sat, 27 Mar 2010 13:15:58 +0100
Message-ID: <20100327121558.GA5880@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

do you have already something in mind how to proceed with the
i2c_setclientdata-topic? I could offer the following:

I modify my semantic patch to remove all set_clientdata(NULL) calls connect=
ed
to a kfree(). Then, we could have a look if there are still some left and
investigate why. Once all issues are resolved (maybe there are none), we sh=
ould
know what to add in the core-layer, hopefully just the call to set_clientda=
ta.

Regarding this comment:

> the core should just set the client data to NULL. If there are drivers th=
at
> rely on the current behavior, then those drivers should be reviewed first=
 as
> to the reason why they need it.

I could check if there is any probe-function calling get_clientdata and mak=
ing
use of that? That is probably the most obvious thing which would need to re=
ly
on the current behaviour or did I miss something?

Have a nice weekend,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkut9v4ACgkQD27XaX1/VRvPqgCfXEYIgNLJxSd5h1ecXBmYjSIS
9csAn3wg1+96l53PLBOZOLzuXuL0M2ak
=UVk/
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
