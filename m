From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mpc: add register documentation to Freescale I2C
 driver
Date: Mon, 1 Dec 2014 18:21:47 +0100
Message-ID: <20141201172147.GB3212@katana>
References: <547A4192.30102@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <547A4192.30102-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2014 at 01:58:42PM -0800, Danielle Costantino wrote:
> i2c: mpc: add register documentation to Freescale I2C driver

This should be in one patch.

>=20
> return -ETIMEDOUT for all time-out error conditions

This should be in a seperate patch.

> and warn on arbitration lost.

And this should be dropped. "Arbitration lost" lost is not an error, it
is specified behaviour of I2C.

>      if (!(cmd_err & CSR_MCF)) {
> -        dev_dbg(i2c->dev, "unfinished\n");
> +        dev_warn(i2c->dev, "unfinished\n");

Are you sure this helps a regular user?


--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfKOrAAoJEBQN5MwUoCm2N4EP/013Uos6jsrhL1qYhLp6Hbh/
VxEd3nWOcqyNebBV8s/SJ/5nTBmboQnhF3by3wC5t7fl7vBOPnoMiHfYSRALu2cy
bsZ9LBbeiWy2HB4V49e/x27Ln2u8CDky8Bzn2FLpHbw3haqPwtWYvhWIX2hacIkN
iUlAqNPn5zVHOB+E9Z7+3J9Zx6H0VdgY4kRmmOmxuScRfuSEVyuEpTXMZTo09LuW
DR5qLJw3yvBnHtLSxZXHMnD2eGtgz/OqgkHTjOzgz/VVWrly12n7c/yezCZ/djVe
++nZHtGZ95vUeTIzt9cfzApgD8OZZFuPK/V/k8I6OfOj4eqdAqLMfStPwxLD3T0q
lXRIsPhXyyvimsKYCDl/TUgDRRIDwoBGd3oD7bp94HnhKgObvTnXjvvGzjIgK0cm
Pi+UK/HlAW5Zvmf08oKAwKoEoocEMESjtd3LPDs1jOcaSa0F1YPDBZqXWcFumswd
v9e2sDLw0Y+0GaMyxd3nbfWlDMderuts7WDAEXob06nZJvJSMhjaFL9g8Y1NarCi
EA6naTXZNnRJQ5auUhykG47Fv2oomaK9XuUhxHTtUY7J01cjrRy0TYMjmHmwz8c1
uz1tD34/n4X7KXK+RfpvknIT+/P0mprAEM+xPRIFOYzfU8rAAfeFwI0Z7RU71bgw
7ctwVwel62p0mm18gK8a
=sWnx
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
