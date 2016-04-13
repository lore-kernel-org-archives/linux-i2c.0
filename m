From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] i2c: cpm: Fix build break due to incompatible pointer types
Date: Wed, 13 Apr 2016 13:59:14 +1000
Message-ID: <1460519954-9365-1-git-send-email-mpe@ellerman.id.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:51891 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933712AbcDMD7W (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Apr 2016 23:59:22 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linuxppc-dev@ozlabs.org, jochen@scram.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, scottwood@freescale.com

Since commit ea8daa7b9784 ("kbuild: Add option to turn incompatible
pointer check into error"), assignments from an incompatible pointer
types have become a hard error, eg:

  drivers/i2c/busses/i2c-cpm.c:545:91: error: passing argument 3 of
  'dma_alloc_coherent' from incompatible pointer type

Fix the build break by converting txdma & rxdma to dma_addr_t.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/i2c/busses/i2c-cpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

*** Build tested only.

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 714bdc837769..b167ab25310a 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -116,8 +116,8 @@ struct cpm_i2c {
 	cbd_t __iomem *rbase;
 	u_char *txbuf[CPM_MAXBD];
 	u_char *rxbuf[CPM_MAXBD];
-	u32 txdma[CPM_MAXBD];
-	u32 rxdma[CPM_MAXBD];
+	dma_addr_t txdma[CPM_MAXBD];
+	dma_addr_t rxdma[CPM_MAXBD];
 };
 
 static irqreturn_t cpm_i2c_interrupt(int irq, void *dev_id)
-- 
2.5.0
