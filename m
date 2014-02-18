From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: retry on NAK
Date: Tue, 18 Feb 2014 18:48:53 +0100
Message-ID: <20140218174853.GC18768@katana>
References: <1378857490-30968-1-git-send-email-luka@openwrt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1378857490-30968-1-git-send-email-luka-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luka Perkov <luka-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2013 at 01:58:10AM +0200, Luka Perkov wrote:
> From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
>=20
> In case of busy i2c try again to get ACK.
>=20
> Signed-off-by: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
> Tested-by: Luka Perkov <luka-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

-EAGAIN is for lost arbitration (see Documentation/i2c/fault-codes).
In that case, the core will try again. NACK needs to be reported, so the
caller can decide what to do in that case. -ENXIO would be the best
response here.


--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTA50FAAoJEBQN5MwUoCm2JaIP/ihvCnhGdWv8ncreE3VBSGAf
8qGq1XM3/bl9mJ/q0dUJO4V3vo9s2KCvuO3dXZexGIbcIfiYJwFDgx1FYTkdlNVX
RUJfgDuw4kYEW3cIYlD2S33eml+1qlufpOQVbZDmosHc9Wb5hNzEi5KPxQZ3qOOu
qLf5V0G0LjqbP24Xna3ZfO6IYMDbY+oQJBIvHNilD/XbKFSuzOZCQChHzswfXXcy
hZGG+L5Aez7KkREdOXj1IWgkPGU+0cHVtwmE53m7nQ7eNAo2M4b2oHQmy+H3z3pW
j1ty5ZETkaXH5DUTIkuoI3prZ51wemq7cjVm0V3nmIz6icF2ipIflHizq59Gwd5V
CunfGSlIqkxpJ+wKODXcAJOpN4CZiCc5SUQUGwlk1O8PlKjXsQiNTuJ145h8QB0t
sL1+Cz4m+ETdDRK0F/eVa+QlteETv26Ppnl7PZenQRH9PShJ2oiQFSkr/F1TC6tF
4aMCieEsaStrx4LH6MDreBwJMmSfdV3cV33hkcSBtJkuBsC/7jAb5O8e3zCDTHKr
SzYlJeOLEzikw7/caBQvEx7UD8UQHqMyXHCdH4pkTHTIq6rsEs+buUZAWaEWRlhc
KJMGEHobnpYP24Q9KMKBff9gKG8s8bMwAHV95z74j8pOy43FbaTW04lNA/tUVR+3
TrCWOoKc/RxTqZztq/mv
=Gvhf
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
