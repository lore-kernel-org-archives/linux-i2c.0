Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258115;
	b=MB4c1MDWuky8llAJH1AVs/aqIs/s+800zgANHx9DDULeJ/WDraAIP2mq4m1G+VhYhjnx
	 RmTVqoVa7u7BQEv7Xi7me12//p5w5+pKSv+CfoJmC8iDBV/7tRnn+yTJzDbKy3iZj7aXg
	 HkwqYfPY2udGLUFwB2NQWjcQcRzk7TDnM9YCzBPTY7/sdwAqVECaOF7JBHKXu7ghuXSWj
	 IbikKkyHNI++srCxozTS70DOc8hgZOnwBp7KwKAR2BfOVI/7W5lTNV+VzCX87RCKSSF/h
	 rdOtj0HQyOYomSNkLKvge0Bqr49GlzHpFVMOzhNkF/bzo8dSjGgZJOMqHgJv8U4/lMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1rRofamHWsgQtnXWvZBbAiHKmjpBdt9GxPKw93w6wfI=;
	b=aIONLNsfkuC9ypFKGW+DGlDfrVXsPZ5HmF4sFmfT/XXGZyTfbKA0tF/BrYaxZsxouZgA
	 Ib9uZYAbVqpodaFe3e2U4YglG4FfJhRcvv+3dI4SLxHgkzMfgCgHDaQqHkKEIH1pxfPvh
	 vgEH8y0gSwaedGPhQD6xHd+W4FexEQI3GFuq8M4f8dLSDn4K1SFSY2GYGSTsy8aoC8Xa4
	 q8k7S6e1CtMiFQyr2UlENRi7e4z0l1pmwM4tIHIxwF8QU7yOOu5vfiQSGGhCU66dVPVud
	 XX9vAH0YgweE2n8Bv846GtxtvcpnayLn+YyjNpXgu70EoWksWqL+nya75aUfdybPK7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D5L6amhx;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED6606A325
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 21:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8ED6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D5L6amhx
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so745913a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 13:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794258114; x=1794862914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rRofamHWsgQtnXWvZBbAiHKmjpBdt9GxPKw93w6wfI=;
        b=D5L6amhxFSoDqc8GwvGK3NvVz5o+I0AQvBDbqUKgOzZ/CdW25tCh9hjypnl+Xpd2ve
         HHub+xs/2/NInY4mxfESNkENa6n9PPadk9TlwMOLuchIADPTzqhp7IRsub52uCgO4VqX
         +FNiv7i/pAKGWeOaHu5/27nUSNVhWxpcNRsFjHMsR7rGe6tmzt0NFkJ80SKfoRiz+K+C
         iTov9Pz6KcZ5UuU/2vHccxPKHJ3hOY1k2afJUiOIn0HKH4uzJcS6WLUv9aFoUom/GSxs
         jOl1dWq49VnmO2BQucHm5wjdl+6ZhZ7azuhhvzWPTHhxZwnNZvM225Bs5xRrdSKCfb7g
         iRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258114; x=1794862914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rRofamHWsgQtnXWvZBbAiHKmjpBdt9GxPKw93w6wfI=;
        b=OSgJ3sD+6A2vUxNZNZcBEsqMfrSNwrFP0BeUCGD+wNmAVAwir5eUpD48FOxrjLYnET
         Zdj0Dg9sJ2n2pL5WpvlSVq2aDZk8AZu4OOb8pw9bkHtYhGQ/ezbUFRWr9koA4WBEz4+z
         vox1ts0ql4EowGy9y5za54YmSVjJHqmiaNgt3dCbGb1gQf87sxmja5YoFy7mBmivxTea
         +q6uoXyhn/mlERggNzM+X6RfUxnpTtuu+33oKPPFPkjyOaPUH4BERWnzAR4xMrFnuBa/
         BnLHybNySq9jj7F9QLmBADoIPs8xjC8hnu8cV7gIMeSOd7lS5rvpp7Df1Brp9UIr2pQA
         URFQ==
X-Forwarded-Encrypted: i=1; AL+hErE41du4/CssrMhtJ2v5+J8FlTnoL+m9qF1GVRTelxB91X5sPDKtzgAipIWkHQuHimQRdUMHfGUj+Ow=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jOg+njcCjLqHdUHi3Xnc/ohMdVKtiroR70rdXsWORaWpxPj9O
	kIGPo/oQvurk1pBaeQSA5BpZdIgRXwvSztkCKmt/x8SyuMEEqZsF1WHm
X-Gm-Gg: AYBFou143+HO/jQHlufp2m40hOEBwevD9McqeUDkFIp/An6jdkGBS4aHVkPphpYlzY6
	rLoI1808mq6yR+vg8HzWFcLKDvYj16vljeM9KKbUUCP24rmhmFHEWZMQpGoeK0tmNgFcwyXFEJi
	4PNAYIoNufwVNx2x8+N7Kvi/zectopoXEL67NNUK3vRjxv5C3z6eH6FlqYLOjgg9d8AyYDP8KQa
	331Cem+xN2KH4hJTXhRmy59OXmZ7TsNnGa3d4HICTDYP76j/1mNjjSpaDK4l+H+beNhP8tDkmAG
	P/VRJh0vgBhyptVGxm6/p1oUC3fUZOeSXjNRyjI8iLjLDG6OnWbE5DEizzJ1RgqUZ9P7jINggXQ
	Fa0VvdPg3atkcaWNIui5Eb9w3fJI5iUnMZVaGWkuxiBVzbEaKYH3nxDuC850Irfd26NWfv0Dvpi
	igI6HV4tuFZKRk6ltEKvYoFTQ3e/x5Os2Ia2l6QWFibHYWqL01ViveVPx545LF2fEmYKBwLEbWs
	VKEWwwLlmX+qwCysOndWf5qdN4UZvvG0qAXeAwZc2u89e87qSu8PeFNG1AE0AXbRBOaE7kxbW8r
	Os/tf6Jqy5e1Zb9UajY6ot+hVQt4GxOY3rmXWAR4MjSgQTtPtseNKDJDn55qN+m/f6lKfxgAeQc
	d1qM6YImNmFIFZoI8GsDApAZeRaTSyaHfLt3o7kUG5SNhdf248CqPHnHi0l3R1RaGlRWUWOHuaA
	WwjmG2VB5m4c8Arh75iUeVbBofoKdwfntuTQEOQBsh
X-Received: by 2002:a17:90b:3e4c:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3b1679e9575mr500295a91.32.1794258114035;
        Mon, 09 Nov 2026 13:01:54 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168ed00d2sm275299a91.1.2026.11.09.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:01:53 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: [PATCH v2 1/1] i2c: designware: Add ACPI ID MSFT0006 for Microsoft Cobalt SoCs
Date: Mon,  9 Nov 2026 21:01:46 +0000
Message-ID: <20261109210146.57766-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
in acpi_apd.c.

Without an explicit MSFT0006 entry, ACPI device matching falls back to
its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
the controller's actual 300 MHz clock.

Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
Acked-by: Jeff Kirsher <jeff.kirsher@microsoft.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/acpi/acpi_apd.c                     | 6 ++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index ea226fd987567..66a7607752d9b 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc = {
 	.fixed_clk_rate = 200 * HZ_PER_MHZ,
 };
 
+static const struct apd_device_desc msft_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 300 * HZ_PER_MHZ,
+};
+
 #endif /* CONFIG_ARM64 */
 
 #endif
@@ -272,6 +277,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
 	{ "LECA0002", APD_ADDR(leca_spi_desc) },
 	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
+	{ "MSFT0006", APD_ADDR(msft_i2c_desc) },
 	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
 #endif
 	{ }
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 13dd7c50486a4..cf364f3c26199 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -280,6 +280,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ .id = "INT3433" },
 	{ .id = "INTC10EF" },
 	{ .id = "LECA0003" },
+	{ .id = "MSFT0006" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
2.45.4

