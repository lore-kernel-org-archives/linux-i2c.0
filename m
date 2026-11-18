Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998988;
	b=GG/kSdYTmOA7s9sQ5tdBBxCfOpCr4Aq0usHM5Lg8/QbiUdJLe+CaexB1RbZeAMtIhZ/d
	 fo2WJpr8XSlT/wUIBuiswc+KbZPN96uc7ARIasTBajBTPNGIsmC93HgjJAN3tef+OqFJn
	 HbD7lL/oiBJGEhKU31toAGL1RdQyYejEHwEB5thAyJb1AGPrEzaCOZ/xaAc2ZMhFAnYhR
	 C0yYkt/DjsWNyaDNh5wAmKEgAa8kMe1RZSgN0reDIijgn9iokAjeyh5fYklcpQxC8x6rl
	 j67IyKpi/p/mOxCvshGopP1BkB4vpALSHYZiOqR4PwxVhndNY/K2mzuJKsPUgE7UECw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LIcWmceFZYgQietyQnWOcEmUtfnOG0g7rm/baVCxi6w=;
	b=Xqwl1kuaBNxs6MHZN2AlV6Wr9INJDQRZM6+MzWCBDyNImy6HMv9SePmvY4U50uYjaqpj
	 cemKS428MQFuLr46O7jGPCIKlXCEUP1y0ohF/BW4faZj8SEJL7Fq9Qaha11IWpAgdlwYg
	 OzQMr/xs23HT33PyCjIjCfI4SVJOH8A41sudWJ+QMmEc0geIf3Aa+J03S3ten/SUHgRMe
	 fzOLes9AkiRVMLK/87j0lchXynh8L7VNOwN9SyxA5/evaAYHcIRpS6DKLo4flJ1tARnqo
	 eaae3GCxPNuvshUV4ifggyVk1hRgBCCWKA8NJ2S6VOXcSp4B4ajNGmOk+IqdZmYlmZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxdHWTwH;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ECE606A33B
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 10:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97ECE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxdHWTwH
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-381d542bc29so1610263eec.1
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 02:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998987; x=1795603787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIcWmceFZYgQietyQnWOcEmUtfnOG0g7rm/baVCxi6w=;
        b=HxdHWTwHorAG2PIpdZLKc3N7ObMPHGYzpHCyX9EECRrJOGiaxqPRBf/D59uI26fi3M
         H7le+B+pvLdnU5bvJjbeYl6czjcErebJQPVTucJBkhLL/8MhXuYY+GCumBRXrEuZNmzj
         eK9zqoo8ciY0gymBrAEMJajGYsx0SHidLXDkEPBn+tu0GHkMypA02nIjmgdpJ9gMpU0/
         wbqh3Fms4eOTjOtK6G9s2nYky9I42q1yjWFwpLgFvEo/MGQr2dQS5sipAdL+S9vcFrbl
         UY4bGPqVpkzkuFY5Ao4Ie9RApz928FndTReiBwIYhk4Myv2oMB5qQ2s4R0IDqWB0yajr
         rDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998987; x=1795603787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIcWmceFZYgQietyQnWOcEmUtfnOG0g7rm/baVCxi6w=;
        b=MGKnwz1NgszOhOYjqZojTleb6cbkv/+fyC1cKJhR8ZifobH2E8Aj0GSIkQfkS8WPQ1
         JBYZ65bnYQ4hVZUmFyR0N4/YiqntLlnBMCGVRzklDliBVMCbq7aGZJoWhhezd7VX5qoL
         rw6M99DVkEJaMza8Qr29ZTdPw7HP7yWqjLr9TQ7ld7h3h8SnGvWrUwzO3oEA5uH5Oqcy
         iJYpVbHOgGcC2sNSe2Y7mGi6piP1W6MAu2drNA0hB0XrqXsUIX88XgstpDCrhmA6Jpfl
         shLeP0x8gbI0alvyBvedxp4m1AFzHeycnNen6gG7Alv1+R2x9ZeooXtM6DTLRKUPUhMZ
         CCeA==
X-Forwarded-Encrypted: i=1; AL+hErEysbQ9njPk+2+6aUm0kXN2eVKHfQ+qRg6Zzl7H6EwQjCBEhPdItUq9gernRIoNv6ZFpzgAV/62a84=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YoenRKIvpIB/AMFU6ZcEwKf6EgobavXE84oIOQ9kM/zxw1DN1
	QzKzYOSJ4OB+WlgGtRUp7XpGpN1NNBHgpJK36yAhADv6zvcnxKKmXErN
X-Gm-Gg: AZFdTZc/RHbaI/JkHHpefs2M+7HE8zIlxi7tgik7eKnrA0oEpNHa/OMonVzse4CkBXz
	QykbTBTp93EUdxVxj/H/nxqMjFHCp3OUeuI/8EwKr//XjT1VJ4qZP+5LVpodfk6pkLHKx5Vpfys
	p9JsodFEfVyVisPH6VSDa3QBTg1QJ5T6GDKMxsJzuEEDvA6sBBr5xeH7Jmltxw4nIQQcEAB+g4W
	rQnWeSKZTCZrL4+y1aLglVikmWBeK5lmUUdqk8cy4M5rqJ+OntYx6dtejwaLLcXUFPyuwX7R1mx
	RoUiBbdjqCz+LeOBYexasu/7JYzvVtbownoLy/B1BdyT0YEy363Uc8RohGMMm8Xpm4s3y5v7YDx
	DZoZGbKtB55rQwQFw8nuPNAZf69ZyyLEaSiazi+SzejzGnpZYLbdD/Q30IZrfHJxVKtlIXvOXwb
	clmPQ4iIkeHveTv7DWcULRqJetCnjvNVZAmspWMLVsacpbd8YxqPXSAuMwxrUJKC+PqZf2ujtUr
	0neDiutE5Ad5ExTfUq78kTfKLPxN2QRsp34KBca7NqOrsK9vyjFC1tA0zWrb/jOP2aVSNoHBMyo
	DOsbxFmfOTMgjHbjhWFLMLWGi9Ikq/47
X-Received: by 2002:a05:7301:fc13:b0:369:f70e:bd40 with SMTP id 5a478bee46e88-38280377e84mr2164257eec.16.1794998986480;
        Wed, 18 Nov 2026 02:49:46 -0800 (PST)
Received: from archl-rock5b ([45.112.0.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm11729913eec.3.2026.11.18.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:49:45 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Alex Elder <elder@riscstar.com>
Subject: [PATCH v2 1/3] i2c: spacemit: Avoid sleeping during bus reset in atomic context
Date: Wed, 18 Nov 2026 16:19:13 +0530
Message-ID: <20261118104935.1716-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
to wait after triggering a bus reset request. However, this function can
be invoked during atomic I2C transfers (such as power-off or restart
handlers running in atomic notifier chains), where sleeping is illegal.

Replace the sleep operation with the driver's internal helper,
spacemit_i2c_delay(), which conditionally uses udelay() when running in
an atomic context, avoiding "scheduling while atomic" bugs.

Fixes: 5dd75dac1b35 ("i2c: spacemit: introduce pio for k1")
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Alex Elder <elder@riscstar.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: https://lore.kernel.org/all/20261110061429.2036-1-linux.amoon@gmail.com/
	collected all te reviewed-by
---
 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index ff32876e24d3..f4b21d7efaaf 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -332,7 +332,7 @@ static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
 		writel(FIELD_PREP(SPACEMIT_RCR_FIELD_RST_CYC, 1),
 		       i2c->base + SPACEMIT_IRCR);
 		writel(SPACEMIT_CR_RSTREQ, i2c->base + SPACEMIT_ICR);
-		usleep_range(20, 30);
+		spacemit_i2c_delay(i2c, 20);
 	}
 
 	/* check sda again here */

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.56.0

