From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: (i2c-diolan-u2c) Fix master_xfer return code
Date: Sat, 18 Aug 2012 12:27:21 +0200
Message-ID: <20120818102721.GF24812@pengutronix.de>
References: <1344527240-18266-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1344527240-18266-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 08:47:20AM -0700, Guenter Roeck wrote:
> The master_xfer function returns 0 on success. It should return the numbe=
r of
> successful transactions.
>=20
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Applied to -current, thanks! To add something to the discussion, an
excerpt for i2c-core.c:

1357 int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int n=
um)
1358 {
1359         int ret;
1360=20
1361         /* REVISIT the fault reporting model here is weak:
1362          *
1363          *  - When we get an error after receiving N bytes from a slav=
e,
1364          *    there is no way to report "N".
1365          *
1366          *  - When we get a NAK after transmitting N bytes to a slave,
1367          *    there is no way to report "N" ... or to let the master
1368          *    continue executing the rest of this combined message, if
1369          *    that's the appropriate response.
1370          *
1371          *  - When for example "num" is two and we successfully comple=
te
1372          *    the first message but get an error part way through the
1373          *    second, it's unclear whether that should be reported as
1374          *    one (discarding status on the second message) or errno
1375          *    (discarding status on the first one).
1376          */
1377=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvbgkACgkQD27XaX1/VRt0VACfZTFJb8B5RLIpJxOINfVLROfd
Hr0AnA2SLQUL3kPGzb+leDVscy6rx6ss
=Qiib
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
