From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Subject: [PATCH 1/3] i2c: qup: remove explicit conversion to boolean
Date: Tue, 17 Sep 2019 00:27:38 +0530
Message-ID: <20190916185738.GA14035@SD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Relational and logical operators evaluate to bool,
explicit conversion is overly verbose and unneeded.

Found using - Coccinelle (http://coccinelle.lip6.fr)

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/i2c/busses/i2c-qup.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index e09cd0775ae9..5519c19bfd9c 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -961,10 +961,8 @@ static void qup_i2c_conf_v1(struct qup_i2c_dev *qup)
 	u32 qup_config = I2C_MINI_CORE | I2C_N_VAL;
 	u32 io_mode = QUP_REPACK_EN;

-	blk->is_tx_blk_mode =
-		blk->total_tx_len > qup->out_fifo_sz ? true : false;
-	blk->is_rx_blk_mode =
-		blk->total_rx_len > qup->in_fifo_sz ? true : false;
+	blk->is_tx_blk_mode = blk->total_tx_len > qup->out_fifo_sz;
+	blk->is_rx_blk_mode = blk->total_rx_len > qup->in_fifo_sz;

 	if (blk->is_tx_blk_mode) {
 		io_mode |= QUP_OUTPUT_BLK_MODE;
@@ -1532,10 +1530,10 @@ qup_i2c_determine_mode_v2(struct qup_i2c_dev *qup,
 	    (total_len > qup->out_fifo_sz || total_len > qup->in_fifo_sz)) {
 		qup->use_dma = true;
 	} else {
-		qup->blk.is_tx_blk_mode = max_tx_len > qup->out_fifo_sz -
-			QUP_MAX_TAGS_LEN ? true : false;
-		qup->blk.is_rx_blk_mode = max_rx_len > qup->in_fifo_sz -
-			READ_RX_TAGS_LEN ? true : false;
+		qup->blk.is_tx_blk_mode =
+			max_tx_len > qup->out_fifo_sz - QUP_MAX_TAGS_LEN;
+		qup->blk.is_rx_blk_mode =
+			max_rx_len > qup->in_fifo_sz - READ_RX_TAGS_LEN;
 	}

 	return 0;
--
2.20.1
