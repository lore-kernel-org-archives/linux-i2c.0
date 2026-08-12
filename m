Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808183845D5
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567391; cv=none; b=L6mVdhFcH/rjawYvTsX0b6PU3jP080J1P+WhgSWEYj0bWM8wB5hfRUBSMrxtpKlh6YTZ3QRJ9vs7Pm3IakApOUULydmMu1lGuYsZXjjFUx2bZTunMvCedB+vrzj5t8rYSFDxGqjHMg+zrTXVM1+MF1bj/MJ8op8mWTF77kOMk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567391; c=relaxed/simple;
	bh=P3F6aEseeh3B2B0HgsyL7LhcHjijtwqBEJAyLQKXL6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjJQSLj17yq5mOByrKctV1/zPXUQBZtxOqrmRDcONqKtPlCpDK+DvINGoiGaNuhWlaTX/uInQ3FbnZgVgxAENjQfwfk3niZIAC8CIuMvDntDknuR1hh2L+pVOufG+hzAXgnyg8BzzTl4slFGUWSeU2aS82ajpslLfc78QFZ3fSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxTvrD7H; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxTvrD7H"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b00d083818so288082e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786567388; x=1787172188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wg1jjn9NqVzpcXQSIFBwdiB0DJ5srbtrb9GNkZ1pBO8=;
        b=jxTvrD7HJcu9svuARpgeKfRabYKe77wS5Db8yfUl2r0lBF4E3YUCyylL/fK0gs4zh9
         7VSdAKxxMjrGFAlWJPiUyelI0iwzOcYF/ZyEdMI6qrXXIGamECKWkqR/FyOIMraTqUA7
         pmEU7j1qCY7vtMy1WnGAvUVuel7Py4l5ePlk48DnUBqfrTNDwd44iIdD7AbZWMJ5vO4i
         WJ43sv56SmujGBTsffBJ7yu3mP0EX4o8B742nrrUgxT3jvIv+duCuCTZxEkeeIN/8wxz
         cfEOY/a8BDqKMzNauA45ZSibMy4MNQ/+rg4zfBZ/5LSxN+y9c7YF4qAz9DP2qhVeJARA
         9NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786567388; x=1787172188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wg1jjn9NqVzpcXQSIFBwdiB0DJ5srbtrb9GNkZ1pBO8=;
        b=Po5BK4NPfzuThBtg0gXoAokNZbINsJEI2N0K9kK5eJ823PDWbqjhmEGFbUgSZoQ6kR
         jg6cYIY3P0cU0ZoOKn36t3JwgTCRJX9FjrVUOCb5crEnnlBLJCuD6THFs/xhG/XDAX8L
         clO5xZeHWBYy5ISDUUmQARPokqiW1uixG00ST44WCrvgtHC2NV5SQN02UlLUhy3AC8d1
         8VzdMFFsdPhtebrjdUpbuSimC0kqLZATJ/2QxWdCyhgeeTE7p7nx8n8qT3e621f+8WRQ
         wBG07397XUSeUlWpEbRmXMH1x+eJ1uL73F8jH8SMpbgh5zqfJkkLGxv0BLGkg00p4a6C
         AYcQ==
X-Gm-Message-State: AOJu0YyR9hlTDoQPAMEDVXaPnij2UEA8UB9zhkotnwxvJ4WJPb5B5irN
	HS68GU0XzANg13A9oSC/AykcqjjOU/sPhdwBicq5ejk2cVYeD6kWysyVYpnqhFDkYUI=
X-Gm-Gg: AR+sD11piDuJmIBFKVAfmy99lo84Wu7jYdNNha/phJCivan+bXDygd1l0mPWlUXqn3E
	uoBmNCD7PA7QOlFq7nDYx2fbcCYMOQW+lOMU+WdXhzV6n5HpP7YTrL3TvoZ0xwcjQFoB0uiDPm+
	oDwuYrmoAsC3YniVNr/Y4x/roWl2O+4Ou4MBy8NN5PZCxYaXEFpG7DKhCoPqb/LOxFKMpksCywN
	6T5shjtGXZWnVyBUiTTbYSbXgWsqSBaLsFlvsrx+VpplyDtQsm5HD3CR90Mv93SS5wUz3DLmAg3
	oi8PNNx+cKkV5bHaQrwqdEhkK32f/NY3D+K+YVUEZou8EPrJkHAlFhX/iVmXMxLuRDHIB/4YE7w
	0wqm88DL4WDCCAfAtRpcY4ytLBYu3twvN0b1HAHQ/kErSgmRKH2wIW8E7oOKSaGkT+M8SavWTiW
	UoBkaOIhk7N3DZ6EVcrxYjDiGEZdNsBhSvLsl9kDXjRfEcNPPMwS1V44oJviwx/eeh1xdjEzWRB
	mx/BMPdN28YCMLGJq4dk3dWUHd3
X-Received: by 2002:a05:6512:63c1:10b0:5b1:5e19:c496 with SMTP id 2adb3069b0e04-5b453cc585amr60211e87.14.1786567388367;
        Wed, 12 Aug 2026 13:43:08 -0700 (PDT)
Received: from mietsbox ([2a00:808:140:f72e:ea47:3aff:fee8:3890])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4539ea237sm55308e87.18.2026.08.12.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:43:05 -0700 (PDT)
From: Guntis Belkovskis <guntis.belkovskis@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: guntis.belkovskis@gmail.com,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: piix4: Add ACPI region conflict allowlist for Gigabyte X870 EAGLE WIFI7
Date: Wed, 12 Aug 2026 23:42:20 +0300
Message-ID: <20260812204220.74726-1-guntis.belkovskis@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Gigabyte X870 EAGLE WIFI7 motherboard, the ACPI DSDT declares
the SMBus I/O ports (0x0B00 and 0x0B20) inside the _CRS method of
\_SB.PCI0.S900 to report motherboard resource consumption.

Inspection of the disassembled DSDT confirms that the firmware does not
declare an OperationRegion over this range or execute any runtime AML
methods against these ports. However, acpi_check_region() fails due to the
static resource reservation, preventing i2c-piix4 from binding and blocking
access to the DDR5 SPD and auxiliary controllers.

Add a DMI allowlist entry for this motherboard so i2c-piix4 can safely
bind and probe the SMBus. Verified working on physical hardware.

Signed-off-by: Guntis Belkovskis <guntis.belkovskis@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 7b6a4e201..33d4b0331 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -136,6 +136,18 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 	{ }
 };
 
+/* Allowlist for boards where ACPI reserves SMBus I/O in _CRS without active AML access */
+static const struct dmi_system_id piix4_dmi_acpi_allowlist[] = {
+	{
+		.ident = "GIGABYTE X870 EAGLE WIFI7",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "X870 EAGLE WIFI7"),
+		},
+	},
+	{ }
+};
+
 /*
  * SB800 globals
  */
@@ -403,8 +415,11 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	if (retval)
 		return retval;
 
-	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
-		return -ENODEV;
+	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
+		if (!dmi_check_system(piix4_dmi_acpi_allowlist)) {
+			return -ENODEV;
+		}
+	}
 
 	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
 		dev_err(&PIIX4_dev->dev, "SMBus region 0x%x already in use!\n",
-- 
2.55.0

