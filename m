From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: add board_info to pdata
Date: Fri, 27 Mar 2015 16:48:31 +0100
Message-ID: <20150327154831.GE27238@katana>
References: <1426594495-31844-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426594495-31844-1-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2015 at 12:14:55PM +0000, Ben Dooks wrote:
> Add board_info so that the i2c-gpio driver can probe devices on probe
> so that i2c_register_board_info() does not need to be used. This is
> preferable for devices that get hotplugged as otherwise we need to do
> i2c_unregister_board_info() which would be more code.
>=20
> Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>

Why can't you use static bus numbers? Or instantiating from userspace?


--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFXvPAAoJEBQN5MwUoCm2E74P/iYk4/VKqCMzrctYYR3K36m6
VE4DC5+u1v4gb2BuL9E2DrIgi6qr/1J4cj5dysqI2f4PhgWDiDXqmFtye9s/9KJ3
f5loQhIdo+6I1pCs4bLO+7eta4PbVPfeyjfXSPD+kcdXzhB/rqdsaZUVS7vZVKCi
8gXtaVZiNnkU2gkvPfv7wVdLEjZdARApW7rBM82Vto9LwKzn3pVLfgHzZ5oVNbXx
cVppsGglETDYhjEisGDDNCF5elv8kHLdgC+SMaIhso586qlaeGhPGWMjqP3p25GZ
QNyZ+Uex4iC75HOsKVEkMQ8c3I/XMhFVrQQZWr9t+mZpn6TawqK4JO1Ygt0ZP4jE
7874j6tYUoo5gOi7vnLuMDg7u0zNbyQ1gNtF/UcHbBtFDHwlHFlNfT3CVOrQF9sS
na78A9AqgP54jL7XtRWjposm2X0CDjdiBSi1y6Fn0harhX/EGGQKhyQZNGTr8svL
+SfO5zJcQdX/6sDcJjGS3FtmSum1B7dNarwtJnfQbKoivclpe9z3BycT8zHp3D33
EsbfQEptQ6/gvRDBir2WIiaE8kev+7tlH2Q5p+DRiR1QGh+9Ae5FGHrW3n0DGB4/
S6juFPGZAr4boz2J56M7orvXuDlfx0MBOcbRwnf2T+y1Zr5CDDOzhR5cPZKX5XNu
S8uDkHQIs9tv8go471Gn
=+hQ+
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
