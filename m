Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5334A3C1
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383546; cv=none; b=Wy6ghoVPCG4NID0M3K63Vgsm88YJJFzf22/4obzI12MBchue9b2S2vLWn+NBOE3XAvAJRHJr/lzKxL0QUdTc6k0i1pDYh5DduEg2GuG4L3f2+mEvKuh0IKPyNod7a4ooonKygcvlnGglT/eZMJi/iuRNG1vZ7OVWGmZivmfIOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383546; c=relaxed/simple;
	bh=Dyg46i6NCc1WhVwi8ovx5dhpXtlJuvYJqgKq6QPv0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdVKeDgk2iJLfDn0hL4RP5K2b82MWIxbfFZOG/VbFTydduUspVviyjZuDcPoqO5H3Fv1O9Q2ieL493G2njiE3SQzyds0oubl2CbTXWXPNWOxZYNWrvI64LRs6vQVpBNRSyq4BH2LZWRDSsnk5KM8BBTOrPf78dsyqwqA9xfoYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6vCoVf1; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6vCoVf1"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94e578a0fa5so837814241.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774383544; x=1774988344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=e6vCoVf12gK9VWthRMn61bBa/NccVDO0jp6+PjF+1gUG5lfxCW6Lloo3qiTgcbzK7o
         UWAtpQ9YKK28PesKG0rLIAedXyI/0nD1swFFk6XPzyl2mBdcb3seQOz3nEhdf4bZq9uB
         EGmF2C+5lfuGxGxTL3WIZq5wH0V092DYfTyuaYnC6oL5iXbypLgE305y0Y4m6mHrcc6f
         3nzxCMRssTptHAgaolWDwMolk+l6XgqgJFCabVIgG0i24QbVuC/oWc5Ke/tpCLlxPW3K
         24OArcrdEiHivf4LCu7yZG6D0xrVagMIRTvdogvgB6wtzFA6XroaH2xmI70oJZAU5RQC
         yaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383544; x=1774988344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=ArKsc5ropMdmroDc173On8ZJDx59YXnQ5x6wHh8ALEOH972hvj0qukulrnOKDbreeu
         gXmZdl3jCSBD/1qcOx50E+8UOS5Eg8QQCzEFxqqpnFa7xY43mknWXIUnXxk6jFGFsPfa
         x26/mE9Pi2bO3TEaRXljGldDBSxshi+o+iM3Jbnv7ESkyRv8iQd2ervg6tdZ8u1C6aXI
         sN1GpKZ8y2lz5GvV4q6ftX3L0FxMNPx+4Px+MpxiD1S9DZebfEYAKsFvzsqodS5bZ+tA
         RR+vRL/HPrBMg1zzV8pIz67NNGo6ngDpmVJbBF38taQolwUdVRXsfVI7kESu2x6mUNQk
         64+A==
X-Gm-Message-State: AOJu0YxDrnyW0OgKJthYNZEpAqUD7BxCLlxjJ8K9eUHakfpWjw9Tzg1E
	uGnB0zDWBxDiQF0bvdy98mKd2bfyqUejLSkITGyDEw7vesaOoiNjCf+tmRv091kiQy4=
X-Gm-Gg: ATEYQzxWzAyEnVo0uvM9g6Q+d8Sb58501w9NDeiVUmdQHL1TCQ6BKHlR6uyBWNFHp+Y
	JB2jsyhVxJnXQQ/sovgHvymgwkKcyeWQsOHX84voxXFNsQcrEpV2uYaannrHgW7iKt0fyezqPFI
	VBBt7ZKu+vKPBklOnfsrX8+0gsLtS/Jl63TKSaBCpKn/k/v5vLqS6EabvaDPVYHYc0eVwTWq0uH
	ydwpQ2FYMYkys+Uban1ioz5IrAAU05Rq8k9elE8S0Q407SKvhIVkqXP0Twd0wskiRURmaaSHJE3
	eeeaa6qcg0Sr1Y2HIi5Lk++kBVeu7jvPwxwhwpxctDDM2eWOUjRlJeK/NHTAhBnpsX5WP3JVSSr
	V0a1G34N8pCGAOO0DiIwFOIhD4ITU/Ul0aoOl5m+zXE+8Ti5Y/YuCzo+bXLQLVACnz1qdAOAIDp
	NQbHa7dOmA3CxYRwXhT1qc6hNY7Abszzehnw==
X-Received: by 2002:a05:6102:4425:b0:602:a4af:5fe with SMTP id ada2fe7eead31-603870b6353mr706587137.9.1774383543988;
        Tue, 24 Mar 2026 13:19:03 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6dd:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-602b549fff7sm11665211137.7.2026.03.24.13.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:19:03 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: michael.zaidman@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
Date: Tue, 24 Mar 2026 14:18:58 -0600
Message-ID: <20260324201858.46591-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324173527.11321-1-sebasjosue84@gmail.com>
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ft260_raw_event() casts the raw data buffer to a
ft260_i2c_input_report struct and accesses its fields without
validating the size parameter. Since __hid_input_report() invokes
the driver's raw_event callback before hid_report_raw_event()
performs its own report-size validation, a device sending a
truncated HID report can cause out-of-bounds heap reads.

Additionally, even with a full-sized report, a corrupted
xfer->length field can cause memcpy to read beyond the report
buffer. The existing check only validates against the destination
buffer size, not the source data available in the report.

Add two checks: reject reports shorter than FT260_REPORT_MAX_LENGTH,
and verify that xfer->length does not exceed the actual data
available in the report. Log warnings to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-ft260.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80..68008a423 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,6 +1068,17 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	if (size < FT260_REPORT_MAX_LENGTH) {
+		hid_warn(hdev, "short report: %d\n", size);
+		return 0;
+	}
+
+	if (xfer->length > size - offsetof(struct ft260_i2c_input_report, data)) {
+		hid_warn(hdev, "payload %d exceeds report size %d\n",
+			 xfer->length, size);
+		return 0;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-- 
2.43.0

