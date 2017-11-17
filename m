From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/5] ARM64: dts: meson-axg: add I2C DT info for Meson-AXG
 SoC
Date: Fri, 17 Nov 2017 14:05:50 +0100
Message-ID: <96dc68e3-c394-70c4-eabe-f59d4c36150e@baylibre.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
 <20171117080236.32504-4-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46170 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbdKQNFx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 08:05:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id z3so6329149wme.5
        for <linux-i2c@vger.kernel.org>; Fri, 17 Nov 2017 05:05:52 -0800 (PST)
In-Reply-To: <20171117080236.32504-4-yixun.lan@amlogic.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Yixun, Jian,

On 17/11/2017 09:02, Yixun Lan wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> There are four I2C masters in EE domain, and one I2C Master in
> AO domain, the DT info here should describe them all.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 59 ++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 57faaa9d8013..99e967aff439 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -129,6 +129,54 @@
>  				#reset-cells = <1>;
>  			};
>  
> +			i2c_m0: i2c@1f000 {

Can you use a more simple "i2c0" phandle naming instead ? or get back to the "i2c_A/B/C/D" naming like in meson_gx to keep consistency ?

[...]

> +			};
> +
> +			i2c_m1: i2c@1e000 {

[...]

> +			};
> +
> +			i2c_m2: i2c@1d000 {

[...]

> +			};
> +
> +			i2c_m3: i2c@1c000 {

[...]

> +			};
> +
>  			uart_A: serial@24000 {
>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
>  				reg = <0x0 0x24000 0x0 0x14>;
> @@ -312,6 +360,17 @@
>  				};
>  			};
>  
> +			i2c_ao: i2c@5000 {

Can you keep the same "i2c_AO" as in meson-gx ?


[...]

> +			};
> +
>  			uart_AO: serial@3000 {
>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
>  				reg = <0x0 0x3000 0x0 0x18>;
> 

Neil
