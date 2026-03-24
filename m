Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C639C658
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376939; cv=none; b=Gfz58oLk9iggufGag1LmRTEeoXIRPq0QF4v0GpfPBuSY2fiDYtryZErmyduAR37T3la1xWhKmZRseRgj9qbW2YnKredMtdePQcJ++eCoz3MZx17XkMsP18PpZtHFC8kIALlvv8KRqsBf691iUGCjepHlGEicE5UqiipRw3O/4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376939; c=relaxed/simple;
	bh=7g/jARnkhTd3DIs23AFH73jSfHB7zbCwImSIcA8YsoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ohp3b8P+M6PxygPUx2BuQPkmewe8Maek9bds8ARAV7656EDfiyddE1Z+T6CvbPR3i8ZPLKPmq5OTIxXJQytffywvy7BDUAtgAR2KrgOA9dgWvM7dWzyvai/lxDuD8VUG2gp8yEwLefbqy7zIYBRN/NOCRH8Kgk//JLDe8LYdawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeayEKFn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeayEKFn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso2114499a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376937; x=1774981737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MPILU45gcDsKK8jp+8jqoirIZBgcXX7ZY0CuqSl9cY=;
        b=oeayEKFny7vadu4kiqbm4VW6IkcFRMWDumZCZUWfZYCw/RxXLv0aaKBlq4/VUUbDp1
         KOa5FwW0/GzBQxBlZw6D6fi8V53ez3Bl6fagBvPaNDh7OzWeo774+Sen0yKN4nSYcmCJ
         7mtLkTPv7K6AD1jUMNdOoaQduZzvAhBO0XhmZyAkJTbvUPriCVAuuAMM/Z3g1O4cdtpk
         ou8bmXIQlpxhaPDV2cdSEcDjxt8zhqlatUqSvYdSryoti2ViVZmB6Ac3Sc5DUOq9qS5A
         +I87rhwmm0Za4LigTmct0Tdjgkj658A48UbVEMAW5aF313a3k+aJOEBCbaLBFBJ5Vz+l
         wHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376937; x=1774981737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2MPILU45gcDsKK8jp+8jqoirIZBgcXX7ZY0CuqSl9cY=;
        b=irddfQJh6xGqLesYEaEpJZS3ZPL+7UuiCx5MRavEsqo2KYrX9c/PqW9AnBldM7xSqf
         T3nEdUt0fmBGt+dZ5DteSbfvi1G361trXoHISUkxf8LDtKwTmoQTnkcaN7C0/nxRmBMO
         VRGQgnH1pj2TkhaC2//id/bh6qxDmveEiph5wtjfV06htapd+7eQwZStaXLk/0NyHBTo
         rf5ansDoQUKy9ZKh3g+r266tX1wqOX2/JBBSWXfdVuS9qGHMx4tJLWbhRGjwCqSr+9g4
         egY6Zt8Sarycv9er7/35wTNUxa/bl+BCxcvL+N7mPFBS41NT3FhMjINB+Olww4KQEY4S
         JI7A==
X-Gm-Message-State: AOJu0Yx33IRReck5sgks/BtVcWYGpDq8WPrfsgJ9gb/yFjSXVGLqjRPi
	w9qLwtW5qixvQ8USn+MGTv9HksurerGKasbvGtmpcL5k9/OXF3vWUQJqdWvcGlO1fFQ=
X-Gm-Gg: ATEYQzzj31JWQuQq0fDigre9eHwBX/5Qtk+YASHOI7ELwAQ9fQaktbCEKodRR++QDoU
	PAgkQwR9cIzk7+FpRyTwjk4sKv3/PhM824FawhfJCEzxMQt0Qj7KrtRoYZO60bQcZYuPVtEFkWW
	T/MGCppRejrREsG9kpKym1j/ZnltOulpMSIxk9dBJIULhlmo3tTUa8UqKdxIfkG5jhleXfHjvnd
	xtwn6QtByHEwpU9/+AisbxBLq/eV5SPaPqDACa2IZ8tcm+ha/axxcU/klY08xjDy3b2PcGDH+lP
	F5cwXuaXVEmitT86Yk5QgOr2cciKsDZXSGdmcLQjDnWnRABgzdgkec+dBOmBJ4phKG40El9Svdi
	Agu99mQucaydpLXzuYzga7bEg5uJPK5zBX+yJpaFPHbKgCRMRXsyjAB3A9O2f1l7akzZfR3hzlO
	JCc2q4aAFeowturqRnyXv7Pl8cOQ==
X-Received: by 2002:a17:90b:3dc4:b0:35b:929f:7e8f with SMTP id 98e67ed59e1d1-35c0dd1000bmr297824a91.13.1774376937217;
        Tue, 24 Mar 2026 11:28:57 -0700 (PDT)
Received: from [127.0.1.1] ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0d6060b5sm350576a91.17.2026.03.24.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:28:56 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
Date: Tue, 24 Mar 2026 23:56:58 +0530
Subject: [PATCH 10/10] i2c: sis630: Replace dev_err() with dev_err_probe()
 in probe function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-deverr-v1-10-7e591cce33a3@gmail.com>
References: <20260324-deverr-v1-0-7e591cce33a3@gmail.com>
In-Reply-To: <20260324-deverr-v1-0-7e591cce33a3@gmail.com>
To: Till Harbaum <till@harbaum.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 Enrico Zanda <e.zanda1@gmail.com>, Atharv Dubey <atharvd440@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774376818; l=2804;
 i=atharvd440@gmail.com; s=20260314; h=from:subject:message-id;
 bh=nhsfDSLdFe3nGX23EexwATKRFgvnwZsN/uRkVIgsfDc=;
 b=MfTL2nua2/UaTOkuHox/mofQ9uGkaQFwD4ef2QTeyEIJWKrK1affTlrqYL2fD+dQbiqZ2kQf1
 368O9MeLyraCsNY7XiqbLSbdhihgwtkeZhLhsjgkAnvnbcpMTIg+zrj
X-Developer-Key: i=atharvd440@gmail.com; a=ed25519;
 pk=T6i1xWOKT/RUSDYATSgyVG/4X7ac8jPjRSG1mMAcqVk=

From: Enrico Zanda <e.zanda1@gmail.com>

This simplifies the code while improving log.

Signed-off-by: Enrico Zanda <e.zanda1@gmail.com>
Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/i2c/busses/i2c-sis630.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index a19c3d251804..3d0638c2bc51 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -431,24 +431,23 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 	   in acpi io space and read acpi base addr
 	*/
 	if (pci_read_config_byte(sis630_dev, SIS630_BIOS_CTL_REG, &b)) {
-		dev_err(&sis630_dev->dev, "Error: Can't read bios ctl reg\n");
-		retval = -ENODEV;
+		retval = dev_err_probe(&sis630_dev->dev, -ENODEV,
+				       "Error: Can't read bios ctl reg\n");
 		goto exit;
 	}
 	/* if ACPI already enabled , do nothing */
 	if (!(b & 0x80) &&
 	    pci_write_config_byte(sis630_dev, SIS630_BIOS_CTL_REG, b | 0x80)) {
-		dev_err(&sis630_dev->dev, "Error: Can't enable ACPI\n");
-		retval = -ENODEV;
+		retval = dev_err_probe(&sis630_dev->dev, -ENODEV,
+				       "Error: Can't enable ACPI\n");
 		goto exit;
 	}
 
 	/* Determine the ACPI base address */
 	if (pci_read_config_word(sis630_dev,
 				 SIS630_ACPI_BASE_REG, &acpi_base)) {
-		dev_err(&sis630_dev->dev,
-			"Error: Can't determine ACPI base address\n");
-		retval = -ENODEV;
+		retval = dev_err_probe(&sis630_dev->dev, -ENODEV,
+				       "Error: Can't determine ACPI base address\n");
 		goto exit;
 	}
 
@@ -469,11 +468,10 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 	/* Everything is happy, let's grab the memory and set things up. */
 	if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
 			    sis630_driver.name)) {
-		dev_err(&sis630_dev->dev,
-			"I/O Region 0x%04x-0x%04x for SMBus already in use.\n",
-			smbus_base + SMB_STS,
-			smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
-		retval = -EBUSY;
+		retval = dev_err_probe(&sis630_dev->dev, -EBUSY,
+				       "I/O Region 0x%04x-0x%04x for SMBus already in use.\n",
+				       smbus_base + SMB_STS,
+				       smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
 		goto exit;
 	}
 
@@ -511,12 +509,9 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int ret;
 
-	if (sis630_setup(dev)) {
-		dev_err(&dev->dev,
-			"SIS630 compatible bus not detected, "
-			"module not inserted.\n");
-		return -ENODEV;
-	}
+	if (sis630_setup(dev))
+		return dev_err_probe(&dev->dev, -ENODEV,
+				     "Compatible bus not detected, module not inserted.\n");
 
 	/* set up the sysfs linkage to our parent device */
 	sis630_adapter.dev.parent = &dev->dev;

-- 
2.43.0

