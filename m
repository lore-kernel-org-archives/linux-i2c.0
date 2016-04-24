From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/12] nvmem: sunxi-sid: remove nvmem regmap dependency
Date: Sun, 24 Apr 2016 20:28:10 +0100
Message-ID: <1461526096-29584-7-git-send-email-srinivas.kandagatla@linaro.org>
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
 drivers/nvmem/sunxi_sid.c | 54 ++++++++---------------------------------------
 2 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index a87273b..377bc21 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -81,7 +81,6 @@ config ROCKCHIP_EFUSE
 config NVMEM_SUNXI_SID
 	tristate "Allwinner SoCs SID support"
 	depends on ARCH_SUNXI
-	select REGMAP_MMIO
 	help
 	  This is a driver for the 'security ID' available on various Allwinner
 	  devices.
diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index bc88b40..1567ccc 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -21,13 +21,14 @@
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/random.h>
 
 static struct nvmem_config econfig = {
 	.name = "sunxi-sid",
 	.read_only = true,
+	.stride = 4,
+	.word_size = 1,
 	.owner = THIS_MODULE,
 };
 
@@ -51,54 +52,23 @@ static u8 sunxi_sid_read_byte(const struct sunxi_sid *sid,
 	return sid_key; /* Only return the last byte */
 }
 
-static int sunxi_sid_read(void *context,
-			  const void *reg, size_t reg_size,
-			  void *val, size_t val_size)
+static int sunxi_sid_read(void *context, unsigned int offset,
+			  void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
-	unsigned int offset = *(u32 *)reg;
 	u8 *buf = val;
 
-	while (val_size) {
-		*buf++ = sunxi_sid_read_byte(sid, offset);
-		val_size--;
-		offset++;
-	}
-
-	return 0;
-}
+	while (bytes--)
+		*buf++ = sunxi_sid_read_byte(sid, offset++);
 
-static int sunxi_sid_write(void *context, const void *data, size_t count)
-{
-	/* Unimplemented, dummy to keep regmap core happy */
 	return 0;
 }
 
-static struct regmap_bus sunxi_sid_bus = {
-	.read = sunxi_sid_read,
-	.write = sunxi_sid_write,
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
-};
-
-static bool sunxi_sid_writeable_reg(struct device *dev, unsigned int reg)
-{
-	return false;
-}
-
-static struct regmap_config sunxi_sid_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 8,
-	.reg_stride = 1,
-	.writeable_reg = sunxi_sid_writeable_reg,
-};
-
 static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct nvmem_device *nvmem;
-	struct regmap *regmap;
 	struct sunxi_sid *sid;
 	int ret, i, size;
 	char *randomness;
@@ -113,16 +83,10 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 		return PTR_ERR(sid->base);
 
 	size = resource_size(res) - 1;
-	sunxi_sid_regmap_config.max_register = size;
-
-	regmap = devm_regmap_init(dev, &sunxi_sid_bus, sid,
-				  &sunxi_sid_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(regmap);
-	}
-
+	econfig.size = resource_size(res);
 	econfig.dev = dev;
+	econfig.reg_read = sunxi_sid_read;
+	econfig.priv = sid;
 	nvmem = nvmem_register(&econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
-- 
2.5.0
