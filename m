From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v9 6/8] dt-bindings: i2c: rk3x: add support for rk3399
Date: Thu, 12 May 2016 15:57:59 +0800
Message-ID: <1463039879-8318-1-git-send-email-david.wu@rock-chips.com>
References: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:58220 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbcELH6K (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 May 2016 03:58:10 -0400
In-Reply-To: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

The bus clock and function clock are separated at rk3399,
and others use one clock as the bus clock and function clock.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Change in v9:
- remove unnecessary "REQUIRED".

Change in v8:
- remove error description.

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index 0b4a85f..bbc5a1e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -6,10 +6,20 @@ RK3xxx SoCs.
 Required properties :
 
  - reg : Offset and length of the register set for the device
- - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c",
-		"rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
+ - compatible: should be one of the following:
+   - "rockchip,rk3066-i2c": for rk3066
+   - "rockchip,rk3188-i2c": for rk3188
+   - "rockchip,rk3228-i2c": for rk3228
+   - "rockchip,rk3288-i2c": for rk3288
+   - "rockchip,rk3399-i2c": for rk3399
  - interrupts : interrupt number
- - clocks : parent clock
+ - clocks: See ../clock/clock-bindings.txt
+   - For older hardware (rk3066, rk3188, rk3228, rk3288):
+     - There is one clock that's used both to derive the functional clock
+       for the device and as the bus clock.
+   - For newer hardware (rk3399): specified by name
+     - "i2c": This is used to derive the functional clock.
+     - "pclk": This is the bus clock.
 
 Required on RK3066, RK3188 :
 
-- 
1.9.1
