From: Naveen Kaje <nkaje@codeaurora.org>
Subject: [PATCH 2/2] i2c: qup: support SMBus block read
Date: Tue,  3 May 2016 17:25:59 -0600
Message-ID: <1462317959-11632-2-git-send-email-nkaje@codeaurora.org>
References: <1462317959-11632-1-git-send-email-nkaje@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462317959-11632-1-git-send-email-nkaje@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rruigrok@codeaurora.org, timur@codeaurora.org, cov@codeaurora.org, Naveen Kaje <nkaje@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

I2C QUP driver relies on SMBus emulation support from the framework.
To handle SMBus block reads, the driver should check I2C_M_RECV_LEN
flag and should read the first byte received as the message length.

The driver configures the QUP hardware to read one byte. Once the
message length is known from this byte, the QUP hardware is
configured to read the rest.

Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 95 ++++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index ef31b26..2658b67 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -526,38 +526,49 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
 
 	int last = (qup->blk.pos == (qup->blk.count - 1)) && (qup->is_last);
 
-	if (qup->blk.pos == 0) {
-		tags[len++] = QUP_TAG_V2_START;
-		tags[len++] = addr & 0xff;
+	/* Handle SMBus block data read */
+	if ((msg->flags & I2C_M_RD) && (msg->flags & I2C_M_RECV_LEN) &&
+	    (msg->len > 1)) {
+		tags[len++] = QUP_TAG_V2_DATARD_STOP;
+		data_len = qup_i2c_get_data_len(qup);
+		tags[len++] = data_len - 1;
+	} else {
+		if (qup->blk.pos == 0) {
+			tags[len++] = QUP_TAG_V2_START;
+			tags[len++] = addr & 0xff;
 
-		if (msg->flags & I2C_M_TEN)
-			tags[len++] = addr >> 8;
-	}
+			if (msg->flags & I2C_M_TEN)
+				tags[len++] = addr >> 8;
+		}
 
-	/* Send _STOP commands for the last block */
-	if (last) {
-		if (msg->flags & I2C_M_RD)
-			tags[len++] = QUP_TAG_V2_DATARD_STOP;
-		else
-			tags[len++] = QUP_TAG_V2_DATAWR_STOP;
-	} else {
-		if (msg->flags & I2C_M_RD)
+		/* Send _STOP commands for the last block */
+		if ((msg->flags & I2C_M_RD)
+			&& (msg->flags & I2C_M_RECV_LEN)) {
 			tags[len++] = QUP_TAG_V2_DATARD;
-		else
-			tags[len++] = QUP_TAG_V2_DATAWR;
-	}
+		} else if (last) {
+			if (msg->flags & I2C_M_RD)
+				tags[len++] = QUP_TAG_V2_DATARD_STOP;
+			else
+				tags[len++] = QUP_TAG_V2_DATAWR_STOP;
+		} else {
+			if (msg->flags & I2C_M_RD)
+				tags[len++] = QUP_TAG_V2_DATARD;
+			else
+				tags[len++] = QUP_TAG_V2_DATAWR;
+		}
 
-	data_len = qup_i2c_get_data_len(qup);
+		data_len = qup_i2c_get_data_len(qup);
 
-	/* 0 implies 256 bytes */
-	if (data_len == QUP_READ_LIMIT)
-		tags[len++] = 0;
-	else
-		tags[len++] = data_len;
+		/* 0 implies 256 bytes */
+		if (data_len == QUP_READ_LIMIT)
+			tags[len++] = 0;
+		else
+			tags[len++] = data_len;
 
-	if ((msg->flags & I2C_M_RD) && last && is_dma) {
-		tags[len++] = QUP_BAM_INPUT_EOT;
-		tags[len++] = QUP_BAM_FLUSH_STOP;
+		if ((msg->flags & I2C_M_RD) && last && is_dma) {
+			tags[len++] = QUP_BAM_INPUT_EOT;
+			tags[len++] = QUP_BAM_FLUSH_STOP;
+		}
 	}
 
 	return len;
@@ -1065,9 +1076,18 @@ static int qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
 				struct i2c_msg *msg)
 {
 	u32 val;
-	int idx, pos = 0, ret = 0, total;
+	int idx, pos = 0, ret = 0, total, msg_offset = 0, msg_pos;
 
+	/*
+	 * If the message length is already read in
+	 * the first byte of the buffer, account for
+	 * that by setting the offset
+	 */
+	if ((msg->flags & I2C_M_RECV_LEN) &&
+	    (msg->len > 1))
+		msg_offset = 1;
 	total = qup_i2c_get_data_len(qup);
+	total -= msg_offset;
 
 	/* 2 extra bytes for read tags */
 	while (pos < (total + 2)) {
@@ -1087,8 +1107,9 @@ static int qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
 
 			if (pos >= (total + 2))
 				goto out;
-
-			msg->buf[qup->pos++] = val & 0xff;
+			msg_pos = qup->pos + msg_offset;
+			msg->buf[msg_pos] = val & 0xff;
+			qup->pos++;
 		}
 	}
 
@@ -1128,6 +1149,22 @@ static int qup_i2c_read_one_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 			goto err;
 
 		qup->blk.pos++;
+
+		/* Handle SMBus block read length */
+		if ((msg->flags & I2C_M_RECV_LEN) && (msg->len == 1)) {
+			if (msg->buf[0] > I2C_SMBUS_BLOCK_MAX) {
+				ret = -EPROTO;
+				goto err;
+			}
+			msg->len += msg->buf[0];
+			qup->pos = 0;
+			qup_i2c_set_read_mode_v2(qup, msg->len);
+			qup_i2c_issue_xfer_v2(qup, msg);
+			ret = qup_i2c_wait_for_complete(qup, msg);
+			if (ret)
+				goto err;
+			qup_i2c_set_blk_data(qup, msg);
+		}
 	} while (qup->blk.pos < qup->blk.count);
 
 err:
-- 
1.8.2.1
