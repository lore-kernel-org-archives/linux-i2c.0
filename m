From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 17/21] i2c: qup: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:26 +0200
Message-ID: <20180514145330.4857-18-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Because it looks neater.
qup_i2c_write_tx_fifo_v1 is always called with a write in
qup->msg->flags.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 904dfec7ab96..025232207aeb 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -453,7 +453,7 @@ static void qup_i2c_write_tx_fifo_v1(struct qup_i2c_dev *qup)
 {
 	struct qup_i2c_block *blk = &qup->blk;
 	struct i2c_msg *msg = qup->msg;
-	u32 addr = msg->addr << 1;
+	u32 addr = i2c_8bit_addr_from_msg(msg);
 	u32 qup_tag;
 	int idx;
 	u32 val;
-- 
2.11.0
