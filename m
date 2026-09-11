Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCF408028
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152549; cv=none; b=VuBQjEte7LM7Hdh9Ab/e/+4A0ZiY3RknNGjcXJbHzlLOnJcYssu906kS5h5uqEFmb2TRCvNBEdJ+yM4btK7uwiUGLq1pgLv9O59rRdm5PXBn/MtuQ9aUUyV9U57Yccj+pgIwMldfM+eh3XNyfywJVeW/xtTSb4HpQml8ZQNw/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152549; c=relaxed/simple;
	bh=Sgjm6c6d2RS8g27uXIF3YjTzR8yRr+CmCatF6miYX8c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nZqRR4wvp/FX0CeDxrGu5fHorP8gRIK8NDozWV4iyjOztK3kEg2WMG5ON0QAwjYoDsOcxdqQE+53urtjaCk6dtnmNHAedvD4LHTKfuy0zG3K4qtGX1USCSSCr2ijl1i68HN+BlT3PkTp5ZEx4lkAD6jgINK2lVU0MSd8Ee9rH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hkcnjfwl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hkcnjfwl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CB54AC63A0D;
	Fri, 11 Sep 2026 18:49:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1F56601A3;
	Fri, 11 Sep 2026 18:48:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACD3A11C7AFAD;
	Fri, 11 Sep 2026 20:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789152530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=3UbfaCqW7cpXjB90GJkoFEsrC9auI/qCe1ywASw2Pak=;
	b=HkcnjfwlJSg/o4HBuy4D5123z4n92V8vKYOYmqXIGVrQUTziBQbQ1BxfT2CKjvoNyMFxEe
	T3Zd218jGch6EE6VyhlY+xLToIhG/RTSaTiSdV8csJiMZsRZSv6AyMHC5hMyWguTeAT/PI
	1H7faHik4n74klTbnP4uRsktwbO7VlT1d9nTIFvbEDxBO17yPMxkQHuzzMqOzVcBShMxS4
	xy6NHxoyOe6csSIHwVgmBSntQDaak3JADoGiirhvUIEn1Ddl41XhH15hIrTB5aE08o9H/v
	+LTtdVo49dBHB+9ApUeMGB0C0+FtKcsTPyFbabWZ7MqGCBgO+uJnMumJhBaQvA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Subject: [PATCH v3 0/9] Congatec Board Controller: Add storage devices
 support
Date: Fri, 11 Sep 2026 20:48:02 +0200
Message-Id: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oyw6CMBBFf4V0bU0fQsGV/2FclDKFJkqxLY2G8
 O8WWKgrXd47uefMhDw4Ax4dswk5iMYb26fAdxlSnexbwKZJGTHCCiKowKqtFTZMYR+sk+nepJU
 Cj/04DNYFXHMAoUByzghKmMGBNo9Vcb5s2cF9TKbwLjuz4J7rG5Eu7WYsyeG3MVJMsIaGlzklh
 aDqVFsbrqbfK3tDCz6yDySlfyBZQnLQsqpKIKDzb+Q8zy+tUnK2OgEAAA==
X-Change-ID: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

For this v3, I deeply reworked the series.

I2C buses are now defined in the MFD driver, and all I2C bus parameters are
passed to the i2c-cgbc driver through platform data. The cell ID is no
longer used as the (BC) bus ID; the bus ID is now stored in platform data,
which allows switching the child devices to PLATFORM_DEVID_AUTO.

I also declared the I2C buses, as well as the devices attached to them, in
the MFD core. The MFD driver knows exactly which board it is running on.
This will be useful when adding support for other I2C buses, so they can be
limited based on the board. This also makes the i2c-cgbc driver more
generic.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
Changes in v3:
- rebased on v7.3-rc2
- use PLATFORM_DEVID_AUTO for child devices
- move I2C bus and I2C device definition in the MFD driver
- Link to v2: https://patch.msgid.link/20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com

Changes in v2:
- i2c: fix typo in CGBC BIOS EEPROM label.
- mfd: make cgbc_devs const
- Link to v1: https://patch.msgid.link/20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com

To: Thomas Richard <thomas.richard@bootlin.com>
To: Lee Jones <lee@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Werner Gartner <Werner.Gartner@congatec.com>
Cc: mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org

---
Thomas Richard (congatec GmbH) (9):
      mfd: cgbc: Fix use of negative error code as valid session handle
      mfd: cgbc: Add I2C platform data
      i2c: cgbc: Use plateform data to get bus ID and adapter name
      mfd: cgbc: Use PLATFORM_DEVID_AUTO for child device registration
      mfd: cgbc: Use real I2C bus names
      i2c: cgbc: Add support for fixed frequency buses
      mfd: cgbc: Add virtual I2C bus support
      mfd: cgbc: Add virtual storage devices on the virtual I2C bus
      i2c: cgbc: Register known I2C devices on the bus

 MAINTAINERS                            |   1 +
 drivers/i2c/busses/i2c-cgbc.c          | 109 ++++++++++---------
 drivers/mfd/cgbc-core.c                | 187 ++++++++++++++++++++++++++++++---
 include/linux/platform_data/i2c-cgbc.h |  28 +++++
 4 files changed, 258 insertions(+), 67 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320

Best regards,
--  
Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

