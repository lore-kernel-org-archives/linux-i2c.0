Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908877;
	b=2Nec3cR04+yJ4Hwegu/8xwl0b28ZZVQ26kAXL9w9vltVjMU2RCzh1pcTYBFf3SpeOqjX
	 Q//TxviqODDeazenTHlB/0CrrFjx5u4CnL7hM20lX/scAQSC6nsnD7OgG52C1F6g/gfbR
	 W/GJbB8Hv2NjjWRX1MDioexpqtDXxuL19EE32iybCYuqpVpPNRGPQFPS6+pyIKF0UT/1W
	 McIwe8zbmXVNSfI3cCAmIyd+coDHQGbk85rfkgzGrLksfi5CMgMzlAV/6BIwqbUTuNUR3
	 nb5v/wsrDQViuOM4/3PVMjIz4d5cK4sNQI8QyKh9Dr5mLrjwukhgbyV7Sq+lTRrBK7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908877;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=353zUokPVdIoWwcOZtl0MfxmeAbr3cHweTUxhjCPGGY=;
	b=lRHno0FhrbxD0XjaMZ6f8BCk9TjpVOkicO3w+/1QdrFITTHtBvzCVAcqSyfU93BSQGy/
	 bP0AqFrMXyTG1DACfHANkHy3Jzn+jxVyCGmfgaYNQDhGTPAW5iHM/NcdqCTY4Bb+qGAYa
	 AeNIwqWTGzPiPW9gNE+z+2M8SJJyWgBgoe9SGwAj/3ijDaMmG5WbYd3/VVIduWVcZvC44
	 Jc2JH4Vabo/pTyF1YYRzydxb4ITTGWiPr0ThlEN18F5dlA72++XedsXsNK7lOV6JzWzoG
	 Nm8u9uxi5EH7sOk/EPQTItdcftlSIMhnnrJJ45J3Xx0wopJuZMUpYFI9yHZUVQddj7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fWlkNovq;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6BE606A887
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 09:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A6BE606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fWlkNovq
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 54CAE1A15A6
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 09:47:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 237805FC81;
	Tue, 17 Nov 2026 09:47:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9970011BC0DE4;
	Tue, 17 Nov 2026 10:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794908874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=353zUokPVdIoWwcOZtl0MfxmeAbr3cHweTUxhjCPGGY=;
	b=fWlkNovqCw48I/tAoumY3I+l3AOsZOq1u2M1BFJn1vZEn5hcMNf/H/iBdFD2mWaMnN0/3X
	RVbrffJPc8BP9ZQqmjrr1SHjOZ+zL5VXCYUfKNPJFvSiwRqZniZ5ny/z+8UmqXV8P6Axc6
	8eSHgnKaFvdgrqDK2/36/reQ1828vWaWhvjJgaTxadYZzNFZmL5iQFSbM9/Ol3b3H6M3e6
	5Zcd5fksKpvxFZt40GoSgD24nDLv+MPqXytkR0rHAfz42Fp1+a3z7rbbetKTHpQ1ju+lTT
	DM5A16nnd6deWpgvqm51Ci7DP/q6bv98ZtjC+CCq9XLcoCKZpz9bX6myjAes8A==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 17 Nov 2026 10:47:42 +0100
Subject: [PATCH v6 02/10] i2c: cgbc: Propagate hardware errors when polling
 read status
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-cgbc-i2c-storage-devices-support-v6-2-bb070ad3e9aa@bootlin.com>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

From: Lee Jones <lee@kernel.org>

In cgbc_i2c_xfer_msg(), read_poll_timeout() uses the same ret variable
to store the polled return value of cgbc_i2c_get_status() and the
timeout result of the macro itself.  When cgbc_i2c_get_status() returns
a negative error code (such as -EIO on an I2C NACK), the loop condition
ret != CGBC_I2C_STAT_BUSY evaluates to true and read_poll_timeout()
overwrites ret with 0.  The driver then issues CGBC_I2C_CMD_DATA, which
completes with CGBC_STATUS_CMD_READY without populating msg->buf,
leaving uninitialised heap memory in the caller's read buffer.

Store the polled status in a separate variable, verify that it equals
CGBC_I2C_STAT_DAT, and check that CGBC_I2C_CMD_DATA returns the expected
number of bytes.

Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
Closes: https://sashiko.dev/#/bug/linux-66cbf4b1-a219-4012-969d-236417bf419a
Cc: stable@vger.kernel.org
Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
Tested-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 164be9b99eb3..dfdb9ffc6447 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -205,9 +205,9 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	struct i2c_msg *msg = i2c->msg;
 	u8 cmd[CGBC_I2C_CMD_SIZE];
-	int ret, max_len, len, i;
+	int ret, status, max_len, len, i;
 	unsigned int cmd_len;
-	u8 cmd_data;
+	u8 cmd_data, data_len;
 
 	struct cgbc_i2c_transfer xfer = {
 		.bus_id = algo_data->bus_id,
@@ -266,17 +266,32 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 		if (ret)
 			goto err;
 
-		ret = read_poll_timeout(cgbc_i2c_get_status, ret,
-					ret != CGBC_I2C_STAT_BUSY, 0,
+		ret = read_poll_timeout(cgbc_i2c_get_status, status,
+					status != CGBC_I2C_STAT_BUSY, 0,
 					2 * algo_data->read_maxtime_us, false, adap);
-		if (ret < 0)
+		if (ret)
+			goto err;
+
+		if (status < 0) {
+			ret = status;
 			goto err;
+		}
+
+		if (status != CGBC_I2C_STAT_DAT) {
+			ret = -EIO;
+			goto err;
+		}
 
 		cmd_data = CGBC_I2C_CMD_DATA | algo_data->bus_id;
 		ret = cgbc_command(cgbc, &cmd_data, sizeof(cmd_data),
-				   msg->buf + i2c->pos, len, NULL);
+				   msg->buf + i2c->pos, len, &data_len);
 		if (ret)
 			goto err;
+
+		if (data_len != len) {
+			ret = -EIO;
+			goto err;
+		}
 	}
 
 	if (len == (msg->len - i2c->pos)) {

-- 
2.53.0

