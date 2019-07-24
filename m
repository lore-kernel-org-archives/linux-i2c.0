From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] i2c: iproc: Fix i2c master read more than 63 bytes
Date: Wed, 24 Jul 2019 13:58:27 +0530
Message-ID: <1563956907-21255-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Use SMBUS_MASTER_DATA_READ.MASTER_RD_STATUS bit to check for RX
FIFO empty condition because SMBUS_MASTER_FIFO_CONTROL.MASTER_RX_PKT_COUNT
is not updated for read >= 64 bytes. This fixes the issue when trying to
read from the I2C slave more than 63 bytes.

Fixes: c24b8d574b7c ("i2c: iproc: Extend I2C read up to 255 bytes")

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 2c7f145..d7fd76b 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -392,16 +392,18 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
 	struct i2c_msg *msg = iproc_i2c->msg;
+	uint32_t val;
 
 	/* Read valid data from RX FIFO */
 	while (iproc_i2c->rx_bytes < msg->len) {
-		if (!((iproc_i2c_rd_reg(iproc_i2c, M_FIFO_CTRL_OFFSET) >> M_FIFO_RX_CNT_SHIFT)
-		      & M_FIFO_RX_CNT_MASK))
+		val = iproc_i2c_rd_reg(iproc_i2c, M_RX_OFFSET);
+
+		/* rx fifo empty */
+		if (!((val >> M_RX_STATUS_SHIFT) & M_RX_STATUS_MASK))
 			break;
 
 		msg->buf[iproc_i2c->rx_bytes] =
-			(iproc_i2c_rd_reg(iproc_i2c, M_RX_OFFSET) >>
-			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
+			(val >> M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
 		iproc_i2c->rx_bytes++;
 	}
 }
-- 
1.9.1
