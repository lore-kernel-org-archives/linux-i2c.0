From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 14/14] i2c: mux: demux-pinctrl: make drivers with no
 pinctrl work again
Date: Thu, 10 Nov 2016 21:12:42 +0100
Message-ID: <20161110201242.GD1585@katana>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161106202032.5227-15-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161106202032.5227-15-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 06, 2016 at 09:20:32PM +0100, Wolfram Sang wrote:
> Some drivers like i2c-gpio do not have dedicated pinctrl states. They
> broke when error checking for pinctrl was added. Detect them now, and in
> their case, simply skip over pinctrl configuration.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current with Geert's typo fix, thanks!


--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYJNS6AAoJEBQN5MwUoCm2qHUP/1D4MO6UdqoA5ezd0dA+Vuoi
4z6FiY+CjkT3OzSdG6yv1lccGQOw5sF86uJV7fbaQTwVbH/qvOdOxkHS8framXiI
37AFDoF5jEHccLaSeaKgjAvmIk49rsN5LEFb9UyzXmsvNH9QplUBMOtObBBUyp65
1quL4yEkdclv4H60xr9qIjLnw5ojmS1WxJSd8RV3RFAdwt3WCMHAIoyfkE8Qtl3v
b3ELLJ7W9cR62dXHjWoQyJIhJsFuJrADYk0YgC3m2gXiNRgezUwB78qM4wkPz42d
gMJ4YWALTZ1jkkjBW7nBPATV+ohv4hL82nmZx3wBaISVFarbckUBWsMPZ4i49bnk
ifbK9kK7H7Xjdx6q6gItgGqLLeGgKPrukLYEX3zVDS3NUcfTyt2KM6ZbiW1S0RsF
qEdb1O3KC90PI4g9TYF+p/Pd2IuLIMuSAeESz8hgtR786g1DQYPE8DH7A3FZgEju
m0tzkJd9ohzsIiEzYsdjyjnJ3r94U2rK9LHNNVEIZWmY0YqeCxfDf8bvh75TW6GJ
6EvBrhXiciYC/+K7g/dS+v4Cr1x2HJMdg2o70eK6xAB/MupeFPz3GcoPu92Zw3pp
UtjLutLrK8DYsJ+iseCgtaRmRQPDbcU4ljs+64r/GhCd2UpFvv3kucHri9qay9t5
OVVE0k9tkoFaqWhAeq26
=iA5Y
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
