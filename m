Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D06A18EFD1;
	Mon, 27 Apr 2026 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777258695; cv=none; b=B1jSTOSP12ACbQw9PH3bjsq4/AywzAGjSd2GqTlYs2cbRvlx2QlDc13Ueta+eFarmoK9fzp2jIV6yAnlfRhQFYU5MhTEG3vFCuhK1qXaJR1n9Tw7N9onNAaEUe0Z00LP3ka3GvufKNswScdXCqu6cku/oV5IvIZ5fMFE43N1mTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777258695; c=relaxed/simple;
	bh=j+fkDPTCxmfB9f3HWX63DLZ1NFhcvRigHtaXjN0X7Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BaP+2j/enku1/Ie6fD4Spab1rAPZmvRjGFOr2ECdR0QtCsCOZHn33tF+C/fVAXwBnpdiKxnryDSPjIgAzPPjXQkZbuvuI7zhDmOl2/+bmI/seCOxgRQUwEf7agNEf1IzFMoqvzZPiT/grSqs7bFkOw8Q70qlH+LHCuomjdPZERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=gLmZbIvl reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="gLmZbIvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=M4XuLowtrg
	j1gs4en2LIN0V1orpMeHUH5tFpuZo9EgM=; b=gLmZbIvli4m+YPjeEAdzCd74bK
	y3C5yKubNSiZC+qU1ZDkiUxhuGeTc8E4774rM0gnqVUsnna0Ma/TZqRER7PlG9dG
	1qAW8g2FPsj0/N38LU7SLpqGNDydEekrPT0rVmw5/gXhNKAjLAVBA+vBt8ackGQ/
	U1sT1o6PGkNqrTSPs=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkD2nbmr0O5pJ9XHAQ--.44724S2;
	Mon, 27 Apr 2026 10:57:56 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
Date: Mon, 27 Apr 2026 10:57:45 +0800
Message-Id: <20260427025745.1100768-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkD2nbmr0O5pJ9XHAQ--.44724S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF18trWxJFW7ur1fXryUAwb_yoW8AFy8pF
	W5Kw1DtFy2qF4jq3Wvyan5XryrWw18JrW5JFZrK34qvan8G3Z7Zr9ak3s0v3ZrCrWkX3yI
	qFZ0q3y3uw4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb0PfJ
	UUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUOEWnriOWDxQACsz

While fuzzing with Syzkaller, a persistent `schedule_timeout: wrong
timeout value` warning was observed, accompanied by SMBus controller
state machine corruption.

The I2C_TIMEOUT ioctl accepts a user-provided timeout in multiples of
10 ms. The user argument is checked against INT_MAX, but it is
subsequently multiplied by 10 before being passed to msecs_to_jiffies().

A malicious user can pass a large value (e.g., 429496729) that passes
the `arg > INT_MAX` check but overflows when multiplied by 10. This
results in a truncated 32-bit unsigned value that bypasses the
internal `(int)m < 0` check in `msecs_to_jiffies()`.

The truncated value is then assigned to `client->adapter->timeout`
(a signed 32-bit int), which is reinterpreted as a negative number.
When passed to wait_for_completion_timeout(), this negative value
undergoes sign extension to a 64-bit unsigned long, triggering the
`schedule_timeout` warning and causing premature returns. This leaves
the SMBus state machine in an unrecoverable state, constituting a
local Denial of Service (DoS).

Fix this by bounding the user argument to `INT_MAX / 10`.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/i2c/i2c-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 7bbe0263411e..fb9d53ff1144 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -487,7 +487,7 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
-		if (arg > INT_MAX)
+		if (arg > INT_MAX / 10)
 			return -EINVAL;
 
 		/* For historical reasons, user-space sets the timeout
-- 
2.34.1

