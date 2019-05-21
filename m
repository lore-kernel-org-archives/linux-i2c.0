From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 7/8] MAINTAINERS: add I2C DT bindings to Versatile platform
Date: Tue, 21 May 2019 10:21:36 +0200
Message-ID: <20190521082137.2889-8-wsa@the-dreams.de>
References: <20190521082137.2889-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521082137.2889-1-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cce1173be35c..169131ff33ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1175,6 +1175,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/arm-boards
 F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
 F:	Documentation/devicetree/bindings/clock/arm-integrator.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
 F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
 F:	arch/arm/mach-integrator/
-- 
2.19.1
