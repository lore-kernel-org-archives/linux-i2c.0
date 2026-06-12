Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C6383304
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259523; cv=none; b=WYGqLsqv3cZ+1mvjCUW0VmDqiVtX/Bo5BF6MmDKbV6aMq5a3kRACW9ILNZaLxVOC29zmPoew/svlqo68+6NZBTdDTxd/+zhyF8UKrxU2e4/KWHEgDPBCgtTvpxkLQKA4jtxjU5uqaesSUVKQ5kJT5oh7lqhxUfgyGEqlMqLZDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259523; c=relaxed/simple;
	bh=sXKBaX6Hr2LAg4dl5TUj48KgKUHVi2a3LJ3BJOGQzPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQemm1wh9iqA7a+5O5U4iWOWSzYGEnYIogQM9tcDXUzY5U/d1SXH1leaZ7iyKTOzhVQmYNEpV+nKDuAy0GjFhw2BL/S+kuTcpZTS+V1rwHgku85GQ+45f9Qofo/0msKITvI+IHYVAUql4hIYZ38WX2vB4UvV51O8vvUWc6kPV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYLDiwcL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYLDiwcL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf1f074a12so8215255ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781259522; x=1781864322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aiqy4XFAiFCzZrOgOwXI36fmGBpHZGsULNLcfvFZih4=;
        b=RYLDiwcLGiCDB+lllDpz874eluxFF6pVvnic88wd9q0lOif7sDB5dcubHX7UJFG1/z
         rcnO0ERssqtk3bI1u9kNLfa3cU+DmHd9mWHtmonkLh27KRwfNA1xy5AmJLm1pJGZdPUD
         G/I8jyqvhnS3paZYfADQ6/AboMrtg15RggB/dn0FsRt7ewwbZlyBmdKkS7NAfR/erC92
         qhJ5VDlWWQvAOS1d6L5lzFL5fpSKbIztlU7AccN1gpmsV7KQl+O1Admj5LHqMPcngABg
         CZCps+tddCjhQ4+rJX+f+0cNVpaXc01JGARnPqYGyb/RD7Sdi5VG9z+YKyX4VIMlITu2
         Ug/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781259522; x=1781864322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aiqy4XFAiFCzZrOgOwXI36fmGBpHZGsULNLcfvFZih4=;
        b=Sk1Auz145tkoDCB4zPhSfDQKVmRGd8Z6tE6SShdGyT6fwKz+OCXS7l6QLf2amWff2o
         37iUYDe45hnsglwy42pRYaPYDhjBuUPXFtr489r5ErsoE2ZpXAHDDKTxsoijrELuvDB3
         GzHwpSFgKb5p7tRiNIpRSrn+L/4jitjSUkDax70czzh+142qe2xbQBsMPCIPf19C1ffz
         nZ3erQAnDi5ukwk2CSRiBXRcGKejOuXZ5W62G21z8B8AUxvUY1KF4eDHRSpMdoB0xgqt
         us+Z8DmiETPp/kIfZdgnekl9nGubWEmFAp+udCiclJcZZZvy0YWNu0hydPmT3l7JB6Bo
         dqVA==
X-Gm-Message-State: AOJu0YzJ0gzBhNVl2lEaH+zmzNFGQYV5ULzxNDRZBdH6ZecUqjM6WNp0
	PS4OkBDAQLer6A0E4ykDceeSoAy8cRgCK1bnqxObjuP7nTbFQ20egQ2MsG0K1T+601s=
X-Gm-Gg: Acq92OFZrMthQ9UvqNbzGU/CwxIskjNgKKdqoECL1qnYmDIlu5TIr0H2j797j5wvjAp
	S3EpXObP+5JZQPEyk7gf2DuDGAnlF0dmKwiqKPkWdBeEaFlH6XXYpec9EjXXIUaDAyyC+iz/qV5
	sj7qssVnIbN0I3mHK8MIy6csqtmdJ/WLkQ3+6KO5gmAVia0zOzVAXOtXHJopFwrPfzBicIu3Tyh
	gMALlHAD4xhjpdYcrHxXoMBQLUQbItVypESLXOuo1bwh3r7Xy3IoufZwSPrW/B3CFClh3ysCns0
	4bGWVsVNQ/BtZrTqIryjpyuNfUuFSMll6xDzUQFKrP3wgMtZmoWZfvqjdn3luIge+on+677sNhI
	dyHzU6Pqrkjmch8Q57OG1FF4I+LIAxST+u1nYrpkb3ubLqQ59O3YEmNfUbk758uBQdb0wt3kOja
	TXvXK7UaBTWiNTONLLQkdn4j7Rbz4=
X-Received: by 2002:a17:902:e84a:b0:2ba:4ad9:70f6 with SMTP id d9443c01a7336-2c412d2854fmr30667915ad.31.1781259521984;
        Fri, 12 Jun 2026 03:18:41 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5374sm15113235ad.5.2026.06.12.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:18:40 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: shyam-sundar.s-k@amd.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>
Subject: [PATCH] i2c: amd-asf: Validate firmware-reported length
Date: Fri, 12 Jun 2026 10:18:15 +0000
Message-ID: <20260612101815.4124804-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612093502.3805287-1-paritosh.potukuchi@amd.com>
References: <20260612093502.3805287-1-paritosh.potukuchi@amd.com>
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

Fix indentation issues reported by checkpatch.

Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
---
 drivers/i2c/busses/i2c-amd-asf-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-amd-asf-plat.c b/drivers/i2c/busses/i2c-amd-asf-plat.c
index ca45f0f23321..e1699da838c2 100644
--- a/drivers/i2c/busses/i2c-amd-asf-plat.c
+++ b/drivers/i2c/busses/i2c-amd-asf-plat.c
@@ -90,6 +90,9 @@ static void amd_asf_process_target(struct work_struct *work)
 		outb_p(reg, ASFDATABNKSEL);
 		cmd = inb_p(ASFINDEX);
 		len = inb_p(ASFDATARWPTR);
+		if (len > ASF_BLOCK_MAX_BYTES)
+			return;
+
 		for (idx = 0; idx < len; idx++)
 			data[idx] = inb_p(ASFINDEX);
 
-- 
2.43.0

