From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v6 3/9] i2c: iproc: Add support for more master error status
Date: Tue,  2 Apr 2019 18:18:24 -0700
Message-ID: <20190403011830.3254-4-ray.jui@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, Michael Cheng <ccheng@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

From: Michael Cheng <ccheng@broadcom.com>

Add support for more master error status including FIFO underrun and RX
FIFO full

Signed-off-by: Michael Cheng <ccheng@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 915c1b5aafd8..d64876cfa11c 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -73,6 +73,8 @@
 #define M_CMD_STATUS_NACK_ADDR       0x2
 #define M_CMD_STATUS_NACK_DATA       0x3
 #define M_CMD_STATUS_TIMEOUT         0x4
+#define M_CMD_STATUS_FIFO_UNDERRUN   0x5
+#define M_CMD_STATUS_RX_FIFO_FULL    0x6
 #define M_CMD_PROTOCOL_SHIFT         9
 #define M_CMD_PROTOCOL_MASK          0xf
 #define M_CMD_PROTOCOL_BLK_WR        0x7
@@ -536,6 +538,14 @@ static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 		dev_dbg(iproc_i2c->device, "bus timeout\n");
 		return -ETIMEDOUT;
 
+	case M_CMD_STATUS_FIFO_UNDERRUN:
+		dev_dbg(iproc_i2c->device, "FIFO under-run\n");
+		return -ENXIO;
+
+	case M_CMD_STATUS_RX_FIFO_FULL:
+		dev_dbg(iproc_i2c->device, "RX FIFO full\n");
+		return -ETIMEDOUT;
+
 	default:
 		dev_dbg(iproc_i2c->device, "unknown error code=%d\n", val);
 
-- 
2.17.1
