From: Tim Sander <tim@krieglstein.org>
Subject: Re: RFC: i2c designware gpio recovery
Date: Fri, 28 Apr 2017 18:14:17 +0200
Message-ID: <2269277.HqpbCE3B5H@dabox>
References: <2259005.m0altzP21Z@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2259005.m0altzP21Z@dabox>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi 

After sending this mail i just found out how i could reset the i2c-1 controller manually with
devmem 0xffd05014 32 0x2000
devmem 0xffd05014 32 0

So i took a look into the device tree file socfpga.dtsi and found that the reset lines
where not defined (although available in the corresponding reset manager). Is there a
reason for this? Other components are connected.

However with the patch below my previously sent patch works!

If there is interest in would cleanup the patch and send it in for mainlining.
I think the most unacceptable part would be this line:
+       ret = gpio_request_one(bri->scl_gpio, //GPIOF_OPEN_DRAIN |
My gpio drivers refuse to work as output as they have no open drain mode.
So i wonder how to get this solved in a clean manner.

Best regards
Tim
---
 arch/arm/boot/dts/socfpga.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 2c43c4d85dee..5f28632bc88c 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -643,6 +643,7 @@
                        #size-cells = <0>;
                        compatible = "snps,designware-i2c";
                        reg = <0xffc04000 0x1000>;
+                       resets = <&rst I2C0_RESET>;
                        clocks = <&l4_sp_clk>;
                        interrupts = <0 158 0x4>;
                        status = "disabled";
@@ -653,6 +654,7 @@
                        #size-cells = <0>;
                        compatible = "snps,designware-i2c";
                        reg = <0xffc05000 0x1000>;
+                       resets = <&rst I2C1_RESET>;
                        clocks = <&l4_sp_clk>;
                        interrupts = <0 159 0x4>;
                        status = "disabled";
@@ -663,6 +665,7 @@
                        #size-cells = <0>;
                        compatible = "snps,designware-i2c";
                        reg = <0xffc06000 0x1000>;
+                       resets = <&rst I2C2_RESET>;
                        clocks = <&l4_sp_clk>;
                        interrupts = <0 160 0x4>;
                        status = "disabled";
@@ -673,6 +676,7 @@
                        #size-cells = <0>;
                        compatible = "snps,designware-i2c";
                        reg = <0xffc07000 0x1000>;
+                       resets = <&rst I2C3_RESET>;
                        clocks = <&l4_sp_clk>;
                        interrupts = <0 161 0x4>;
                        status = "disabled";
-- 
2.7.4
