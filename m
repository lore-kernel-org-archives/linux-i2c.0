Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964F56B874;
	Tue,  8 Sep 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883324; cv=none; b=WOvRHofYzjCey2iOm/jD0K43vYQK+sq0Ar77KPOXRSJFAn4eY8gAAhYikW9ZEDR+RUVhT1s3D2IKpsd/1YQteHCgdzZIYZPi0PjhM88oKC8x4cVtG9jLl+2mEehmdvQMLLwFH192z1P8RiI7cdMo9edauYke7Sgj6snr8bBpmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883324; c=relaxed/simple;
	bh=PtBvshArS3P1b+I2XeuugmZi94aHWwfsom4fpF20Tj8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Noau7DQltlqO9YmJTo4h4d4UOOLjDY/Xysw83k+mAUC/lQcadbxviC+AOf08ERhV28hZbkVuN2PXHddzMxsJgq8HEfxrmADzU2cHtoHMxMKT94Ij6x7SZJCuVM/nxDSzq9aw8JGwWc0scLV0q2n8uEoWLUYhE4U+aXRo0Ss/H54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cA9AP2BB; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cA9AP2BB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1788883316;
	bh=6SwRQ6PA+jZ9sSnyk3mpNdGgMyUDicpbvYGA8+pGlt0=;
	h=From:To:Cc:Subject:Date;
	b=cA9AP2BBeBRMIcVSMX3/V27YTRhx8lemN8guv/6gHMhGv/tWCtej+81boyBwcVmPF
	 zRQ/BPnOv5fqWqr0YRm7jHQkLOqxV0NBhxjO1qLlnU8qlWBpD3mxhUTqQOQEi56jh1
	 5NIyt//U/LVn+nVpab65sL6NNJ2gzdMvmBoRJjgQ=
Received: from LAPTOP-TKBJAGN4.localdomain ([2408:8256:2d01:e2b1:f9b4:79bb:79ab:d0e2])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 6F854B2; Wed, 09 Sep 2026 00:01:47 +0800
X-QQ-mid: xmsmtpt1788883307t0dys8503
Message-ID: <tencent_342A87BFCECA70C9982E68A79AAD878B6909@qq.com>
X-QQ-XMAILINFO: MXzpxT/vcbSg1A6KbdFVmG0bev7a//SwtdgMKyqlQmb1J15c/8b45jn6e/n++N
	 oy/K9Oa3/ujrfqmzuGOkzW4Dg11LO1WiY1hXXp2bX0NS/w6SHVmNpUILzzB79Z8GHQ84fMNLCLG2
	 g4dr0cNCC4oiFwrjAbSfN3Ul7HjyX3eub9w2tNO8+nOocLInxP/DzNhhZF9rszK1WkT1ESge5n2h
	 B2BuN5cpP/bW8jUHyz5fEKkLtxQeUG4sIj/OR0qfilH9NUK1irs7Trj+xhM2ct9+ZVXoUUO8o1rF
	 Z+ipMbGGrIiWlcma6nG8Bl1PGI4KoXyRBUhnhVota0Q3bk9dCesMDR7+Q4GOtFvUykodpi5akkc+
	 1Ll2jZ4LfXuLPCnxPhK6yqh86w6DAXWSk9OrnfO7rtmKJI5f4J9JUdyLS3C9Jwz0s9CDHp2sXCCU
	 6XLVL8VPN2Y6QUxJDlTzC4e3CDMLyJG/uypHfRq8z7bxDL4kjXcr7K8R4rzv3sgywMNkXXQs3l1U
	 I/wH7iLbXA/6/57+rxzDeXhNDn7dCs1Q+DhhLrdLrJ9ldMh82Ygl/2QQw6LK18zuQminc1Lb5eC1
	 SSsYC9h88UGM0BUZiq/6bBPzM6aZ8fKtNMruaMXQ1oevdkeZ8hkKmQHmBWmrNlFQDYkGHMer5o/M
	 3z66tDN+rkRMgHnE0C+AcZYny39YP7QDg6h36BfvApNwVLADDUNPgf5ye3RDc9QKuOmgeIseuA9T
	 uzc6i9pJDi2P464u4QprI4GxJWxTuSMkvXZGjrQiRyysEqzMvwFdpTBdNyYJcL5Sk4qbGakx3ryu
	 NTh2YsITDkbVBIhyt3/jKl1qdNyQuJX3wgU2bkwYPTb4b2e9SNetT9Lph8PVPD6O1pfRSBR/v0PX
	 0NfzpgPd4ak2TEqR6WqC++0pSQn26f1VNq4AvnkdY/yvcgzS+9idxcmdrdwHDO1GqRGEFT4EuJHZ
	 22ANU/j4XxtkvOUUltPlRKPKFwPV3kphpKbKr93xmluKS8VjGgtreCEH5nXVJ+DKlaxvWxXuKzhs
	 d3v/Qh5EbgGgAFUG17WewXjoueZUeT1K75FCy1IJrV9Lh0N81x/NP11/8wuXABUW4JKQ/gb0T2oo
	 vFf4oUb1dH10NZdNa6MSz6sAjw54T4lrO6tJzV4m3H6AlETn8U+J9PoO6tmvsGA9xT0NM6mVnlqX
	 mtXt/eVkTFVWfWqA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Haobin Jiang <lemonoutput@foxmail.com>
To: carlos.song@oss.nxp.com,
	dillon.minfei@gmail.com
Cc: andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	Haobin Jiang <lemonoutput@foxmail.com>
Subject: [PATCH v3] i2c: imx: honour I2C_M_IGNORE_NAK
Date: Wed,  9 Sep 2026 00:01:45 +0800
X-OQ-MSGID: <20260908160145.180323-1-lemonoutput@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I2C_M_IGNORE_NAK is removed from the flags rejected by
i2c_imx_check_msgs(), so the flag is honoured as documented. I2C_M_STOP
stays unhandled to preserve existing behaviour and backward
compatibility. I2C_M_NO_RD_ACK stays rejected.

This change is meant to apply on top of the I2C_M_REV_DIR_ADDR and
I2C_M_NOSTART series [1], which is not yet merged.

Tested on an ALIENTEK i.MX6ULL mini board (v6.6.44, equivalent
backport) with a logic analyzer: with the flag, a 3-byte write to an
unpopulated address clocks out every byte (each NAK'd) and returns 0;
without the flag it aborts with -ENXIO after the address byte. A
4-byte read with the flag completes and returns 0 as well. Waveforms
and test logs: https://github.com/JHB11Hinson/i2c-imx-ignore-nak-test

Note: part of the code was generated with the assistance
of a generative AI tool (GLM 5.3) from the author's description of
the problem, then reviewed and verified by the author.

Link: https://lore.kernel.org/linux-i2c/20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr/ # [1]

Signed-off-by: Haobin Jiang <lemonoutput@foxmail.com>
---

v1 -> v2:
	- Honour I2C_M_IGNORE_NAK on the read path as well, mirroring
	  i2c-img-scb, instead of silently dropping the flag there.
	- Force the PIO path for every message with I2C_M_IGNORE_NAK:
	  a NAK'd byte does not generate a further DMA request, so a
	  DMA write to a deliberately-NAKing target would stall until
	  DMA_TIMEOUT.
	- Reject I2C_M_NO_RD_ACK instead of advertising blanket support
	  and silently ignoring it. I2C_M_STOP is not rejected: the
	  controller already emits a STOP after the final message, and
	  rejecting it would break the ov2659 camera on imx6qdl-ds.

v2 -> v3:
	- Rebase on top of the I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
	  series; the flag rejection moved to i2c_imx_check_msgs().
	  I2C_M_IGNORE_NAK is now honoured and I2C_M_STOP stays
	  unhandled, preserving the ov2659/SCCB use case and backward
	  compatibility as agreed during review.
	- Keep the DMA write path checking ACK with ignore_nak=false,
	  as suggested during review; messages carrying
	  I2C_M_IGNORE_NAK are forced onto the PIO path.
	- Fix double spaces after periods in the changelog and comments.
	- State the use of a generative AI tool in the changelog.
	- Test on an ALIENTEK i.MX6ULL mini board (v6.6.44, equivalent
	  backport); results linked in the commit message.

 drivers/i2c/busses/i2c-imx.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ab6794bf3ea5..9cd1fa0f4021 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -612,9 +612,12 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx, bool atomic)
 	return 0;
 }
 
-static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
+static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx, bool ignore_nak)
 {
 	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
+		if (ignore_nak)
+			return 0;
+
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
 		return -ENXIO;  /* No ACK */
 	}
@@ -968,11 +971,15 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
 	return ret;
 }
 
-static inline int i2c_imx_isr_acked(struct imx_i2c_struct *i2c_imx)
+static inline int i2c_imx_isr_acked(struct imx_i2c_struct *i2c_imx,
+				    bool ignore_nak)
 {
 	i2c_imx->isr_result = 0;
 
 	if (imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) & I2SR_RXAK) {
+		if (ignore_nak)
+			return 0;
+
 		i2c_imx->state = IMX_I2C_STATE_FAILED;
 		i2c_imx->isr_result = -ENXIO;
 		wake_up(&i2c_imx->queue);
@@ -985,7 +992,7 @@ static inline int i2c_imx_isr_write(struct imx_i2c_struct *i2c_imx)
 {
 	int result;
 
-	result = i2c_imx_isr_acked(i2c_imx);
+	result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 
@@ -1014,7 +1021,7 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
 {
 	int result;
 
-	result = i2c_imx_isr_acked(i2c_imx);
+	result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 
@@ -1229,7 +1236,8 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	if (result)
 		return result;
 
-	return i2c_imx_acked(i2c_imx);
+	/* I2C_M_IGNORE_NAK messages never take the DMA path. */
+	return i2c_imx_acked(i2c_imx, false);
 }
 
 static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
@@ -1248,7 +1256,7 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
 		result = i2c_imx_trx_complete(i2c_imx, !use_dma);
 		if (result)
 			return result;
-		result = i2c_imx_acked(i2c_imx);
+		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 		if (result)
 			return result;
 	}
@@ -1381,7 +1389,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 		result = i2c_imx_trx_complete(i2c_imx, true);
 		if (result)
 			return result;
-		result = i2c_imx_acked(i2c_imx);
+		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 		if (result)
 			return result;
 	}
@@ -1396,7 +1404,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 		result = i2c_imx_trx_complete(i2c_imx, true);
 		if (result)
 			return result;
-		result = i2c_imx_acked(i2c_imx);
+		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 		if (result)
 			return result;
 	}
@@ -1580,8 +1588,9 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 	return ret;
 }
 
+	/* I2C_M_STOP is the controller's native behaviour; don't reject it. */
 #define I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS \
-	(I2C_M_IGNORE_NAK | I2C_M_NO_RD_ACK | I2C_M_STOP)
+	I2C_M_NO_RD_ACK
 
 static int i2c_imx_check_msgs(struct i2c_msg *msgs, int num)
 {
@@ -1675,6 +1684,10 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
 			msgs[i].flags & I2C_M_DMA_SAFE &&
 			!(msgs[i].flags & I2C_M_NOSTART);
+
+		/* A NAK'd byte may not generate a further DMA request. */
+		if (msgs[i].flags & I2C_M_IGNORE_NAK)
+			use_dma = false;
 		if (msgs[i].flags & I2C_M_RD) {
 			int block_data = msgs->flags & I2C_M_RECV_LEN;
 

base-commit: 04e9bf1648f846976b543e91c1838a712433772a
prerequisite-patch-id: 24876ef6d4dc440b8d8080e65d369b2b37709b0b
-- 
2.34.1

