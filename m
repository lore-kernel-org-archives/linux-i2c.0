Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1706366060
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038054; cv=none; b=rRMVueNG7G3Wz5WkPntpNdohS/c8+ezLw0AgfjP+clmDttBxjlUkhME1aLRJT07riQk+mUBvPfsNT9t54Pm8yUuq3v/nZcOrLAANAOaCfaKSrg3rgrTJKnOfl63GYuH8IGjyxbrhZC2eQs1laxpIXcZw5BPZ7LNA2pFnN0307Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038054; c=relaxed/simple;
	bh=hXbrIL/+RlZ4QrzMitIlyjKmIQanPf6iyPGIcFMUZrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7kjB0jKwUy/hJB80T77RD/FX47WGFldqHh7Jv4tJVrEyY97oC6C/5GUBrCXF6A1lQfMkzDG8/+Aq1eRJQKyqmZaW1XWvQGzdEG6Nw69FFjDA/HWdDkNWY8xGjl9G8l8iS7S6t8id+trX+gVpCpgNFCqXrCBItJ4577UWWILd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyUCxvC9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyUCxvC9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43284ed32a0so2376813f8f.3
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 05:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770038051; x=1770642851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TLTptQVGzGqVMmcaxe2rInRq4le7Tc2RkR47pL2Pvw=;
        b=DyUCxvC9ICxWXD3w79i8NBIjpLxxVxqCbW/A0lMAhkEo1m7TvoOj6tDZ5f1VGfGBPr
         jPWtKCY6SuY0ruXaS5AeLBidRZ4SIukoMUb2miuvxHCR70oDD1SUrVeLMcxr0tvLXmip
         QEKZORJzgE2Je7hkE1HZY6GEk2pOuN2zpsQBADl8Pw1svk2jKn3nEGbTctTBWXX4qUbp
         OEbnAV4V45/UfVUbem6sTCvrmfw9bt5kmUWUgj1XqMQAizRy01XimrKyVAp0tbZxgEAR
         XkWZ6NBUPJ9fxD2panbK1QAJkRyma3eXofW99ocKEO0F+9HzhV0dJpUSK6tvj7yCTiCe
         Km3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770038051; x=1770642851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2TLTptQVGzGqVMmcaxe2rInRq4le7Tc2RkR47pL2Pvw=;
        b=f6EnYdKxEU6waP4f68PVyHnsu4KQIHvdOq90hVuZ4MqCd/6tCwAt/j+UvdliLwxkca
         Ucmn35rb5Q+JOIPK8JLf53vd5Ba7Prngy/HSZp/hFw+EbqmmNqplSYeZMOE18QA+YdwG
         8ksHOAT5/11CVqKk/QOYagb8G1XiMfmptiM/zKmMwtgx/M7pRAclQo1QW+VfJkiOke3w
         x+6P1d5UOQESOWD1zoDze+pJjhtXNvSpuQGCWvsCcWAJSaLmWpzFzAbBy69eVEkxPMge
         LPPmTDmryKfsCSYR7sp/RaMREzLRwloDrsOCJucEpeP6jdRwleo7t8BuL3E6SUm0bNJB
         abEA==
X-Gm-Message-State: AOJu0YyIdvGEZEcwFGoHcSyxd8zHxphVt2djwxE5UNBknV2qjrierFch
	MOoo3FSFswveMstaZeLzZ4aQwXEpQZdwq7oFE8G4yTwP1jRcoTB37FqSl/VEEa+VFjfCPHjA
X-Gm-Gg: AZuq6aL/qVSnYQ1DPjmea4iShzV5+c8OWbclK1zGUHfx+iJQrpLLILSficsPwAxsmRV
	wBN8LrJqzKTOOsen3U9xdcI9O6nomQ7+vGtnHeEvOCLEnqeUalIoCxKkX1FmW7K6tbEf0MxJj8f
	gmr4VLP7usClg6IAuIkaKSehzp33ehxk9yqQBFrX1kpBG8BCv4VMUGRiIsPqarAHWsK6e0TazYm
	CdelyBhACQHKZuA+okf/WYhGOpSQWXJLlNOyhXL5/kWvDqYGdoXw4eF4atfNBRvESnt4LHIiaT+
	bsvbaM0FSEDHVy5WQ3KVqiEf7zqDX0HC9kssL4W6dsBxFir9iOxJy2Grgpm3UqoCKt49mN9Xrzt
	REEzEp9QBC3w6qMxhK6vuRB6IlakI16rpHHasX3TrGO3VS0EVl5FG89HfA+2ManT8RL2xYDMvh1
	gp4r4umFUYjOZThOI7OeA2ByQ=
X-Received: by 2002:a5d:5d84:0:b0:435:9a4a:9b79 with SMTP id ffacd0b85a97d-435f3aaa9ebmr17085567f8f.31.1770038051060;
        Mon, 02 Feb 2026 05:14:11 -0800 (PST)
Received: from fedora ([179.43.189.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee04csm44242415f8f.12.2026.02.02.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:14:10 -0800 (PST)
From: =?UTF-8?q?Filippo=20Muscher=C3=A0?= <filippo.muschera@gmail.com>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Filippo=20Muscher=C3=A0?= <filippo.muschera@gmail.com>
Subject: [PATCH 2/2] i2c: amd8111: switch to devm_ functions
Date: Mon,  2 Feb 2026 14:13:04 +0100
Message-ID: <20260202131304.8524-2-filippo.muschera@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202131304.8524-1-filippo.muschera@gmail.com>
References: <20260202131304.8524-1-filippo.muschera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use devm_kzalloc() to manage the memory allocation of the smbus structure
and devm_request_region() to manage the I/O port region.

This simplifies the error handling paths in the probe function by removing
manual cleanup and allows for the removal of the explicit cleanup in the
remove function.

Signed-off-by: Filippo Muscherà <filippo.muschera@gmail.com>
---
 drivers/i2c/busses/i2c-amd8111.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index 51e3660e51c6..dd9ac4bb6704 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -427,7 +427,7 @@ static int amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!(pci_resource_flags(dev, 0) & IORESOURCE_IO))
 		return -ENODEV;
 
-	smbus = kzalloc(sizeof(struct amd_smbus), GFP_KERNEL);
+	smbus = devm_kzalloc(&dev->dev, sizeof(struct amd_smbus), GFP_KERNEL);
 	if (!smbus)
 		return -ENOMEM;
 
@@ -436,19 +436,15 @@ static int amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	smbus->size = pci_resource_len(dev, 0);
 
 	error = acpi_check_resource_conflict(&dev->resource[0]);
-	if (error) {
-		error = -ENODEV;
-		goto out_kfree;
-	}
+	if (error)
+		return -ENODEV;
 
-	if (!request_region(smbus->base, smbus->size, amd8111_driver.name)) {
-		error = -EBUSY;
-		goto out_kfree;
-	}
+	if (!devm_request_region(&dev->dev, smbus->base, smbus->size, amd8111_driver.name))
+		return -EBUSY;
 
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, sizeof(smbus->adapter.name),
-		"SMBus2 AMD8111 adapter at %04x", smbus->base);
+		 "SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.class = I2C_CLASS_HWMON;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
@@ -459,16 +455,10 @@ static int amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	pci_write_config_dword(smbus->dev, AMD_PCI_MISC, 0);
 	error = i2c_add_adapter(&smbus->adapter);
 	if (error)
-		goto out_release_region;
+		return error;
 
 	pci_set_drvdata(dev, smbus);
 	return 0;
-
- out_release_region:
-	release_region(smbus->base, smbus->size);
- out_kfree:
-	kfree(smbus);
-	return error;
 }
 
 static void amd8111_remove(struct pci_dev *dev)
@@ -476,8 +466,6 @@ static void amd8111_remove(struct pci_dev *dev)
 	struct amd_smbus *smbus = pci_get_drvdata(dev);
 
 	i2c_del_adapter(&smbus->adapter);
-	release_region(smbus->base, smbus->size);
-	kfree(smbus);
 }
 
 static struct pci_driver amd8111_driver = {
-- 
2.52.0

