From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Subject: [PATCH 3/3] i2c: qup: Use devm_platform_ioremap_resource helper
Date: Tue, 17 Sep 2019 00:32:54 +0530
Message-ID: <20190916190254.GA14207@SD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use devm_platform_ioremap_resource helper which wraps
platform_get_resource() and devm_ioremap_resource() together.

The semantic patch that makes this report is available
in scripts/coccinelle/api/devm_platform_ioremap_resource.cocci.

Found using - http://coccinelle.lip6.fr/

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/i2c/busses/i2c-qup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 23c4893512b2..2d21168f81a0 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1663,7 +1663,6 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	static const int blk_sizes[] = {4, 16, 32};
 	struct qup_i2c_dev *qup;
 	unsigned long one_bit_t;
-	struct resource *res;
 	u32 io_mode, hw_ver, size;
 	int ret, fs_div, hs_div;
 	u32 src_clk_freq = DEFAULT_SRC_CLK;
@@ -1760,8 +1759,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	qup->base = devm_ioremap_resource(qup->dev, res);
+	qup->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qup->base))
 		return PTR_ERR(qup->base);

--
2.20.1
