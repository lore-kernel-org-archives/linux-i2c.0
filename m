From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-gpio: fix some of gpio sleep issues
Date: Fri, 27 Mar 2015 16:46:09 +0100
Message-ID: <20150327154609.GD27238@katana>
References: <1426593869-8724-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426593869-8724-1-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2015 at 12:04:29PM +0000, Ben Dooks wrote:
> The i2c-gpio driver can be used in systems where the GPIO itself is
> provided by a GPIO driver that may be sleeping (for example, SPI or
> USB). In this case, it is preferable to use the _cansleep() variants
> of the GPIO code.
>=20
> We can only fix this up for the case where the i2c-gpio implementation
> provides open-drain outputs as there are no gpio_direction_xxx_cansleep()
> provided.
>=20
> This removes the issues on the customer system with the console constantly
> showing the following warning:
>=20
> WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:2389 gpiod_set_raw_value

??? It will silence a warning but will totally break the timing in case
sleeping is needed? I'd think the warning is very suitable.


--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFXtBAAoJEBQN5MwUoCm2BPMP/iiJGJAiN4TbM6+BtbYeV5wl
wjdAJbWhLAxA+0ycPFMB22pL9iH08rpFYJiKrq7TN2BP3L+WwyJ2i8xo0HRheIAz
Dgrkn7lscP0AWQ2uJnjZ0M4hZuLYmndiO3DaCKKFlZGImzh7K2lqi60ep2dZC3sr
pcC08BsJ2pl3RrckrBm7jkC+y2PYqiXZSQo5E7wVsqA5uKbhz6fCHhqUbrA6tmNg
a/NQRzoByCrVzlQ14gTn9cgxEvUKChVKiyGGDChpVuk5pvB+YqltpDXO81k+kdBO
ZdQ4TsKvyf3wqxC9uC9T/vx/KrEx7QuKZVgQ72XSRCxN8bMuWqZzRENh2IpRk7v5
B+TOFmn1tL6tqs+S6np3BeD+8Mdgj/qT23PzqFWSVsQ3RL17+3kOGGZfD/IwJ1bB
0b9crzmVpexdodTyh4RPQAbNav5alJxhgYcclbWUiQgC1GhFyMtNyFt/iR3Xi/DC
F+gQd7I9pgYaWak4qelizLtM10OjozyZCRVhJx5IG8knyYIKZPzQRmtgFfeEKv0Y
V8FA1MURnVPRKauJnztEfFKSyqGwaLCUW3VazyqkjrYpi78cA3st60VlpEakBqwd
q5lYHi6lDT5Kql8Ei6KWwxJTrB1zV44Ez/7Ss0NE/JDCpzaEcEbRqjFDMj+Px4Vz
PCO5/r/o/Dcgd7UheORW
=mJ/Q
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
