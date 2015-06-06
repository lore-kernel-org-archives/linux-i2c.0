From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4] i2c: busses: i2c-bcm2835: limits cdiv to allowed
 values
Date: Sun, 7 Jun 2015 06:55:49 +0900
Message-ID: <20150606215548.GA1644@katana>
References: <1433614726-1737-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433614726-1737-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2015 at 08:18:46PM +0200, Silvan Wicki wrote:
> Adds: make sure bits 16-31 of DIV register are always 0
> Adds: assume minimal divider of 2 if divider resulted in 0
>       (bcm2835 sets divider to 32768 if cdiv is set to 0)
>=20
> See page 33/34 of BCM2835-ARM-Peripherals.pdf for the DIV register.
> https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Periph=
erals.pdf
>=20
> Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
> ---

Please provide a small changelog below the --- line, like:

Changes since V3: ...

I get so many patches and can't figure that out on my own.

Thanks!


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVc2xkAAoJEBQN5MwUoCm2C58P/14s0q21otvQ6wyCoOEzFVKQ
wp/CWZO/rr0aWuJ/Mh8ricoFlJl1OVCI/m3xn+phnMqxOWF+bgfZp7TBSD/oAUMZ
Smlo82voxMN4SpKahWtytQXbcbh10ggbn9xbaEnLUuDNMaNvl3OHVL5/6dxN5mm2
96DVWO4LZZwNiAfZ6YTDbbijU4mP4kgUt7XYHloL8ssn5huvXwXYOF8xGdm3/17u
cNDa3Q1F8O/7j9NwC9g2oqpFofB8ODxiqwOn036J8cQvT2id2rWE7x4HAwLPNxSW
nneExVVBt9cdjbD82bQlC+dPsNC0NbmBHk/0sC+UMhaJNWfAxCjV480+v1ojSMBZ
xkLZkNEPDG7CK6kxq11BillvfshWRKJ2S+vK+PCNBL5gtMK3RbMErsHuQfVNBbbG
NyxMPNb2TLa9SYcMzx/QsPjADNWq7rIzJfmd2c71FJlc7Emv/vI5cp7kBfDKKFV6
3T51VT8v+XU2+AObNR1qo75pS01/bbvPy7JgwjMxKpmbjNvCBuipDmn2lClZ8UVi
l/zZd+xPp0bEYEApxqPSKjJB2CCbk4Iyr+RYbjWp31Xh5xCQeJwREup5AWDfbsxE
OPhFofQrJmUWDpAybVlUhiPgdL3woEmkCe/+rYZ8EMsS6zxuXH1afvHo6UJjlk21
W/U03CPzo+TZ3wk0kwsK
=va6p
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
