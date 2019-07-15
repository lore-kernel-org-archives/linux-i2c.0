From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 06/24] i2c: ismt: Remove call to memset after dmam_alloc_coherent
Date: Mon, 15 Jul 2019 11:17:39 +0800
Message-ID: <20190715031739.6467-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: linux-i2c@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/i2c/busses/i2c-ismt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 02d23edb2fb1..2f95e25a10f7 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -781,8 +781,6 @@ static int ismt_dev_init(struct ismt_priv *priv)
 	if (!priv->hw)
 		return -ENOMEM;
 
-	memset(priv->hw, 0, (ISMT_DESC_ENTRIES * sizeof(struct ismt_desc)));
-
 	priv->head = 0;
 	init_completion(&priv->cmp);
 
-- 
2.11.0
