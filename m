Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6E3F3263
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855377; cv=none; b=JA+Yoe47/g36mhIkvjQ+RwsIPo36XXrvRurmMy5U+5f0KlgtvfA7vo+wkU38LnE8f2xOp7JJ8QMa/EyOnzcD7Ls5NjhEQHujSqxZ39jYeBxRVqQjYt9nIk4DAs+nj8Aklzoiv+jQwPkNHrjZgRG8FrsdO7UmZjXGqXWPlMw35K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855377; c=relaxed/simple;
	bh=8RNOwG3ZepOtWh9A3e9lLXLVAvJfkOaUb5pq19/wUZY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OUJTOirxvvyJZ/tty1ygsw/uWFrQTpVTPhuSsY9ORfKYMEUhToGtX3VvnkIjmsXgLyFz6P865jCsZAvEBF68A/4fhUR3n/9Z68TInsspItpv4JVhV87lkjE3spIPWEM7w56iJJbIJpn4qtTAW2bi6B+ac6g1bsxIFsVuAZSuQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZmiiEWgG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZmiiEWgG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 51B0A4E410DE;
	Tue,  4 Aug 2026 14:56:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 21AED6029E;
	Tue,  4 Aug 2026 14:56:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E807911C32F2D;
	Tue,  4 Aug 2026 16:56:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785855372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=wMKCpGzde44WGCNaOstqI+K+UpoNsd04Cs3OOxvzj80=;
	b=ZmiiEWgGNhPpblkf/h+w9ty3Lje9o8Sqki+qcNvV6oXV/HMkDK3g9JmD/ExhYtKRHPmfDT
	HGRH0vofNGHVBo+eAIfQlw2rK8J28u67erckzLZgZAROJIn3GxmSJDjjiaqEzfHwiOX+02
	YcQC4NEDIloxUxXtSjhkR1OezLQ/1YiE3TTGbAuQkMOIrSEFDjgHEvGEST2+VVXsMY86te
	lIHDgqFsowIxauBEd5sA5Wl0UypMPYLFWuVlxJ/8KhZgq6ADdxrxbeDesJMwHZ0Aqee3zP
	D3WJowxkE/VQWHFcaV4vHZvG5Nx0E0AylamxeAPyrxI+/XkjDs4WGKRVAT6F5g==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Subject: [PATCH 0/4] Congatec Board Controller: Add storage devices support
Date: Tue, 04 Aug 2026 16:55:50 +0200
Message-Id: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQrCQAxEf6XkbGC7Cy74K+Jhm8aaS3dNtiKU/
 rtBPb4ZZt4OxipscBl2UH6JSV0dxtMA9CjrwiizM8QQzyGPGWmZCCUSWq9avJ99RWxoW2tVO06
 JOROXlGIAv2nKd3l/Fdfbj5Wfm5v6PzyOD12h8kqHAAAA
X-Change-ID: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The Congatec Board Controller has an internal I2C bus with several storage
devices (EEPROM and RAM). The bus and devices are virtual but act as real
hardware. This series adds support for both the bus and devices.

List of devices:
- Secure Data EEPROM  (64 bytes, RO): static and dynamic board info
- BIOS EEPROM         (32 bytes, RW): reserved for BIOS applications
- BC EEPROM           (32 bytes, RO): Board Controller operational params
- User EEPROM         (32 bytes, RW): user applications
- BIOS RAM            (32 bytes, RW): reserved for BIOS applications
- BC RAM               (8 bytes, RO): Board Controller operational params
- User RAM            (16 bytes, RW): user applications

The i2c-cgbc driver instantiates these devices. A dedicated driver for
these devices was not necessary since the at24 driver can handle them.
The 24c01 entry (the most generic one) is used, and parameters (size,
read-only flag...) are customized via the software_node properties.

I also took this opportunity to fix an issue reported by Sashiko in the MFD
driver (PATCH 1).

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
Thomas Richard (congatec GmbH) (4):
      mfd: cgbc: Fix use of negative error code as valid session handle
      i2c: cgbc: Add virtual I2C bus support
      mfd: cgbc: Add virtual I2C bus support
      i2c: cgbc: Add virtual storage devices on the virtual I2C bus

 drivers/i2c/busses/i2c-cgbc.c | 174 ++++++++++++++++++++++++++++++++++++++++--
 drivers/mfd/cgbc-core.c       |   7 +-
 2 files changed, 174 insertions(+), 7 deletions(-)
---
base-commit: 82442496954504a901faf74105a5ab592d782288
change-id: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320

Best regards,
--  
Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

