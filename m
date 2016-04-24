From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 07/12] nvmem: rockchip-efuse: remove nvmem regmap dependency
Date: Sun, 24 Apr 2016 20:28:11 +0100
Message-ID: <1461526096-29584-8-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1461526096-29584-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch moves to nvmem support in the driver to use callback
instead of regmap.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/nvmem/rockchip-efuse.c | 49 ++++++++----------------------------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index a009795..4d3f391 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
 #define EFUSE_A_SHIFT			6
 #define EFUSE_A_MASK			0x3ff
@@ -41,17 +40,9 @@ struct rockchip_efuse_chip {
 	struct clk *clk;
 };
 
-static int rockchip_efuse_write(void *context, const void *data, size_t count)
+static int rockchip_efuse_read(void *context, unsigned int offset,
+			       void *val, size_t bytes)
 {
-	/* Nothing TBD, Read-Only */
-	return 0;
-}
-
-static int rockchip_efuse_read(void *context,
-			       const void *reg, size_t reg_size,
-			       void *val, size_t val_size)
-{
-	unsigned int offset = *(u32 *)reg;
 	struct rockchip_efuse_chip *efuse = context;
 	u8 *buf = val;
 	int ret;
@@ -64,12 +55,12 @@ static int rockchip_efuse_read(void *context,
 
 	writel(EFUSE_LOAD | EFUSE_PGENB, efuse->base + REG_EFUSE_CTRL);
 	udelay(1);
-	while (val_size) {
+	while (bytes--) {
 		writel(readl(efuse->base + REG_EFUSE_CTRL) &
 			     (~(EFUSE_A_MASK << EFUSE_A_SHIFT)),
 			     efuse->base + REG_EFUSE_CTRL);
 		writel(readl(efuse->base + REG_EFUSE_CTRL) |
-			     ((offset & EFUSE_A_MASK) << EFUSE_A_SHIFT),
+			     ((offset++ & EFUSE_A_MASK) << EFUSE_A_SHIFT),
 			     efuse->base + REG_EFUSE_CTRL);
 		udelay(1);
 		writel(readl(efuse->base + REG_EFUSE_CTRL) |
@@ -79,9 +70,6 @@ static int rockchip_efuse_read(void *context,
 		writel(readl(efuse->base + REG_EFUSE_CTRL) &
 		     (~EFUSE_STROBE), efuse->base + REG_EFUSE_CTRL);
 		udelay(1);
-
-		val_size -= 1;
-		offset += 1;
 	}
 
 	/* Switch to standby mode */
@@ -92,22 +80,11 @@ static int rockchip_efuse_read(void *context,
 	return 0;
 }
 
-static struct regmap_bus rockchip_efuse_bus = {
-	.read = rockchip_efuse_read,
-	.write = rockchip_efuse_write,
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
-};
-
-static struct regmap_config rockchip_efuse_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 1,
-	.val_bits = 8,
-};
-
 static struct nvmem_config econfig = {
 	.name = "rockchip-efuse",
 	.owner = THIS_MODULE,
+	.stride = 1,
+	.word_size = 1,
 	.read_only = true,
 };
 
@@ -121,7 +98,6 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct nvmem_device *nvmem;
-	struct regmap *regmap;
 	struct rockchip_efuse_chip *efuse;
 
 	efuse = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_efuse_chip),
@@ -139,16 +115,9 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 		return PTR_ERR(efuse->clk);
 
 	efuse->dev = &pdev->dev;
-
-	rockchip_efuse_regmap_config.max_register = resource_size(res) - 1;
-
-	regmap = devm_regmap_init(efuse->dev, &rockchip_efuse_bus,
-				  efuse, &rockchip_efuse_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(efuse->dev, "regmap init failed\n");
-		return PTR_ERR(regmap);
-	}
-
+	econfig.size = resource_size(res);
+	econfig.reg_read = rockchip_efuse_read;
+	econfig.priv = efuse;
 	econfig.dev = efuse->dev;
 	nvmem = nvmem_register(&econfig);
 	if (IS_ERR(nvmem))
-- 
2.5.0
