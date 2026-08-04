Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC046C4B2;
	Tue,  4 Aug 2026 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855387; cv=none; b=lqHpaJjC/j6DsOXUO33jCer0YqinuliAdx0Arso6gmT64XdXWgqaFIezBW5F1h3J3HvKAYezwrZuxi6KUKnMEXZK0mC0hHyJdJtMiaEzAsi4wa4gmI3r8OuZ3ItlVg+QYF4su8xhXG9qG6hAbghvnN6Sm/OMHDRG8i1x364Xpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855387; c=relaxed/simple;
	bh=RmSrwG1F/7aFAs+HK0sePhP3Sxnni0CaFwzbwEbsY8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ok91UFFp5pgcj37kU+FYOxgvy1q9lLfsOW1+hPNpE64H5XAj5rZaQSrkNeXp9gXTDjMREQkEtRDVNoq461NkKjzwwjfV3NO2a7jRV1Y2Fa+tTm/cFnlSBj0M+kfFs3AoseBkDvucRGZCEFkBXCZZ9vuzyqM1/KYkU575yNFMgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0cqLLQLw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0cqLLQLw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 33E791A140A;
	Tue,  4 Aug 2026 14:56:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 060F46029E;
	Tue,  4 Aug 2026 14:56:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A151E11C32F24;
	Tue,  4 Aug 2026 16:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785855379; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sKJTZ3340Wy50yFmZKeX4ClEQ3lKUgb8dpkNiuzSFvM=;
	b=0cqLLQLwDEvg9gnAs07pGYm6N9sU3ZDiMTf2M+f4TSdVvfvEXJeYVCewlvyUiLmUnZUlsz
	7Mc2mxLQK/9E20mb2AnA7hdtorR7YI9VVgzNzDecTb2UMBDFKDW8AOGljgSBOGhakQillE
	5QniHtghbIw50GAeS13+/r+wcEF9s7yOIxgfIkswvmjd4XRC5BQ7Runmz6TXd5ZoJPEoVu
	NAGpXWTwuHfzVzqUm+J0Crx3mQCiU3ipYfLr3cAZRIGfzg/nflDIbz0TCnwq6C1eCE54Ex
	7zdJfnISVpLLLEAD8PRhsuPjr/errUv+p4U6bV3l2xbfxmbVSitvZ4VbSnFFxw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 04 Aug 2026 16:55:53 +0200
Subject: [PATCH 3/4] mfd: cgbc: Add virtual I2C bus support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-cgbc-i2c-storage-devices-support-v1-3-fed38510671c@bootlin.com>
References: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
In-Reply-To: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Internally the Board Controller has a virtual I2C bus with some virtual
storage devices (EEPROM and RAM). So add a new I2C cell for this virtual
bus.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 4a409234e66c..81bd0a381ca1 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -240,6 +240,7 @@ static struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-gpio"	},
 	{ .name = "cgbc-i2c", .id = 1 },
 	{ .name = "cgbc-i2c", .id = 2 },
+	{ .name = "cgbc-i2c", .id = 3 },
 	{ .name = "cgbc-hwmon"	},
 	{ .name = "cgbc-backlight" },
 };

-- 
2.53.0

