From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/6] i2c: ismt: do not duplicate msi_enabled flag
Date: Wed, 16 Sep 2015 17:24:00 +0300
Message-ID: <1442413443-123579-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442413443-123579-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

struct pci_dev already has a flag to track if MSI is enabled or not. Use it
directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-ismt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 570b0a0..6c2058d 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -172,7 +172,6 @@ struct ismt_priv {
 	u8 head;				/* ring buffer head pointer */
 	struct completion cmp;			/* interrupt completion */
 	u8 dma_buffer[I2C_SMBUS_BLOCK_MAX + 1];	/* temp R/W data buffer */
-	bool using_msi;				/* type of interrupt flag */
 };
 
 /**
@@ -398,7 +397,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 	desc->tgtaddr_rw = ISMT_DESC_ADDR_RW(addr, read_write);
 
 	/* Initialize common control bits */
-	if (likely(priv->using_msi))
+	if (likely(pci_dev_msi_enabled(priv->pci_dev)))
 		desc->control = ISMT_DESC_INT | ISMT_DESC_FAIR;
 	else
 		desc->control = ISMT_DESC_FAIR;
@@ -806,7 +805,6 @@ static int ismt_int_init(struct ismt_priv *priv)
 		goto intx;
 	}
 
-	priv->using_msi = true;
 	goto done;
 
 	/* Try using legacy interrupts */
@@ -822,8 +820,6 @@ intx:
 		return -ENODEV;
 	}
 
-	priv->using_msi = false;
-
 done:
 	return 0;
 }
-- 
2.5.1
