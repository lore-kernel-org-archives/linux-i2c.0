Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794664975;
	b=ariTv1wkRaFP1c0TjbRHwstsv4v4Ujz5DsM5iT6chd1ZTnrs0EI85/3CjTIpnE2a5aQW
	 Uzbr6L/kWGTRbjDQRrIXe6yuqOdGzRAkbK/MYHRbxzrG8IXpJHG06g5W/9TaIXUdo64X9
	 ApTYxadzOp5DLkWtMHHbkvZffIc79zXn5WzbhfU6KY2vJKdnBVGoZkRScvIiUBXveujn6
	 MPpIDMsJJo2aFRtFbnY3uBN/wv/S6uBn/u1L9o1qQoWPi0sHn7cVMIPTvSgoi+JO9GOXg
	 b7VvTN/BNdrFmcXyicQcgWlhcr6oPM79+dQHaL3+SCq1QNkfJX8sP9SGC5agX/McY5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664975;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hyjEvWjCmu9ZhqykLopS+0U4K+phVlInpXperM3Jliw=;
	b=LxYWNyyPzoJMSxzKxegf6ySx9997VO3fx3IYqognDlSOWb5nsUOCToH3V8JY6hX6P3Hr
	 EIEq+ARQElk6LJ4f3ltDIBzv1fyz+8F6RVhhnytXC5O+EU4mSkqb7coWnRx0hxt5Uot8P
	 oMJZwi/25RlI5USCtvMGvAQ2UJcVzdJYzZeu3cMiLyL4N/yx+DbBMdSY3VKZsD5t/Q7Dg
	 gBqRJprIzoDGRZkuxGDRIWtpVpe4GjcFtWiv+31RDF7IgQf9aX8N7QGwNdWGGeTsJF+MJ
	 KHZ7Q7snFLi5bHzQIGlZwsj/F+70kif+lDfMAhfGZaNF4Ad4RJa7xAC77s7sk0wLlDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyfieUFo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65169606A327;
	Sat, 14 Nov 2026 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyfieUFo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794664975;
	b=du+zeb9dFdwa6PR3y0vU+JiHER4aEM/fWx89NDXpUhNoruxaG3JXmTgQJueDLXgrtrC0
	 ZBaoM2BhlD6NPS+/kHFlfj3YUBSflUlsoSXwu11bXNIOhyYMyczIVfpLVwnW2vbqSqurt
	 3Z+7r5gCNCGZ1Ka5uXtdipr5Daj8i3CseWQa9uyYPtM0cu7pcd+ELHRtm4GWmM8Opxx9y
	 ZqyBKzWgFpn9U93haM443fUPl8CA6pZrcw1MLNEuLJPI0IwiEaW594KV3SFJVRh57pgDQ
	 ErFjc1UPT9vZbTQzwtXXs3c3kNV2M30Wrpwd3xpu2Y4j+xZFz464z7xIyvFvvJLj1dQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794664975;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hyjEvWjCmu9ZhqykLopS+0U4K+phVlInpXperM3Jliw=;
	b=HJEAGqAHU2mnTAQZO2rZBLtgZoAnPyLmUPlnDC7JtWSvcYdNqEj+1tWWCATQILUfTnok
	 vjVR3fOmdktDYzP2Dg7q+noAYHPHsrxCFzCJCXS6ZqrmklswL1YS12aZQKn0b4YbpXYvz
	 woP/nPbo7RMgc3BNAvBzNhpkaUyv9HtXUChLTWopdAYUbQxWwouP4zwYx1RKV3Jk21UQa
	 nKRGJpht5B1vUdcwfSGkPHbFLLV7fqMgSEOyIBP+bWa43W24e6J6JRB152GT2SEVbLTl5
	 kwEip0ri5B6wY+UH5ya6YmrAPQDk2e2Z+6zhyM6f8tMkTEGdjkLs7BFsAwFzVl76mMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F92A1F000C4;
	Sat, 14 Nov 2026 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794664974;
	bh=hyjEvWjCmu9ZhqykLopS+0U4K+phVlInpXperM3Jliw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=WyfieUFofS87Clr9a2qfL+fZnAK4XOSJu0lelpKoAcghXY7dym7+WfC0A/fwX4asQ
	 OR/vWngKhde42mL3TT3dzH2d0Tl0Km1hB1NNStXUksulIYKQ3mQ1w8G2X6aC0MWQwg
	 NtdTBq2iMwndGBGIB5jcnfZD8yGGrMFV9AdTALiykRpZEI/XCQglcFdTxpeycvuvjt
	 oE8jcE+zdoRWGGKxunsIGZY780SjD3blu0cSv7u3ta64h5Fc++OJ2s1MmhxM+mKc0x
	 4b+asMUyK5KKzOVciDmmq5HekJwsow3/TUQh+Y6JeQW7vmWKZJReHJ7fdvR772mrFx
	 h/qVK8OaibV0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F29A049DC2;
	Sat, 14 Nov 2026 14:02:53 +0000 (UTC)
From: cookys via B4 Relay <devnull+cookys.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 22:02:54 +0800
Subject: [PATCH] i2c: qup: scale the transfer timeout with the transfer
 length
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-qup-timeout-v1-1-ab3be931d506@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWWtiEBW/IhYtg5F49SES8e+K5
 Vnce4Elw2Shii4wdLDldQnAOIJ2VMtAgrtgSJO0QMRc7H4TjmdavROFlirpykxqiRCKzVDP53e
 rm9/W64la9y7gvh8wYiE2bwAAAA==
X-Change-ID: 20261114-qup-timeout-6b7a0d837b71
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794664973; l=3701;
 i=cookys@gmail.com; s=20261114; h=from:subject:message-id;
 bh=zxianrKojbq9bic6+na8V+oRSupTcgwcBLkFgdWYgvE=;
 b=x9S2ehW1Zf27K0+xaHExDuSiTdAXjX1Fkaef3wnZLrOUEFHb5ECZSiGELuPKVY00avdXYKso0
 V4JMCGOiaA9AgE7PWsLO8h+pzBuFprYTVKWyWYQulhtB93iLr6YaoBk
X-Developer-Key: i=cookys@gmail.com; a=ed25519;
 pk=CR+HDlVDbzSn6HgGtSLe9WwOu5qDJieqaLN/LgFay6c=
X-Endpoint-Received: by B4 Relay for cookys@gmail.com/20261114 with
 auth_id=1525
X-Original-From: cookys <cookys@gmail.com>
Reply-To: cookys@gmail.com
Content-Transfer-Encoding: 7bit

From: cookys <cookys@gmail.com>

qup_i2c_probe() sets one transfer timeout for the adapter, sized for the
largest DMA transfer: TOUT_MIN (2 s) plus MX_DMA_TX_RX_LEN (128 KiB)
byte times. At the default 100 kHz that is 2 s + 131072 x 99 us, about
15 s, and every wait uses it, even for a one-byte read. A transfer that
never completes therefore stalls its caller for 15 s before -ETIMEDOUT.

On the Lenovo ThinkSmart View (APQ8053) the FT8201 touch controller
sometimes does not complete the first read after power-up (about one
boot in four). edt_ft5x06 probes asynchronously, so for those 15 s
every module init waits in async_synchronize_full(), and boot stalls:

  probe of 2-0038 with driver edt_ft5x06 returned 0 after 15343275 usecs

Set the timeout before each wait from the bytes that wait covers: the
message length on the FIFO and block paths (v1 and v2), the total of
the messages in the batch on the BAM path. The probe-time value is now
only the initial default. With this change the same failed read returns
after about 2 s:

  probe of 2-0038 with driver edt_ft5x06 returned 0 after 2353169 usecs

Tested on the ThinkSmart View (msm8953-mainline 7.3 with this change),
24 boots: touch probe 0.32-0.35 s, and 2.35 s in the one boot where
the controller missed its first read.

Assisted-by: Grok:grok-4.6
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: cookys <cookys@gmail.com>
---
 drivers/i2c/busses/i2c-qup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index a0e076fc5..cda78933e 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -439,6 +439,12 @@ static int qup_i2c_change_state(struct qup_i2c_dev *qup, u32 state)
 	return 0;
 }
 
+static void qup_i2c_set_xfer_timeout(struct qup_i2c_dev *qup, unsigned int len)
+{
+	qup->xfer_timeout = TOUT_MIN * HZ +
+		usecs_to_jiffies(len * qup->one_byte_t);
+}
+
 /* Check if I2C bus returns to IDLE state */
 static int qup_i2c_bus_active(struct qup_i2c_dev *qup, int len)
 {
@@ -864,6 +870,7 @@ static int qup_i2c_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
 	int ret = 0;
 	int idx = 0;
+	unsigned int xfer_len = 0;
 
 	ret = qup_i2c_vote_bw(qup, qup->src_clk_freq);
 	if (ret)
@@ -900,6 +907,8 @@ static int qup_i2c_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 		if (ret)
 			break;
 
+		xfer_len += qup->msg->len;
+
 		/*
 		 * Make DMA descriptor and schedule the BAM transfer if its
 		 * already crossed the maximum length. Since the memory for all
@@ -910,11 +919,13 @@ static int qup_i2c_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 		if (qup->btx.sg_cnt > qup->max_xfer_sg_len ||
 		    qup->brx.sg_cnt > qup->max_xfer_sg_len ||
 		    qup->is_last) {
+			qup_i2c_set_xfer_timeout(qup, xfer_len);
 			ret = qup_i2c_bam_schedule_desc(qup);
 			if (ret)
 				break;
 
 			qup_i2c_bam_clear_tag_buffers(qup);
+			xfer_len = 0;
 		}
 	}
 
@@ -1054,6 +1065,7 @@ static int qup_i2c_conf_xfer_v1(struct qup_i2c_dev *qup, bool is_rx)
 	if (ret)
 		goto err;
 
+	qup_i2c_set_xfer_timeout(qup, qup->msg->len);
 	ret = qup_i2c_wait_for_complete(qup, qup->msg);
 	if (ret)
 		goto err;
@@ -1432,6 +1444,7 @@ qup_i2c_conf_xfer_v2(struct qup_i2c_dev *qup, bool is_rx, bool is_first,
 	if (ret)
 		goto err;
 
+	qup_i2c_set_xfer_timeout(qup, msg->len);
 	ret = qup_i2c_wait_for_complete(qup, msg);
 	if (ret)
 		goto err;

---
base-commit: 04e9bf1648f846976b543e91c1838a712433772a
change-id: 20261114-qup-timeout-6b7a0d837b71

Best regards,
--  
cookys <cookys@gmail.com>


