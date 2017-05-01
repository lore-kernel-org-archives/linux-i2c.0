From: Phil Reid <preid@electromag.com.au>
Subject: Re: RFC: i2c designware gpio recovery
Date: Mon, 1 May 2017 09:57:35 +0800
Message-ID: <25752a11-3b13-762f-5916-66893d223988@electromag.com.au>
References: <2259005.m0altzP21Z@dabox> <2269277.HqpbCE3B5H@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:41755 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164160AbdEACEU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 30 Apr 2017 22:04:20 -0400
In-Reply-To: <2269277.HqpbCE3B5H@dabox>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tim Sander <tim@krieglstein.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

G'day Tim,


On 29/04/2017 00:14, Tim Sander wrote:
> Hi
> 
> After sending this mail i just found out how i could reset the i2c-1 controller manually with
> devmem 0xffd05014 32 0x2000
> devmem 0xffd05014 32 0
> 
> So i took a look into the device tree file socfpga.dtsi and found that the reset lines
> where not defined (although available in the corresponding reset manager). Is there a
> reason for this? Other components are connected.
There's a few thing like that where the bootloader has been expected to setup the resets etc.


> 
> However with the patch below my previously sent patch works!
> 
> If there is interest in would cleanup the patch and send it in for mainlining.
> I think the most unacceptable part would be this line:
> +       ret = gpio_request_one(bri->scl_gpio, //GPIOF_OPEN_DRAIN |
> My gpio drivers refuse to work as output as they have no open drain mode.
> So i wonder how to get this solved in a clean manner.
I thought the gpio system would emulate open drain by switching the pin between an
input and output driven low in this case. How are you configuring the GPIO's in the
FPGA?



> 
> Best regards
> Tim
> ---
>   arch/arm/boot/dts/socfpga.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 2c43c4d85dee..5f28632bc88c 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -643,6 +643,7 @@
>                          #size-cells = <0>;
>                          compatible = "snps,designware-i2c";
>                          reg = <0xffc04000 0x1000>;
> +                       resets = <&rst I2C0_RESET>;
>                          clocks = <&l4_sp_clk>;
>                          interrupts = <0 158 0x4>;
>                          status = "disabled";
> @@ -653,6 +654,7 @@
>                          #size-cells = <0>;
>                          compatible = "snps,designware-i2c";
>                          reg = <0xffc05000 0x1000>;
> +                       resets = <&rst I2C1_RESET>;
>                          clocks = <&l4_sp_clk>;
>                          interrupts = <0 159 0x4>;
>                          status = "disabled";
> @@ -663,6 +665,7 @@
>                          #size-cells = <0>;
>                          compatible = "snps,designware-i2c";
>                          reg = <0xffc06000 0x1000>;
> +                       resets = <&rst I2C2_RESET>;
>                          clocks = <&l4_sp_clk>;
>                          interrupts = <0 160 0x4>;
>                          status = "disabled";
> @@ -673,6 +676,7 @@
>                          #size-cells = <0>;
>                          compatible = "snps,designware-i2c";
>                          reg = <0xffc07000 0x1000>;
> +                       resets = <&rst I2C3_RESET>;
>                          clocks = <&l4_sp_clk>;
>                          interrupts = <0 161 0x4>;
>                          status = "disabled";
> 


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
