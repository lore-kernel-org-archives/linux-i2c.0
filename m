From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v2 2/3] MAINTAINERS: add zx2967 i2c controller driver to ARM ZTE architecture
Date: Mon, 23 Jan 2017 13:03:25 +0800
Message-ID: <1485147806-17792-2-git-send-email-baoyou.xie@linaro.org>
References: <1485147806-17792-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485147806-17792-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.shevchenko@gmail.com, jun.nie@linaro.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
List-Id: linux-i2c@vger.kernel.org

Add the zx2967 i2c controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 275c434..757c098 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1987,12 +1987,14 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
+F:	drivers/i2c/busses/i2c-zx2967.c
 F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
 F:	drivers/thermal/zx*
 F:	drivers/watchdog/zx2967_wdt.c
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
 F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	Documentation/devicetree/bindings/thermal/zx*
-- 
2.7.4
