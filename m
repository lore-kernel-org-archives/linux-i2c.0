From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] misc: (at24) move header to linux/platform_data/
Date: Fri, 23 Aug 2013 22:11:49 +0200
Message-ID: <20130823201149.GA5640@katana>
References: <20130823190247.GA3821@katana>
 <1033284781.908504.1377285587778.JavaMail.root@mail>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1033284781.908504.1377285587778.JavaMail.root@mail>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivien Didelot <vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > This message explains what the patch does but not why the change is
> > wanted. I'd be surprised if we really want *all* platform_data in one
> > single directory?
>=20
> IMHO it makes sense. Why wouldn't we want all platform_data in
> include/linux/platform_data/?

For the same reason we don't want all driver source files in one
directory? It's a mess.


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSF8IFAAoJEBQN5MwUoCm2rVAP/2t+HLu2dUEAB2dYqb2vz+4B
gT5UTnfIay+uMYV72N8BEZeNqMUUxHwzz0n27T1nUP4YrSZ3X0LfzsqwyMyF2Ao4
y+VWuzx/d8SBeqOx5NLs+mer/C5wlMvAg4uaWMU40QbLBJi+lkh9KERsuV2AI5OU
4KdS6xH34JLytm/71p7ODiLif3TeydCnDq/APwm/gxnXFY3xbtcdbBWT4eZ6w8kQ
bGDI9gkJdZ0FvKsEn5qvHQfbaXj+8oYf2Y6WCDaii9AhpwUPUpbFphNAtzUp3zzN
FDYlqZ3sRe5Zo2EJnF66BIctlbtsajfXNLZMR4ILiAp9/eVi4I6GsKQHZt0AoWuG
fpUXl+HCB6jS1g7eagTWNJjE9vOPANNISN6vMlC4qrCkIIXFYtBU/QXQrVWId/1J
5aERvdBn9SmIupFGtbtJxKICVxPHfANJeWXaAGtvreBQe3WkZR6YfhthrHTA3Wv6
opSwBENLdEmYBKC0Hqr8wW0bMTVaZFEGCnpFxz2T2aqr5ePVHBa8sB3MwSzjUM0Z
useSGJWYbl/vnv0b5y8N6/f7VmADedejNYf3IOjpw02uklnvsrEQptsNcYEJibUS
xgaqcKTJ9gS2gM2noJK7pbh0fXg27ICXWWObrruE8MDem+cHCY2bXiYvldYpMDrB
/eagJsI2Uo9CZ8LEkH2t
=hLge
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
