Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5713BFE4B;
	Wed, 21 Jan 2026 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039540; cv=none; b=uDcuDaUXBeuPMwNcjMAD4arMt/xa49mjVitXGxneUqVVA7exAuA/+AMPFlv/TdCPKpzKeh9La2MOW+EF/dIpiV1GVaO9oQy6yW/C261GUtn5ib5GrEfT3T2f+Hc8IGLCydGUTzu0ZscHNe+d9Bb1Ojgfu5jFGCIEAbYSN7THexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039540; c=relaxed/simple;
	bh=n1GiS+Ch3u2nLGAQ5qcayVMM0M3M5UTjjiWfRPTnAXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q+acJt9rcUTHjFTCmf7Kf9nhPundfLjLN1GGvtXqnQl+kayvWIU+R/5nD+b6AcNjvAwsx+zvAVP8hl2B2h1TaxYlEapmMIvzktOB9PRJuAYtUxQr5MPtbtDekadEa82MFl/G6TYgAohQbNhb2+kphIHfhv8ccU2gmDUJrI7TDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqSO0s2Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqSO0s2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D25C4CEF1;
	Wed, 21 Jan 2026 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769039539;
	bh=n1GiS+Ch3u2nLGAQ5qcayVMM0M3M5UTjjiWfRPTnAXA=;
	h=From:Date:Subject:To:Cc:From;
	b=CqSO0s2ZF2AJmrPdX0PwbVimN87CQgzdk/SMSOVl31MMY3YzTjxAhIF5xoactLYUS
	 R6UZQDTEGQ2VvYDQHJyUS9TRnXasypqcX2b31bgfPKHo0mlAVcoKpbmFBojo3/sE2a
	 bwoIH91xDx+BncJn8GPxIqN3cjW5mj7PN1u9tGq4JaeG33HLgPF7wPyh7twKDWywHW
	 On01DsqKSYJWyadBuSz3I7+yMTDPNBk3Y2XbmiCFYr+2IbcT15MvrLr2Ub3xhdb9QP
	 F/mOEsvEkjAutydjwywMR9b1IzoaUpY9KhmFIF5dliByuk6ssEqAR4onjEVQIA0juf
	 rw2ONm047F5uA==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 22 Jan 2026 07:52:00 +0800
Subject: [PATCH] i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ9mcWkC/x3MSwqAMAwA0auUrA00qYp6FXEhNmoQ/LQggvTuF
 pdvMfNClKASoTMvBLk16rFnUGFgWsd9EVSfDWy5tsSMtsKNUHlCDRd6Yue8b2ZqS8jNGWTW5//
 1Q0oflqgmzl8AAAA=
X-Change-ID: 20260122-05-k1-i2c-irq-d1233dd8f194
To: Andi Shyti <andi.shyti@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@kernel.org>, Alex Elder <elder@riscstar.com>, 
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=dlan@kernel.org;
 h=from:subject:message-id; bh=n1GiS+Ch3u2nLGAQ5qcayVMM0M3M5UTjjiWfRPTnAXA=;
 b=kA0DAAoBMarqR1lNu+0ByyZiAGlxZq6jol8rc6i0KYVnmnJvNIRDpqx3w/Dsiyc1fnnxdLUE0
 YkCrwQAAQoAmRYhBLW6uMnDG3EVZwIj3DGq6kdZTbvtBQJpcWauGxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjExLDIsMl8UgAAAAAAuAChpc3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9
 yc2VtYW4ubmV0QjVCQUI4QzlDMzFCNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqu
 pHWU277UoOEACZ5p9LnaVA+kkMQ1kg4fhqsbC2b1guKLuo3Fcr0yhW606ffvjtvnQOheIZ1NZUW
 c01rtedEDpgcXo8DeHxZN1wW4wglAPfcBkg0/QeBu8qA0it+ZuspiSpOVUrolpvnmkZGNc3BK5+
 lbuXBcT/GW2Dx4li+DaAWQ2sY3GM3anZXmco1w/bU6wM4kasS4HSo1wDBQaKmoB+iLFJDXMr9v8
 SdtneLNLOMw4Nd3aCQSNkGARNNRcZzE05TBcsEcXPy/rmlanQE3y10sKlg9xbP/urK7HC9+LBJC
 l9GFYSBndWb5fCNOKFSlb+avHaNfGUUCYHN5mK5PN7nyrJUH4MypFZUDI0gAyRvLBM1/5tv6unc
 XlnamKu/ceimiHvpLyL3nwTvQtcsFDtXZBB9ZuoulLMy9Jheb5cOIiLl8stEtfrW11ol5SdtUIZ
 u689oNk7fBLE/kDSDukGdn7g2S4yRv8fWtG8A67IcUai8qTVb/4/Sc3eZ8E1hR4PSH6IAafPoWy
 ZeqT5LBq9MftKWRbCi3B4266ClgJlgLjO5DO2PDafPrtWSeXkonmAjrXu9bawEFK6Fjtk+I8KPK
 0dah5XkLy3RIJAA7D/3JYjYevoYNlYLM+z+zggMO6PPSy+kMgTGsA25YEJI64dY48b612u9kf0s
 ErLF3Tp9Hvukf+V3gUj0Q==
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

In commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a
threaded handler")[1], it will check IRQF_ONESHOT flag in IRQ request,
and gives a warning if there is no threaded handler. Drop this flag to
fix this warning.

Link: https://lore.kernel.org/r/20260112134013.eQWyReHR@linutronix.de/ [1]
Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index d42c03ef5db5..8ef6d5d1927b 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -566,7 +566,7 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, i2c->irq, "failed to get irq resource");
 
 	ret = devm_request_irq(i2c->dev, i2c->irq, spacemit_i2c_irq_handler,
-			       IRQF_NO_SUSPEND | IRQF_ONESHOT, dev_name(i2c->dev), i2c);
+			       IRQF_NO_SUSPEND, dev_name(i2c->dev), i2c);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq");
 

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260122-05-k1-i2c-irq-d1233dd8f194

Best regards,
-- 
Yixun Lan <dlan@kernel.org>

