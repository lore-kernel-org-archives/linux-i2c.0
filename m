From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: ismt: add error return code in probe()
Date: Fri, 23 Aug 2013 11:30:14 +0200
Message-ID: <1377250230-19166-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Return error code in the error case, and not success.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---

Error code itself is probably not perfect, but consistent :/ Improving the
return values might be considered for a later patch. Based on 3.11-rc6.

 drivers/i2c/busses/i2c-ismt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index cd82eb4..8ed79a0 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -879,6 +879,7 @@ ismt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 						 DMA_BIT_MASK(32)) != 0)) {
 			dev_err(&pdev->dev, "pci_set_dma_mask fail %p\n",
 				pdev);
+			err = -ENODEV;
 			goto fail;
 		}
 	}
-- 
1.7.10.4
