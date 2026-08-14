Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE54756CF
	for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714842; cv=none; b=qhnZCFpANiHtm7mnOM35PmPXntx52LSmq6Jw8rFU8bpSlt+9GuHph0Jm/hLoBnU/3UKpWYG6boIuCr3ZWOEw7Hp4i0v6kwDlDD6MmY0dv1oweuWiDxbY2URcDxMt4RPoN/b4upn0nq5CJ+2H+Zyqfj8ZHWJ5ixtPW6n5ch19dIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714842; c=relaxed/simple;
	bh=ZFcWIVAF5GwsG/s4LdZRYp+ubN6mNHhGokZn49msOb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UV/Tfw29U1dF8aA3YydPAOrrY3d+eQ8x9gp+k/+1KMD15OKxKY9MMUSz3Tf67xtJcmYbfpobUxvIIkpRzGr9CxQlh3JnjEChjDiTRhs+hgEqnz87LUSjVONOMiE/5oD7YOS4aeEpJbub9uFtVyiXM1VKdLV/Kimd6p7IJS1S1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLpgpsDm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLpgpsDm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf27856f9cso9943295ad.2
        for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714840; x=1787319640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUSt8iKsvLES1DoWZPe2NRZJAWICuOCKAgFaBxq4B1Q=;
        b=iLpgpsDmmHH/0UEm0F6qf9XUEO2XnvWLU2/Wxi315LxaQGFtbQ/tQXBr6hDmkZRcBh
         uz1MDe2zo24xk2wVx3CNnPkwLJP0uS2uWdK4ep0AbjVClkfIr+pRNccAIV1sb7E57yET
         85K7gI8uWiVuOd43YYD4cHx7AOTQztkJ6UY8+KN7LqTnoenm7/Ccad7pjycS0wgD/HJ2
         7D95e0KqHDkR5NYn74fl2NRpqyMw7UUeWupgZFZRypdpm4ub/ZGHQ+Wi+U57vzXEDzuI
         giXEdFbVPJyvCVo0N3i6fNRA2fK9jNA4IUMc7oX0GyWf+v5Jsavn+sGCk7ur9ivhQ0uX
         yMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714840; x=1787319640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUSt8iKsvLES1DoWZPe2NRZJAWICuOCKAgFaBxq4B1Q=;
        b=nkZ/WMTinDEeMeL1QWJYierdyVuG6cwCbz8LT7WQ993fxoTuLzo5r5erNV3EYS1J+V
         RAelk5hDSJmVAnZK1Ns6+1A1IThsNxHaJvpNuqwJbS9eNUoYYj6Y4Iy6bLExPSvUtEre
         s4uMgmTck8Rf4p325jlhbUVfEAwiJGfyahMuKjEfy+C2qomdUvRXVdO43P2FI9L3Nntg
         AXPkCpYZHRqhp6RZJs4/UoKtaTwk1DUBxUXyOgKlFb6WYoLJtJBmbvKli7+v5PKJEXef
         E/PG2LW3i8rYc3Ry+BR56Gwe5c9Nj5iNVlr30tvYvJQtkdd3UlFcro7Ppole92uWDDoE
         qqaA==
X-Gm-Message-State: AOJu0Yw3zM0A/WXsUGrZNR32RSkYUJImG0NbAniEJEPKeA21a4iI460X
	EiWxnHq37xXLXFwPpzK8tsDeUIdq6dpg5FNRaV6RvEo/BAg3xXAwvDLz
X-Gm-Gg: AR+sD12ymwWMpPZpb4uqaWfEaJepEn3b1AanveWOwMIbRapgjYHNGI/TQPb2ADGMaNW
	ACmpFZUIKGpx867yZVuVks02HfyTuDU4SjAAXrm7KRoI59ePI/2jY6gqgzlRKAvWTmAUpuE7pHM
	umpXKmATnYY4uCq8GrEIRXh4tqMQie7l6VSeX71TcGVvbdUsgU4Y34FrLl1jKHbapOCM3iVHJ2P
	f1zOosUsn5gu/Ggxdvjdeb4NLfwegUcRMRGfkU6E+loqc+t1WvnrWm+L96o3CifFXenuEIEck7H
	y6+1CXoe4OFX7MzYM00nDGk6yeXvbLcE7+GUfLa+m4Y34plkr92OL943i5xNKuEtDMcXFt+uwBS
	TsSCqY49OdqAhBj3t2m3djrQu6VO3HfEgNzTqfRPH7F6u4stHaK//wBHhYFUA4dtra1emMKmSxB
	WG2bkxJPe7mt885wc2J8vYPDW8ohJp7q7sCAyG2u+Ze1R1XhXplf569IllaQq68Z2d+A+ik2/f1
	t27wIPA
X-Received: by 2002:a17:902:da92:b0:2cf:9f0b:b562 with SMTP id d9443c01a7336-2d3b0cf922amr67711065ad.22.1786714839447;
        Fri, 14 Aug 2026 06:40:39 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb2a085sm9837125ad.42.2026.08.14.06.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:40:39 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] i2c: mxs: fix DMA channel leak on probe error
Date: Fri, 14 Aug 2026 21:40:33 +0800
Message-ID: <20260814134033.1386874-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_request_chan() grants the driver exclusive use of the channel until
dma_release_channel() is called. If controller reset or I2C adapter
registration fails after the request, mxs_i2c_probe() returns without
releasing it. The failed probe does not invoke mxs_i2c_remove(), so the
channel remains allocated and can prevent a later probe from acquiring
it.

Release the DMA channel on both post-request error paths. Keep the
adapter-registration unwind ordered after the existing controller reset.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 62885f59a261 ("MXS: Implement DMA support into mxs-i2c")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/i2c/busses/i2c-mxs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 4e07babea9c3f..a5c8b44ec8142 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -849,8 +849,10 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 
 	/* Do reset to enforce correct startup after pinmuxing */
 	err = mxs_i2c_reset(i2c);
-	if (err)
+	if (err) {
+		dma_release_channel(i2c->dmach);
 		return err;
+	}
 
 	adap = &i2c->adapter;
 	strscpy(adap->name, "MXS I2C adapter", sizeof(adap->name));
@@ -865,6 +867,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	if (err) {
 		writel(MXS_I2C_CTRL0_SFTRST,
 				i2c->regs + MXS_I2C_CTRL0_SET);
+		dma_release_channel(i2c->dmach);
 		return err;
 	}
 
-- 
2.51.0

