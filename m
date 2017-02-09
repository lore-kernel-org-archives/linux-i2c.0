From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v6 2/3] MAINTAINERS: add zx2967 i2c controller driver to ARM
 ZTE architecture
Date: Thu,  9 Feb 2017 17:32:32 +0800
Message-ID: <1486632753-17363-2-git-send-email-baoyou.xie@linaro.org>
References: <1486632753-17363-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486632753-17363-1-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawnguo@kernel.org, andy.shevchenko@gmail.com, jun.nie@linaro.org, baoyou.xie@linaro.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, chen.chaokai@zte.com.cn, linux-i2c@vger.kernel.org, wang.qiang01@zte.com.cn, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Add the zx2967 i2c controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e63063b..313fab5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1987,9 +1987,11 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
+F:	drivers/i2c/busses/i2c-zx2967.c
 F:	drivers/soc/zte/
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	include/dt-bindings/soc/zx*.h
 
-- 
2.7.4
