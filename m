From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 2/3] i2c: iproc: Fix typo in the driver
Date: Fri, 12 Feb 2016 13:10:42 -0800
Message-ID: <1455311443-30590-3-git-send-email-ray.jui@broadcom.com>
References: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>, Ray Jui <rjui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

From: Ray Jui <rjui@broadcom.com>

Fix typo in the driver from 'I2C_TIMEOUT_MESC' to 'I2C_TIMEOUT_MSEC'

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index ce062d3..c368159 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -76,7 +76,7 @@
 #define M_RX_DATA_SHIFT              0
 #define M_RX_DATA_MASK               0xff
 
-#define I2C_TIMEOUT_MESC             100
+#define I2C_TIMEOUT_MSEC             100
 #define M_TX_RX_FIFO_SIZE            64
 
 enum bus_speed_index {
@@ -207,7 +207,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	int ret, i;
 	u8 addr;
 	u32 val;
-	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MESC);
+	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
 
 	/* check if bus is busy */
 	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
-- 
1.9.1
