Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D733DEE5;
	Fri,  8 May 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225210; cv=none; b=iuOBmkAV/yTkftorof+/+s0Uo153NGHqVnQ+L1pIN0J0MmRo5WXasYy5o7niN71IBUkh3aQdT3b9lx1pnJ5Myqahux3Gg5Isxbu/9vtjAjIwcSQpz5+pfBpBtgGhC8zGpUCmH315XW2531fIxQFjiOybClYIRO2PSoVb/Lfi0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225210; c=relaxed/simple;
	bh=M4lbjoUhPJoCny3IpmEjnduHHjV318FmUyFmpW3E6zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLQXTxQq/mG1afHsXX5M1WByrCqXk0NY8h25xa0QG05765RflOzSJWAZNB+ZUL9t8heobCziu8LJTe36YTL6xzi+px/z1MiwW5CsT558TLGT3Zh4pxLZyG4T61D2BUf6y73tmf6OhHNkcUQNModHLxKTLcV1kemmj7V1Z6yoCnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=A+ZHduP7; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="A+ZHduP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1778225141;
	bh=rbweoWs65LxK6V/Lcm00CesALe08dny3oLDJ8d/9Clk=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=A+ZHduP79W5W0f4M72QoQUgJw8fJux5FRGDRnNsWWZ/Jcs02jpvm1ZMVqldTauqf4
	 rHxAI1DSB5dogdLJY5BMMbDEh6IkHEp0ARBhbzNg+gMYwy8DaXkwaHVgnYS3mIh/EM
	 XQkMTJkzQ2YHf0W/S6Rh7UzePjwVRosLYybRhN08=
X-QQ-mid: esmtpgz16t1778225135t2ec53698
X-QQ-Originating-IP: GvWsHhv6gPUuVDAnAl6L7AnrUg0HjU2QvetGSF/n2Sg=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 May 2026 15:25:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14195893166969710674
EX-QQ-RecipientCnt: 8
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 08 May 2026 15:25:25 +0800
Subject: [PATCH v7 2/2] i2c: spacemit: drop warning when clock-frequency
 property is absent
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-k1-i2c-ilcr-v7-2-8c2dde5c3ed5@linux.spacemit.com>
References: <20260508-k1-i2c-ilcr-v7-0-8c2dde5c3ed5@linux.spacemit.com>
In-Reply-To: <20260508-k1-i2c-ilcr-v7-0-8c2dde5c3ed5@linux.spacemit.com>
To: Andi Shyti <andi.shyti@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778225126; l=1956;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=M4lbjoUhPJoCny3IpmEjnduHHjV318FmUyFmpW3E6zo=;
 b=L1QVCc9kPq+VZX1eNxdP9Uhfxn4G0ma/iZS8P0qUY/XLiZd0Std0gRCjyRoUdDg2gOXNGwYsv
 lkUlaG1kSaiDz5AAWxS2Aq6oSj4NkyEk7NqbRBv+NAZ8jWVI7JMsX7k
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N8RLcQ8dzVhj2mrFTixT9so0omh7/fjfhx5jYyMcWJTa53ERrehX134L
	8GbMuAYZ6XMji2v8k4d91KQQHLIKgFIBn+qGlI0FuSoNnwa3Im6CK7Nf7tkopOEI/2pjhPG
	shu1zgs3YGsSSJI2T/TP8IJaOQu1/1dU80DVeOOoGGDfAFntXLwScXshTVK39bA6V+kTJZT
	XYHV4xwXNksmVu67T8UoJ4YNsi+sShu4PT0pggKuux9zsfO1XSyn+KLSrw2yC4TSBEQltSR
	UXfdkHwnRzKUVXs+CPLFL92hmkdHsODtkU3gPADu2B7WMssxpFsrKV/JnC5fyPiRjS/EkLn
	wuT4OLPkbw0lL7Gbj4RnLv7yiN7VMc3F46ZFMPi5aAeojVCuhA4JZXCgyxs3DS6MlDSLiuT
	5KDYVT8MNZ67D+peSEb+qwsbofE92WKyztm1nJqC/GOpDj3TcjVV0d289w2vogv66012J3P
	WwvyIkklf5clDjNYpszC5AX0TY+NU7k3oBKrr5dd9xhvROViPZQv1M9YPC46yobXNg472L7
	xBhVYp51XPTM7C6AtJCPg50L8jtUOjm4UJ9KeBvdBQ/eqfYBfi3U1iC52LJOVKzeIOlqwl+
	AM+3CgKQIAItohLyglovrJ5XVELJvAR7HMac1SkkX5mK3Iu/m+qSUUxS1ZXt1cma8DB4leA
	9YhgLG6pblKRQoVkQDyp4o8zgX3FF7+Q5dGf9Z++LlGfge3jXVxVELSJDKs/gbpmEh2DtXB
	VlmXRGvmEltpKsYctG7byD7UBlPLwrZbCDCxUMpqsxDyVkKlGmiCQaFiXDc7wDl1DO1/C9d
	N5JjOJMA1Ua9tuZZhjJPnFTnNW/OtH83B6HdFs2pKQMVrmcTZE7EF3/WpcKbXgNP1LyL+pE
	bh3eX5uJR38xOkkn7p3Uk0nH2G4VO2tza7zRIU613J4f483b+kaw3ayn1DcAFWyUt3HiaVr
	SjC2rJ0XKTdItWGliiR4tMBN5ImtcmK2i252HzYQ2ewONoGHnk0lMvEF15WnLsHnXBlJQWr
	Fw9nMJ/lHyHcuyoNkgF4koNoSFAE6v3f0rDrqE8u96cqMxkD1Lz20ayWwSYhxpYLEV4qEVw
	VwOEd0uLvUgizdjHy2R+NY6mvBjq74MHB8Tlpmppr6LdVTzhE0vKc81dX21tMyUZabYtP3J
	gVpw/vMZDSgsndh+rHrVBKNd2642pfCrkIS8
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The clock-frequency property is optional according to the DT binding.
Do not emit a warning when the property is missing and fall back to the
default frequency instead.

Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v7:
- add Alex's tag
- Link to v6: https://lore.kernel.org/all/20260429-k1-i2c-ilcr-v6-2-1c7a5a5a8b24@linux.spacemit.com/

Changelog in v6:
- drop Fixes tag per maintainer feedback (this is not a bug fix)
- change dev_warn to dev_info when clock-frequency is absent (it is optional)
- Link to v5: https://lore.kernel.org/r/20251226-k1-i2c-ilcr-v5-0-b5807b7dd0e6@linux.spacemit.com
---
 drivers/i2c/busses/i2c-k1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index c6fe2052e479..7cf5c05a20d2 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -833,9 +833,7 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	ret = of_property_read_u32(of_node, "clock-frequency", &i2c->clock_freq);
-	if (ret && ret != -EINVAL)
-		dev_warn(dev, "failed to read clock-frequency property: %d\n", ret);
+	of_property_read_u32(of_node, "clock-frequency", &i2c->clock_freq);
 
 	/* For now, this driver doesn't support high-speed. */
 	if (i2c->clock_freq > SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ &&
@@ -844,7 +842,7 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 	} else if (i2c->clock_freq && i2c->clock_freq <= SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ) {
 		i2c->mode = SPACEMIT_MODE_STANDARD;
 	} else {
-		dev_warn(i2c->dev, "invalid clock-frequency, fallback to fast mode");
+		dev_info(dev, "clock-frequency not set or out of range, using fast mode\n");
 		i2c->mode = SPACEMIT_MODE_FAST;
 		i2c->clock_freq = SPACEMIT_I2C_MAX_FAST_MODE_FREQ;
 	}

-- 
2.54.0

