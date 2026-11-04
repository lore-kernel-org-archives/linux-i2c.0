Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836273;
	b=RfejaHQ8uNCT8ltosJj6u0Gg5Ucbpkul7rDZIHK4FSf0BVM3PwmDlFqMBupzyicWok+k
	 Vvc8xNR+vjzHUG0gV1V2e7l0MK3/nbULITMUwhATVhVIMDsBAmsTaSdVK7o8DTpGI0q2m
	 NP3Fj+ZycLO6bRsIYjr9YxdiKFKJLSdmlfRAxZAyAKmKwgo1k9vXkpcjl3SokTxW5lvEs
	 oBSXZQiN42pN/Iy6CE1LDs+o57AXtOnXMmAgBmXQ03d8fpc8gWa/s99pM1i0aWMaDU9aT
	 EeDF7QdUUfZQ/catRAUh1SqkvZn3iUxORuNHf53S9lRGqa47IXDba0819R1cFe3MSSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cwbe/XfdA3mX7yoytvk/55af8sErsLEc1FTxPSa6yI0=;
	b=z4g0vpmmpwmU9HJn7FWzl/HRpSC+yLbnxTPd4Gbc6YaOM1N1dILuzOPA6cGqItYxQ1Zn
	 veyuMR0n0F+Vr+kw1ANAFtUG4m/PSbvx4P4TYxmOIwyiWNQstfYbj7SMwicnrD9qGT90Z
	 LjJ01ShPyajrx6pNOH0qwJ9xi/wcMEdLBN0ynS4yKfjsranMExs7ptAS7/5j2K0I7mesy
	 aN7hght1cJS8CEzlQUZq6pcQ03EIIw6B2IzjR1F8h+wugWxU3X8/QzQQ+0c4kQOUp4Sjm
	 5RMOzRZ/8WL1rKRETjERWy3ozFAV1roGQaVclMY8niyZjqEMwQutEYXFyIrpMjUz46w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNmQF1kE;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF9606A326
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 23:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7AF9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNmQF1kE
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89f639ba307so546314b3a.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836272; x=1794441072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cwbe/XfdA3mX7yoytvk/55af8sErsLEc1FTxPSa6yI0=;
        b=bNmQF1kE3aFKPO1ntIRZIaBAjUZbGWG4hp0SzTcG4Hn96N8bGgPVm8D6NGrsZijfSK
         aVxtTZnycYxlNxHKrALH/SYEIQqTOg8+8ijbx2UGsi4ONuMf8TcxbUM/v+Tzn8ALjMpw
         92jbLGo0IdTNKi9hpKdIGinD4visJcg7A3BM+SBAx5x6esVjGoJorvso0uvE+7Z5MDVJ
         vjqrYVTF9sbn4lv8F0xW0tkrrEAAi7jF8OSI5sVK1+RqrLsysNKIEiUqjCvmD6vFwmam
         UFGTT4xro/GLVbj9/sY8jYBUp6a/ZPCgXNpJ2kEEPVHnkstDwT4Nauy+VEpL43GrY1ep
         zexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836272; x=1794441072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cwbe/XfdA3mX7yoytvk/55af8sErsLEc1FTxPSa6yI0=;
        b=SW3J7+AtlXeI0NgtYM7TwopAvf5hLM6PK91DTApIO9S4ojLhVVeU6GCB5w/HAZ2OnV
         cqdjnpAQy1deRhAL6WnoQ9B20Ts7NtsGsuMmcZpr1/p7m2VNxrvyq0jfRKWNCF/F3CtN
         KychPu1P5GhURTMBZv9TXu6UarX5BqJp2Jyo1dsaUlwHq5i93AcZIhmZHshfVVkQVlQI
         vU7gv2vINnw/fdPTBm4PAiwNzjIwuOdzOkTRzkTbVErgRrp3Ou8MLPHlo86E9SKK0CUL
         KXmhqlbuMDleJE3UKNjrAGk+gWgryUTLWKwbFqo7TBku8ZWf+X9jvjZD4rC5Cm8IH+ud
         PM9w==
X-Forwarded-Encrypted: i=1; AKwUvBzbse1u3mQhecTNuZb7o7uo13z56+MAD4Bd2eA74bob0uHloRzMPzWctGCD9XRqNHym5jdbSSkodgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GHCCc5bcSPlLJl7IkhCeaeteWjHP9jMrj4eztXdeH/dz8goUq
	5qneYnkKBYEVlrrzjQJveLEl6QO/kyW9zYdyOFRYuuBqEvXvOuwkoUg8
X-Gm-Gg: AYBFou1sTg9llOND4DIrTVAF23OXKKYNV3JmW33GEF/2RM3wPpB+K1M+2rH2Fgn42WW
	reRMz08oyvqQhid6k34kOPK+RXSiquK3fOAOBoyX0dxieKti3JA6D3qnHyAFuTaAu/qzHKCLIza
	ln7SnUlttX1Zjp2GAXDIhmQg+yvU8SRPA4fdgtZFz5yft1+jHNzGYXTOv8xU3EdLBHhGXqnawzD
	m6eZCPaVrsIPO895ljyPhEmzCcOHsFtb4TdlCKk+8PeIGtZDFmNXhDHLgzY5zCV5YOd4BV3bXGc
	nooYVSI8SepUcaCpLK0h44OTy3T7bpHRjac6T/44dkS3ae43bbjfW6zYEPp5g/ChfADmhRojWsV
	3batJAqaGKr5f8EF4MTPB9jUhZdgcTY81rpe8yYamLXLlgfboZrG7JtuYsjuS0CL+ZoYTVWi6Y6
	6YNevalCEi673mJWlCoTh31UkfvR0Fe6KTGBVTZa26zHt8Fn8Ul5OtOFerlj86QA9xixTXKIYbQ
	Lj72sYiOTBw3BT4+zmE/BjwzIMx3HpGPzPkAGsndPJIa4hgIfVETSmQfHEHSA62KKJUQ0sY/h6/
	HlHCyxg52Tta6uzau5trgF4j8RKvZsz8IayFnneFG9BS9NUUwtZg7eMe5INuos7WxBYiscR/Ogz
	2rKU6fovr57n7jUIz9/8UxoUBgg41hYkSSrYAP1Te29jECZIUVGq8N5NqWLjKLv2jilE5bJ5wo3
	abqkxW5onB3z9ryBor8x9KWc3T41BtgpW5T6HECx68Pd+6iBPvzBfn37DhE8JIgg==
X-Received: by 2002:a05:6a21:6a0d:b0:3e2:47cf:17ec with SMTP id adf61e73a8af0-3e928d28b6cmr14923917637.34.1793836272084;
        Wed, 04 Nov 2026 15:51:12 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm1608170a12.8.2026.11.04.15.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:51:11 -0800 (PST)
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
	Jarred White <jarredwhite@microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006 for Microsoft Cobalt SoCs
Date: Wed,  4 Nov 2026 23:49:28 +0000
Message-ID: <20261104234928.86458-1-sidchintamaneni@gmail.com>
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

Cc: Jarred White <jarredwhite@microsoft.com>
Cc: Jeff Kirsher <jeff.kirsher@microsoft.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/acpi/acpi_apd.c                     | 6 ++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 9fc667d6776c8..a1baa056931c4 100644
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
index 1da6b0314b6a0..f359d38cc63c7 100644
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

