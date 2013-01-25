From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V10 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 25 Jan 2013 12:13:22 +0100
Message-ID: <20130125111322.GA2649@pengutronix.de>
References: <59a73d182bf1ce330becf32ad780f3501a57aed0.1359106966.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59a73d182bf1ce330becf32ad780f3501a57aed0.1359106966.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2013 at 03:17:48PM +0530, Viresh Kumar wrote:
> Add i2c bus recovery infrastructure to i2c adapters as specified in the i=
2c
> protocol Rev. 03 section 3.1.16 titled "Bus clear".
>=20
> http://www.nxp.com/documents/user_manual/UM10204.pdf
>=20
> Sometimes during operation i2c bus hangs and we need to give dummy clocks=
 to
> slave device to start the transfer again. Now we may have capability in t=
he bus
> controller to generate these clocks or platform may have gpio pins which =
can be
> toggled to generate dummy clocks. This patch supports both.
>=20
> This patch also adds in generic bus recovery routines gpio or SCL line ba=
sed
> which can be used by bus controller. In addition controller driver may pr=
ovide
> its own version of the bus recovery routine.
>=20
> This doesn't support multi-master recovery for now.
>=20
> Reviewed-by: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Code-wise I am mostly satisfied, except that I need to think about
clock-stretching a little more. We could add that later, too.

However, while I understand you are keen to get rid of this series ASAP,
it seems that this eagerness results in some sloppyness which is a bit
cumbersome (most lines changed since last time have something to comment
on).

So, I'll try a different review style this time and let you do the
detective work :)

1) Please be strict and consistent with spaces around operators.
2) Make sure the warnings and printouts match the code
3) Take the printouts serious and invest a thought if they can be
further improved.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlECaNIACgkQD27XaX1/VRvTEgCdGQe+oJo1giSU4cGbz8/RXtvy
nWoAnRfDsSQ9YBTAr4MwioFYBi0KLidU
=80L0
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
