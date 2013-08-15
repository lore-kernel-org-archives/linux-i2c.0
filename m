From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: davinci: Allow i2c driver available for
 keystone platforms
Date: Thu, 15 Aug 2013 14:31:53 +0200
Message-ID: <20130815123153.GD17155@katana>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
 <1374712099-32095-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1374712099-32095-3-git-send-email-santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2013 at 08:28:19PM -0400, Santosh Shilimkar wrote:
> Keystone SOCs uses the same I2C IP as available on DaVinci SOCs.
> Update the config so that ARCH_KEYSTONE can use it.
>=20
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>=20
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>

Applied to for-next, thanks!


--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDMo5AAoJEBQN5MwUoCm2R8oP/jCJXIup//UlGMxVfZJ9ZJsp
WsZrFmS8Xb0nmBpwX6o3JZbTX9Lt9Zwkryyjrg5aASNNtisAm3tFZOX3lJ0Pzsjc
HJQzkEQ3qRZTLwvZp35uaakkEvCLUF/aLtMmeLc5g5pum37lCoBTkddQ0OiPM+Bl
qB6lELygLEofIK90LtLSO9UQVJIMzvOWDCBmEcVfLVRy2W//OI21M2u0wX9WIm9J
4T4+f0wPXUdPQPDF276vXTor5E10Mgu6jRpdIDGwgxUdbJJNLf3TVgt4f/pt3mIx
vOvU7eKXPoUh/BSGsK9zYs03DI0uQqXXpUMGkqZppQQlvMuSNPqJcpp+2HhbnS/Z
gWUopUooD7AUbqZhluW2UqklchFdV/PI3fqSXrRDoUVLeGLkEKzaWTXn3qtZX0lL
sEi51v14sz+dTUpL/WifQlEJfkIKX/rjSaDmp3nQYVXoSLss71dJBVGbgy849gsY
scjtq8LuFc5j5X+ZKPoVL1bL/X7QxMaIlYzTAtveP+0JpsQmBWucN16Vly7hBuym
ldiIFb44Nmb5Lm2/fzNI4uPI8Vd4lF/wQoun7kBnuiSA0s03EPkRdLysCNeXNLgh
gN2SeGBJrsHpceWVr+yYSZ2HJPzY+lztC3YJJu4zfY8CdJ8yQxqksg0acrrJlNGg
vgRbJLD6nM7jDBM+5eeU
=OeJP
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
