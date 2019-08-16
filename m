From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/3] arm64: allwinner: h6: add I2C nodes
Date: Fri, 16 Aug 2019 09:50:31 +0200
Message-ID: <20190816075031.zw4bjunn4hfoaq3e@flea>
References: <20190811090503.32396-1-bshah@kde.org>
 <20190816064710.18280-1-bshah@kde.org>
 <20190816064710.18280-3-bshah@kde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibqavahcu4hffii3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816064710.18280-3-bshah@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhushan Shah <bshah@kde.org>
Cc: Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Wolfram Sang <wsa@the-dreams.de>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--ibqavahcu4hffii3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 12:17:09PM +0530, Bhushan Shah wrote:
> Add device-tree nodes for i2c0 to i2c2, and also add relevant pinctrl
> nodes.
>
> Suggested-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Bhushan Shah <bshah@kde.org>
> ---
> Changes in v2:
>   - Add the SoC specific compatible string instead of re-using a31 one.
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56 +++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index bcecca17d61d..a1a329926540 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -329,6 +329,21 @@
>  				function = "hdmi";
>  			};
>
> +			i2c0_pins: i2c0-pins {
> +				pins = "PD25", "PD26";
> +				function = "i2c0";
> +			};
> +
> +			i2c1_pins: i2c1-pins {
> +				pins = "PH5", "PH6";
> +				function = "i2c1";
> +			};
> +
> +			i2c2_pins: i2c2-pins {
> +				pins = "PD23", "PD24";
> +				function = "i2c2";
> +			};
> +
>  			mmc0_pins: mmc0-pins {
>  				pins = "PF0", "PF1", "PF2", "PF3",
>  				       "PF4", "PF5";
> @@ -464,6 +479,45 @@
>  			status = "disabled";
>  		};
>
> +		i2c0: i2c@5002000 {
> +			compatible = "allwinner,sun50i-h6-i2c";

This isn't going to work if you don't patch the driver to add the
compatible. And this isn't what you described in the binding patch.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ibqavahcu4hffii3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVZgRwAKCRDj7w1vZxhR
xS+HAQCepqHx2ZpfYXULQei3MlCiSsZt/LK4vD5T0th5iQi3YgD/Yh5TJDYYPBYh
bHb7icMbNnDQjvYijyzCk3IJQmfegAU=
=b9Qc
-----END PGP SIGNATURE-----

--ibqavahcu4hffii3--
