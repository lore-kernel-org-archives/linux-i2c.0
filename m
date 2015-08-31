From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: muxes: fix leaked i2c adapter device node references
Date: Mon, 31 Aug 2015 22:40:47 +0200
Message-ID: <20150831204047.GD1544@katana>
References: <1440622773-20913-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440622773-20913-1-git-send-email-vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2015 at 11:59:33PM +0300, Vladimir Zapolskiy wrote:
> Every call of of_parse_phandle() increments user count of found device
> node, if OF_DYNAMIC is enabled.
>=20
> The change fixes all similar addressed cases in drivers/i2c.
>=20
> Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5LvPAAoJEBQN5MwUoCm2zUUP/iXN3l0cVdpyDcutT0BI/c5r
L43afmDsx0+SCEzYYn73P0Jvg8IM9c8G5uYNrz9GVaKGkmpghDYpRbuSapxmlTME
gupp6D45JVudm6BEgRP5v5tPtHs7QeIyY8uLsN8HDuAN5LtwuMfkJCz4CuWuvGX7
Esk+tCbCvhInBd6HDeqnd9NhJKBrvZD+v5/AHUqB764dts7nW+BX+zsm7ji1FAkW
CwXbzA+J+OVG3bGjvQRx1Ue2VuFGl74eFeBCHXSQbBUm0OKnsaoqKXe8YkXDFxkJ
TZkVzE6YAsen4nJRsNDOSVIvcurRJYkeE+nVonhx5WnS8m78jE3S1hfw7rRpafi4
jio97UOsOQ1+YofxDRyXv8XKpysuLTocE2ThEBTWC5lSCc1mKq4Md2UytswEOpZI
XPk7P880JnFxmr5ABGaXys/ns8rVzBbGnM90/YEZuiCg/jgBdKmm1wTyZ5P6EdfH
E+0eSzo7+P7fewTFcELU1wWuIz5iMprUTx2Orq0x406g04wYcHhWTOD4yCZI3AYB
bX37XayeFj1ZE6pugA/INyTgl+Eu2ElE+dpm6wCIonHObDigXStC3EDZh/Hy6YQ6
N2KcaXXWnhuZODJOssosc7zJgAZPdBm8ge7RfQ0Cq2nHfs++RW2M396GO3+Ah/fI
LKVd682v1QS9WM8z5Pl2
=4trh
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
