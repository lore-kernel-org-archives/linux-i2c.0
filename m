Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04C41C2FE
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516047; cv=none; b=PLoxS+1YUZVChrR+IP+KcRpzkGw3KQn8fwAonJUNe5SWpjV4LoDEh13XsMcMgK4msedAbp7Cd7vU8rdULC0mP9MI1yomqyQLOkv5LGBFTthMPuKGu3bVP9cRVa6ejk3/4Y4JDqIxEe4d5l2sa5la1dEuJF/EP8gynJHUQ4pzLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516047; c=relaxed/simple;
	bh=RMppgc+SyB8KfyqFbWTvIckWRFBjKUCa3PlowRWSmFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W91NoJbDL3OO8BspGZdqEPfyUmOYRxl53sFGivTvjd+sE5mQfvymFrXPB8doN7olfDXBfJRFiSfLqqad6ljQuYcorS6jCutLhlvaU8O3s/qdsXZVr7tlMTgp/uon6Rbc93OtRVGHB5nZmdd7V7ReXmOz6eRh8wNArf6Tw59FJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0n5uQazX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0n5uQazX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B1A714E42BF4;
	Mon, 11 May 2026 16:14:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8603460646;
	Mon, 11 May 2026 16:14:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8609E11AF9F4A;
	Mon, 11 May 2026 18:14:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778516043; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=urDOZDUkdQTYQO7V3D5GvpamQ1NtOpy9T9SQj+EOjRc=;
	b=0n5uQazXNc9tI588LixPkfFIXAHVEHnLEiSxffHNuF1vP9WXoZohkqIdr4uxB9ItIfmyIf
	kUi4ENPmrsRbiF6Uwi7+L40kv3ceEx5xcFIL42n4Ng2BIFkUjoB7Jwd5bFQow9I43ZW91E
	5QHeN4SrWqw+tuJDtIBmKhl+rV2TTuRxYsqRBZLyQfD20IKZsiFwjTIdnyFK2jEtiqTZK3
	IN6P54lvPR1+Pc9Wd13vQXZoIPbSPeZxSxrPETztpbyVVH4/jfpPRaIiUfE2aDUNyBP1UZ
	qTUQ4KlNBIzoVxf5E67a9LH9DM4Fb4vQlhIow/cVdo0mcrDDrgJBZLBf5BfnjA==
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v7 1/1] i2c: busses: at91: Add MCHP_LAN966X_PCI dependency
Date: Mon, 11 May 2026 18:13:49 +0200
Message-ID: <20260511161355.35656-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511161355.35656-1-herve.codina@bootlin.com>
References: <20260511161355.35656-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The AT91 I2C driver depends on ARCH_MICROCHIP.

This I2C controller can be used by the LAN966x PCI device and so
it needs to be available when the LAN966x PCI device is enabled.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867a37..3b6b6c4efc32 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -417,7 +417,7 @@ config I2C_ASPEED
 
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
-	depends on ARCH_MICROCHIP || COMPILE_TEST
+	depends on ARCH_MICROCHIP || MCHP_LAN966X_PCI || COMPILE_TEST
 	help
 	  This supports the use of the I2C interface on Atmel AT91
 	  processors.
-- 
2.54.0

