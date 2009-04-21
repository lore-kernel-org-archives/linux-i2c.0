From: Mark Ware <mware-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
Subject: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than NULL
Date: Tue, 21 Apr 2009 22:49:02 +1000
Message-ID: <49EDC0BE.7040505@elphinstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Recent DMA changes result in a BUG() when NULL is passed to
dma_alloc_coherent in place of a device.

Signed-off-by: Mark Ware <mware-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
---

This patch fixes the BUG() during boot that has appeared during the
2.6.30 window. It has been tested and appears correct on my 8280 based
board.
Sent to both linuxppc-dev and linux-i2c, since I'm not sure where it belongs.


  drivers/i2c/busses/i2c-cpm.c |   14 ++++++++------
  1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 3fcf78e..83276d2 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -532,7 +532,8 @@ static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)

  	for (i = 0; i < CPM_MAXBD; i++) {
  		cpm->rxbuf[i] = dma_alloc_coherent(
-			NULL, CPM_MAX_READ + 1, &cpm->rxdma[i], GFP_KERNEL);
+			&cpm->ofdev->dev, CPM_MAX_READ + 1, &cpm->rxdma[i],
+			GFP_KERNEL);
  		if (!cpm->rxbuf[i]) {
  			ret = -ENOMEM;
  			goto out_muram;
@@ -540,7 +541,8 @@ static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)
  		out_be32(&rbdf[i].cbd_bufaddr, ((cpm->rxdma[i] + 1) & ~1));

  		cpm->txbuf[i] = (unsigned char *)dma_alloc_coherent(
-			NULL, CPM_MAX_READ + 1, &cpm->txdma[i], GFP_KERNEL);
+			&cpm->ofdev->dev, CPM_MAX_READ + 1, &cpm->txdma[i],
+			GFP_KERNEL);
  		if (!cpm->txbuf[i]) {
  			ret = -ENOMEM;
  			goto out_muram;
@@ -585,10 +587,10 @@ static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)
  out_muram:
  	for (i = 0; i < CPM_MAXBD; i++) {
  		if (cpm->rxbuf[i])
-			dma_free_coherent(NULL, CPM_MAX_READ + 1,
+			dma_free_coherent(&cpm->ofdev->dev, CPM_MAX_READ + 1,
  				cpm->rxbuf[i], cpm->rxdma[i]);
  		if (cpm->txbuf[i])
-			dma_free_coherent(NULL, CPM_MAX_READ + 1,
+			dma_free_coherent(&cpm->ofdev->dev, CPM_MAX_READ + 1,
  				cpm->txbuf[i], cpm->txdma[i]);
  	}
  	cpm_muram_free(cpm->dp_addr);
@@ -619,9 +621,9 @@ static void cpm_i2c_shutdown(struct cpm_i2c *cpm)

  	/* Free all memory */
  	for (i = 0; i < CPM_MAXBD; i++) {
-		dma_free_coherent(NULL, CPM_MAX_READ + 1,
+		dma_free_coherent(&cpm->ofdev->dev, CPM_MAX_READ + 1,
  			cpm->rxbuf[i], cpm->rxdma[i]);
-		dma_free_coherent(NULL, CPM_MAX_READ + 1,
+		dma_free_coherent(&cpm->ofdev->dev, CPM_MAX_READ + 1,
  			cpm->txbuf[i], cpm->txdma[i]);
  	}

-- 
1.5.6.5
