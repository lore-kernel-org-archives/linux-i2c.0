From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/12] nvmem: mtk-efuse: remove nvmem regmap dependency
Date: Sun, 24 Apr 2016 20:28:12 +0100
Message-ID: <1461526096-29584-9-git-send-email-srinivas.kandagatla@linaro.org>
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
 drivers/nvmem/Kconfig     |  1 -
 drivers/nvmem/mtk-efuse.c | 47 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 377bc21..c158712 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -48,7 +48,6 @@ config NVMEM_MXS_OCOTP
 config MTK_EFUSE
 	tristate "Mediatek SoCs EFUSE support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	select REGMAP_MMIO
 	help
 	  This is a driver to access hardware related data like sensor
 	  calibration, HDMI impedance etc.
diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 9c49369..32fd572 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -14,15 +14,35 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
-static struct regmap_config mtk_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-};
+static int mtk_reg_read(void *context,
+			unsigned int reg, void *_val, size_t bytes)
+{
+	void __iomem *base = context;
+	u32 *val = _val;
+	int i = 0, words = bytes / 4;
+
+	while (words--)
+		*val++ = readl(base + reg + (i++ * 4));
+
+	return 0;
+}
+
+static int mtk_reg_write(void *context,
+			 unsigned int reg, void *_val, size_t bytes)
+{
+	void __iomem *base = context;
+	u32 *val = _val;
+	int i = 0, words = bytes / 4;
+
+	while (words--)
+		writel(*val++, base + reg + (i++ * 4));
+
+	return 0;
+}
 
 static int mtk_efuse_probe(struct platform_device *pdev)
 {
@@ -30,7 +50,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct nvmem_config *econfig;
-	struct regmap *regmap;
 	void __iomem *base;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -42,14 +61,12 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	if (!econfig)
 		return -ENOMEM;
 
-	mtk_regmap_config.max_register = resource_size(res) - 1;
-
-	regmap = devm_regmap_init_mmio(dev, base, &mtk_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(regmap);
-	}
-
+	econfig->stride = 4;
+	econfig->word_size = 4;
+	econfig->reg_read = mtk_reg_read;
+	econfig->reg_write = mtk_reg_write;
+	econfig->size = resource_size(res);
+	econfig->priv = base;
 	econfig->dev = dev;
 	econfig->owner = THIS_MODULE;
 	nvmem = nvmem_register(econfig);
-- 
2.5.0
