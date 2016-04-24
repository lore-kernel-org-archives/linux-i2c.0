From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/12] nvmem: qfprom: remove nvmem regmap dependency
Date: Sun, 24 Apr 2016 20:28:08 +0100
Message-ID: <1461526096-29584-5-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1461526096-29584-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch moves to nvmem support in the driver to use callback instead of
regmap.

Reported-by: Rajendra Nayak <rjendra-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/nvmem/Kconfig  |  1 -
 drivers/nvmem/qfprom.c | 56 +++++++++++++++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 36f4f4b..a87273b 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -60,7 +60,6 @@ config QCOM_QFPROM
 	tristate "QCOM QFPROM Support"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
-	select REGMAP_MMIO
 	help
 	  Say y here to enable QFPROM support. The QFPROM provides access
 	  functions for QFPROM data to rest of the drivers via nvmem interface.
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 3829e5f..b5305f0 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -13,21 +13,35 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
-static struct regmap_config qfprom_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 8,
-	.reg_stride = 1,
-	.val_format_endian = REGMAP_ENDIAN_LITTLE,
-};
+static int qfprom_reg_read(void *context,
+			unsigned int reg, void *_val, size_t bytes)
+{
+	void __iomem *base = context;
+	u32 *val = _val;
+	int i = 0, words = bytes / 4;
 
-static struct nvmem_config econfig = {
-	.name = "qfprom",
-	.owner = THIS_MODULE,
-};
+	while (words--)
+		*val++ = readl(base + reg + (i++ * 4));
+
+	return 0;
+}
+
+static int qfprom_reg_write(void *context,
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
 
 static int qfprom_remove(struct platform_device *pdev)
 {
@@ -36,12 +50,20 @@ static int qfprom_remove(struct platform_device *pdev)
 	return nvmem_unregister(nvmem);
 }
 
+static struct nvmem_config econfig = {
+	.name = "qfprom",
+	.owner = THIS_MODULE,
+	.stride = 4,
+	.word_size = 1,
+	.reg_read = qfprom_reg_read,
+	.reg_write = qfprom_reg_write,
+};
+
 static int qfprom_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct nvmem_device *nvmem;
-	struct regmap *regmap;
 	void __iomem *base;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -49,14 +71,10 @@ static int qfprom_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	qfprom_regmap_config.max_register = resource_size(res) - 1;
-
-	regmap = devm_regmap_init_mmio(dev, base, &qfprom_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(regmap);
-	}
+	econfig.size = resource_size(res);
 	econfig.dev = dev;
+	econfig.priv = base;
+
 	nvmem = nvmem_register(&econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
-- 
2.5.0
