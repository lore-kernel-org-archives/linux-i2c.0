From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: mvebu: Introduce a new compatible
 string for mv64xxx-i2c
Date: Fri, 9 Aug 2013 06:13:37 -0300
Message-ID: <20130809091336.GA2848@localhost>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <1376039158-1896-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376039158-1896-4-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

(Sending to devicetree)

On Fri, Aug 09, 2013 at 11:05:58AM +0200, Gregory CLEMENT wrote:
> The mv64xxx-i2c embedded in the Armada XP have a new feature to
> offload i2c transaction. This new version of the IP come also with
> some errata. This lead to the introduction to a another compatible
> string.
>=20
> This commit split the i2c information into armada-370.dtsi and
> armada-xp.dtsi. Most of the data remains the same and stay in the
> common file Armada-370-xp.dtsi. With this new feature the size of the
> registers are bigger for Armada XP and the new compatible string is
> used.
>=20
> The Device Tree binding documentation is updated accordingly.
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 13 +++++++++=
+++-
>  arch/arm/boot/dts/armada-370-xp.dtsi                  |  2 --
>  arch/arm/boot/dts/armada-370.dtsi                     |  8 ++++++++
>  arch/arm/boot/dts/armada-xp.dtsi                      | 10 +++++++++=
+
>  4 files changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/=
Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index a1ee681..c5dd952 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -4,7 +4,8 @@
>  Required properties :
> =20
>   - reg             : Offset and length of the register set for the d=
evice
> - - compatible      : Should be "marvell,mv64xxx-i2c"
> + - compatible      : Should be "marvell,mv64xxx-i2c" and "marvell,mv=
7230-i2c"
> +for controller which support the I2C Transaction Generator
>   - interrupts      : The interrupt number
> =20
>  Optional properties :
> @@ -20,3 +21,13 @@ Examples:
>  		interrupts =3D <29>;
>  		clock-frequency =3D <100000>;
>  	};
> +
> +For a controller which support the I2C Transaction Generator:
> +
> +	i2c@11000 {
> +		compatible =3D "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> +		reg =3D <0x11000 0x100>;
> +		compatible =3D "marvell,mv64xxx-i2c";
> +		interrupts =3D <29>;
> +		clock-frequency =3D <100000>;
> +	};
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts=
/armada-370-xp.dtsi
> index 90b1176..d8b24c9 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -121,7 +121,6 @@
> =20
>  			i2c0: i2c@11000 {
>  				compatible =3D "marvell,mv64xxx-i2c";
> -				reg =3D <0x11000 0x20>;
>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
>  				interrupts =3D <31>;
> @@ -132,7 +131,6 @@
> =20
>  			i2c1: i2c@11100 {
>  				compatible =3D "marvell,mv64xxx-i2c";
> -				reg =3D <0x11100 0x20>;
>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
>  				interrupts =3D <32>;
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/ar=
mada-370.dtsi
> index fa3dfc6..0e2eefa 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -155,6 +155,14 @@
>  				};
>  			};
> =20
> +			i2c0: i2c@11000 {
> +				reg =3D <0x11000 0x20>;
> +			};
> +
> +			i2c1: i2c@11100 {
> +				reg =3D <0x11100 0x20>;
> +			};
> +
>  			usb@50000 {
>  				clocks =3D <&coreclk 0>;
>  			};
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/arm=
ada-xp.dtsi
> index 416eb94..e1f2547 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -138,6 +138,16 @@
>  				};
>  			};
> =20
> +			i2c0: i2c@11000 {
> +				compatible =3D "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> +				reg =3D <0x11000 0x100>;
> +			};
> +
> +			i2c1: i2c@11100 {
> +				compatible =3D "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> +				reg =3D <0x11100 0x100>;
> +			};
> +
>  			usb@50000 {
>  				clocks =3D <&gateclk 18>;
>  			};
> --=20
> 1.8.1.2
>=20

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
