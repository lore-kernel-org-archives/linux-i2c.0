Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348D352FA3;
	Sat,  7 Feb 2026 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477049; cv=none; b=LD6sNMUJn0X5HQiU5mAxbgrw4NGNTbWh6FK9kAdS+OAebUsa7ymxjluFnYIzf2R+Dz3xB3ApCO2IdMxZHOOMkTH+6PEcyStIORUDsKiF+bFJSGPDKpS76dsAcTtR+0Nff8hybX13rTRnJs3x94VK/IPogPOq/dh/qqsS3VS91Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477049; c=relaxed/simple;
	bh=fObZ2VADvmnq2ga4fUiik6dtloWq4BE/WX/lsKHQ3Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dMde17zfHNwsNXnN9oVJelg7MDyuK9VK9ps2QA10Z/VUmB6+h0MJ5OGsRb2kdZhJc4/ejkD0ZRJs6O9mSyPnA6xOemJyCSYBmS9bJKVTqEDMTmq4IB3Q5r2M1Yx1x3E4hnvaUI7wy5emJwNikWou+8YDU2jmxhd/AufRnBa7h2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=jdtFHMdK; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="jdtFHMdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770476910;
	bh=3tysreunGyxK9grEoo6D7aMrnzbnsab2/WrUaDPKeU8=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=jdtFHMdKscG4XFmSJI5XzmBxp6FAl2f2CqtIxDImhfrS8RYmzkgxpOpn9XIhQcTQ/
	 FqScGSiLRVKSAQP4j02BeFlyKXu7/uKAEzJrflyw6sc3il58IY9oofNFX2svvQrxeB
	 9wxURMKiGyHbErKjmXy1JKc+5Z9x5EwjC7R5tMoM=
X-QQ-mid: zesmtpip2t1770476909ta9e74f16
X-QQ-Originating-IP: NqBWQtJ7emv0IMzEADEC24CCXPphDOyUyc+MZjPCjAs=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Feb 2026 23:08:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18321366254888439668
EX-QQ-RecipientCnt: 9
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Sat, 07 Feb 2026 23:08:21 +0800
Subject: [PATCH v7 1/2] i2c: spacemit: move i2c_xfer_msg()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260207-b4-k3-i2c-pio-v7-1-626942d94d91@linux.spacemit.com>
References: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
In-Reply-To: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
To: Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770476904; l=3114;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=fObZ2VADvmnq2ga4fUiik6dtloWq4BE/WX/lsKHQ3Sk=;
 b=bu1J1Kg+2C5ALywRbkZ6pYQAc7dkVxcV7i9gdjhpyGTuFjmHvJDrt/0aEkZ2RD7Q0tKMFTkAd
 mOVKspNhag1AZ/QvqMbxFXtcJ7DadSIgdE0IGxYFg6pnaGanWw2UuGm
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NEpYz65Zs0E8QCCvLySY/hHdRN5ebyaoUAuKUJWHwYpcQAZzX7O0Ephs
	XCqaETFFk/5bfF6KWCi3CeIYvkXOT7afK1jiYExDc3uxeQmf6xJ65dSOZfPRb32JsgKxAI2
	2P3oTSGXcSnuJVeUY30ZU28DAZ8Uouu/ljbDRSlZg2OGTlv65tNIe6SyS7gU2dMNHEo2//i
	H/87G1Z21BgYWXSVxwitRvPy+b0N7aIDhFF4dXVnGhW/AwI2MfpvMCqENC88ZYCE3ncD6bE
	FBh42bu5bj5LE/dkRbelRvA2NPWo5tsGQngTg5HG1e0TfYq8QBe4cH8TThdS+ctIuAK/teQ
	P++bfoYmO/0rHGb8QjdTxzz5C2Rn84hleTzgF9V8yAfKfnrkKC8LRxfcEQvzLvkqJ821XC0
	uh7pja32bRZQeEFWHoJ9sr82bvtsyTWfShj5ZaX77rHN3aBtdHJoHUU74Jaf4jjjwN9/9Qa
	SlmBFgoA+j17lLAR7EIO6Ubs25z3K0Fsmf4e37XDor+m2gH2+VScaY3WIFpZPOSd8HuQ/6M
	YUbaE5xzPxmyz8qba/645hhzdPQZA8i5Kmoi/7C0On9yUQPavSkvw8sHjOiScI00Jeskedm
	YMhg/BGCoRLYAK2IntSSxKcKoOee/iZbpQGhiVLBoxkmOGYfW5dcIvACcAULzO2mx6hF3y9
	E2Z/axDTYUOTc9mE53a2r9bOgnaym1zzhRhPplbQdaLJ1iIOKLoTLBUg4aXL2Rm7js9nwP7
	ZttRrfyyKWKel0nIz72Ea+cLCcF1sV0bQjlxxbKR7oRH/eLxs82bymiH6lv3zVu6j1aJ2cx
	dp8Dn8hRj9xuDvcAYRNSMh8Ho0nJOX9w5WqiCAxxklkmexqmCl8nTCXGfH9hYxaEawVM8Hk
	y5Rrq1uDpAqcPlTQ6XmOORhHV/XRQ0LQ/pd05eyRqN3uaJ3r2OmWbqv1bWavG6gBZTzATsD
	324xA476XHL7DCIrlSl25Qw9zUadGujbNs3PcHCF/9GhPb0/uUUuyDnq01q0kIBSfdcNn84
	b3t9lcE60ag4A5uRje3d10Mh/MjWW+T/sHP1qifiZccNghFrUzIhc/EwrLKMrhxlM203YFX
	GhkeudMjM4du0sG8/9UBU9Lu5Jaa9Lykd4L6kOnJrPQZv2NnCoXnjIkq/nFvItlwE4Jazy7
	GyhXDTddQcvzv1ymBQqz7kZ32y6sdcaTwUSWLvbA53ljl90=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The upcoming PIO support requires a wait_pio_xfer() helper, which is
invoked from xfer_msg().

Since wait_pio_xfer() depends on err_check(), move the definition of
xfer_msg() after err_check() to avoid a forward declaration of
err_check().

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
---
Changes in v7:
- nothing
- Link to v6: https://lore.kernel.org/all/20260108-k1-i2c-atomic-v6-1-41b132b70f68@linux.spacemit.com/

Changes in v6:
- fix wrong subject
- Link to v5: https://lore.kernel.org/all/20251226-k1-i2c-atomic-v5-1-023c798c5523@linux.spacemit.com/
---
 drivers/i2c/busses/i2c-k1.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index d42c03ef5db5..accef6653b56 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -304,37 +304,6 @@ static void spacemit_i2c_start(struct spacemit_i2c_dev *i2c)
 	writel(val, i2c->base + SPACEMIT_ICR);
 }
 
-static int spacemit_i2c_xfer_msg(struct spacemit_i2c_dev *i2c)
-{
-	unsigned long time_left;
-	struct i2c_msg *msg;
-
-	for (i2c->msg_idx = 0; i2c->msg_idx < i2c->msg_num; i2c->msg_idx++) {
-		msg = &i2c->msgs[i2c->msg_idx];
-		i2c->msg_buf = msg->buf;
-		i2c->unprocessed = msg->len;
-		i2c->status = 0;
-
-		reinit_completion(&i2c->complete);
-
-		spacemit_i2c_start(i2c);
-
-		time_left = wait_for_completion_timeout(&i2c->complete,
-							i2c->adapt.timeout);
-		if (!time_left) {
-			dev_err(i2c->dev, "msg completion timeout\n");
-			spacemit_i2c_conditionally_reset_bus(i2c);
-			spacemit_i2c_reset(i2c);
-			return -ETIMEDOUT;
-		}
-
-		if (i2c->status & SPACEMIT_SR_ERR)
-			return spacemit_i2c_handle_err(i2c);
-	}
-
-	return 0;
-}
-
 static bool spacemit_i2c_is_last_msg(struct spacemit_i2c_dev *i2c)
 {
 	if (i2c->msg_idx != i2c->msg_num - 1)
@@ -418,6 +387,37 @@ static void spacemit_i2c_err_check(struct spacemit_i2c_dev *i2c)
 	complete(&i2c->complete);
 }
 
+static int spacemit_i2c_xfer_msg(struct spacemit_i2c_dev *i2c)
+{
+	unsigned long time_left;
+	struct i2c_msg *msg;
+
+	for (i2c->msg_idx = 0; i2c->msg_idx < i2c->msg_num; i2c->msg_idx++) {
+		msg = &i2c->msgs[i2c->msg_idx];
+		i2c->msg_buf = msg->buf;
+		i2c->unprocessed = msg->len;
+		i2c->status = 0;
+
+		reinit_completion(&i2c->complete);
+
+		spacemit_i2c_start(i2c);
+
+		time_left = wait_for_completion_timeout(&i2c->complete,
+							i2c->adapt.timeout);
+		if (!time_left) {
+			dev_err(i2c->dev, "msg completion timeout\n");
+			spacemit_i2c_conditionally_reset_bus(i2c);
+			spacemit_i2c_reset(i2c);
+			return -ETIMEDOUT;
+		}
+
+		if (i2c->status & SPACEMIT_SR_ERR)
+			return spacemit_i2c_handle_err(i2c);
+	}
+
+	return 0;
+}
+
 static irqreturn_t spacemit_i2c_irq_handler(int irq, void *devid)
 {
 	struct spacemit_i2c_dev *i2c = devid;

-- 
2.53.0

