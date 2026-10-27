Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124057;
	b=ANB46eN9cAEgmEObvsrJHh+Lp1Pw/hOoeBLI8MDebXm6BvXP4HUKc7BB4pLob2UVCd/a
	 zDw6FywQC7oZ7d9HkqKJ0PZ+jcWKWcm9K46XmwyRjC24VItoWyi/aFV+SALy8f0l15P4S
	 0hwTH+BMyNNmqY/rYVEadm4T9FPxCR1SSIBv6P8zu0Lq6VNrxPhVGCYE0NeV3kAPchNxz
	 ndywZF+17waQ5ECRSK4hPu1nZbhJU4dS+wa6uy7jIAkgCbtsQUh+tz+JBNY7jzcQC5pQt
	 qsKzUkQy+J6x+a8JpCsbn1xvTWfW4zGlohGXW3p8siGPdhrfsnzOkJvfL0FF0YuTwBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124057;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=spM3KcIMCTj+Sev7DLll6n6wD3ZIu3g46O7rzTg5psQ=;
	b=T3+OQwbyqjgNJSvgLRtEpFdincAeSBzzuR5l/eRnaRPgHE9B9P4xzdb2EIAz1+OWS8B6
	 P7S0/QGVFgBEIJm0iULpWrgLORUPlrzVRj+8bQzNzNKUMjGKUSnbx9AtLaxAWG65bGwPX
	 wqmV7qTQ6AGiUk7G9tgptDYvw6x+mndMFvaATOo+bLT+NtDm+Oh6M0raxhp1RdrBDgJMl
	 OAkzv10zjIMKt+siRh94wIj1FU4Ekl2xlwu6xUrsBk9e1qpIXXZxJYiexfXuK38Ro7Rq3
	 2AnPfVu7RKr98aoEJOms+lgA9h7qXhV8STgOwlv3x9GDorBsFSpg4kHAeTUBgSxyLYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=qW5JV1G0;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32A606A31D
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 18:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE32A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=qW5JV1G0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793124051;
	bh=spM3KcIMCTj+Sev7DLll6n6wD3ZIu3g46O7rzTg5psQ=;
	h=From:To:Cc:Subject:Date;
	b=qW5JV1G0NwjaH8K2vvXH9SaH2apLWuFgqoN72y4/ij8hebgmpAyiCUnPgyl9CS2Oe
	 EulW/NBiap5CVhNdzfogKXbjhg0LUzjt9xs7mjuZuxmGFR6r5T9r3h0Kp9JBNjCm/Q
	 DN/5uju3KPgE8O7UPBLWFVZxLNZQcOEYc7Md4C1c=
Received: from LAPTOP-TKBJAGN4.localdomain ([27.38.201.62])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 3013632; Wed, 28 Oct 2026 02:00:48 +0800
X-QQ-mid: xmsmtpt1793124048t1hi43pfb
Message-ID: <tencent_877C99956190215D644EB959DF1663542A0A@qq.com>
X-QQ-XMAILINFO: N6IfSeM/PG+tdCz5Cj1vhLmiuKazt8ArHwWiFVGNcpvZ35kcBBkkbT142hdYXb
	 EwNVr9Toq0fjfi5FlkZBig7el4RHfpoBiUf8ha4CMdmo763I5EUJs2h2k6LkoK8URenxUj++4Ne0
	 C83Snqx65b/nQdrLw7/snnIRj/2H3xIXAYseTejahOVm+o8fMNLhu8FaAxXOiJxr8pb8iJrycmWM
	 f0cNcynccpVQEw5XNYH0PskUTwGiPxpJfMbcwWJttKumYlXtyx6uoRWbTE/e4OkV2BtR1rlRJ954
	 dCLWXiTZ3y0bwHq4X4IejGyFALnc2+mF8dZizgzf4rON7QhaKQ5nT9OqLrb8Y3uYtSpIrxAu5nVw
	 RpDji+FXBM2PeDY7dJY6JtpCxEz8XCWCacOnw9/AgMOeggSDVjkiO8eFSBpEFq0OGkgFfQr+3cqd
	 XaAExW1nNfDisb61TngEmxk0v3j2m00VdvE574xY8Q5MdtJocsQDUI5LOabK6DnLcPWfg9exMbsI
	 tO6/9NDQD+Gr1O54jRXnP3MX2ZhNLyg5JiGVWkl0ey7qBy53gB7Sk7Z4mKopr/UwbpfMKH0obLZQ
	 2iKbY0x/oGpk0upeIxsL0P4rw4qXNDP7rvKdznRgPYnCFO16W171WT2kjbMSvevuquaFMUfZ2RT+
	 eSgnmC8UcwxBagdfJG+r+TXvyCn+rgV+EwSQSJRTuoFMn118ycZDCXzHEavug5uLUtjDXjVNNv/X
	 sYmrNr2+qznl18QQzow3faBjRIVBXTv6tvZIPoBiy9SbwvBa8L248VP/Wsu6zIfVfhgaYUGMSVtZ
	 W/hl0K1AfY/fDdBwywZQCG/X710Ee3T11fA2lyMEJS+cee3R+yvFKfPBBB9jEF0Z1s8iWbx8X19N
	 Gm3sstgB+ZJPpoPYv1O3LxbbbXsLiRoZQmwTHHv3f9i0NW6/xGic1wNcSlJHCxFlx+2GkvOpVUfO
	 o7zn/UaJwGQIaYpb330ke20sroOgG00WiJ/vhHVycFx1kUDfp73AZ/NDVo1C3G7IIW9NNtA2RzLY
	 au3nOddP9JVoNZFxky6yqWyRSXmtbp/W3Cy/sfd3+9/upNqv4mcPzJqGIoSMw/RAqvK/DG02AWQc
	 NRbgX9S11aqJpHhAu727n3A754nd3m+CzHmxAHRMmjux3+moLX40wjaOBWFrkcmKM7Hb5em6+Lo/
	 8hTEnPo+E0Ox9VqDebhzfsKOXrdaj/S2dDaxm7CSn+kJW3LQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Haobin Jiang <lemonoutput@foxmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-i2c@vger.kernel.org
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Carlos Song <carlos.song@oss.nxp.com>,
	Vincent Jardin <vjardin@free.fr>,
	dillon.minfei@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haobin Jiang <lemonoutput@foxmail.com>
Subject: [PATCH v4] i2c: imx: honour I2C_M_IGNORE_NAK
Date: Wed, 28 Oct 2026 02:00:44 +0800
X-OQ-MSGID: <20261027180044.21532-1-lemonoutput@foxmail.com>
X-Mailer: git-send-email 2.34.1
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

I2C_M_IGNORE_NAK is removed from the flags rejected by
i2c_imx_check_msgs(), so the flag is honoured as documented.
I2C_M_STOP stays unhandled: the controller emits a STOP after the
final message and repeated STARTs between messages, so rejecting it
would only break the existing ov2659/SCCB use case. I2C_M_NO_RD_ACK
stays rejected: the controller always clocks the ninth acknowledge
bit, so it cannot be implemented.

This applies on top of Vincent Jardin's I2C_M_REV_DIR_ADDR and
I2C_M_NOSTART support [1], merged as c2867bb0fa1d ("i2c: imx: add
I2C_M_REV_DIR_ADDR and I2C_M_NOSTART").

Tested on an ALIENTEK i.MX6ULL mini board (v6.6.44, equivalent
backport) with a logic analyzer: with the flag, a 3-byte write to an
unpopulated address clocks out every byte (each NAK'd) and returns 0;
without the flag it aborts with -ENXIO after the address byte. A
4-byte read with the flag completes and returns 0 as well. Waveforms
and test logs: https://github.com/JHB11Hinson/i2c-imx-ignore-nak-test

Note: part of the code was generated with the assistance
of a generative AI tool (GLM 5.3) from the author's description of
the problem, then reviewed and verified by the author.

Link: https://patch.msgid.link/20261023-for-upstream-i2c-imx-lx2160-reverse-v3-1-a07b249df381@free.fr # [1]
Link: https://lore.kernel.org/linux-i2c/tencent_342A87BFCECA70C9982E68A79AAD878B6909@qq.com/ # [2]

Signed-off-by: Haobin Jiang <lemonoutput@foxmail.com>

---
v3 -> v4:
	- Rebase onto i2c/i2c after Vincent Jardin's I2C_M_REV_DIR_ADDR
	  and I2C_M_NOSTART series was merged as c2867bb0fa1d [1].
	- Previous version: [2].
	- No functional change from v3.
---
 drivers/i2c/busses/i2c-imx.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf08cd63..8e422b45d 100644
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
@@ -971,11 +974,15 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
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
@@ -988,7 +995,7 @@ static inline int i2c_imx_isr_write(struct imx_i2c_struct *i2c_imx)
 {
 	int result;
 
-	result = i2c_imx_isr_acked(i2c_imx);
+	result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 
@@ -1017,7 +1024,7 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
 {
 	int result;
 
-	result = i2c_imx_isr_acked(i2c_imx);
+	result = i2c_imx_isr_acked(i2c_imx, i2c_imx->msg->flags & I2C_M_IGNORE_NAK);
 	if (result)
 		return result;
 
@@ -1249,7 +1256,8 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	if (result)
 		return result;
 
-	return i2c_imx_acked(i2c_imx);
+	/* I2C_M_IGNORE_NAK messages never take the DMA path. */
+	return i2c_imx_acked(i2c_imx, false);
 }
 
 static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
@@ -1268,7 +1276,7 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
 		result = i2c_imx_trx_complete(i2c_imx, !use_dma);
 		if (result)
 			return result;
-		result = i2c_imx_acked(i2c_imx);
+		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 		if (result)
 			return result;
 	}
@@ -1401,7 +1409,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 		result = i2c_imx_trx_complete(i2c_imx, true);
 		if (result)
 			return result;
-		result = i2c_imx_acked(i2c_imx);
+		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 		if (result)
 			return result;
 	}
@@ -1416,7 +1424,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
 		result = i2c_imx_trx_complete(i2c_imx, true);
 		if (result)
 			return result;
-		result = i2c_imx_acked(i2c_imx);
+		result = i2c_imx_acked(i2c_imx, msgs->flags & I2C_M_IGNORE_NAK);
 		if (result)
 			return result;
 	}
@@ -1613,8 +1621,9 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 	return ret;
 }
 
+/* I2C_M_STOP is the controller's native behaviour; don't reject it. */
 #define I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS \
-	(I2C_M_IGNORE_NAK | I2C_M_NO_RD_ACK | I2C_M_STOP)
+	I2C_M_NO_RD_ACK
 
 static int i2c_imx_check_msgs(struct i2c_msg *msgs, int num)
 {
@@ -1712,6 +1721,10 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
 			msgs[i].flags & I2C_M_DMA_SAFE &&
 			!(msgs[i].flags & I2C_M_NOSTART);
+
+		/* A NAK'd byte may not generate a further DMA request. */
+		if (msgs[i].flags & I2C_M_IGNORE_NAK)
+			use_dma = false;
 		if (msgs[i].flags & I2C_M_RD) {
 			int block_data = msgs->flags & I2C_M_RECV_LEN;
 

base-commit: 123cffeca4a33d770c29ff8d3f22453a5fd59c32
-- 
2.34.1

