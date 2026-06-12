Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1C3AA9F3
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256980; cv=none; b=JiGzXPxbSxh9/95TFQY0thNFYKOZCMsW8Jm08n/6UAVWzzn9a5Zy8hc9q1eGIc85fgp3m4ACbLEKKCGbACApDpF2F/zE99b4iwIzcCwp+NFa/2nhqurVUjq3mzmilksjvU3QPM24eOpDG7VXUJw+23mF0CI7Ca0+Erk3hej0LJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256980; c=relaxed/simple;
	bh=k45LPxbi8Z+hz+KQCRHVhQ72vUfstcU7nrp/BFSgY4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcUUHbC/FmN3XaTFXq5Xx1kDrXoVJGA319UNpNsoUpaLdOFlBTIK+9YPn2IkM/DDxC2qE846xaOCvhZUj4wpABXnFZ9Yd6d8wJelZl9UtwQFJuO1jcJvqpBr6JxRXKi7175Qnh1YLivTa9eXbIaxfvF5VrGVPSx3HL/FSzNYA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh7wQdAT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh7wQdAT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422f148dfcso490993b3a.3
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781256976; x=1781861776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTu7u8FS5bZuOkg5kwPhz2mwDAHKZtJNZoWMEvIIywE=;
        b=Qh7wQdATLyBDPJfGA69te1SsXd0G5oNfRR+fl4ND6BJziDceGGwnQyYzd68/L9W7D/
         m2ClKoqgbUbXahmbpK7JFlJE2Vu2Pz16fMJw6wko2Pbw4DCDs5v/gmxaVm/jgFKTm3ih
         qjZYIg8gwYAk1SCc+tuJYzxDrjWxUkfzxmb9197kNM9SIXxWXHkj8w13PafqZMaHQT/+
         LQPOAJBBKz9DVUmQd3nBdZprH42n2qDyu8+YuU+bINWZIS8qsQCrDWhytDnbO9Ds6W29
         RRk/JrCvKGWF6DayQ2zjHitmOq3bjQm82d7RUjGpp3MTSdlgHiEan31lCn5BpZH+vIPY
         zaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781256976; x=1781861776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTu7u8FS5bZuOkg5kwPhz2mwDAHKZtJNZoWMEvIIywE=;
        b=jzFJN3ZnqjADOBsS3Ge4NzuoHSel1dZ6GKc7EVgwZVySJT30VmCXUbqVAvl/hnf1pi
         V/cN9hwif4UIVyuDjTKWfrM14LzyHBEffAvPBOzsgzRjDuR/iMxqf1RBWj8H5rCfktKf
         yinDJOLv6JCyB11A+TxIHEr217nASn/Y+VuYdVDOMxN6H1731X2Jrq10UcBEiRi4COvV
         cBQVGV2GCNlCVjJK3mMiT8ataRiC5PoIWqTt1nt/b04y0NBms7tL7h6aByphimP7UQa0
         ABLqOcHEDFYe2/yOBgtlaANp/BCy4juFOf8clxi5pVJ06aQcu8drOruWvK880nIJ2uM2
         5UHA==
X-Gm-Message-State: AOJu0YxHRiRXx4p6GyjktKLVzOg6UcrFVSVm233LtRUES0VMfXFWhArI
	+F62bChp1wKhvNKWi/HW8PfLha8UpAz+9z7GQKmoKYDAtFMzO9FzzyBemwAVRma+
X-Gm-Gg: Acq92OGASyD22qbRNZcnctkj7hCHDtjtAQSDog5AEe1JLIs/Fr+e2/8fTViVZVyngwd
	FyCpFV2VDauAVqpSyoztuI8WuA1drcpKSmMe8j/CaVTJU5cdKsi20l4VjWY4U3l9MoO0N60rn7e
	pcVKY6vvDe18H2Gi8wi1Cb0Wcq3KLQUsrsG4lNs1MfDuL49iz7zAVPWicW3f9rvWQSJiekWl1Xu
	PsqXFHycFu25kgG7q6aqsbnGbxgpl5Gz9Ona1eWpjZooQPJHSXkDXOTsPTnEMdhrE6giCoh/Piq
	AMfxXAfY07ix/oFpOqggbGJ7CmtjtenXQW25fENoieOkmMBXvK3a36PglGVwLV2YAefmnL5vydP
	6KPcRFl8OXi63yYGB20/ov0xtRtMxLkNNi65K4EOzTb58iN8zMqXffcsjt3g0tXIh04oTfq+tKv
	V6YzStDy5JAQfP44Pjxo45hvbiNes=
X-Received: by 2002:a05:6a00:390b:b0:842:6004:3fb9 with SMTP id d2e1a72fcca58-8434cf0dc0cmr2208873b3a.25.1781256976020;
        Fri, 12 Jun 2026 02:36:16 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acffd04sm1701370b3a.26.2026.06.12.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:36:15 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: shyam-sundar.s-k@amd.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>
Subject: [PATCH] i2c: amd-asf: Validate firmware-reported length
Date: Fri, 12 Jun 2026 09:35:02 +0000
Message-ID: <20260612093502.3805287-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware may sometimes return a length greater than the
allocated buffer size, which can lead to out-of-bounds access
and a kernel panic.

Currently, the driver does not validate the length read from
firmware.

Add a check to ensure the firmware-reported length stays within
the bounds of the data buffer.

Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
---
 drivers/i2c/busses/i2c-amd-asf-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-amd-asf-plat.c b/drivers/i2c/busses/i2c-amd-asf-plat.c
index ca45f0f23321..3d355e880d54 100644
--- a/drivers/i2c/busses/i2c-amd-asf-plat.c
+++ b/drivers/i2c/busses/i2c-amd-asf-plat.c
@@ -90,6 +90,9 @@ static void amd_asf_process_target(struct work_struct *work)
 		outb_p(reg, ASFDATABNKSEL);
 		cmd = inb_p(ASFINDEX);
 		len = inb_p(ASFDATARWPTR);
+	if (len > ASF_BLOCK_MAX_BYTES)
+		return;
+
 		for (idx = 0; idx < len; idx++)
 			data[idx] = inb_p(ASFINDEX);
 
-- 
2.43.0

