Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864578;
	b=ot/ixo5DC1wtLvM/uJ+v9AsCSzd7BFxFvFwpqpZRyzQLZURoeUO2BuhhTaiHLPoTvaUF
	 zMxHGJGuKewmCj7WpDQY3R/iN8pl8R6Wv1aMmk+Kq9bJ2Euy7ZQ3D7b44gi9IUvlzYuBJ
	 7gWwIoBxj65QBBWdx+56qqU9TCKqXmzDIctnDb0kh1580lS/JIn7hEb4GQU33vZ8olpB3
	 yWl3gPBF5eNtfaGHUrcRsD3abCHfL4/TklmAIbKe51GDpl2HMB1O7Y3FV6ZkSM88/Cr2l
	 ir4dM2FEsREGa/NIh3CLO+VAJWO1WJPJzEtM5K4eJpNB2wYzZ7+N2gEj9TKLrBWX4aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=e4YnTjIG+CDujm7r7VgOZzRW8vqo6YF7xuCzjl3AIV0=;
	b=TwdGxu5+91xwtd0D5PH9Z5Z1Cugbo8mWykEbLbaNWipuZX9pmqDRpyEhe4BLm917KOf/
	 50bk1X4YOf3nHQTxe4auPta88Ubeb/NRW54x3PipWk1a+R0Jg6CEVaGlEeMo92QeKro8i
	 cO2j9869XmfDyeoORilnnqJEilrw3To2teVwn7HsZNpjdOczTbSvjQnC7w0qFKLb+MefO
	 52/394bTa2n696Lsp7zcUTlXaAuZ7slkp//dMhIAwkUtR7J8LeO1FAn/Ul+FVrn+TyOK8
	 PcPm8X4MviFewQqUZTUhS1efDI86mS5frAnFIV+ninLWToj1Ki95OcnwcgGh+7gUpuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lf5ovjXP;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BE606A32D
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 07:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A8BE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lf5ovjXP
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ed1b9e8f43so4720415ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 23:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793864578; x=1794469378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4YnTjIG+CDujm7r7VgOZzRW8vqo6YF7xuCzjl3AIV0=;
        b=lf5ovjXPfiAwfRtwPVaQ/Y2DiVU/A608Fb2fb9QbOIArj2CV3NIcqyYnedI8inTMfE
         Z8oBVQk/nt/o8B6ieR01uqnGyhVYvwBNMZBAL2atEyhil5qiMrAXGPCVrhMelX8cABaK
         ywPFOqm6HeEuFOsOvtnblmyfbzzSmTfR0t/pPvIkMCe0YCaRgJ5+Aif5ZGg7pwCSXb2I
         pqKLj5GVv9oOsqUi7k51ITOlgA+ZsrnXf5d+5xaKOhFbDGi9oj3x1yvPWa87Qz5BYhws
         ifpUhREziSygdoeAeTpL1KBBkedn7Pz5gbgH2rCMYYasVX/puA72ianyJVKc59KwRQWA
         9oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793864578; x=1794469378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4YnTjIG+CDujm7r7VgOZzRW8vqo6YF7xuCzjl3AIV0=;
        b=hvj4tXhvBvN2+sK0zIKk3hi5SIQ4GiMkbp67Ms+39hihDHlX6t1mOh4RIF52K2MiUR
         XTZ0fhXh7CYvdJ/Zev+z6zu68me+3jwMRyG2r8bvmkV8MFRpBASxzvnm0s0pDVAGnJoy
         llIXfgd2lL5xwlrTxos+RXR+Tvh+Lp7ulofXZmKGFuy/ouG3Zcd+ejhlvwIwJKnRJPQI
         Q76KLLKuob6tQiMNcRDMM1vQta9KCO83AOvZUXVCRCZFToGr3aD1HOpyQWkvOsjFI15C
         BrP2Kn84sUpuqt9AAUhnXNW8+JE34Os0el2SsTRsPrn4G7uuG9MoWHh2VfmTLscvuCyp
         PuVA==
X-Gm-Message-State: APuU4Z/PIjDXPYgznm2YUVHRIpnhpUVOUGMfwQvVwFkoUJ8pL6B1EpeV
	m/KHxzcYaqbvXQMVNmk+0YVaHJskPTG2KmaDh+xasM/oAFG2WjOeueEhhLCQnww=
X-Gm-Gg: AYBFou0ORF3FvrraCfYw4lXzQrjlb4ApR2cu7vTHrutZK9VNH2L1gOSe9RI/h/seXw6
	ngmQjCiW621sscae04MRZOTouTXgqitqIGiEPa+LHxk8IxJUiQhR+cvewvqt5NkPwIz868R/fkX
	JxMza+flOapWLGm9Ys+Xl45BwlLHDbFMRaawjlV62k9yp5RSnWqzfztRXV+cd8BltGQym8LaTNN
	5kcniUNGWMSY+Al6akquz7QIcifYmxjnUqQaa+UIIaZ7QFr13zYpSCwwhrs18t5IQg2QepKuYJW
	JP6GQs701+bA+J7YDRTDMrvdcAMx8PSOXJ2Jznmp1Op5ouD5U+aoHTsX1gi023NlJtPXo+qIMuy
	uZ8gV5oUEd3dOvMaMC4Wrj8BJ8S4r1950hhyhiLPJ/EMZ5dAE1jqGVclvIbSqMGYHimaYNGplXt
	Nzexxpp/z0YqpYMSGIhAFcSB2GCknRMrGABdL/nMOUAXrmsp9hFtD200COGhlNRXpyeAyWlFkMS
	1tbwGH7QX9ADM+EdzuA5EpbgDwaEmOUbTv+DLXR9XngSV03Hki0gQRjZbnr2UurT7Zb6i+naJ7x
	SioLuaJH8bXXZdRCOZmLEzocr2mB0M2sOJTfVdeO6ecPZqGu81fVDRt/9A==
X-Received: by 2002:a17:903:3205:b0:2e9:5714:608b with SMTP id d9443c01a7336-2eb364b11ffmr182159575ad.34.1793864577662;
        Wed, 04 Nov 2026 23:42:57 -0800 (PST)
Received: from localhost.localdomain ([202.51.247.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed091c83d5sm14942345ad.66.2026.11.04.23.42.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:42:57 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] i2c: qup: Release DMA channels if interconnect lookup fails
Date: Thu,  5 Nov 2026 15:42:44 +0800
Message-ID: <rc-review-20261105-vc-48-dbf6a486c74f@gmail.com>
X-Mailer: git-send-email 2.50.1
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

qup_i2c_probe() acquires both BAM DMA channels before getting its
interconnect path. If devm_of_icc_get() fails, the direct return
skips fail_dma and leaks both channels, including when probe is
deferred. A later probe can no longer acquire those channels.

Keep the reported error code and jump to fail_dma to release the
channels. This avoids the clock and MMIO cleanup, which have not
been initialized at this point.

Fixes: d4f35233a634 ("i2c: qup: Vote for interconnect bandwidth to DRAM")
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261102 (2637bdec0535).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_OF_DYNAMIC=y.
COMPILE_TEST=y.
Baseline and patched target objects built from this exact base.
No full kernel/module-link, hardware or runtime test was performed.
AI assistance was used for analysis and patch preparation.

The error needs an interconnect provider failure/defer after DMA setup.
No in-tree QUP I2C DT with the needed interconnects property was identified.

 drivers/i2c/busses/i2c-qup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index ce30634e1f40..671bc41a5abf 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1786,9 +1786,11 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		qup->is_dma = true;
 
 		qup->icc_path = devm_of_icc_get(&pdev->dev, NULL);
-		if (IS_ERR(qup->icc_path))
-			return dev_err_probe(&pdev->dev, PTR_ERR(qup->icc_path),
-					     "failed to get interconnect path\n");
+		if (IS_ERR(qup->icc_path)) {
+			ret = dev_err_probe(&pdev->dev, PTR_ERR(qup->icc_path),
+					    "failed to get interconnect path\n");
+			goto fail_dma;
+		}
 	}
 
 nodma:

base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
