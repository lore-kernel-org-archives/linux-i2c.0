Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DB3921C6;
	Wed, 29 Apr 2026 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449002; cv=none; b=S+Ved8uN4wDuiMEnip6JfizqLtXAvUx/0Drg1372aPv7TxtkQp2tYVCtamr8Xn4IaMJU3HJHhyrWFovZNUh1EJqGmeXle5AxPhICzwc68aq9n80ZbIubz0E/FtE2LXA89+ZmKJBTKpj0YnuqzxprJ7WFerB0nZv70QmbgUqbwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449002; c=relaxed/simple;
	bh=mCQayAr9RouaadceLxaNioH49sLgj8dEFAMiyWvUNLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sA8PRcZh+hd2HajFp+S21T0ayXD2a0XVA/PRrRUAPX9MpGDEXXoEmjfimuq+7xhvDRoOcWYjrrJQbFeKKbAyjd9veJATGJ11bGuyc5FlZBAFzum6W9PsvcoA+Hr6GLZyYlhqOBbd+rXhya+8qXpcvwQP3SFxeoc6dsn1V9etw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=MhMe4Uf7; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="MhMe4Uf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1777448952;
	bh=/XBLU/2EPMf5LiPhya2jhRX0WZEvv8umzim0o1th8vo=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=MhMe4Uf7IiKX9v0zyN3tM8f9+7jaUaWsUJeOlgy0fMdHYxucpaqtw7T6iMvHx0RTL
	 Ujz3UK5PbjQMDMjv4e2bdECMAqlib/z0QGzuOrsZhBX78kD4q8VKGzkk791hbTW9bj
	 D8IU6VO134Gml0d53I2GWbJp8bS5bKcQmrEDqqfQ=
X-QQ-mid: zesmtpgz9t1777448946t7992dc9f
X-QQ-Originating-IP: NIGDpNr5nns6isGhGyKxzyKT90BztXn9N5xiG1xN5EI=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Apr 2026 15:49:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14935581430065835113
EX-QQ-RecipientCnt: 8
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Wed, 29 Apr 2026 15:48:57 +0800
Subject: [PATCH v6 2/2] i2c: spacemit: drop warning when clock-frequency
 property is absent
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-k1-i2c-ilcr-v6-2-1c7a5a5a8b24@linux.spacemit.com>
References: <20260429-k1-i2c-ilcr-v6-0-1c7a5a5a8b24@linux.spacemit.com>
In-Reply-To: <20260429-k1-i2c-ilcr-v6-0-1c7a5a5a8b24@linux.spacemit.com>
To: Andi Shyti <andi.shyti@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777448937; l=1770;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=mCQayAr9RouaadceLxaNioH49sLgj8dEFAMiyWvUNLc=;
 b=6XoYLdtoh1REnJ/XnCtZ6jKyFHHng6mH2yjpbp0UYn/RazkzBbdN44yZKhVE2FeyR4yjwF7nl
 /emkxihAbwJAmIItQvo+5FUsweTpM3PjXyvopUvvbfYjrGin1xHSCnt
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MeriHi1OVszfSpOBSOeiYDAaFgQrWVj3qNROv/xAg8aYIb/pKXdlZShN
	NX4AP3Plx+MZx0MHfr30AVBKVeOMOxcfkB8VuGmwBo5FOi2vJ5ifPodPM/e96gE+82sCq/v
	V6yQy7lullCr0HSbB2XjXCkkncy9ZQQqVSySoIEo+3bBXuB6IzT7mTZ7zxB5XNaThG08Z4K
	hr+BRHhGdxWTTUdJ8MhZN9ui79V0F/o8RTQgssQFIcmHyH1ma85jv/PzpZOpeuSOzyUw71y
	h2zSOs7ftTyRp3VGJTPyf8ZgHAk5nkvrHntO/2f9pTIARBJyjvvz+xd3+gDCRKcFcyKv+f+
	acL7Vzl3ACbWa20300jLi1R2SxMHT2KV4Cyn7CKNgpEPzEtvkaw2SixY/ViZ7svLPANAYL/
	6RhtEmmBasAbvAnzN12YD9Pg7eppqLdqLz+3mBVmGOwOKFcOtoqcXSqUJosmhafD6Ttwgnm
	caMbSV32bhH4+0iIYlUDZm0HCCYFw2Ln7MigmU2uQVuvlzDWOhcxZ2bxLoxh3BcUD3xLCT4
	8Rmgp6Gnsfzxx/bgDiFuhthabQG9z/GD6wiQ1aXRHjfH0/MezF5XwudD+6qUou/kzOB7Olo
	O7MRYIrpSiugSAAsiE4zob9JoO18b/yqKORhbplgGNDmRh+EfrZEOanGEOI3gcVTSoys2KV
	kRW9hi3IBFCoZtIBgLagKHBjG12ZfkDXSooPuSpFxx6J+dXp+LSuGEtJWfN6mggwHAEHXa6
	t1kr1msaTHOO8eBQo94zznNJK10UF3JbOW0B7ArReb4ADnjociR4KA4NYeqx4vv6YtTIgh6
	DlNWq1djZh3kRBF1QkaSa75tvl/5hDlksC5HCWMQB5ZXLXte2sR+JR/s7vkNEFDxgHcSG3x
	JR716LO0ElioYRJ9/rZI13+xmrDX0EBGr2xg+aCFOalnZG9g4js8zI22ioIS65H4i10MzTt
	Hy8fcuaU5QbTpwxUHl4iUi0aWpvrd4xAmTyqUFHnxWIjq0cp7KDFy+NF/gbMbYVw8bmjxcL
	tuyPuYXnaEtjpjdsWwqhZVVj8LtbHwEf8ekvZzoDfm+v3wOggT322EprzJNFR7SJBN4s7ag
	fokI1rQjZQpqUOfa0NDuEqfmpznq4KP7TO3s/Ow611iZ2labTwuw40=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The clock-frequency property is optional according to the DT binding.
Do not emit a warning when the property is missing and fall back to the
default frequency instead.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v6:
- drop Fixes tag per maintainer feedback (this is not a bug fix)
- change dev_warn to dev_info when clock-frequency is absent (it is optional)
- Link to v5: https://lore.kernel.org/r/20251226-k1-i2c-ilcr-v5-0-b5807b7dd0e6@linux.spacemit.com
---
 drivers/i2c/busses/i2c-k1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index fad6a20bb43d..8b0a215dfb29 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -823,9 +823,7 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	ret = of_property_read_u32(of_node, "clock-frequency", &i2c->clock_freq);
-	if (ret && ret != -EINVAL)
-		dev_warn(dev, "failed to read clock-frequency property: %d\n", ret);
+	of_property_read_u32(of_node, "clock-frequency", &i2c->clock_freq);
 
 	/* For now, this driver doesn't support high-speed. */
 	if (i2c->clock_freq > SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ &&
@@ -834,7 +832,7 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
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

