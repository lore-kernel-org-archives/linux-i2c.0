From: Jun Gao <jun.gao@mediatek.com>
Subject: [RESEND PATCH 1/2] Documentation: devicetree: Add i2c binding for
 mediatek MT2701 Soc Platform
Date: Wed, 18 Jan 2017 17:41:00 +0800
Message-ID: <1484732461-13594-2-git-send-email-jun.gao@mediatek.com>
References: <1484732461-13594-1-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484732461-13594-1-git-send-email-jun.gao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Jun Gao <jun.gao@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

From: Jun Gao <jun.gao@mediatek.com>

This add i2c DT binding to i2c-mt6577.txt for MT2701.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
index 0ce6fa3..ef22ecf 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
@@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
 
 Required properties:
   - compatible: value should be either of the following.
-      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
-      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
-      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
-      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
-      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
+	"mediatek,mt2701-i2c", for i2c compatible with mt2701 i2c.
+	"mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
+	"mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
+	"mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
+	"mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
+	"mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
-- 
1.7.9.5
