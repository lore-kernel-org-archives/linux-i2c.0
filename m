From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/8] i2c: img-scb: fixes to support i2c on pistachio
Date: Fri, 31 Jul 2015 13:12:52 +0200
Message-ID: <20150731111252.GL1522@katana>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437997641-32575-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Stable kernel (v3.19+)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 12:47:13PM +0100, Sifan Naeem wrote:
> Following patches are required to fix the existing driver to
> support i2c on pistachio.
>=20
> Tested on Pistachio bub using an Adafruit I2C Non-Volatile FRAM Breakout
> (256Kbit / 32KByte) eeprom.
>=20
> Used i2c buildroot tools to test the eeprom and the other i2c blocks.
> Also used dd commands to copy data to and then to dump data from the
> eeprom. i2ctransfer was used to test repeated starts and verified
> using a scope.

That sounds like good testing \o/ If you are happy with i2ctransfer,
then please consider adding Tested-by tags to the i2ctransfer patches,
so Jean gets a more cosy feeling to include them to i2ctools.

>=20
> Cc: Stable kernel (v3.19+) <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I am happy for indications like "please consider adding this line for
stable: ...", but not CC stable yourself. These patches need changes,
so they are noise for the stable lists. The ones I ultimately apply are
the proper ones.

That being said, I'll mark all your patches "changes reqeuested" since you
need to resend based on current review from James (thanks a lot!). Even
if some patches are good and got acked, but it is easier for me to mark
them all the same :)

>=20
> Sifan Naeem (8):
>   i2c: img-scb: enable fencing for all versions of the ip
>   i2c: img-scb: do dummy writes before fifo access
>   i2c: img-scb: use DIV_ROUND_UP to round divisor values
>   i2c: img-scb: fix LOW and HIGH period values for the SCL clock
>   i2c: img-scb: reset interrupts in img_i2c_soft_reset
>   i2c: img-scb: remove start bit detected status after handling
>   i2c: img-scb: improve transaction complete handle
>   i2c: img-scb: verify support for requested bit rate
>=20
>  drivers/i2c/busses/i2c-img-scb.c |  101 ++++++++++++++++++++++----------=
------
>  1 file changed, 58 insertions(+), 43 deletions(-)
>=20
> --=20
> 1.7.9.5
>=20

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu1g0AAoJEBQN5MwUoCm23lwP/153c/IJeQWFM2f3trwnmosN
d8jtFDkXpeVD2jEbnW8w1k3Ya46SSOTIA7Fd88JJF18pqE4BB9jFAFoGJFwQekxv
G8N675pbnU+Zg593p71cxPZ766nkSUng72Xtu91fHba1eFi5wIz9dOyvpZoTyLzz
7IZn2VylxTTjq6gDBFbtQh+OD7XfNHfFGzoOpAbz7MBWGwyyL3DZ3hyxQZpjcUfd
0Q/uDEyu2oj9U1P8GYrbBKtd2g+NTg60742mCm6Rysa/ju6aMJq91fjKgaOFT6J2
xMDiq9yGpgI10JYiiCG1Cuix4A5Crfk8S3tD6DkIEB2w6uJz7ybeH7B2FGp6UH3l
2WBcNz6viNGaJPvbxiANPt9Bc6nt+Q9GUTylX/9H3IpqUqrYhnlh+Jo5QSPxTkrD
2jnch4WGyfkVfnvenEOrPNb4G+3/3R6pdG05O8Kk2+rRb8gSv8jUmadTPH9P6dk9
S7PtVcBJOTrOn9GYpFBX6+ziFCXQeuPYjC5zgAqL+yiihik6IViGs6Y++bR2/XSg
yRK6Ww4Q4vzaSqkH618ypSosRvKaxGnKook8/mlDg+cRLiC8cL522uTGKWxCD55m
uUtfhls25qPQLv+RpHUz9YlP8E2AwhzmelqBHQ9jTgfFBGFi9GB037qh0NibTNiD
cBlnF1/F/BTmIer2ECAT
=lBsN
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--
