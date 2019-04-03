From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Date: Wed,  3 Apr 2019 14:05:35 -0700
Message-ID: <20190403210535.32236-1-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Change the iProc I2C driver to use the 'BIT' macro from all '1 << XXX'
bit operations to get rid of compiler warning and improve readability of
the code

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 562942d0c05c..a845b8decac8 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -717,7 +717,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 			/* mark the last byte */
 			if (i == msg->len - 1)
-				val |= 1 << M_TX_WR_STATUS_SHIFT;
+				val |= BIT(M_TX_WR_STATUS_SHIFT);
 
 			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
 		}
@@ -844,7 +844,7 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 
 	iproc_i2c->bus_speed = bus_speed;
 	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
-	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
+	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
 	val |= (bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
 	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
@@ -995,7 +995,7 @@ static int bcm_iproc_i2c_resume(struct device *dev)
 
 	/* configure to the desired bus speed */
 	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
-	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
+	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
 	val |= (iproc_i2c->bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
 	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
-- 
2.17.1
