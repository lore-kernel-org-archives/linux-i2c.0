From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Thu, 13 Feb 2014 09:26:30 +0100
Message-ID: <20140213082630.GA3119@katana>
References: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391680285-16668-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391680285-16668-3-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Why is the devicetree list not on CC? (Added now)

On Thu, Feb 06, 2014 at 10:51:25AM +0100, Maxime Ripard wrote:
> Switch the device tree to the new compatibles introduced in the i2c drive=
rs
> to have a common pattern accross all Allwinner SoCs.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi  |  6 +++---
>  arch/arm/boot/dts/sun5i-a10s.dtsi |  6 +++---
>  arch/arm/boot/dts/sun5i-a13.dtsi  |  6 +++---
>  arch/arm/boot/dts/sun7i-a20.dtsi  | 10 +++++-----
>  4 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index 28273f9..ac65c8a 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -518,7 +518,7 @@
>  		};
> =20
>  		i2c0: i2c@01c2ac00 {
> -			compatible =3D "allwinner,sun4i-i2c";
> +			compatible =3D "allwinner,sun4i-a10-i2c";

Can't we have:

	compatible =3D "allwinner,sun4i-a10-i2c", "allwinner,sun4i-i2c";

? And keep the old "allwinner,sun4i-i2c" and extend it with a SoC
specific a10 compatible entry when a distinction is needed?

> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a=
13.dtsi
> index 6de40b6..537072c 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -377,7 +377,7 @@
>  		};
> =20
>  		i2c0: i2c@01c2ac00 {
> -			compatible =3D "allwinner,sun4i-i2c";
> +			compatible =3D "allwinner,sun4i-a10-i2c";

For non-a10, That should be at least

	compatible =3D "allwinner,sun4i-a13-i2c", "allwinner,sun4i-a10-i2c";

or

	compatible =3D "allwinner,sun4i-a13-i2c", "allwinner,sun4i-i2c";

depending on the outcome above.

Or is my knowledge outdated already?


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS/IG2AAoJEBQN5MwUoCm2SLAP/1Cs2ezJL8MyqtUNk66tq5NW
xQmUrk3bN7LBFgWyjzmbg0+lfOUNL6cKgPpgjqRVLEjbsl+ng+UCjLEwP/XQhDYT
cppY2dDCNa6rtvgRqSvjxKW43uXHHo9YI2Dt0p8h9j7fzk4EVGnQgpH15qYU4vCL
6vOiaV2nHASxAhSWsF8mPss9HHoBdTRL7Szxt0dvh11PFVqCiu7OnOkq5ZPQu02h
vY44Kz47ouLIeurSbFrwvjqwvo0Z3RGv75sVXrW7cCVOO/yNzkXk0p/ooIvRfwPw
U2lfA8V4Uz1bCP5+872sMzoqMMs1pRGX6gjpSMnPkBNe0z2iASD8aTguY1ETkWB0
xomeBQ4fSkx4gdzEKJh1CkGh1r1Gsbum+ye94BPxodR8czZz26amVY6t+MtSsPJ4
zl2IN+jzrxjmQj0lclKqH2cyW0T8XQcuoor2xP6JUADFQv0o/paagaY/IMKcL3Rt
jVG6SUMJ0ZoKlmTdb5aOD+bK8so7o6pph9LyiicMQdNh0b3E3ZEYkiIkT3k7Xqr/
2VeDXPjxFEGAFjuaNPoPpE9WGkayRdSSWxSTebcdK89tbn9j4Wv2fQlY38MyDB5R
kbRfuUSQ7O+diGxglDFbDCDDsJPOKMeupSbClkv5A2dMkDpWJx04k5aGVo2AOZwP
h5ibcS9oitV0Lt2DHbdj
=h8kc
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
