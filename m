From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Documentation: devicetree: move trivial-devices out of
 I2C realm
Date: Mon, 13 Mar 2017 08:54:57 +0100
Message-ID: <20170313075457.GA1431@katana>
References: <20170306143859.11881-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:50230 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbdCMHzB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Mar 2017 03:55:01 -0400
Content-Disposition: inline
In-Reply-To: <20170306143859.11881-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-i2c@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 03:38:59PM +0100, Wolfram Sang wrote:
> The I2C directory is for I2C master controllers, not for clients. So,
> move the file describing trivial devices one layer upwards where it
> fits its generic nature way better.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  Documentation/devicetree/bindings/{i2c =3D> }/trivial-devices.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{i2c =3D> }/trivial-devices.txt=
 (100%)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/=
Documentation/devicetree/bindings/trivial-devices.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/i2c/trivial-devices.txt
> rename to Documentation/devicetree/bindings/trivial-devices.txt

Rob, shall I take it or do you want?


--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYxlBRAAoJEBQN5MwUoCm2SeUQAJ2JuA8szz7YN948mpzwz/EX
7fIs/WeKRR2x1iLKEr/k52ezA6jlK/B7R+vJpC8RwPqwqbaZcy7DHzoXCSrv8edK
iimALnQGKWu0MicDxJlzCyWfESDf8oFrO/KZXvODhIysTRPzzqbaM7NOGkzgbJp3
ANJQZ9yQt9gmt83kn3bIQRwwhDW9/Rk8C+z8EgXenYrIXS0/iHCLxQ6VHa+IgobO
c/iP8Z2hps40toQTL+PcxH7VzLh46TrISEIWrTp3oQT+8TkL49y3Jc+IYXyKQBmh
Eb6g1r7n3MjyXwgDlTvcVC2KaMw2q60m0jyD256bKk47Hf9RWv2xmaA1KqrbEEdr
+VvizwvU4OF6L4sjcAWb5dqHQ8uIkOSKVu0VMEL5p8LjcGQDdS5++AgF8dwIBjBY
IltTLR8z4pMapl7wH5ccHVPt1Yzg2iD08E3kOeUn1wQgLCC5JIwNEDZr7PMCJhZO
J+eyITJC5SkgjpLl1Se+dwtN42pDXgg08n8up+/oy2oocTc/xR1jLrz0m4EbzgRO
xSGZun0ceiEDpauYoqs9KXbp8qIp6Tre/P6D0waRtuiHNOULLfiqkZPdaNGds91/
qXBk0SVL6DYgM/5GToaG/uPNeURwhUkymXmUdITs1jNxi6YkBdMGDGF/0vwSJKLR
95SkphPSdmH1nSp1pyTF
=nm/I
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
