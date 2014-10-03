From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: axxia: Add I2C driver for AXM55xx
Date: Fri, 3 Oct 2014 13:55:04 +0200
Message-ID: <20141003115504.GE1349@katana>
References: <1412334482-20720-1-git-send-email-anders.berg@avagotech.com>
 <20141003115048.GD1349@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141003115048.GD1349@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2014 at 01:50:48PM +0200, Wolfram Sang wrote:
> On Fri, Oct 03, 2014 at 01:08:02PM +0200, Anders Berg wrote:
> > Add I2C bus driver for the controller found in the LSI Axxia family SoC=
s. The
> > driver implements 10-bit addressing and SMBus transfer modes via emulat=
ion
> > (including SMBus block data read).
> >=20
> > Signed-off-by: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
>=20
> Applied to for-next, thanks!

You missed to move the Kconfig part to embedded. Fixed that for you!
Nonetheless, was a quite smooth driver submission, thanks.


--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULo6YAAoJEBQN5MwUoCm23c8QAJVgFKe33TnG3nOMQ81JeEeM
LarFUfOlGCoZw7AaPLWjgEM0A3EIrBgUbtNuWchQBv922na3oULLy4DPgCI0dvvG
8v0S4xZbCDZ4Ws4gOWX1m2mIasUYGHBjrXFTjjDi2QYIp59tt21lddKwbOEClRGP
JCSPkum/Nq0a44TuhH692uz5utLnN61XLdP/MALvHE7JdKP9R57JcByD3VxchJie
CTA+gYf5BQcHz9m7NyRGVAB6JvLn3ZeeHIcFLtSokxnv+DxQc9zcWcjO74ueZqQ+
Eaagf/OvbLf+PpmfsqJZhgBweDkC789gSWiItP9y0zFlRx0FhE9TJd5k0K4Dikv9
5edRwv8aGfExNQHP/sejx/JtL3kgcuhPC0nFJBXlQwBTvViMIV8wmU6mXmRshG/P
JEGyj/wFjP2UoNlKUBW9lEekTvI9VvLDuDji3zpHZ5dT232JIiQKJufGN66IXjmi
RmKqQZvcp+DjLT5S6pXE9LeFVFQ+glEQCB79AvZMJ50auoj4etezrdoKfwgqdliL
MYso2ZmmWxJb/AO9OFS1/EuRezxIsfNkKcCyZOlQwvd3JRAezgumDN7seP0I0dmD
fpvzHaQRl+WKcSLrYGAnJXG82gXDj70tlYi41FM/Mze7+MZk0KIsAPWr1Ojna6wL
fEQo3Jw6thLClZxs7t+4
=qIQU
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
