Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FA6FB9;
	Tue, 11 Feb 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285973; cv=none; b=HN/0R2FxMYKIki9tSGufOQF3EMFZXp91Vu9CezWi8c/dIkhp9H657AUN/6aJpyMvDs1ScJu2IbSoFgC4UIyuYBLeP0crl8OqfU+F73ns+Ur5K0ePcBqSQk8iUu0tTuf4uk0fcEoJaKMm1tX9qSj5ayd7BSozQs2O1g8Oid1XMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285973; c=relaxed/simple;
	bh=4zC6x+CpQqoCmxAQhffvrEuh7sa+yX3iLGjXNbfq5/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/ab2e+VJTFzwFyh/Vnk4Ca8qrE51rIqp7n7UtfdD525mvpwlJachwhd3l27ZQEAGcbMpA4KZJEheB7pmtIgYe1vl0kpSzMY/3hGq57VAMOoR3s668r8/Y1IGKxiFB68o3UJDHTnSNq/Ej8XbCQLtEE68kCt/V6m77aRt4DK8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=GnC2E3e5; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="GnC2E3e5"
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 571E342248AA;
	Tue, 11 Feb 2025 14:53:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 571E342248AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1739285611;
	bh=T7kxGTwqhclUsLySrCW/c9t4qOJGEDofM0UqKWyJ5DU=;
	h=From:To:Cc:Subject:Date:From;
	b=GnC2E3e58pI9t2oOvNJQYaoalrCjj+s6IkqYywzR0grchaJP461pOUcNuX4aYPYSW
	 2lk3pyoNWJEo99B0XzpymJANCWHpOHOEtJhdt/urjU0iqEZ8b92zc3GelLn8Ib61f2
	 YOFLCITdZnNnNKxvbAHYZQlw1lVvKObsDklPXKrM=
From: Vitalii Mordan <mordan@ispras.ru>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH] i2c: pxa: fix call balance of i2c->clk handling routines
Date: Tue, 11 Feb 2025 17:53:21 +0300
Message-Id: <20250211145321.1137001-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock i2c->clk was not enabled in i2c_pxa_probe(), it should not be
disabled in any path.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: c3cef3f3c07b ("[ARM] pxa: update pxa i2c driver to use clk support")
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/i2c/busses/i2c-pxa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index cb6988482673..4144b0ae195e 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1503,7 +1503,11 @@ static int i2c_pxa_probe(struct platform_device *dev)
 				i2c->adap.name);
 	}
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret) {
+		dev_err(&dev->dev, "failed to enable clock\n");
+		return ret;
+	}
 
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
-- 
2.25.1

