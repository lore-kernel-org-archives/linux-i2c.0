From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] arm64: dts: marvell: Add I2C definitions for the Armada 3700
Date: Tue, 08 Nov 2016 16:52:01 +0100
Message-ID: <87h97im0ke.fsf@free-electrons.com>
References: <20161108151506.1131-1-romain.perier@free-electrons.com>
        <20161108151506.1131-3-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161108151506.1131-3-romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Romain
        Perier's message of "Tue, 8 Nov 2016 16:15:05 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yahuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Igal Liberman <igall-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Romain and Wolfram, 
 
 On mar., nov. 08 2016, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> The Armada 3700 has two i2c bus interface units, this commit adds the
> definitions of the corresponding device nodes. It also enables the node
> on the development board for this SoC.
>
> Signed-off-by: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Acked-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

This patch is OK for me but I would like to apply it myself on
mvebu/dt. Indeed Thomas Petazzoni pointed that I made a typo on the
peripheral clock label: nb_perih_clk instead of nb_periph_clk. I would
like to fix it and by applying this patch I will avoid a merge conflict
or worse a mismatch with the label name.

Wolfram, once you will be OK with the patch 1 and 3, I will apply the
patch 2.

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts |  4 ++++
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 1372e9a6..16d84af 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -62,6 +62,10 @@
>  	};
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +};
> +
>  /* CON3 */
>  &sata {
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index c476253..bf2d73d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -98,6 +98,24 @@
>  			/* 32M internal register @ 0xd000_0000 */
>  			ranges = <0x0 0x0 0xd0000000 0x2000000>;
>  
> +			i2c0: i2c@11000 {
> +				compatible = "marvell,armada-3700-i2c";
> +				reg = <0x11000 0x24>;
> +				clocks = <&nb_perih_clk 10>;
> +				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +				mrvl,i2c-fast-mode;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@11080 {
> +				compatible = "marvell,armada-3700-i2c";
> +				reg = <0x11080 0x24>;
> +				clocks = <&nb_perih_clk 9>;
> +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +				mrvl,i2c-fast-mode;
> +				status = "disabled";
> +			};
> +
>  			uart0: serial@12000 {
>  				compatible = "marvell,armada-3700-uart";
>  				reg = <0x12000 0x400>;
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
