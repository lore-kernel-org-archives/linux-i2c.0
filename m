From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v8 6/8] dt-bindings: i2c: rk3x: add support for rk3399
Date: Wed, 11 May 2016 03:30:47 +0800
Message-ID: <1462908647-27236-1-git-send-email-david.wu@rock-chips.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462908252-27016-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The bus clock and function clock are separated at rk3399,
and others use one clock as the bus clock and function clock.

Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Change in v8:
- remove error description.

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index 0b4a85f..5429301 100644
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
+     - "i2c": REQUIRED. This is used to derive the functional clock.
+     - "pclk": REQUIRED. This is the bus clock.
 
 Required on RK3066, RK3188 :
 
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
