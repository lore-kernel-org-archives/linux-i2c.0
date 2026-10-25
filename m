Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896539;
	b=TYnxC599hM6IO1QkZoBovywc8Bovbs7fyOskvjY4sLCi0y9oBp4VBF/bIXst0KJFZgdX
	 +LZ+p58JFOuQC42HkX/KfmoMOxwHm5R005qWPAWUXM4biERZZt396bsg1DHvvZTAq1mbd
	 zXJ8+lWJtdMX4HB+jFuaRwLFd1HPCE75t+Qe52kMx550Uao9kh03OahhBmqLO8Qy7UJlA
	 8yLm0J3F7MnzEaPEYUZmiJ5/M5Y4H1Sa113CM9G07Ct9cYOLQY2OLcza7ZBETDFInYoPU
	 lkhNDztSXuZ//JeGGpREyxFT8YHuMB1s6ddKPZZnSUZJEAKPvRxo/+IOk1O4V3h7fBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
	b=n4iVBx7Yf1ZJq2SyJ8QinGovJO06JS90fyIsfEoPlNKdGFfLADhJxAM2wWVJ/SksHx0s
	 n8wqmlXh2cwB0sLf5rnuQl5+BG+sJ92bfdJMUF4UuBTd95YCA1/wrJwYYKK96O4t4S/Xe
	 jbAmbVVqodprx7KcmllWRTJ58UB/dCcAPMe5D/GI3O9ZUeiNQ8ntu71L+alluhYfyiXH8
	 kN1qT97hkJgrYM/b/V3wZxbEPIksGAQVxfBwjq0bIplbv7EiztYot6KqQ1V8DzBC1/8Up
	 C62aGevThRFROoa4RG2O8rOKmMjyigOR3Ktiuu+mDGPE6zykVYVr1sOU+gZFMlJ3ouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KoY+mptH;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4960A260B
	for <linux-i2c@vger.kernel.org>; Sun, 25 Oct 2026 02:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE4960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KoY+mptH
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5337129eec.0
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896538; x=1793501338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
        b=KoY+mptHC0CdbSXyXRIQLOUk+sIQ2V8zR/H4vg66uM1mRxvr8C2tagJSF+7ZHnvhXb
         mrm+QXgnkIMNQlrG+qcqoZpD2EjjNBgf7f9tWH1pbJYvt9qCPRW9+uC87jYr5Ky702+k
         AnIyrs+SQfRs/p/9TcI61sYs1h+H/Fsfw++AkiPkMECbrp3cvdsYXqI2VnhX7hkgOGEj
         mD+1RWZQm1044SZN0wrIX9xjwCRD/zU0pUFMP5Gs6Ypw/7ixhIsI0b0kGgurBXqbWMeO
         eC+o04P9a2kRz69dA+KfBCr9OukmHDQDjvSOZdjBIcjV7OxjDDtIWYnbg+PLlF0D+H3m
         4z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896538; x=1793501338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
        b=1WfF+VTG/BwMY002LnWdN9gHoolj4hrBFpt+xOukMos3rzCZGWct/YCXdOVATWITWv
         KZlm7Qx1d5zT6NsfbHMylq5el/DItq0Qkr1tuc2EDlI5tGk5cxi4w1vn0hB/bApIoj5/
         /luifiFXLqbrjXWDATU6ATk+PGwsoZB4qN5r4X2Y2ZNFtVmUaxUQjHwKtwPmwULahKvv
         5+TiH5Y0XpACQDR7uBBZL/dpJVQ3FNqqXVtQJrvRLeB6fyZSKb4Y0aaTW3bce3Uh0pYp
         fxQWcC3TlDRxoVTkyhf/8XLDK3sb/apoKTRQBncZGa1hrPpMyUnwqM9ZMVTbZ6+kAdai
         6J+g==
X-Gm-Message-State: AFq9FYLZ7JXdQtFB5LTrA1ZzlfsmDUJGI8RT9KcRFruGiUHSCRyGHT8F
	UP6eEbDfxd6FidQVys4bPNDmDWQjKxt7qQZIk58FZ8Bd1ID+Ja8grzJW
X-Gm-Gg: AYBFou3c9pmxqJv7FdGTxLENsXWWscm0XmzWeVlxr0TH69NQ7SYYvpGt/F/QZY8+4lK
	Gu9eVk4J5A2y5h9FCnULPOusZJWw3gavSZ/CbShMJlVeNPE8l4BVRRX1c1aSkL5hayiwrxEu5jV
	Imtny2oThaK9omqoeFE3dV4fNJXOoTLHrWk4CczBBLyEjLFFmrxyzrhRzv8ymH8fdFQb1XD9GZT
	PZypSoVqYRbWXF9GU+QbB0rYaC3mC8CxhxTf8meAeeD1g47+Maj2ZY05tbjJ1nMocVe/3fnBtfg
	TfYqiH+CBfUv2t2lHQjf0g51IiufewWAaH5Kzl34EQKszowKIdlVA4J2TziCjEAiOtH2nzI4gR6
	jE3Z8yG0aPhfzoeTBl2NpsqFikiwo/TraS4e2Gz8Xf4sUfPTUqr61ygGbGJnvP/EgN9pq8DejlP
	FVH7/BDOfglgE6RlnVNKLvQeHK4Qem6xIcg5nz3FzSPZbV826Our0XZkmbbR/DgCgM3apviH6qg
	HrRNvUSXGyORRYAa+rszLgYHXEXjUFxSjU+35hBJFPbTZxtEb57nXD2f/z5fMvCCX7a4WR4XqKT
	+l/7AtRmayfXwi1kp8qNPhHHqPSnMRHIh4XLIA8qIMo=
X-Received: by 2002:a05:701b:2714:b0:19c:dd9b:d09e with SMTP id a92af1059eb24-19cdd9bd124mr1585077c88.23.1792896537822;
        Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:47 -0700
Subject: [PATCH 7/8] platform/x86: x86-android-tablets: use 4-argument
 i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-7-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass the expected response length and destination buffer directly to
i2c_smbus_read_block_data() in atla10_ec_cmd() instead of copying
through an intermediate buffer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
index 67dba9aa51f6..bbfa040cd4ec 100644
--- a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
+++ b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
@@ -65,16 +65,14 @@ struct atla10_ec_data {
 static int atla10_ec_cmd(struct atla10_ec_data *data, u8 cmd, u8 len, u8 *values)
 {
 	struct device *dev = &data->client->dev;
-	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	int ret;
 
-	ret = i2c_smbus_read_block_data(data->client, cmd, buf);
+	ret = i2c_smbus_read_block_data(data->client, cmd, len, values);
 	if (ret != len) {
 		dev_err(dev, "I2C command 0x%02x error: %d\n", cmd, ret);
 		return -EIO;
 	}
 
-	memcpy(values, buf, len);
 	return 0;
 }
 

-- 
2.56.0.257.gf7497c7d27-goog

