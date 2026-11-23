Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421104;
	b=dr6yIBwQ5tCyPtj3wHb8FLuVzmDLjJ12I/t/m9LjrrmmpADoFyc7ubgQZ5QRWu7X16gU
	 pOhU3+s0KJO486Ry2eS6seHgeDePljPJ7RYvIyHANyUaBGizEipHSqoc6JpwdToNfKucl
	 6/NRtpYNJtdiEPCwBu6enorP2bYj2dlLOthIaYBAfEmeDDGIPb53w79xTJIc4h74HW7FJ
	 KttNWtU28xvaR2ZEIO50lyJmVaMImUp7YvT9K46UBycODQnjAPEFNHeaVmVR+QSbB5Rov
	 PzdH/ohyLWCHreHGxHeaXXyort/+HgSZLUsI2NEWSd4EynPrMxrKbW6QeDAtFPaaZCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hGcttaruzyRZJCZXM7VU5qWDg/6JovBYDGPldO8dc2I=;
	b=p+mQza1lh2YpFtigIRZqRcZj/KeEIX+068nZusEx9AYlVz+yJkhSadAxlqTwEaUtnKcP
	 AaPjmIcr2hJjjawc+QuXmDzLS9RIQUU7uEnTVRpYevFSB7BXV/vB4sxfzpeo+4g5EX/MV
	 RoEDuvuIYkQvo1h4vj+nzCbkYn5DwsBWNTOxMcfOmnQJ/QKU30ScADlUTQV5X6SNwL/Vt
	 1dXm6N4zE2jV8m2KjeYqaygA2mtWXlA9UTb+V5Z2rWtcjy/yh+fST7bS8zkfLyPYgjzG7
	 8X2cFM2HAJpTxUPPjkzCDwJi1l29JG85Ps9StqglRTHb7n6cNWTvYrOHnVIEXsVY5Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dtCjep9t;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E7606A6B2
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 08:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E48E7606A6B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dtCjep9t
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1352622b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 00:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795421103; x=1796025903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGcttaruzyRZJCZXM7VU5qWDg/6JovBYDGPldO8dc2I=;
        b=dtCjep9tMb/zOrN99TYPLcGo4+TNxcnVGNc95lKRXeYTMUajKcxC6DwmCXmyotxSTI
         0C8ahNihTMNM4YGUxKrH08k8VUNWB5cFeU1oZZa9zySyT0EnILcQWN0je+ctMVNMFQYm
         2iqfk0prJPrSjZCIB9Jsa9MlsH1Dkt1CFyaapVOgDQn9B9bZv073lZTv1vmwRMNeL5L2
         jwgykj/2DI4Sey3KicxVgB398Fwi44OsWSEcaJr+NykFYrLv3gxWhuWVkeNadf49lSJe
         TKCRI7gepfG0kHDbsHKMAseN+TDMV6fHJTU1g0gHGghahQWSgqbqjHEYwXVSqlF3bYgw
         FBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795421103; x=1796025903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGcttaruzyRZJCZXM7VU5qWDg/6JovBYDGPldO8dc2I=;
        b=DtCPe+iqlUY4nkZNMdee5mcBIc++TFagHe2yKTK6N+YAlMNtTD8rf5WXIt4WJiuE/P
         F9UevfgbNXbCR2CMH5yM/bgws4OFXdA7mZABIecgqIbnoRpjFX0s6F9Ng3F33d9Wmhb8
         MPril4xO65iBQCoTr9NmMm63LkMX+oIoDhGqkhvc/MvKq63IgTp8TeqwMZmg+7jjrLJ9
         wHODp+maJEmZT0cHuEBC1ACg4aP2PvnafaoreyHrbv5qgI0imcYqRHep1PxarOoisEXZ
         k/+6whs72DKwMu2y3ZV0SapPl5OIEcft4JiM602zR3S6ISoamEoT9V/6aeIp8qK9UF1W
         zoLw==
X-Gm-Message-State: APuU4Z8qp4Yk8u05/yr1Izxj6FnY9w0QSzkrUWzb/BeZoN+4jSHy8S5B
	Gjei8anOpoDmSHMpN9Zx+6FXxbtbioC0GhcDUDnTV70zbboX5ARMVXKArsF5fg==
X-Gm-Gg: AZFdTZcNdKTYKMQDh/uRElri3mMbx+6iJO4RgwYXYgWVU7Vvsv4vIEYepzVf8Fd1Hky
	NJmNlBEfSo6+poCmLpqm/FdiFJTsgXX0Mq086wiYnexEcJRKuBNaAwk1DMQ+DtJUtZfPSCspXYj
	KApHpUsWA5Nf3GkRkCsSArpijDJS2pg7q/9hxQMrOpNFkv88y6QCjNodBxvoA/trahSERv/fDRM
	T8+sh0Kt2qB8t45jXr1UXRYI0ymN9Upst5BVoujKOoIxiXRrOqs8cWHeG326vvxyLQETwWijxjn
	dZEbviyeS1QYILXe81ndY6Pp123pW2cf8r+jVLeXrO+Pbo5baj6abVTTf4YnJhxCj6rN0wcOgph
	Dxg1u7MxloX20kjFvCuVzz7ZLnjVPxDgGWFCVd02DZ0wK2IhyIcTsH6sH9FjrsXbVv/KuHuJgyR
	bLcH8vF9qpUgWstqib+qYr5HTYN35OJYwK93+8EsqaHuWmYXBA2rrpUkBpb/bcSevAgMyj3QeOR
	TLsaIZGESfDSq0OSqd6UJkvPMJXFdKHZ6yFCRXEDq5/wx2A+QxXjHcqM/3hwGuilBg8jl/LalOl
	QamkfT0WeN4+ylCb26xvEbnzGqTgeYVTLXxXr0ap680tJbWz1/MzpXJEXszSQfdU89u10W3NceV
	RjI7fy0sUfR7ZZRojrLzI80uIgrp4QJUmHLxMvYIU0TPyiFOFXcbWf2z9uIcFUUIrGdNwiFZ+8P
	gr9A==
X-Received: by 2002:a05:6a20:748f:b0:3e2:1218:3ea8 with SMTP id adf61e73a8af0-4014b564283mr12121127637.14.1795421103054;
        Mon, 23 Nov 2026 00:05:03 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87392d408sm4997126b3a.44.2026.11.23.00.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:05:02 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] i2c: piix4: ignore ACPI resource conflict on X470 AORUS ULTRA GAMING
Date: Mon, 23 Nov 2026 00:05:01 -0800
Message-ID: <20261123080501.31289-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The \GSA1 WMI device in the board's SSDT declares an OpRegion over the
FCH SMBus registers (\GSA1.SMBI, 0xb00-0xb0f), so the driver refuses to
bind and the board has no SMBus adapter: SPD EEPROMs can't be read.

The AML that touches the region is only reachable through the \GSA1.WMBB
SMBus commands (0x5e-0x6d) and DIMM queries (0x130, 0x136) used by
Gigabyte's Windows tools. On Linux only gigabyte-wmi calls WMBB, and it
only issues board-info and temperature queries, so nothing races the
driver for the controller. This was checked against BIOS F66d.

acpi_enforce_resources=lax would also work, but it drops the check for
every driver on the system, not just this one region.

Skip acpi_check_region() via a DMI match on the board name (which the
firmware reports as "X470 AORUS ULTRA GAMING-CF"), and only for the
SMBus base the OpRegion covers. Other ports, such as the aux controller
at 0xb20, keep the normal check.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 43 +++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index a21e6d377bc2..08b3e209300e 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -126,6 +126,43 @@ static const struct dmi_system_id piix4_dmi_blacklist[] = {
 	{ }
 };
 
+/*
+ * Boards whose ACPI tables declare an OpRegion over the SMBus registers
+ * that only AML reachable from vendor WMI methods uses. On Gigabyte's
+ * X470 AORUS ULTRA GAMING, \GSA1.SMBI is only touched through the
+ * \GSA1.WMBB SMBus commands (0x5e-0x6d) used by Gigabyte's Windows
+ * tools, which nothing on Linux issues, so the conflict is nominal.
+ *
+ * driver_data holds the SMBus base the OpRegion covers; the ACPI check
+ * is only skipped for that port.
+ */
+static const struct dmi_system_id piix4_dmi_acpi_ignore[] = {
+	{
+		.ident = "Gigabyte X470 AORUS ULTRA GAMING",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR,
+					"Gigabyte Technology Co., Ltd."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME,
+					"X470 AORUS ULTRA GAMING-CF"),
+		},
+		.driver_data = (void *)0xb00,
+	},
+	{ }
+};
+
+static int piix4_acpi_check_region(struct pci_dev *dev, unsigned short smba)
+{
+	const struct dmi_system_id *dmi = dmi_first_match(piix4_dmi_acpi_ignore);
+
+	if (dmi && (uintptr_t)dmi->driver_data == smba) {
+		dev_info(&dev->dev,
+			 "Ignoring ACPI resource conflict at 0x%x\n", smba);
+		return 0;
+	}
+
+	return acpi_check_region(smba, SMBIOSIZE, piix4_driver.name);
+}
+
 /* The IBM entry is in a separate table because we only check it
    on Intel-based systems */
 static const struct dmi_system_id piix4_dmi_ibm[] = {
@@ -264,7 +301,7 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 		}
 	}
 
-	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
+	if (piix4_acpi_check_region(PIIX4_dev, piix4_smba))
 		return -ENODEV;
 
 	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
@@ -403,7 +440,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	if (retval)
 		return retval;
 
-	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
+	if (piix4_acpi_check_region(PIIX4_dev, piix4_smba))
 		return -ENODEV;
 
 	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
@@ -502,7 +539,7 @@ static int piix4_setup_aux(struct pci_dev *PIIX4_dev,
 		return -ENODEV;
 	}
 
-	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
+	if (piix4_acpi_check_region(PIIX4_dev, piix4_smba))
 		return -ENODEV;
 
 	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
-- 
2.56.1

