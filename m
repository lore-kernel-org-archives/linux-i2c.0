From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 6/6] i2c: ismt: mark register space with __iomem
Date: Wed, 16 Sep 2015 17:24:03 +0300
Message-ID: <1442413443-123579-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442413443-123579-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This fixes the code to suppress sparse warnings like:

drivers/i2c/busses/i2c-ismt.c:725:36: warning: incorrect type in argument 2 (different address spaces)
drivers/i2c/busses/i2c-ismt.c:725:36:    expected void volatile [noderef] <asn:2>*addr
drivers/i2c/busses/i2c-ismt.c:725:36:    got void *

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-ismt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 48e0693..80648be 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -165,7 +165,7 @@ struct ismt_desc {
 
 struct ismt_priv {
 	struct i2c_adapter adapter;
-	void *smba;				/* PCI BAR */
+	void __iomem *smba;			/* PCI BAR */
 	struct pci_dev *pci_dev;
 	struct ismt_desc *hw;			/* descriptor virt base addr */
 	dma_addr_t io_rng_dma;			/* descriptor HW base addr */
-- 
2.5.1
