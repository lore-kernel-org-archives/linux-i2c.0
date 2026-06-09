Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BC39EF23
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996589; cv=none; b=BWJ/obHoi/wvJKxgyPe0U00+DJARx4HStOmQuwnhnDBV8qDE4dXGOm3PSJTQLBh//sdxxngvSNx/zDlvEo+nBE/rMXKprFgiX/hUZ8SAXasSqwTenzg4dcZ/6clqhY5AcYrJOZl3QfV9UzuQ4ZTtABG4NhZg4p0/ruEijcqK2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996589; c=relaxed/simple;
	bh=UqaR4G2zUz0AlCNyHV37WuxfXZIc7q216vRr6DiHkFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeFPW7l8jo1GiqxQaZ9zTYg0uDNjUxq+CxWDxcYuSh27MHwzjkHAV/J3btzJRm1581vvHxQTzY0ak0U5AqaCBGflUwRIQT2RaxKBx+Kni6BVOdgnJDM6iRJSm/Wr1yvAB12ITVXcLO8MLWa+WeWBzBuZJCfD9ApHOAKFHO9BJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UW02mOQt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UW02mOQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=q/GB8JxA4C4bjzo6jF0NshW5bi7CG7fGAat92Gs0Ssc=; b=UW02mO
	Qtt0HfToyY8ewaaTivaWD7uAlG7WmfnD1zcFr8Xf3Dcnad1k5N3lOg3ZCVUXLQFh
	aplHbb420jU11FRsm6vJYJytlh2IEznwR4sFM2qGP5vgNjHMakG9dWTjOWG37438
	isEBVwgWXOOYi1kOPM1BGcy4mm1mHcDjQkXdGame452WaIZzxSpua4Gw4m3OO/tm
	8R6eDsFdqzLS2TY2V3YNFlUEM2OePMg5D3E4tHLxLY94FbQ130BSOWVO0qUZgrCM
	8sl+3NkmdSct5dBln5srX1GpI9mGJPvVe3xv0Ov7FuRMnhBRCGWOrZijkjUCZuBR
	VlN2lCmruOQK0EnA==
Received: (qmail 1205493 invoked from network); 9 Jun 2026 11:16:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2026 11:16:24 +0200
X-UD-Smtp-Session: l3s3148p1@eWC5lM5TLMEujnvA
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] MAINTAINERS: hand over I2C to Andi Shyti
Date: Tue,  9 Jun 2026 11:16:14 +0200
Message-ID: <20260609091612.8228-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260609091612.8228-3-wsa+renesas@sang-engineering.com>
References: <20260609091612.8228-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After 13.5 years of maintaining I2C, it is finally time for me to move
to other areas. So, I hereby transfer I2C maintainership to Andi Shyti.
He has been taking care of the I2C host drivers for a while now and
kindly agreed to look after the whole subsystem. Thank you, Andi! I also
want to thank all contributors, reviewers, and fellow maintainers making
all these years a mostly smooth ride. Happy hacking, everyone!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04542eebfbea..a4a0fcabe516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12094,11 +12094,11 @@ F:	Documentation/i2c/busses/i2c-parport.rst
 F:	drivers/i2c/busses/i2c-parport.c
 
 I2C SUBSYSTEM
-M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
+M:	Andi Shyti <andi.shyti@kernel.org>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git
 F:	Documentation/i2c/
 F:	drivers/i2c/*
 F:	include/dt-bindings/i2c/i2c.h
-- 
2.51.0

