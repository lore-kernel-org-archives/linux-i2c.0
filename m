Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE2466B65
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464949; cv=none; b=fgPynlaNwzRC0Fc7KAWoC9S6KmQSx1OglEG/DR7JQJHNFgFVETaGjRpqIzNzsByNTPpxaANIbVoYAoBv3GDusYmr4fWWXKBL7Z6ZKETFP0dxh5KmOc8ynmaqx+GFh3ivacUjDxoGhnuCyY6WYrO2HLtp4rfFSD64F7MNN/iTwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464949; c=relaxed/simple;
	bh=TGXtrZXdjVqoMa48XR5MI8NAV1kEc9n6IXNdRcpAAaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4J9U76lpIwWP7vBl5nUWShH5BHKtXfE2X5ZGBugIQWDkdrvSWrlb40bCvCTdm2DxMInHPjrdSzxVzq0PCkkiXIVsf9Fn/Hw1Zbf1c6iH6L7eMB1oaHk9pF5OwEFW1tqo2c+b8aadYvNeSTwePuqr87+BE/JqnLv1zXi1ZWl4+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KiWyFUmk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KiWyFUmk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F14921A1570
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 16:15:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4AA96033C;
	Tue, 11 Aug 2026 16:15:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F046011C48FAE;
	Tue, 11 Aug 2026 18:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786464941; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=swodfQHwP9uXMPGV1udBQbxCGjaTe6Q09FMEiRmHWfU=;
	b=KiWyFUmk5IrIi71HwscYdukh1eqz/jBjbRlGnq1PAah8eRYy6hjHk+jUe+SRTjDxSyOmRR
	lQaWsxU0Z+LVBAhnhPLY1/5G/0z86sxF++7CKPZWhOwbxoY+l3Bj0JASWfC7LBwMrtYTi8
	nLHyLClAOUAjyA6wTP+9EtGrNjfFvOYkBTA1Q+xygkS8QGXWvXF0PzItY2r4Jt21gPa8Sr
	GBSvfHhSWFMT1AylbrwlBjckSJc8NYHJOU9i4+amB/FeZpI8vO/J8sYZqQU1V2tzBR2HGy
	YajJiPBaork/e/4WkHpSRKMZhFfdPv3KysyJJfGkJxfRc2W5E+S98DWbmoUPUA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 11 Aug 2026 18:15:05 +0200
Subject: [PATCH v2 4/5] mfd: cgbc: Add virtual I2C bus support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-cgbc-i2c-storage-devices-support-v2-4-3efa998e0ef5@bootlin.com>
References: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
In-Reply-To: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
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
index f09fd671bc8c..e800a0f4e50a 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -240,6 +240,7 @@ static const struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-gpio"	},
 	{ .name = "cgbc-i2c", .id = 1 },
 	{ .name = "cgbc-i2c", .id = 2 },
+	{ .name = "cgbc-i2c", .id = 3 },
 	{ .name = "cgbc-hwmon"	},
 	{ .name = "cgbc-backlight" },
 };

-- 
2.53.0

