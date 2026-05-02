Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898D2C21F2;
	Sat,  2 May 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777735954; cv=none; b=A60knHPQmXjTazw4rnR3Dy1wGbxidRGRaL2zBQ4rF9BLvsM4oUYgS4LSb+Wzgfha9TOKgCwzNeW+SpWIIxg2w/k9OcKFqDfKp05ZsjVViTyZhF8d84sHsfxGas8dAM31i3rvt6gmDcVhkqjZOmYuMSXVXcUnh3E/rHUVI4QR+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777735954; c=relaxed/simple;
	bh=5N4j7dqp3wXHijrMRaccB7RFI8HYwGLQKs9hGzmNDcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7hiZeJ8mjddY7qVN8mvUKlMql7ePrgU3sx45ApkGAl0wzwJiYuzYT0nWFyviXmpK23MfrNqcqRzQ1AxUcoK0eoe7VtIWlUWabNlfmI4p+IRNEJ9deTkkmFVdNtWElYSquTNOTPgPkb26TSZ/fqYcSBWmSAv/MTV4A68/YyNegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Hq2oZqmf; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Hq2oZqmf"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D205D112877;
	Sat,  2 May 2026 17:32:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777735944; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1Ji4o/UKh5s3iYAgum24fW1ttfWjMxe2zCp2y0o6sCg=;
	b=Hq2oZqmfzGYQ/21alyh41Hi/ZBlWkeDrmW6/VbJiHP8dLV0mska06rVLmpVN9VEtln9Jmh
	6EdvO9PtCahkjrCKRB2AOicrdvK9Lcxf0kBCoXeapjzM38empUchYBlqx4/X+gQ15aed6i
	ep8GvpYJMHENQuOGrPjh2OFUj4DE5gtghEF7nlztujBGVJJERJBQbp/d2kYk9elanswqC8
	hY38US03Y94gHVOgP4S7nfzKrKVTWRRGhDfM0MUkI+DQ0PPH54zDgEkPo5e4byXIgSgaP1
	w4jz7e7sirOQNlQmpMwqACaIggv1ELxVFr6kflPJloNbHohmF9MMl9byOw8dFQ==
From: Marek Vasut <marex@nabladev.com>
To: linux-i2c@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] i2c: stm32f7: Move reinit_completion() to stm32f7_i2c_xfer_core()
Date: Sat,  2 May 2026 17:31:54 +0200
Message-ID: <20260502153218.56142-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Currently, the driver may repeatedly call reinit_completion() during
transfer which contains multiple messages, while another thread is
waiting for the completion.

This happens during transfer with more than 1 message, invoked via
stm32f7_i2c_xfer_core() -> stm32f7_i2c_xfer_msg(). After invoking the
stm32f7_i2c_xfer_msg() to start transfer, stm32f7_i2c_xfer_core()
calls wait_for_completion_timeout() to wait for completion of the
transfer of all messages. When the first message transfer completes,
the hard IRQ handler triggers, and detects transfer completion, which
leads to stm32f7_i2c_isr_event_thread() IRQ thread being started. The
stm32f7_i2c_isr_event_thread() calls stm32f7_i2c_xfer_msg() in case
there are more messages.

Without this change, the second and later stm32f7_i2c_xfer_msg() would
call reinit_completion() on the completion which is still being waited
for in stm32f7_i2c_xfer_core(). Fix this by moving the reinit_completion()
into stm32f7_i2c_xfer_core(), together with wait_for_completion_timeout().

Since stm32f7_i2c_xfer_core() now waits for completion of the entire
transfer, increase the default timeout. This fixes sporadic transfer
timeouts on STM32MP25xx during kernel boot.

Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alain Volmat <alain.volmat@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
 drivers/i2c/busses/i2c-stm32f7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 70cb5822bf17b..53d9df70ebe4d 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -895,8 +895,6 @@ static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
 	f7_msg->result = 0;
 	f7_msg->stop = (i2c_dev->msg_id >= i2c_dev->msg_num - 1);
 
-	reinit_completion(&i2c_dev->complete);
-
 	cr1 = readl_relaxed(base + STM32F7_I2C_CR1);
 	cr2 = readl_relaxed(base + STM32F7_I2C_CR2);
 
@@ -1728,6 +1726,8 @@ static int stm32f7_i2c_xfer_core(struct i2c_adapter *i2c_adap,
 	if (ret)
 		goto pm_free;
 
+	reinit_completion(&i2c_dev->complete);
+
 	stm32f7_i2c_xfer_msg(i2c_dev, msgs);
 
 	if (!i2c_dev->atomic)
@@ -2253,7 +2253,7 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	snprintf(adap->name, sizeof(adap->name), "STM32F7 I2C(%pa)",
 		 &res->start);
 	adap->owner = THIS_MODULE;
-	adap->timeout = 2 * HZ;
+	adap->timeout = 8 * HZ;
 	adap->retries = 3;
 	adap->algo = &stm32f7_i2c_algo;
 	adap->dev.parent = &pdev->dev;
-- 
2.53.0

