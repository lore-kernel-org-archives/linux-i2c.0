From: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] Document: i2c: Add a dt binding for mediatek MT2701 soc
Date: Mon, 4 Jan 2016 14:15:37 +0800
Message-ID: <1451888138-11471-1-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add a dt binding for the MT2701 soc.

Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt | 11 ++++++-----
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
1.8.1.1.dirty
