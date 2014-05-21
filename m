From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-eg20t: Fix Kconfig dependencies
Date: Wed, 21 May 2014 12:48:09 +0200
Message-ID: <20140521104809.GO2708@katana>
References: <20140506100521.03861792@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFMLoheMaWcIEZAi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140506100521.03861792-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--UFMLoheMaWcIEZAi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2014 at 10:05:21AM +0200, Jean Delvare wrote:
> From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Subject: i2c-eg20t: Fix Kconfig dependencies
>=20
> The i2c-eg20t driver is for a companion chip to the Intel Atom E600
> series processors. These are 32-bit x86 processors so the driver is
> only needed on X86_32. Add COMPILE_TEST as an alternative, so that the
> driver can still be build-tested elsewhere.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--UFMLoheMaWcIEZAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfIRoAAoJEBQN5MwUoCm2I6EP/2su1BbQwVx7rcWbHTKYWNHg
cWbeaLlbqmwlXZn6whr9c4Y59vQH/fCARbcMl9eTaMTlppKtoDJr6nqxK0XDVvcU
4n5Nsc1rl1i2k6KzZ/ItAYj8I7q3kjHqXaZEbN9M/Ci9SeEJyiK8wfILSSpYu3jg
1pfNzjqE/mxEFXAuy9cm+wEAgimUopIqAmCHfyUYpWokWBRSTMkjvS5rLIYBi4Lc
3tBGN4QD3afQN6Dw4S29uT8wbcWqdo2+qc1uVJ2aBe6IdxSYFl7kZ/+oIiwxLIyP
H0eRWpcW9Q+LM85Uhbqy2UWqiwp4oYhmjNwR3sha357jwOsy0dVZCHuQufh83WIO
3GILw8NeCzPFch44maRizhJdbhf6n22W+6dFIZUyMwJI4fTwNHzUuVnVvZurmt2x
2eUgo6BTZuaLFHXv1OAVorpmsHNkBhPXSp/sq93EVgig8E7SGbVgKZuhLVdNL+l2
nvqllMb6SQDuEqaMx5+D77q9hlNdRLAExBt2TnDcur8yaATEExPGKG9pNPgzy9A3
JFUIbIZAZaK+NRPgnCU7br4tw82oe9x5Ukn/NcdIa3e//xxxc8e8T5eQMiZazm3P
BA8S7Tkj9OKttnbM6EdMknvu0QIyC5drVhNMC8trMXFhDJPcqJfx8C7YtXx+2Jcu
qmIkjwA3oh/SoaLvb51W
=cA3p
-----END PGP SIGNATURE-----

--UFMLoheMaWcIEZAi--
