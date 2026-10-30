Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357384;
	b=eaTxRZZ6NdNbpbSoq8CqqXqIW5/JV1Rggk70KVAVKbSNMc6RBtgKEwL3q6NJvUbC9uNs
	 3+g16/UZJdy8KkG313jdChGMzHB0qJB4c9o6Kh4HuAqSvF6VaZzSlaHUpVZXQu3+4vkhE
	 gNidQlSRmLE443gfywj/CKQMhsQIpiZUHvnr6RSQ0l5OFn48PRwkHEkPbn2eT43kAsEEI
	 aogoUXkHvaUI0KoUy4ItJSiMEo0SC/gztQIEyABfnKQs0FVUEJFukdP+XnN/pKTnnobP4
	 U9Hi8UzE5Ey/0tPywJ1esROzlgL97xdVeGYLOTHR6TzX0KlykqoyuXGspiN6lcJ5WuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357384;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=M5JlZGMtPIuCXri1CvOi7+apBqpZ9BaS4Q7JJAZH5zg=;
	b=FY94+GMPa1CpXobaWpZ1bniOMoD2YmIeSqIJSNZUPZmcwiIw1TfOG8sFWfje7TSVBIK0
	 LvRcBin05rZfastJhgo9Yq3Djw5U4PssIX/7GyH+wjZz2l8wfJRe2h64SKHDtCPZDZJ1A
	 HbWcuv5zOd/HvXdf/ZLQvV7P+k/ClIRL3Tx1PtYe+NYqrkqbjNVn+N9TnhzuykS6Bl6Ek
	 q4l91naKNZH5j5lk1EXGFcQTDieZRvdlwb18v9o1iYCtWZJsbLxzkE/LXntzHfz/gwsYn
	 7yXmjlVXyGi1nFQ1Hvpb3PCHvvgSGahTwTb1tO6P0eSFCqlqJCtHrYx9rVcY6Ibzwow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stu.shzu.edu.cn;
	spf=none smtp.mailfrom=stu.shzu.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D2606A33E;
	Fri, 30 Oct 2026 10:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397D2606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stu.shzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=stu.shzu.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.shzu.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=M5JlZGMtPI
	uCXri1CvOi7+apBqpZ9BaS4Q7JJAZH5zg=; b=A2zofV7iIlsc8Ceg+aaswLaE0F
	ze3sm6KHODWb7X11IIAqeh2djGYidhQG2w2iq9KfZNR7yZ6c9xtBdldNgy9+vRCF
	Eha5XfMd5d1awuaoxILDlGHjB1iesPt6+0m/lNC68N4a2ngt9Tg9Qv7l0uZcqEq1
	f/GzFcYsnlToKAq0c=
Received: from kernel-build.. (unknown [39.144.207.123])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWHQM7duRqnoYJAQ--.10533S2;
	Fri, 30 Oct 2026 18:49:33 +0800 (CST)
From: Wang Xiong <20221010117@stu.shzu.edu.cn>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] i2c: robotfuzz-osif: use DMA-safe buffers for message data
Date: Fri, 30 Oct 2026 10:49:30 +0000
Message-ID: <20261030104931.3958-1-20221010117@stu.shzu.edu.cn>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkDWHQM7duRqnoYJAQ--.10533S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DtrWxuFW8tr1rJryDAwb_yoW8trykpa
	nxKFyqkFW2gr9avr42yr47Zry5Jw4rJFyxGF47t3Z7uFs7Jr1jgryktFW0gFy0gr97Xw45
	ta1kX34UGFn0qFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
	uYvjxU4F1vUUUUU
X-CM-SenderInfo: qsqsjiyqrqiiux6v33wovk63oohg3hdfq/1tbiAgUSCWrfb0EObQACsm

The SMBus emulation layer can pass stack-backed I2C message buffers to
the adapter. osif_xfer() forwards those buffers to usb_control_msg(),
which requires DMA-safe storage for nonzero data transfers. An archived
SMBus read report reaches the USB core's stack-buffer check and the
transfer is rejected.

Obtain a DMA-safe buffer for each nonempty message and release it after
the synchronous control transfer. Copy received data back only when the
full message completed. Keep the existing short-transfer error handling
and allow zero-length writes without treating them as allocation failures.

Assisted-by: LLM
Signed-off-by: Wang Xiong <20221010117@stu.shzu.edu.cn>
---
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 412fa8e37..786c3f1b4 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -59,28 +59,33 @@ static int osif_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 {
 	struct osif_priv *priv = adapter->algo_data;
 	struct i2c_msg *pmsg;
+	u8 *buf;
 	int ret;
 	int i;
 
 	for (i = 0; i < num; i++) {
 		pmsg = &msgs[i];
+		buf = pmsg->buf;
+		if (pmsg->len) {
+			buf = i2c_get_dma_safe_msg_buf(pmsg, 1);
+			if (!buf)
+				return -ENOMEM;
+		}
 
 		if (pmsg->flags & I2C_M_RD) {
 			ret = osif_usb_read(adapter, OSIFI2C_READ,
 					    pmsg->flags, pmsg->addr,
-					    pmsg->buf, pmsg->len);
-			if (ret != pmsg->len) {
-				dev_err(&adapter->dev, "failure reading data\n");
-				return -EREMOTEIO;
-			}
+					    buf, pmsg->len);
 		} else {
 			ret = osif_usb_write(adapter, OSIFI2C_WRITE,
 					     pmsg->flags, pmsg->addr,
-					     pmsg->buf, pmsg->len);
-			if (ret != pmsg->len) {
-				dev_err(&adapter->dev, "failure writing data\n");
-				return -EREMOTEIO;
-			}
+					     buf, pmsg->len);
+		}
+		i2c_put_dma_safe_msg_buf(buf, pmsg, ret == pmsg->len);
+		if (ret != pmsg->len) {
+			dev_err(&adapter->dev, "failure %s data\n",
+				pmsg->flags & I2C_M_RD ? "reading" : "writing");
+			return -EREMOTEIO;
 		}
 
 		ret = osif_usb_write(adapter, OSIFI2C_STOP, 0, 0, NULL, 0);
-- 
2.47.3

