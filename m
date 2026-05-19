Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7492475E3
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168275; cv=none; b=JasDK1NxtHTmfepZFpn2Vp8tkL9N9sdxxekNp8CW5V4E0bUJ9XfvcxVpce3x17AUN4ZLATVh9gHaG4pbvkcC7+haa0A7uxOJWA1+fiQT3vScCZbGBcGYg3K1dm8/WFrOd3e1zWL3z1/qfS5vRVYOxCPH940VvLx0IQI+U6yFDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168275; c=relaxed/simple;
	bh=lhtTz6r9h3gam08PpROtwyqAJ6lm3HQYUI3xZrXDqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmqqlDWflh3FCT1SPfNtgb0gssn8WlsgdCW3+OjCP6cxCOUmIdmObjOsxxm7D3/K48mEsHj5PsK3Iqk9iwrhp2PfTR8L8cDKcYFWML85IWY7TTrmMZjshPtUiTXyBwbNNnP4Dbu5/tHzbl4qoznAUz25RJ06J5oCGFHIpeybe7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuMpEM/J; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuMpEM/J"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d6ab4476eso36932571cf.2
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 22:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779168272; x=1779773072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlSbwvOjgwkLSIAC4sw+jiTYmv44YqHx2Q9LfFfV2q4=;
        b=BuMpEM/Ji2NNQGRz9lcBiY5cu2OvBHGUvoaTdvSDLh2jbEgmPq5rfW3GKrtFVirNIm
         HgPJ0QJfKDj7E3WA1KwXSGFNrC1kXnXUB55rfhxDVLkWalXbGZ58l9tenghUPz9tsJ1M
         Fhhsn1Bp1B+UsxotnVevlJiqAsp7ynQLlo90VD/P7DxQr+j1LjiBDW48AVXwjd90WimX
         PhB89HlGv+GcDwUPXadODJMpeV+WMSTTIyVMXqU6HZPGD7BOilHc05S8nAxvqP/ZWGK4
         d4zam+PCP90O8BMmzdWcTWHxu1t2dlDj4g+vPdz8xCUutLT0YCLW4DBMidsYU+2HL1XI
         jRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779168272; x=1779773072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlSbwvOjgwkLSIAC4sw+jiTYmv44YqHx2Q9LfFfV2q4=;
        b=fc5w/vc5lf7nCDG1dg4Dp3aZvy84OrOeyVvMHm1AEHjimvKBsjJgUJfoRi4W3ddvsp
         OtPtXHwW6iPrwTZ5QOruViTOWprdFkpQiGFMCvnvcbLi8AAMAh0ZoIY+yO6w+H0CWZUc
         lOULERn3JXueS7o/pN6xpmyySiw2VA7ZHEJzkjj/R441o9udCJjjZbX3wrdDjZnm6KeW
         jWWV095AIX/kpknmpr+sxg0GhRxKysNclocRYpYcp2UBlsrmK7929ErqlvlY9zAPiw3B
         le7z+wKoUApS+mwc1wZW5VAvP1zcTNGSHRhjp65rZrip5c15pZBBhC72N/kzxx86IcM2
         LUzQ==
X-Gm-Message-State: AOJu0YxzwG1WjiOVWyFyhVjgReus/r1bRdPiSKqzMM06WtYwzPaU2M4t
	RS3/lo5xc9BwxIkoDTFJad4csvC7jDlaGrj1tu+EIaiNAsgaxoK5yr3Jy30v71yk
X-Gm-Gg: Acq92OHZm0L5o6VvY6Fb1k6n/hZu5EUzcd04/W8kLB6J3pUYQxjP3ZF9mQRCdOpor6B
	2nMPaKbiayxT37jvALVhqUJdIIH4QkMzE1EHopwvCDvfUAKhqhYWIQnzPnGZsi+NgAF5jY+yMWf
	IEQixD2zbKf9qi3b1+AINRYbsPob93pOfBrvscL0FrcfW5pFG4yiwx6CILMbWxPdALMxyMNfkuE
	eOUyyAvyRFGCbon6D9WoxIINJ9hEDepy7yEyYTT8nXlfd/p5DRnI8ho8rkQ4RJzLMQovzySbrpi
	WpH/cgTxthCVWXYb/XeK/EQoL7dXPRYi6QSSWktDNE3Wh8D/Oz80CsQ2+N9nERY/yKcelGdZc6h
	Iq8dmaeA5x85wZowBE9Sd9w6TURtbX8gFybUm9kCkdC9pJPaY1XQhEoViH9KvmwFO7v08WgjbZL
	CraIAYFV+B7eZlv2WsjAHPlnsq1Qf5vf3T42kmXXTg99Yg1w9Zruo6iaDURA==
X-Received: by 2002:ac8:588a:0:b0:50e:defb:77d9 with SMTP id d75a77b69052e-5165a22032fmr243600281cf.46.1779168272348;
        Mon, 18 May 2026 22:24:32 -0700 (PDT)
Received: from xps (ool-45718bcd.dyn.optonline.net. [69.113.139.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086ac6sm81286726d6.7.2026.05.18.22.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:24:31 -0700 (PDT)
From: Jacob Bazata <jacobbazata@gmail.com>
To: wsa+renesas@sang-engineering.com,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jacob Bazata <jacobbazata@gmail.com>
Subject: [PATCH] i2c: acpi: Add VEN_04F3 to i2c_acpi_force_100khz_device_ids
Date: Tue, 19 May 2026 01:24:24 -0400
Message-ID: <20260519052424.7591-1-jacobbazata@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This model trackpad (04F3:32AA), found on various Dell XPS models
from 2023 including XPS 9500, 9510, 9520 and 9530 is well documented to,
at random, exhibit excessive smoothing with no obvious cause, similar
to other trackpad devices listed in the i2c_acpi_force_100khz_device
_ids struct.

Forcing the bus to 100KHz eliminates this behavior.

Signed-off-by: Jacob Bazata <jacobbazata@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 28c0e4884..512ebdfcc 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -373,6 +373,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
+	{ "VEN_04F3", 0 },
 	{}
 };
 
-- 
2.54.0

