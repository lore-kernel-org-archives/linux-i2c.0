From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for RK3328
 SoCs
Date: Wed, 22 Mar 2017 18:23:56 +0800
Message-ID: <58D250BC.4040609@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-5-git-send-email-cl@rock-chips.com>
 <14610453.rKm3MBREMz@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <14610453.rKm3MBREMz@diego>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>, cl@rock-chips.com
Cc: mark.rutland@arm.com, wsa@the-dreams.de, linux-iio@vger.kernel.org, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, kever.yang@rock-chips.com, dianders@chromium.org, yamada.masahiro@socionext.com, tony.xie@rock-chips.com, linux-i2c@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de, zhengxing@rock-chips.com, khilman@baylibre.com, linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, paweljarosz3691@gmail.com, arnd@arndb.de, yhx@rock-chips.com, knaack.h@gmx.de, robh+dt@kernel.org, matthias.bgg@gmail.com, rocky.hao@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, david.wu@rock-chips.com, fabio.estevam@nxp.com, andy.yan@rock-chips.com, akpm@linux-foundation.org, shawnguo@kernel.org, afaerber@suse.de, jic23@kernel.org
List-Id: linux-i2c@vger.kernel.org



On 03/21/2017 04:55 PM, Heiko St=FCbner wrote:
> Hi,
>
> Am Donnerstag, 16. M=E4rz 2017, 21:17:22 CET schrieb cl@rock-chips.com:
>> From: Liang Chen <cl@rock-chips.com>
>>
>> This patch adds core dtsi file for Rockchip RK3328 SoCs.
>>
>> Signed-off-by: Liang Chen <cl@rock-chips.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1362
>> ++++++++++++++++++++++++++++++ 1 file changed, 1362 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi new file mode 100644
>> index 0000000..a92955c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -0,0 +1,1362 @@
>> +/*
>> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of t=
he
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <dt-bindings/clock/rk3328-cru.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,boot-mode.h>
>> +#include <dt-bindings/power/rk3328-power.h>
>> +
>> +/ {
>> +	compatible =3D "rockchip,rk3328";
>> +
>> +	interrupt-parent =3D <&gic>;
>> +	#address-cells =3D <2>;
>> +	#size-cells =3D <2>;
>> +
>> +	aliases {
>> +		serial0 =3D &uart0;
>> +		serial1 =3D &uart1;
>> +		serial2 =3D &uart2;
>> +		i2c0 =3D &i2c0;
>> +		i2c1 =3D &i2c1;
>> +		i2c2 =3D &i2c2;
>> +		i2c3 =3D &i2c3;
>> +	};
>> +
>> +	cpus {
>> +		#address-cells =3D <2>;
>
> #address-cells =3D <1>? You most likely don't need the 2 field cpu regs?
>
>> +		#size-cells =3D <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			device_type =3D "cpu";
>> +			compatible =3D "arm,cortex-a53", "arm,armv8";
>> +			reg =3D <0x0 0x0>;
>> +			enable-method =3D "psci";
>> +			clocks =3D <&cru ARMCLK>;
>> +		};
>> +		cpu1: cpu@1 {
>> +			device_type =3D "cpu";
>> +			compatible =3D "arm,cortex-a53", "arm,armv8";
>> +			reg =3D <0x0 0x1>;
>> +			enable-method =3D "psci";
>> +		};
>> +		cpu2: cpu@2 {
>> +			device_type =3D "cpu";
>> +			compatible =3D "arm,cortex-a53", "arm,armv8";
>> +			reg =3D <0x0 0x2>;
>> +			enable-method =3D "psci";
>> +		};
>> +		cpu3: cpu@3 {
>> +			device_type =3D "cpu";
>> +			compatible =3D "arm,cortex-a53", "arm,armv8";
>> +			reg =3D <0x0 0x3>;
>> +			enable-method =3D "psci";
>> +		};
>> +	};
>
> amba block here please
>
>> +
>> +	arm-pmu {
>> +		compatible =3D "arm,cortex-a53-pmu";
>> +		interrupts =3D <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
>> +	};
>> +
>> +	psci {
>> +		compatible =3D "arm,psci-1.0";
>> +		method =3D "smc";
>> +	};
>> +
>> +	timer {
>> +		compatible =3D "arm,armv8-timer";
>> +		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	xin24m: xin24m {
>> +		compatible =3D "fixed-clock";
>> +		#clock-cells =3D <0>;
>> +		clock-frequency =3D <24000000>;
>> +		clock-output-names =3D "xin24m";
>> +	};
>> +
>
> [...]
>
>> +	wdt: watchdog@ff1a0000 {
>> +		compatible =3D "snps,dw-wdt";
>> +		reg =3D <0x0 0xff1a0000 0x0 0x100>;
>> +		interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	amba {
>
> amba block above arm-pmu please
>
>> +		compatible =3D "simple-bus";
>> +		#address-cells =3D <2>;
>> +		#size-cells =3D <2>;
>> +		ranges;
>> +
>> +		dmac: dmac@ff1f0000 {
>> +			compatible =3D "arm,pl330", "arm,primecell";
>> +			reg =3D <0x0 0xff1f0000 0x0 0x4000>;
>> +			interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&cru ACLK_DMAC>;
>> +			clock-names =3D "apb_pclk";
>> +			#dma-cells =3D <1>;
>> +		};
>> +	};
>> +
>> +	saradc: saradc@ff280000 {
>> +		compatible =3D "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
>> +		reg =3D <0x0 0xff280000 0x0 0x100>;
>> +		interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>> +		#io-channel-cells =3D <1>;
>> +		clocks =3D <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>> +		clock-names =3D "saradc", "apb_pclk";
>> +		resets =3D <&cru SRST_SARADC_P>;
>> +		reset-names =3D "saradc-apb";
>> +		status =3D "disabled";
>> +	};
>> +
>> +	cru: clock-controller@ff440000 {
>> +		compatible =3D "rockchip,rk3328-cru", "rockchip,cru", "syscon";
>> +		reg =3D <0x0 0xff440000 0x0 0x1000>;
>> +		rockchip,grf =3D <&grf>;
>> +		#clock-cells =3D <1>;
>> +		#reset-cells =3D <1>;
>> +		assigned-clocks =3D
>> +			<&cru DCLK_LCDC>, <&cru SCLK_PDM>,
>> +			<&cru SCLK_RTC32K>, <&cru SCLK_UART0>,
>> +			<&cru SCLK_UART1>, <&cru SCLK_UART2>,
>> +			<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
>> +			<&cru ACLK_VIO_PRE>, <&cru ACLK_RGA_PRE>,
>> +			<&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
>> +			<&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
>> +			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
>> +			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
>> +			<&cru SCLK_SDIO>, <&cru SCLK_TSP>,
>> +			<&cru SCLK_WIFI>, <&cru ARMCLK>,
>> +			<&cru PLL_GPLL>, <&cru PLL_CPLL>,
>> +			<&cru ACLK_BUS_PRE>, <&cru HCLK_BUS_PRE>,
>> +			<&cru PCLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
>> +			<&cru HCLK_PERI>, <&cru PCLK_PERI>,
>> +			<&cru ACLK_VIO_PRE>, <&cru HCLK_VIO_PRE>,
>> +			<&cru ACLK_RGA_PRE>, <&cru SCLK_RGA>,
>> +			<&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
>> +			<&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
>> +			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
>> +			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
>> +			<&cru SCLK_EFUSE>, <&cru PCLK_DDR>,
>> +			<&cru ACLK_GMAC>, <&cru PCLK_GMAC>,
>> +			<&cru SCLK_RTC32K>, <&cru SCLK_USB3OTG_SUSPEND>;
>
> that list is way to long.
> Device-specific clocks should be inited in their respective device nodes.

Cpll init freq is 1200M, is too high. we need set cpll child clk div =

first,and then set cpll freq.
After pll init, others clk init freq can inited in their device node.

>
> Aka sdio clocks in the sdio controller node, video encoder/decoder in the
> encoder/decoder nodes, efuse, gmac etc etc.
>
> Controllers for which you don't have bindings yet, also most likely won't=
 need
> their clocks to get adjusted just now.
>
> The cru assigned clocks are really only for system-wide shared clocks.
>
>> +		assigned-clock-parents =3D
>> +			<&cru HDMIPHY>, <&cru PLL_APLL>,
>> +			<&cru PLL_GPLL>, <&xin24m>,
>> +			<&xin24m>, <&xin24m>;
>> +		assigned-clock-rates =3D
>> +			<0>, <61440000>,
>> +			<0>, <24000000>,
>> +			<24000000>, <24000000>,
>> +			<15000000>, <15000000>,
>> +			<100000000>, <100000000>,
>> +			<100000000>, <100000000>,
>> +			<50000000>, <100000000>,
>> +			<100000000>, <100000000>,
>> +			<50000000>, <50000000>,
>> +			<50000000>, <50000000>,
>> +			<24000000>, <600000000>,
>> +			<491520000>, <1200000000>,
>> +			<150000000>, <75000000>,
>> +			<75000000>, <150000000>,
>> +			<75000000>, <75000000>,
>> +			<300000000>, <100000000>,
>> +			<300000000>, <200000000>,
>> +			<400000000>, <500000000>,
>> +			<200000000>, <300000000>,
>> +			<300000000>, <250000000>,
>> +			<200000000>, <100000000>,
>> +			<24000000>, <100000000>,
>> +			<150000000>, <50000000>,
>> +			<32768>, <32768>;
>> +	};
>> +
>> +	gmac2io: eth@ff540000 {
>
> phandle should be gmac instead?
> Node name, ethernet@ff540000
>
>> +		compatible =3D "rockchip,rk3328-gmac";
>> +		reg =3D <0x0 0xff540000 0x0 0x10000>;
>> +		rockchip,grf =3D <&grf>;
>> +		interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names =3D "macirq";
>> +		clocks =3D <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_RX>,
>> +			 <&cru SCLK_MAC2IO_TX>, <&cru SCLK_MAC2IO_REF>,
>> +			 <&cru SCLK_MAC2IO_REFOUT>, <&cru ACLK_MAC2IO>,
>> +			 <&cru PCLK_MAC2IO>;
>> +		clock-names =3D "stmmaceth", "mac_clk_rx",
>> +			      "mac_clk_tx", "clk_mac_ref",
>> +			      "clk_mac_refout", "aclk_mac",
>> +			      "pclk_mac";
>> +		resets =3D <&cru SRST_GMAC2IO_A>;
>> +		reset-names =3D "stmmaceth";
>> +		status =3D "disabled";
>> +	};
>> +
>> +	gic: interrupt-controller@ff811000 {
>> +		compatible =3D "arm,gic-400";
>> +		#interrupt-cells =3D <3>;
>> +		#address-cells =3D <0>;
>> +		interrupt-controller;
>> +		reg =3D <0x0 0xff811000 0 0x1000>,
>> +		      <0x0 0xff812000 0 0x2000>,
>> +		      <0x0 0xff814000 0 0x2000>,
>> +		      <0x0 0xff816000 0 0x2000>;
>> +		interrupts =3D <GIC_PPI 9
>> +		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	pinctrl: pinctrl {
>> +		compatible =3D "rockchip,rk3328-pinctrl";
>> +		rockchip,grf =3D <&grf>;
>> +		#address-cells =3D <2>;
>> +		#size-cells =3D <2>;
>> +		ranges;
>> +
>> +		gpio0: gpio0@ff210000 {
>> +			compatible =3D "rockchip,gpio-bank";
>> +			reg =3D <0x0 0xff210000 0x0 0x100>;
>> +			interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&cru PCLK_GPIO0>;
>> +
>> +			gpio-controller;
>> +			#gpio-cells =3D <2>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells =3D <2>;
>> +		};
>> +
>> +		gpio1: gpio1@ff220000 {
>> +			compatible =3D "rockchip,gpio-bank";
>> +			reg =3D <0x0 0xff220000 0x0 0x100>;
>> +			interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&cru PCLK_GPIO1>;
>> +
>> +			gpio-controller;
>> +			#gpio-cells =3D <2>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells =3D <2>;
>> +		};
>> +
>> +		gpio2: gpio2@ff230000 {
>> +			compatible =3D "rockchip,gpio-bank";
>> +			reg =3D <0x0 0xff230000 0x0 0x100>;
>> +			interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&cru PCLK_GPIO2>;
>> +
>> +			gpio-controller;
>> +			#gpio-cells =3D <2>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells =3D <2>;
>> +		};
>> +
>> +		gpio3: gpio3@ff240000 {
>> +			compatible =3D "rockchip,gpio-bank";
>> +			reg =3D <0x0 0xff240000 0x0 0x100>;
>> +			interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&cru PCLK_GPIO3>;
>> +
>> +			gpio-controller;
>> +			#gpio-cells =3D <2>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells =3D <2>;
>> +		};
>> +
>> +		pcfg_pull_up: pcfg-pull-up {
>> +			bias-pull-up;
>> +		};
>> +
>> +		pcfg_pull_down: pcfg-pull-down {
>> +			bias-pull-down;
>> +		};
>> +
>> +		pcfg_pull_none: pcfg-pull-none {
>> +			bias-disable;
>> +		};
>> +
>> +		pcfg_pull_none_2ma: pcfg-pull-none-2ma {
>> +			bias-disable;
>> +			drive-strength =3D <2>;
>> +		};
>> +
>> +		pcfg_pull_up_2ma: pcfg-pull-up-2ma {
>> +			bias-pull-up;
>> +			drive-strength =3D <2>;
>> +		};
>> +
>> +		pcfg_pull_up_4ma: pcfg-pull-up-4ma {
>> +			bias-pull-up;
>> +			drive-strength =3D <4>;
>> +		};
>> +
>> +		pcfg_pull_none_4ma: pcfg-pull-none-4ma {
>> +			bias-disable;
>> +			drive-strength =3D <4>;
>> +		};
>> +
>> +		pcfg_pull_down_4ma: pcfg-pull-down-4ma {
>> +			bias-pull-down;
>> +			drive-strength =3D <4>;
>> +		};
>> +
>> +		pcfg_pull_none_8ma: pcfg-pull-none-8ma {
>> +			bias-disable;
>> +			drive-strength =3D <8>;
>> +		};
>> +
>> +		pcfg_pull_up_8ma: pcfg-pull-up-8ma {
>> +			bias-pull-up;
>> +			drive-strength =3D <8>;
>> +		};
>> +
>> +		pcfg_pull_none_12ma: pcfg-pull-none-12ma {
>> +			bias-disable;
>> +			drive-strength =3D <12>;
>> +		};
>> +
>> +		pcfg_pull_up_12ma: pcfg-pull-up-12ma {
>> +			bias-pull-up;
>> +			drive-strength =3D <12>;
>> +		};
>> +
>> +		pcfg_output_high: pcfg-output-high {
>> +			output-high;
>> +		};
>> +
>> +		pcfg_output_low: pcfg-output-low {
>> +			output-low;
>> +		};
>> +
>> +		pcfg_input_high: pcfg-input-high {
>> +			bias-pull-up;
>> +			input-enable;
>> +		};
>> +
>> +		pcfg_input: pcfg-input {
>> +			input-enable;
>> +		};
>> +
>> +		i2c0 {
>> +			i2c0_xfer: i2c0-xfer {
>> +				rockchip,pins =3D
>> +					<2 RK_PD0 1 &pcfg_pull_none>,
>> +					<2 RK_PD1 1 &pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		i2c1 {
>> +			i2c1_xfer: i2c1-xfer {
>> +				rockchip,pins =3D
>> +					<2 RK_PA4 2 &pcfg_pull_none>,
>> +					<2 RK_PA5 2 &pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		i2c2 {
>> +			i2c2_xfer: i2c2-xfer {
>> +				rockchip,pins =3D
>> +					<2 RK_PB5 1 &pcfg_pull_none>,
>> +					<2 RK_PB6 1 &pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		i2c3 {
>> +			i2c3_xfer: i2c3-xfer {
>> +				rockchip,pins =3D
>> +					<0 RK_PA5 2 &pcfg_pull_none>,
>> +					<0 RK_PA6 2 &pcfg_pull_none>;
>> +			};
>> +			i2c3_gpio: i2c3-gpio {
>> +				rockchip,pins =3D
>> +					<0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>,
>> +					<0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		hdmi_i2c {
>> +			hdmii2c_xfer: hdmii2c-xfer {
>> +				rockchip,pins =3D
>> +					<0 RK_PA5 1 &pcfg_pull_none>,
>> +					<0 RK_PA6 1 &pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		tsadc {
>> +			otp_gpio: otp-gpio {
>> +				rockchip,pins =3D
>> +					<2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
>
> no need to line -break all these single-pin definitions, there are still =
enough
> characters below 80 left :-)
>
> Same for all below
>
>> +			};
>> +
>> +			otp_out: otp-out {
>> +				rockchip,pins =3D
>> +					<2 RK_PB5 1 &pcfg_pull_none>;
>> +			};
>> +		};
>> +
>
>
> Heiko
>
>
>
