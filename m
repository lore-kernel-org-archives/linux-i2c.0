Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B536449B30
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464938; cv=none; b=nAhxbX+OfsaMrf0QS9WAYEM1rKcHO85ZRSDZACnk+r1pnZexD1Tpcl0dTaxAqSQOQ9W+mVD/hOU0e7VH/JxCodRxChX8N2VlBIsEAZtPR4zE6BXtS6VcUN2s+n9MAVULWdty5QRTuqG/eEj8EaLStvgmlKfeWtT8fFSLKsw+kuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464938; c=relaxed/simple;
	bh=wc21kG4AX+ZzJq0gJVXiWEcD+lnUKOYtfwLGM0hGkZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6cjILFAxVj7UH8Z0tpWaflxcpAJOD6psr8DBelnS1nncZhNvKvuJg6vWPzvk5mKMa3YurKtgn9Zf1VXf6oshr3fg/e00qO8ENI2s24slZn0iMcjnEuvgyEL7pP/oewb1SBJXimoJRjApNksAn1MG+4xZTKdCftMeFL0zc5YBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T9QBwAJc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T9QBwAJc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 70DCA4E411B7;
	Tue, 11 Aug 2026 16:15:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4598E6033C;
	Tue, 11 Aug 2026 16:15:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3E2111C48FAA;
	Tue, 11 Aug 2026 18:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786464930; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IojpC1611eNpzo/tBaBNvfHDBqXXqjdiSpsL7i7OgbM=;
	b=T9QBwAJckWUfHjAs534fe1YJcsBfKdQHIgEZHWkL/oHLk3/loVGPHrYZyL5vHKXQDdJmKz
	2ddqnrG7wrDJwgYcEFqqPqdMq4nBiFvPUGfncTwA16F3dGunSJXTXaXEgbNtbTeJTcRikl
	6jm+NPl7H26cW5yoaaKjJBOFRe33hLlJuIZBnJR5Kn6AB3kl9isOpMQa5qAbnLqKtvogAk
	lwaOQL/Uce6xJzeQk8CH2VrZdjkbh5aNYfVdvhkl/svoqcKQg53eTJohRXwthqr4H5Mw27
	McJagdNfuDx+uXMAG4yJ4ILw+mvCjomClKYBNTHxoo8K4zUiBpjsRxT6XOA2BQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 11 Aug 2026 18:15:03 +0200
Subject: [PATCH v2 2/5] mfd: cgbc: Make cgbc_devs const
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-cgbc-i2c-storage-devices-support-v2-2-3efa998e0ef5@bootlin.com>
References: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
In-Reply-To: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Make cgbc_devs const, so it will be placed in .rodata section.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 4a409234e66c..f09fd671bc8c 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -235,7 +235,7 @@ int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size
 }
 EXPORT_SYMBOL_GPL(cgbc_command);
 
-static struct mfd_cell cgbc_devs[] = {
+static const struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-wdt"	},
 	{ .name = "cgbc-gpio"	},
 	{ .name = "cgbc-i2c", .id = 1 },

-- 
2.53.0

