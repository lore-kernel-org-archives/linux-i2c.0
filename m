Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD81407562;
	Mon, 11 May 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517867; cv=none; b=QjbjCSqyPXuhKnZNrt2cqz11QZEABaE+oaa0Lf8zUu2e4hsmE/b7c/oSbC0/My8wAw9lpw5zEu62A8LE4hXjLiD/n/u35+05zhP+EiSz2YIB2rOBZhn6atYQskk8bhTBIwcZR8vvi0gUdmZfEO+lJBa/VrMqImrub5pchej+oCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517867; c=relaxed/simple;
	bh=ZbfQaqnIThO4hCP6bsbpQ6QdR6WXippelKijIV2rptY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOg6SV+mg1r2k9Ao+q4HH+e0fzzCkx/is1HJuARsc7A5FHD1kvlMZ6vMERN5DEg+hATGUaCsypGTC+Icslyit3iDe+gLV8+3tMZZiPNmLJLNULmlnjj0RZkHMgbVVImg+jnV5ospnXnVFHZzzecZdeYgocmkatmbdz1qTBzOeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=B7wCKWP5; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="B7wCKWP5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2519112FB9;
	Mon, 11 May 2026 18:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778517321; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=kG3Mwdm8DEqhxmq4n/YcHXOUDvd+gpWWSEoncsPBJ4I=;
	b=B7wCKWP5K/dvB3r+Zn8RMQOBX+k9I6BGl3dIGZaN5SPfQWYFl4o91aOOV1204z3g7lv4Zs
	0I+LNf8t9ztyWNtLEipGcICzV2sONEtwVQC8ZB0ov3lWBNc8diG1RMgYtdQlL0GxcPGBsT
	W2aXSUT2v1GW+tcJaPbwzlkEIPdJaHuqhqjAxUB3o0vHZ4Gee0qz3fmTAWvBgZIQd3o/rC
	RuVjfsJyj/HXYqqj7vsYHac4NGku578xwBKtoPJ1bAlKURGp0daovL4PKdnwlzx72Q+RGh
	zY2645vHQjoLhDXpTd+r1dCQJWzAPz6k0KweVh9+DMp6Fm0KvtS1MKtziUibqA==
From: Marek Vasut <marex@nabladev.com>
To: linux-i2c@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: core: Mark nWP GPIO as non-exclusive
Date: Mon, 11 May 2026 18:35:07 +0200
Message-ID: <20260511163518.51104-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Mark the nWP GPIO as non-exclusive, because there is hardware in the
field which has multiple AT24 EEPROMs with nWP GPIO line tied to a
single GPIO. This allows such hardware to be described in DT and the
nWP GPIO operated via NVMEM force_ro sysfs attribute.

Note that GPIOD_FLAGS_BIT_NONEXCLUSIVE is a deprecated flag and should
not be used, but thus far there seems to be no replacement.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/nvmem/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index be28a366f6031..4fe2fad2f88b4 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -928,7 +928,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	if (!config->ignore_wp)
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
-						    GPIOD_OUT_HIGH);
+						    GPIOD_OUT_HIGH |
+						    GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(nvmem->wp_gpio)) {
 		rval = PTR_ERR(nvmem->wp_gpio);
 		nvmem->wp_gpio = NULL;
-- 
2.53.0

