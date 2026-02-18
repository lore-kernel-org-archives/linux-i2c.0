Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CC285CB3
	for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427396; cv=none; b=GwsQq0ODUgY6lItP3NmK3JhMKHmLSM25zNYVxZU9BW0Z/ADXCOgsg58BdWCVwasPVAvAlJXwRpZupvwzkx2VXNMchWWsJDoQ2zpn169cW2J6gVjdk5vS4c3vbFgHkTfPC50AWbifmkDvh1pcyt1toLLh8FkQqDdX+birLxaoAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427396; c=relaxed/simple;
	bh=nD2q10ThWeIvjvO9WzEUwgKZIjJ/JreIZj5OT5fabdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pET0M1acOJVvuSfejab2FwrU6tDmpBsn+2/ULPjDdm5kQKm+9jEQ49LdLr23/IHzoijpVBod2NbOpV6MZryKWFsGHPlgxSo1PFNKplJv8yMNZ/53OwGzPZAIn3/OXBG/EnA2vfo8TfUdNQdxeveRNzEDNoRHctVfgvDAd6YEXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+KMiHrg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+KMiHrg"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371119eacso51479175e9.2
        for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 07:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771427394; x=1772032194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiCCUrdk9XYqcbI+I7lzNNzu+GG7xW/ZdG+JQfCsf/M=;
        b=N+KMiHrgFWHEPKSZoiDJvWVFBaBSeygtPh2iuxwN64QKECidoiB0q+fP+FGNhcJAvD
         N3tmKKwsedRVpOj7hfyH8B2b+go6MP2cGhL/6aGBkOOpvutG88u1vuEbc5MDeVZU8oiN
         G2CaOoR0IoRu4mqjZOL6yR/xrOVixBOZ3XyCnCR6zqkjBtDBuL9Qjv2svWcORL/w5NtE
         7egE5nnsl9scsxbEoSrFpnSNC97KykE+u1tARGtLVTTzNpmIa+TCWzxEHGWY9iXSFU7E
         U8ipA/ftwkRvXnvueZt8edCehJPmTowBTa1QfjoTwjJrYLQLeBQWsw14BLyZQgqS3VWm
         1pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771427394; x=1772032194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YiCCUrdk9XYqcbI+I7lzNNzu+GG7xW/ZdG+JQfCsf/M=;
        b=tM6D1BuQuS0mjD9ve6VktCb/Ar0TAXlzJ3HHkbyKdJ8b4SX92xWAu7eDq5OivO7uCs
         M9HCClvA1A+jnEQkbyLMKG1/rmkY0m68NRbyrswSds2eS0a88VwaKOi/AVqMAn4JG5T4
         VbG75foeaJSnodQoHyn2kUD07Ahri35H+ETwykrO/cNJJjTwL36jYOhQYWE7pOO4ZZdO
         c1QeorMw0PpBm47h6LEgi2HxPNR3qhjVR3cTC84TAWj8FFAyu9wBQdvN295O4a3gSpqZ
         xfsHdLt7vAyScMsZEbg6f5AeUACy05QvhMcvY39nVS6ONu1iQ+iqYVt2F++RApNmY68Q
         DkEQ==
X-Gm-Message-State: AOJu0YzSEBuSotXvxjqEoijlO4zGQVq9akiufVJKXG8PhMRBWDoE1HVC
	va7Rho698ow92+2E6rB6hkGdY3bjjN8JHlfI70EpHpTO7ZfbFHha3f6/
X-Gm-Gg: AZuq6aLiKzDYIpOiAInirX/AvNb2KMubmEBkMYVfakFJa8FrhoZvJG1EqFjAnAbyMP1
	HBeecCrDU892Un1svUT5TPNBT9K8bdJJUO6i7vqgcbWTK5CR0b3QqgSbYgwlzFUbDlCON4ks4la
	GssFfJblIm/J7P4KNEEMOASIDvb82xwS9/W8FVzAcAxy+rfjGFLDRoVxfgpzUWRmq+IKmoYR+jr
	BthJEK6n5KQKlG5G0w8tDaBw06wDqSXs37yxSTFdhJrAEKmFFrXE+TRwxGE4y3BsVnWKogHgaAl
	kFAyJ4+thUOE34Tpz3kNC/0dTyjlGI9CM8L0Tg/4E2QrVqUEiMaFiooeR/6dS7dH1OmC8jM/Jx6
	55SeWEAwN3KcXp7uobLD7OoQhmQOqB+3xjjnrrpXZwTpvaIl6g994aZzkL4AjJG+UX70Mjj475X
	zuwmh+j4VVrCxk0EWs4lyaYWG8uhZ0ntxx+ZIYHJDP2ieG0A56yMykqfoaoYGb5LZ9e2e+JVM4b
	8zg5dEnBpMgXHBRtAoVbORCeYEl8qD6bSlGjoOTOneJVzQ=
X-Received: by 2002:a05:600d:13:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-4839b4c7242mr20986195e9.5.1771427393465;
        Wed, 18 Feb 2026 07:09:53 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm44333116f8f.26.2026.02.18.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 07:09:53 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	stefan.eichenberger@toradex.com,
	francesco.dolcini@toradex.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last read
Date: Wed, 18 Feb 2026 16:08:50 +0100
Message-ID: <20260218150940.131354-3-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218150940.131354-1-eichest@gmail.com>
References: <20260218150940.131354-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

When reading from the I2DR register, right after releasing the bus by
clearing MSTA and MTX, the I2C controller might still generate an
additional clock cycle which can cause devices to misbehave. Ensure to
only read from I2DR after the bus is not busy anymore. Because this
requires polling, the read of the last byte is moved outside of the
interrupt handler.

An example for such a failing transfer is this:
i2ctransfer -y -a 0 w1@0x00 0x02 r1
Error: Sending messages failed: Connection timed out
It does not happen with every device because not all devices react to
the additional clock cycle.

Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/i2c/busses/i2c-imx.c | 51 ++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 56e2a14495a9a..452d120a210b1 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1018,8 +1018,9 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
 	return 0;
 }
 
-static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
+static inline enum imx_i2c_state i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
 {
+	enum imx_i2c_state next_state = IMX_I2C_STATE_READ_CONTINUE;
 	unsigned int temp;
 
 	if ((i2c_imx->msg->len - 1) == i2c_imx->msg_buf_idx) {
@@ -1033,18 +1034,20 @@ static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
 				i2c_imx->stopped =  1;
 			temp &= ~(I2CR_MSTA | I2CR_MTX);
 			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-		} else {
-			/*
-			 * For i2c master receiver repeat restart operation like:
-			 * read -> repeat MSTA -> read/write
-			 * The controller must set MTX before read the last byte in
-			 * the first read operation, otherwise the first read cost
-			 * one extra clock cycle.
-			 */
-			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-			temp |= I2CR_MTX;
-			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+
+			return IMX_I2C_STATE_DONE;
 		}
+		/*
+		 * For i2c master receiver repeat restart operation like:
+		 * read -> repeat MSTA -> read/write
+		 * The controller must set MTX before read the last byte in
+		 * the first read operation, otherwise the first read cost
+		 * one extra clock cycle.
+		 */
+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+		temp |= I2CR_MTX;
+		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+		next_state = IMX_I2C_STATE_DONE;
 	} else if (i2c_imx->msg_buf_idx == (i2c_imx->msg->len - 2)) {
 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 		temp |= I2CR_TXAK;
@@ -1052,6 +1055,7 @@ static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
 	}
 
 	i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
+	return next_state;
 }
 
 static inline void i2c_imx_isr_read_block_data_len(struct imx_i2c_struct *i2c_imx)
@@ -1088,11 +1092,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
 		break;
 
 	case IMX_I2C_STATE_READ_CONTINUE:
-		i2c_imx_isr_read_continue(i2c_imx);
-		if (i2c_imx->msg_buf_idx == i2c_imx->msg->len) {
-			i2c_imx->state = IMX_I2C_STATE_DONE;
+		i2c_imx->state = i2c_imx_isr_read_continue(i2c_imx);
+		if (i2c_imx->state == IMX_I2C_STATE_DONE)
 			wake_up(&i2c_imx->queue);
-		}
 		break;
 
 	case IMX_I2C_STATE_READ_BLOCK_DATA:
@@ -1490,6 +1492,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 			bool is_lastmsg)
 {
 	int block_data = msgs->flags & I2C_M_RECV_LEN;
+	int ret = 0;
 
 	dev_dbg(&i2c_imx->adapter.dev,
 		"<%s> write slave address: addr=0x%x\n",
@@ -1522,10 +1525,20 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 		dev_err(&i2c_imx->adapter.dev, "<%s> read timedout\n", __func__);
 		return -ETIMEDOUT;
 	}
-	if (i2c_imx->is_lastmsg && !i2c_imx->stopped)
-		return i2c_imx_bus_busy(i2c_imx, 0, false);
+	if (i2c_imx->is_lastmsg) {
+		if (!i2c_imx->stopped)
+			ret = i2c_imx_bus_busy(i2c_imx, 0, false);
+		/*
+		 * Only read the last byte of the last message after the bus is
+		 * not busy. Else the controller generates another clock which
+		 * might confuse devices.
+		 */
+		if (!ret)
+			i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = imx_i2c_read_reg(i2c_imx,
+										     IMX_I2C_I2DR);
+	}
 
-	return 0;
+	return ret;
 }
 
 static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
-- 
2.51.0

