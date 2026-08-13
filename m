Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA06485CF1
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635125; cv=none; b=G1y8tPGiRh94cV/Ip6OBpDkJbajrqC2K6NqiELtP2aH8p8kle1WEEV1Z1rMjNmq2zsUnwgmgqnz6hT2hKAXs7iRZelCh3GoiVF0PD16WMjGB/BtfVjIHEfE+ljPgKDBZZ5pJibsGbyFzjKQ21L5kjePFutgWJnN6H1HC4dzD4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635125; c=relaxed/simple;
	bh=EN4LhodwYbuCiC5jqwsFoAkYL7S1UXvqKzFEK/fGe/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Miawvn7Z72V/bXkdBv0yjVsQ8OhC828FhbILYbIKx4McxMbIRwRKcJX7ogTeLe15yKLkXCQhMGAoN2CdGN4PKDZjHEKpH42I3EIggm3HVhbKlFmTc1SEbo62NQrVjATTJreJoMcYsHc92Xa8qnO6nqExmw3gHyNxJ39JGCMczNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czVRmL2R; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czVRmL2R"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso504925ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635121; x=1787239921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWqLatESzRUbhMgwOKx9MP14zwvcSFVaT+uWumR2dGA=;
        b=czVRmL2RbgiriBq82tE7k8jbmNZvPMsnSZf+N9JdvnQ3cS7ZBaXYV5artg1m+KM6I+
         BX8IbC27TGhqqFWYhN7ijcpebubUX9nXikKBjkWddMhJ7qEZ0UJQU1pbP2sDeckFgUVe
         wBwsndFZgfGKbIzREhnsnf2x20mnnhC7ocC9AJv3Eb+OoZ8C4z42LJj+AnaKpEo3/DM1
         mk1dSAxnQNLsycvAiPFTCXDLjtdv5wQMWGb0rbmoOITg1N3dmv1p3VFjYoQkv0V6Y4tX
         ihwcTzn6HqiQKe+oIelAIpVJduityMwQ57PPUdVG874lXs+DmJOSMUj/S4SN1E5sPHas
         RP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635121; x=1787239921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWqLatESzRUbhMgwOKx9MP14zwvcSFVaT+uWumR2dGA=;
        b=dEnjY/fLmm5Xm7eFI9jd+wg6MPDtfkwRPYkZinKmQmDtsQiwglId9iRBJt5K/+cmjv
         HaJFabrepZOpfDEkULcQ+DYESiZcHHoBSbZI544Km48vg6j83o74XVlQoBGJ6KHEzODJ
         n3YQ1u7URx2eMtVQ/cWtR3D+99YlqAV4izSuIFumhjqtcdKCHsmamSNI29JkclXS5Q33
         rbkYtuk321pn/4vfppTmSNhSNEsSjv9L52w5gYJOddv/LAceV2BOWRhVOGVso6Uop/cF
         UxlIt6mTPvI50IU/HSGctcC0RfyiA3HkJ1gZRb92JCbLtG7+TjW+SqxusOf+5wMOSuGf
         nuiQ==
X-Gm-Message-State: AOJu0Yx8fhmEwV2dMZ+baErGsoDynUQS4gqMdZNfoJBXBaVYH2toEF/p
	/kvru3GzGB2BD9Z2GxWHdLdC1VR+7kvvA8vL7TPE1SqKgzcezY4NsI9FbleyuPCeXWs=
X-Gm-Gg: AR+sD106asnbehZGOhLHdVxy6jJx48T4x4ZoJQEVTBFJRlpzJSi3hdUfLqMGd+Vf21z
	kjtBDJe3LQ0E1llEVutOVqBHtNb7q2AqkFR9ADHRyLp8yesf7Udnj9w5j73ovU0f+0R/kbf6Wpw
	jnlV8lQfKtO0mLHP8vqpfMOj4mjB191c3xixuieot/3STJMPZ/fc7qDUp1R318KTV1Rbq33O744
	slQM8ldSrpsjGSPs+3Xsf9qq6/UIRivlq2DXE9EGPuHkydBK4HNvagi6H97QVoSMUlKwgOk6c2B
	tFql+qrNuSwFpurOB82bcGTauXcC0rzwN6ywCatXrv1xUdD+Uvxv5OgiUDRUgoiTHfMOjURhjmW
	7sYNiS7vsdLBsXC1YZYMRd6n66RFbh19m3pxhx+VQ3aS3vskfo8yb0WbwbJOZGwt6ArmhNucHkm
	ff9GstdW+tp1vzQcgBw5j3yyPODmUd2x1G2V1G5tVp22qH6VAg7nTurOzbhXF4JEHBy/G/8WJW/
	2ATEBc=
X-Received: by 2002:a17:903:1ace:b0:2c0:e2ea:6b0c with SMTP id d9443c01a7336-2d37f0bf777mr84784575ad.21.1786635121472;
        Thu, 13 Aug 2026 08:32:01 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:3b7:6da1:c188:d14f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c200cf3sm12030325ad.4.2026.08.13.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:32:01 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: peter@korsgaard.com,
	andrew@lunn.ch,
	andi.shyti@kernel.org,
	jcmvbkbc@gmail.com,
	wsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] i2c: ocores: Disable clock on failed resume
Date: Thu, 13 Aug 2026 23:31:55 +0800
Message-ID: <20260813153155.3953577-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocores_i2c_resume() enables the controller clock before reinitializing
the hardware. If the clock rate changed while the device was suspended,
ocores_init() may reject the resulting prescaler. The callback then
returns an error with the clock still enabled, while the controller
itself remains disabled.

Disable and unprepare the clock when ocores_init() fails so the failed
resume path balances the successful clk_prepare_enable() call.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: e961a094afe0 ("i2c: ocores: add common clock support")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/i2c/busses/i2c-ocores.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index df6ebf32d6e8f3..2d18c10358375f 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -755,7 +755,11 @@ static int ocores_i2c_resume(struct device *dev)
 	rate = clk_get_rate(i2c->clk) / 1000;
 	if (rate)
 		i2c->ip_clock_khz = rate;
-	return ocores_init(dev, i2c);
+	ret = ocores_init(dev, i2c);
+	if (ret)
+		clk_disable_unprepare(i2c->clk);
+
+	return ret;
 }
 
 static DEFINE_NOIRQ_DEV_PM_OPS(ocores_i2c_pm,
-- 
2.51.0

