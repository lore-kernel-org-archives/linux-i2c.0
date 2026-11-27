Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795806215;
	b=C50Ton8OyFPicp0/PHY2z3kiJcYK3ZrKMK1iw6LONEvZosTA9qPc3lIZUM0OyPCtM+Ua
	 888cMhF79ZsXcCwN1kmxjGoC4RtqTWsIcQqo1mqZ9lNO+tjohFk3RJQrsirnbpOE+Id07
	 Yq7tiSiCCQymk/czg2v0INZSaqu0LuWJwz8+vvpLvoRXdWnV9AXl3jd2RSt1qqRHg0ULu
	 cCWmVkzX0zqlPA9Q/POSu+6Jc82HWfnyKIKWrkdLacunnNy2eKFwydrXLz99VL7FRDBLk
	 jMRL4B5HGfpJ4cWPA37HRxLUY/fAyL46bl+a+2jXvzJj+SFfBRWZT9g8KE1xgjV027A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806215;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oKg0XmsKV4XfBnWh2hNz4kuDsiTnanENrTKudHVyA+Y=;
	b=fmcvWqRawfbwOj5hR09JeJBGlfQQEknNJQW42bk3k3JfgHcG9em7NYPrQMBLscNOrjVh
	 PLUaw5SttpE5aKtIkff3wRBe4FE6JkpRHBJJNVMC7oNYa8Q80qzsJ0bCmzv/da4W0xO4F
	 RJeKegw/tmUuQZcvEUVyU9GsnxyvO4y3pUD+AyWsp292rBJ2u9EGbOCL+RYnpSP3G2kuM
	 ioREruXD+YDVDqxiWC/9KOhISPQ4DpfgAkDcM5tTlFf3jlimYAOc9n/GBj/fGjQE9mdil
	 U/cSGo1V2aE6JFzaanX/OYUWWj7vW0u/W5rp6veOnkyLg5qpTLiMqaqPxCLl224BJaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKQhIzjy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10092606A31C;
	Fri, 27 Nov 2026 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKQhIzjy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795806214;
	b=f4E9sj/eUZXsSWIveq/yUxbnwFTaQOF7208iutA9RuWCboqYw3mK1cbLzb/gilHycyRr
	 n/ZbGpgMqM1VjayFRMcREUoKY92L9jsuYzkEVAcgu/IViimGCvfj73oULTIHQiBejZPZr
	 ICg1ULiXo2CXndDjkzgTTrlxJmphl3IzMch3numXskKGIqa5A8Pf5Wc2ZpE8K1JXxNilm
	 3vy8H44HsfeJPxynlxOcFQkxHM8krscmL3xTg4aCFSbPyuqKfu69lDEZPyJ37CrBzs73m
	 SqptwFW7tJytEn5Zv1f6iLMHI4ZGM/9BTBElf0xBRftjZuDyYwojEzkg55fgMgkynLQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795806214;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oKg0XmsKV4XfBnWh2hNz4kuDsiTnanENrTKudHVyA+Y=;
	b=XBwPxcMRC7GOwbIftROuGU/At7kSbQTsUcUMIZjGccI+Q3/i49BLgssmj7g8ANRi1Nyu
	 SUPczzO4UiNZY2IAjmZ5uAf/RSrv9z4Rk0jcof0tBK7k5IrVGCW2ndY24VgC7ZeoKWHz1
	 pLR2019Xt8WY8hCp/1AzRne6+4dRqDOIyCmjuB2ixfXn6eJFlmVyo4LZe8cKIWdcOEBBp
	 Sr8AaHiH6qQPHO0Ooi4J6ajjJsLgW4zJiP3AoIKU4SyEIhEvaDipBUXv0Z77VcBtko6fU
	 GwB2ZR3KbrZuRgTHP6JTlGI+Qn0keoZRp5sUQ/Xw+QI0bqGfpr9kMKizVmcOadDwpWQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CCA11F000C1;
	Fri, 27 Nov 2026 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795806214;
	bh=oKg0XmsKV4XfBnWh2hNz4kuDsiTnanENrTKudHVyA+Y=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=WKQhIzjyJyp1eflZGnyKxjxrpuseqwQeXaRJHw8ihepHZgJFYoQoXXlWA3nmvouzM
	 5LSBNPwicnGf0ECB5JMZ2K9Xcg/z+qIVnqVxntsO6dPEJ7zwgfq2ggJoKSA3y2hkmQ
	 Ropt867AyZcWT/FTn3X+VKzN638BlYW2sxG4ipLz7o+L8NsP2qQJaR0fw4M4R99pxO
	 ZeB/cGGP6wP/BQxvpfPdCv5/U09bBb+l2pTaYwuy+x7lmuR3MpxftVfHgs5/DXgi8u
	 H7KGLskEmiia7N9+I89C0mdviWeSQS/92xoTJbyOIgLwlxiVRM3MPP3L2NulGr3YoN
	 sEYP5YY/BssLQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0BA934DD1C;
	Fri, 27 Nov 2026 19:03:31 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 22:03:31 +0300
Subject: [PATCH] i2c: cs75xx: Disable the controller before releasing its
 IRQ
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-i2c-cs75xx-irq-teardown-v1-1-f6acd781af04@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAxA0auUrA00gWnBq4iLMY0aF1NNqg6U3
 t1Rl2/x/wqhbhqw71ZwfVnYXBpo14Fcc7ko2tQM3PNAxCMaC0qMqVY0f+Ci2af5XTDlfmCVRIk
 YWn13PVv9nQ/Hv+N5uqks3x1s2wdEWE97ewAAAA==
X-Change-ID: 20261127-i2c-cs75xx-irq-teardown-5a062ec51512
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795806210; l=2481;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=H8bWwANLWzhb+hTYvLCYBcRvBSWNfP9Xtsa2d31C1Nk=;
 b=qmgG547+jw6GW3bGVGWtiElxcn0Eg/+RbwUnQ8zCGD0lg1HRXszHaKksLpZWE8u8Abjn/nER4
 GxHNK5Wd9TrC1oldyPens+dZ/PQa64RtS3x+6C8T1R4qWLJ+wBOB89X
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Managed resources are released in reverse registration order. Registering
the disable action before the IRQ causes free_irq() to run while the
controller is still enabled during probe failure or driver removal.

Register the disable action after devm_request_irq() so that the adapter
is removed first, then the interrupt source is disabled, and finally the
handler is freed and synchronized before the clock and mapping disappear.
Disable the controller explicitly if requesting the IRQ fails.

Fixes: 3fdb0e8ef0d4 ("i2c: Add Cortina Systems CS75xx I2C controller driver")
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
This is a focused follow-up to the driver accepted in i2c/i2c as
3fdb0e8ef0d4, rather than a reroll of the complete I2C series.

Move the managed disable action after the IRQ registration, and disable
the configured controller explicitly if requesting the IRQ fails. The
adapter is removed before the source is disabled, then free_irq() drains
any handler before the clock and register mapping are released.

The driver postimage matches the correction already compiled in native
ARM and OpenWrt 6.18.64 builds and installed on Almond+. Focused tests
using the actual cleanup source cover successful teardown, request_irq
failure, action-registration failure and adapter-registration failure.
No hardware fault injection is claimed.
---
 drivers/i2c/busses/i2c-cs75xx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cs75xx.c b/drivers/i2c/busses/i2c-cs75xx.c
index 49a14f27b..c5365448c 100644
--- a/drivers/i2c/busses/i2c-cs75xx.c
+++ b/drivers/i2c/busses/i2c-cs75xx.c
@@ -344,12 +344,15 @@ static int cs75xx_i2c_probe(struct platform_device *pdev)
 	writel(0, i2c->base + CS75XX_I2C_IE);
 	writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_INT);
 
-	ret = devm_add_action_or_reset(dev, cs75xx_i2c_disable, i2c);
-	if (ret)
-		return ret;
-
 	ret = devm_request_irq(dev, i2c->irq, cs75xx_i2c_isr, 0, dev_name(dev),
 			       i2c);
+	if (ret) {
+		cs75xx_i2c_disable(i2c);
+		return ret;
+	}
+
+	/* Quiesce the source before devres releases the interrupt handler. */
+	ret = devm_add_action_or_reset(dev, cs75xx_i2c_disable, i2c);
 	if (ret)
 		return ret;
 

---
base-commit: 3fdb0e8ef0d477ce4b9a9c5ebd370e64d7ae4ed8
change-id: 20261127-i2c-cs75xx-irq-teardown-5a062ec51512

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


