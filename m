Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694601;
	b=B6sDiACak6Y57ZNfJL5lowK1cs/ISlHyD1oUYytnY00YMYW7I3xSjvfx56SUFWxPThq/
	 OHW/bTgdsJoN0l5g5jfxhu1dPsWZLxSqgdF3hjk8O8IIaLTeE0a94wXrANe/lUz5S4PLc
	 FXr6Fnuo823KRq6kNCelwYMXePYz/t2/uZsq8n8CuDGIoBrgGonACdti0Jd3t98CdGEyL
	 21axULUYn82WEhY3sHwIdCSoBI1bpFnpLgC0fEDONVEuDszEwqgNp/OZVSTHExZyQp6bh
	 L0GpTstc7k5YfZCEC/QN2/hrRnn4tFgEBtnF4xQHvVZR4Rzwv7UKdNhTH+5QUdRIrvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694601;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=ODSyaZb6iOYvcs1BvP93T2fTuOcB0dzKDjVE0d08qMA=;
	b=ZX/xNkvAx/TE7O9I/q+7vMYPM7FoF4lXSryMT77C2z+p7idhveGk773fddPIJFXUFWEW
	 IHZhEa+RfTdoPUM4bFPZwD/1jz4+mwvzqc9+J6qRdbARnosLOBucJhtBnXAMPt0E7YjLb
	 DvhgG4ZDmiQss/3hqFtusxTlVgI0db72fR2jHlA/BZmWdl4ZlyqmcOp/A/NblUw74VUpN
	 KHs53T4zaUE7q3azPO0GgugCphyk0WItrL3kbYOJbxtZ+ZBdP8DXUSI7Hh6Pvx7KkH7pg
	 pr3sUzWXUmy43C4fKkeYBxdZYTVmiJhOeKPUhXIR407XBIhy7N+ADtiGhphFebF/iBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851D606A33B;
	Tue,  3 Nov 2026 08:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6851D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694606; x=1825230606;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5ot/vsSV1jLBRjwCF03ft7v/3Sn6vO/9cVJVvarpdRI=;
  b=f+dXn9y6luI6qlVN2tczzvIwI+klJdHm1Ski7c07OzBbMhuwjViK+gCv
   3UK3Cw/5agtSQK7fNEhpj/bRAHCcekSqEWdU4y2ttwtd8OW17T8FSFD1m
   2KEQMvfmXdxjMRe/xaaTSlUqj5zjsFojEdVI2vi87oTx4oJsyDZgKGN7t
   g+T/1Sv9aUIghJfMhcU1XPxHXgNeMf1USDLoLcU3YtbiaOCWkTZT3olYA
   OrP8nwBl7mtsUkyC9+/Ck3yWY9hYUSY9ddSG8ayiBR5+ot5oXw8NY1i2U
   LyZK00tm9zwyO65OVOFnNcupM2vQcWKhNOhTN5b24C4m6bqT730wEbZ/U
   A==;
X-CSE-ConnectionGUID: 934Ie9vNTzGq9yPtCoPvOQ==
X-CSE-MsgGUID: JiB7NE88TWWNP8vXjD1xyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:29:56 +0200
X-CSE-ConnectionGUID: U4AlIu8lTLi7/mwzFOBadw==
X-CSE-MsgGUID: 2tgeEiiiSi6r1E36YMkUNw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 03 Nov 2026 10:37:49 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:48 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 10:29:38 +0200
Subject: [PATCH 2/8] i2c: nomadik: do not try to retransmit I2C message
 series on errors
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
Message-Id: <20261103-i2c-nomadik-fixes-v1-2-655c6af2cb70@mobileye.com>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

i2c-nomadik driver of I2C bus controller in xfer() callback retransmits
the whole message series in cause of any fault, and returns fault only
after third failed attempt. This behavior contradicts with API because
not only it hides hardware faults, but also re-sends messages, while
they are not guaranteed to be idempotent.

Remove the triple attempt to send messages in xfer() callback.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 45b4815b0945..ca9366e09e71 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -716,27 +716,21 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int status = 0;
 	int i;
 	struct nmk_i2c_dev *priv = i2c_get_adapdata(i2c_adap);
-	int j;
 
 	pm_runtime_get_sync(&priv->adev->dev);
 
-	/* Attempt three times to send the message queue */
-	for (j = 0; j < 3; j++) {
-		/* setup the i2c controller */
-		setup_i2c_controller(priv);
-
-		for (i = 0; i < num_msgs; i++) {
-			priv->cli.slave_adr	= msgs[i].addr;
-			priv->cli.buffer		= msgs[i].buf;
-			priv->cli.count		= msgs[i].len;
-			priv->stop = (i < (num_msgs - 1)) ? 0 : 1;
-			priv->result = 0;
-
-			status = nmk_i2c_xfer_one(priv, msgs[i].flags);
-			if (status != 0)
-				break;
-		}
-		if (status == 0)
+	/* setup the i2c controller */
+	setup_i2c_controller(priv);
+
+	for (i = 0; i < num_msgs; i++) {
+		priv->cli.slave_adr	= msgs[i].addr;
+		priv->cli.buffer		= msgs[i].buf;
+		priv->cli.count		= msgs[i].len;
+		priv->stop = (i < (num_msgs - 1)) ? 0 : 1;
+		priv->result = 0;
+
+		status = nmk_i2c_xfer_one(priv, msgs[i].flags);
+		if (status != 0)
 			break;
 	}
 

-- 
2.43.0

