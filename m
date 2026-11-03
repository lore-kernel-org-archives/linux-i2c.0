Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694601;
	b=0xEb0MWfnXBDKRL6UaHGoNJLiPgZuMBN7zKps5Y1WjqTRf58FlhJm/Mjnx+ulwsvpbjF
	 Y9axxEEvsNt12emeO7nFvTM2/eR8dOroT/VhH191Hb7FpF9YsKFFy4XtUGhkrG4hU1KgG
	 g8q3N2+s4Zv0Ew8N/0C6jq1RCglc2FyimBlvPXrSQY2pPUnYuqEcz/EscNf2ANHYDgCpd
	 AN4UGQUn70tJhYAATFVOE6IZ/hnQ0VDfW3NRHQiSjhJ6DigPTEVr1eUWvXMCLRKiDayTa
	 wxF5xQxnAJk/6UxVjsl3XOhf9lIvgAC5DXtd4Jwmbm/64paucFdDs1SmaTN+NO0bGqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694601;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=vAJsDviy3Fr5desxJFh65jr3SkocS+1xF/1kHL4MgFE=;
	b=0d5skS0zBOMNsVS2PemvRdk4x/DpYjZdXOqHoyiZf3do25meR5WJShewUjQ3x77Q4SCq
	 xKk9bt30mL3hsEOsGd318frWjq23HkIsROrYdJsYg+lq4g24uVj3i4XTu9iWl7eXndji5
	 L8WVF1yLJE6hFyxExh+Et+cS97gWtTY4TT88WraeNGHvaYSEEWPzS0uf5OM4jzEXexQAx
	 H0Lg/e/SQJ9d67pgHUQ6Qf8g9Xddvf1PLVwcddzAN0BeM8sjI6lCGm1aDRVMcI7vmtzGq
	 K3rgpV7s2S73M47ZGlZAUz1tyneVQFrEmDI6wtPY71MiUB5eQd0gQ8+CJfsU80d2K+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00891606A332;
	Tue,  3 Nov 2026 08:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00891606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694606; x=1825230606;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GKnijHUVVD7v3+YYQuJyw1BFy9XJ5bZ03qErcUlJTPA=;
  b=Y72T/SuUWPyEdEFNx86cSyL6xUzgFKuT7sgpVyfILDQKnLb59KnT7Wh6
   JoQrYWj1srIbij/0tXM7vUXF7nyvxO7XfhD/SqgxajQrhEZviLYi12PIg
   d1r9gA/BiOIMK72RUqPrp8G98BKqPpevnCUGkj1b9LuZufO8zmZAtaCIx
   nIlF4COXmuzdzbKEEbjUmpxlR5HUUIbG8U61UpJOLhy+wV7a9d3l7zWIk
   YJjgHLOvTwepoA7E6ZFA7ZXGX+ycOk5vcx4C0aXefVWWL5r7z2meXhMAu
   1NZex2B7UvzwL+X77reWOobMreabUf25ae0mD4BaLs4ezPFLkpMcz7i2/
   w==;
X-CSE-ConnectionGUID: mkHVKEemQYKyShKrAcDMuQ==
X-CSE-MsgGUID: om3b6wYrQYGbFqVO/j4UZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:30:01 +0200
X-CSE-ConnectionGUID: AU8Asm2xRRWrzXa6a6BCmQ==
X-CSE-MsgGUID: mIf+bvJPQCu52rWwts5/BQ==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 03 Nov 2026 10:37:40 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:53 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 10:29:41 +0200
Subject: [PATCH 5/8] i2c: nomadik: add quirks max_len=2047 and
 no_zero_len_read
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
Message-Id: <20261103-i2c-nomadik-fixes-v1-5-655c6af2cb70@mobileye.com>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

In Nomadik I2c controller, register I2C_MCR has 11-bit wide LENGTH
field. Its maximum value is 2047, so this is the maximum length of a
single message. It is less than the common maximum I2C message length in
I2C subsystem (8192), so define a quirk in order to report the
unsupported message without any attempt to transfer it.

Zero length reading doesn't work properly on this controller, so add
`I2C_AQ_NO_ZERO_LEN_READ` quirk flag.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 9c7658148bd4..d07246d11b35 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -79,6 +79,9 @@
 #define I2C_MCR_STOP		BIT(14)		/* Stop condition */
 #define I2C_MCR_LENGTH		GENMASK(25, 15)	/* Transaction length */
 
+/* Controller hardware limitation of the message length */
+#define I2C_MAX_MSG_LENGTH	(I2C_MCR_LENGTH >> 15)
+
 /* Status register (SR) */
 #define I2C_SR_OP		GENMASK(1, 0)	/* Operation */
 #define I2C_SR_STATUS		GENMASK(3, 2)	/* controller status */
@@ -1087,6 +1090,12 @@ static const struct of_device_id nmk_i2c_eyeq_match_table[] = {
 	{ /* sentinel */ }
 };
 
+static const struct i2c_adapter_quirks nmk_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+	.max_read_len  = I2C_MAX_MSG_LENGTH,
+	.max_write_len = I2C_MAX_MSG_LENGTH,
+};
+
 static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct i2c_vendor_data *vendor = id->data;
@@ -1161,6 +1170,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	adap->class = I2C_CLASS_DEPRECATED;
 	adap->algo = &nmk_i2c_algo;
 	adap->timeout = usecs_to_jiffies(priv->timeout_usecs);
+	adap->quirks = &nmk_i2c_quirks;
 	snprintf(adap->name, sizeof(adap->name),
 		 "Nomadik I2C at %pR", &adev->res);
 

-- 
2.43.0

