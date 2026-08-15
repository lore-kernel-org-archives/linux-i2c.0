Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793435C6B9
	for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786807049; cv=none; b=Wn6Nt7jKwMT5jAiP5LdY7kSBFvgo5dsWex/YAFkQZfMKzubYaxGuU7SiHyHk05CjDBVrPlbOoBmoEHjaVYOiHBks5HaKlQlLemcWQaiwakTBrz0v0SMRnCOlV1MJ7YJDe5MLE+w3hSQ9pNBS8dZNRKhmdQARsa9yOnsBW+qxEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786807049; c=relaxed/simple;
	bh=L2rv/8hWgLO/9YX6ozCUc2a/DuHG5ngeE3Pn+3OXH8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY/AscTfLtTkyF363Jbk+WEPqrzHd8rR88z5tmhRd2pkwjqNA6ZUqzBTPf+AUy+AqcTJiL6e8VaQFyAX/bjkJ2PLWpFhpIpGFEEYmhTzy1Zg0RP4SnK/mihVMGsDmNCLdzgmmOfckKCxz0omRlD31LGPHp89ppXibsNIJ5IkWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oascWz5K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oascWz5K"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc61541f8cso38025465ad.0
        for <linux-i2c@vger.kernel.org>; Sat, 15 Aug 2026 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786807048; x=1787411848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UM/qY+57O2WGKIidD8uuvpNNv07GGWbHqFgymg7+PkQ=;
        b=oascWz5KL4PyzIZbFGE5GK3I3uLIfdIHeWGEmXFuRsm48rrpO+tWiH7aaOkWJp+Qh+
         WhnHuVhcwP4OZTTRjX4i2z8dcG9UDvqQjX07bGMc0wbP1NXcCM04ziUxhi6IF05uwDck
         LN+4sbEdD4JGPCsnMExtgwTHip2daVL6HZszeTMQ+RW3G4d595IqYkhgjnpjtS7DZSWg
         gnRwR2maVnBLwAXUjMU025WyoBgJy3wKGiHeeTLlvH9ta6I0+SeL9RSP3PGbNrJee28W
         /jlL5kpgiEerhzg/udjPT2GjzD1vm0JScUAKzGrx2AAFot4vy1RG3GdxaJG1mqcpefs3
         hbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786807048; x=1787411848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UM/qY+57O2WGKIidD8uuvpNNv07GGWbHqFgymg7+PkQ=;
        b=EScPlp7nwtC92x7Mtfh9wtxXWgDwsV3e9StaqJt577FhOqQJhRYlOTCTriTMxbbHC4
         KixtQDYwSCqHkM+MDpNYniyJ+80dphozf4xNHGJ+rL2L4kjPPzHCME/ruWGDvUwP9Yi0
         z6VpoiNuz9Zd4A2zbuF0rNwIE8DFDuyGaNft4+++Ecyk6tyu3lLTf/EYlkieD4rcY7Q1
         thHvbpMpZbMdr0I1mGBcxjwsJuEmnKJPl80GXJXEU60ASGgWBq475AV/oEWf3LJOuXXt
         6Hn5skHkqcoCu62L8QAagtA6wjO/fyKh8QehUer+Q8xju2KPWvaPiCln0bOWDHI1/MCn
         tFrw==
X-Gm-Message-State: AOJu0Yzp8suF0WP1lOBlBeG4hqbsrJnRggrCVYgjcJJSRo/yA11RLWbg
	vdboNG6/RDsWjGqsFkbTHCPKp+nWjweGPsynY39l+mTyTXK2kx5WnGjn
X-Gm-Gg: AR+sD124b1ERnGHPDdHIMfExS4GNCcadnNdgpxVlzEl5NJvTTQDh7dnAVLMQBDCEtL0
	HKTO6DojxZb+2QTo41BzmRyL1C+UadyxZQXPmYKLVTkns6W2zc3j9Zf6oUIN69FL4uoOnN8Mo5V
	HNIB7592l+GIKQdJmHH9ECCcJ6bWK+oxRkrgUcuPExinwkAW2bUQVJXtc5lOlwNLUG8XFrRulcX
	XpNn3riukU13PQIYhI39iGGzmR3JV6EhvBkFRRnMwQOCXAXFmR/5VSvPkZJKwb1SueqMIk91Rod
	YVrijpMFcyjzJwheADMlS8GkHAioP3fJ6lGHBwn61mI0IIlGKik2btqFWFG7WFh8Z0lskUISRJT
	u3QK9WLHO390d4PsuKcRP5pew149ZtPIsEhSsB3DMQulgHNDMFV67BEVG819FLnF3LH+yfqVwl+
	pPqqYjCkw2A8c9JGauTkU2kHhZfUJ9EwsLMp89mrztK/eW4DF22v0mtABfi0FfNVpr139wR9kep
	VNTjzx6Mw==
X-Received: by 2002:a17:903:15c3:b0:2cf:b9f9:18bb with SMTP id d9443c01a7336-2d3afdacabfmr116123305ad.4.1786807047906;
        Sat, 15 Aug 2026 08:17:27 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:5225:2a2e:8e7c:13a7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb88bddsm19887805ad.63.2026.08.15.08.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 08:17:26 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
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
Subject: [PATCH v2] i2c: mxs: fix DMA channel leak on probe error
Date: Sat, 15 Aug 2026 23:17:20 +0800
Message-ID: <20260815151720.3757460-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mxs_i2c_probe() requests an exclusive DMA channel before resetting the
controller and registering the I2C adapter. If either later operation
fails, probe returns without releasing the channel because the remove
callback is not invoked after a failed probe.

Use devm_dma_request_chan() so the device core releases the channel on
probe failure and driver detach. Remove the manual release from the
remove callback because the channel is now device-managed.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 62885f59a261 ("MXS: Implement DMA support into mxs-i2c")
Assisted-by: unnamed:claude-opus-4.8 typestate
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

---
Changes in v2:
- Use devm_dma_request_chan() instead of explicit error unwinding.
- Remove the now-redundant manual release in remove().
- Add the Assisted-by tag.

v1: https://lore.kernel.org/r/20260814134033.1386874-1-ruoyuw560@gmail.com/
---
 drivers/i2c/busses/i2c-mxs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 4e07babea9c3f4..eee4fdcd9df31a 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -839,7 +839,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	i2c->dmach = dma_request_chan(dev, "rx-tx");
+	i2c->dmach = devm_dma_request_chan(dev, "rx-tx");
 	if (IS_ERR(i2c->dmach)) {
 		return dev_err_probe(dev, PTR_ERR(i2c->dmach),
 				     "Failed to request dma\n");
@@ -877,9 +877,6 @@ static void mxs_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adapter);
 
-	if (i2c->dmach)
-		dma_release_channel(i2c->dmach);
-
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 }
 
-- 
2.51.0

