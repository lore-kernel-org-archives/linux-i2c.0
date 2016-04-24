From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/12] nvmem: vif610-ocotp: remove nvmem regmap dependency
Date: Sun, 24 Apr 2016 20:28:09 +0100
Message-ID: <1461526096-29584-6-git-send-email-srinivas.kandagatla@linaro.org>
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
 drivers/nvmem/vf610-ocotp.c | 44 ++++++++++----------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
index 8641319..72e4faa 100644
--- a/drivers/nvmem/vf610-ocotp.c
+++ b/drivers/nvmem/vf610-ocotp.c
@@ -25,7 +25,6 @@
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 #include <linux/slab.h>
 
 /* OCOTP Register Offsets */
@@ -152,23 +151,16 @@ static int vf610_get_fuse_address(int base_addr_offset)
 	return -EINVAL;
 }
 
-static int vf610_ocotp_write(void *context, const void *data, size_t count)
-{
-	return 0;
-}
-
-static int vf610_ocotp_read(void *context,
-			const void *off, size_t reg_size,
-			void *val, size_t val_size)
+static int vf610_ocotp_read(void *context, unsigned int offset,
+			void *val, size_t bytes)
 {
 	struct vf610_ocotp *ocotp = context;
 	void __iomem *base = ocotp->base;
-	unsigned int offset = *(u32 *)off;
 	u32 reg, *buf = val;
 	int fuse_addr;
 	int ret;
 
-	while (val_size > 0) {
+	while (bytes > 0) {
 		fuse_addr = vf610_get_fuse_address(offset);
 		if (fuse_addr > 0) {
 			writel(ocotp->timing, base + OCOTP_TIMING);
@@ -205,29 +197,19 @@ static int vf610_ocotp_read(void *context,
 		}
 
 		buf++;
-		val_size--;
-		offset += reg_size;
+		bytes -= 4;
+		offset += 4;
 	}
 
 	return 0;
 }
 
-static struct regmap_bus vf610_ocotp_bus = {
-	.read = vf610_ocotp_read,
-	.write = vf610_ocotp_write,
-	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
-	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
-};
-
-static struct regmap_config ocotp_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-};
-
 static struct nvmem_config ocotp_config = {
 	.name = "ocotp",
 	.owner = THIS_MODULE,
+	.stride = 4,
+	.word_size = 4,
+	.reg_read = vf610_ocotp_read,
 };
 
 static const struct of_device_id ocotp_of_match[] = {
@@ -247,7 +229,6 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct regmap *regmap;
 	struct vf610_ocotp *ocotp_dev;
 
 	ocotp_dev = devm_kzalloc(&pdev->dev,
@@ -267,13 +248,8 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
 		return PTR_ERR(ocotp_dev->clk);
 	}
 
-	ocotp_regmap_config.max_register = resource_size(res);
-	regmap = devm_regmap_init(dev,
-		&vf610_ocotp_bus, ocotp_dev, &ocotp_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(regmap);
-	}
+	ocotp_config.size = resource_size(res);
+	ocotp_config.priv = ocotp_dev;
 	ocotp_config.dev = dev;
 
 	ocotp_dev->nvmem = nvmem_register(&ocotp_config);
-- 
2.5.0
