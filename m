From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5] i2c: busses: i2c-bcm2835: limits cdiv to allowed
 values
Date: Tue, 23 Jun 2015 19:58:13 +0200
Message-ID: <20150623175813.GB3326@katana>
References: <1434618611-16062-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434618611-16062-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 11:10:11AM +0200, Silvan Wicki wrote:
> Checks if the cdiv value is in between min (0x2) and max (0xFFFE)
> supported values by the bcm2835. If not, it returns -ENODEV.
>=20
> See page 33/34 of BCM2835-ARM-Peripherals.pdf for the DIV register.
> https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Periph=
erals.pdf
>=20
> Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>

Applied to for-next, thanks!

But I needed to rebase on top of your "i2c: bcm2835: clear reserved bits
in S-Register" patch. A small patch series would have been a good choice
here.


--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJViZ41AAoJEBQN5MwUoCm26kUP/0nuDL00SJd7q9gxDLzP1X5P
dNKgh764bjjVwiNKDOGChnFjtK7rYuOKknee78nZbjPbbOn2bFC/RCfJf7vWR3Aj
uaTSqOu2jcd+IFuknkJwwcWw6gaWytTKmVKNwNhCWjn0waAeFH0Jck1KC+URM+fo
pzMUrR9ctmFIpPcCwDaaOJx7Y2C9+5jPEJ1zDftcu6N0YllWxLP5uoRkWI7O0FYO
vGUb/cRc44bCrmn1q73/SWcA77D3ZvtjSF6oGWgGtyrB/++SeKsguYLqrF1GQpMU
sJbiaTWePorGBo5/Nk9JpaDXCLFqtIjsttKSregDmp/9Y0PxoY42vqQj2r+64VO7
PYzw27jWmKbejk4HEtrKhZa3fJ63ggF6G1+NJlQolETpJsqOND4HY0l66tgzQDni
ZXMg2csqQbG21TAdGat7v5UuSJaWm/kKCNe/ULY2eRxIr5UyIRBqdPYrhdBekkwn
9zV8m5dZdJs6WvtvJmkmIDOw59MPA/GHqhv7rPhuWIgTkYAGATWM3T85Ju057TqV
MJtjrXPMgpzEBQ2ZHr7TGNVdNmlBcW4ynSbAR7YSdwokoS9oJMc3mAZeZdZzM8by
LrCQsUpXvqTW0Qp60fZxZPcDFZ998k9IQrolcjGwrvL1wUaSe4MOITEVTZ84EINJ
c/P/cuaVky5MilfuzAG7
=yRvM
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
