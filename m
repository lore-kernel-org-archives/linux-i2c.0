Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03E37474F
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912616; cv=none; b=lQJHIuBvRkOPGErmQegIdD76qd4VlBaaX+nGDocfGcJ1OvtQG5+NCG9Jlyem+5bUonTI5sDF1LKBEff7tcUPMdJe0zd+x8uhEaQT1CEC0776tfra2cJaY6SC+MlTidJWHL3LFQ7FmBbXdkBm0HYKESAxav/Bnb+fZGHTxf0O18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912616; c=relaxed/simple;
	bh=wNDplq0YqnffOYbsYnOSFvRKdTxylDnq3Hrxa4ha8LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A80ll/qn+V2LH5B42WEyRXPa0XtMyZQxZDvQ4l/gdd8N+g/LpFgdOCFx2rK2y8m9+4MOmyCchWxImEImCvpNY9xSqAhO6K+JFWu+41ijqUiu6jesy91fj7Y7HGk6UcFOUswnyGF6D59uKO50UtQYnJhuuAn7Nvqo4+yaB5XwaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=rZkX2wPw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="rZkX2wPw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3697c35eab7so7406820a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1779912614; x=1780517414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yowAEUOtQuzWZAIQXcwy3+wvBYyr2OnsXsvl8HFebjU=;
        b=rZkX2wPw4vAevc2XwSDSvI5s+W5yY9N2awJJB263B/9kRhqrMqhPyTca4i8D9KDWCx
         GnA3eJtaxJbMPiClAtifMa2Tr3BaWrZ/OqPc17U12o+Ub+eDvadzCnOe47E8pIfSSxWY
         OdxHL87HNhh6RlohcAyXiK59gCTXGOqmY+2/tmg1m1o2gD6lYG3wJxONN6KpKLelhOWv
         hjgamoGKDPdh1ndTEkpEcBABlVD/0P26ZIoo7sGRBdbdhGKNb9Ge3z7KboM+VuHZ2IN2
         wPV1P2mn6D/rk3Ihm9exN+DBBgSo6LMfo+Ili1hNenVeUOWi5oCGuwOeD3ra3pCT6RqP
         jtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779912614; x=1780517414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yowAEUOtQuzWZAIQXcwy3+wvBYyr2OnsXsvl8HFebjU=;
        b=KdrVxOa2fOun3QWnGZxfPJM3IUp2Movu4bBmoCsU1H/QRSjdgXOw/5gtbYifvBNXGQ
         Xdj3zYhHf/CjtTxEsMOeODJ+xa5jBoILT90gf8DdwXQWjIYh4lbd6flSCHjBLPzA7bsE
         /EuSAQvskmKtBoy8irx9dJIvy8BFzMs1B9spaSg1UcXNh9ygYUsSZAyZl8VLmsJ5nfO1
         qJDVBTME2CfA/20pC+TVRTKRiDXZzYd+NybZtypwx0+HS/0C6zg7mETT39loO7i3TTyL
         to3ug/nRrkmyIfNWD/F8R/VlsY/mQA4j+gs5KeyUtHp3sEPw+aExn4t4XjszeC41PKUZ
         eCZw==
X-Gm-Message-State: AOJu0YwZ6SvaW2dY/6sEgzvWPFHUTkcEuK6ibxdqH2QNh3XqeCw36FHD
	97THCQ9wGDW8YzhR6nyUcpzWJOdBVF3fKF5bKrYY4WalZnd3uv2SCVblM9ElgSPf+Co=
X-Gm-Gg: Acq92OHyJjRrINOep7x03KnpfvAW/zBRl/nj9nLO0UpxIQdP0f2AIoNr+twz+87jlL0
	mgOZYnyEAZFZVRWeptXoecHHKWeaQdMk0fwfiB8KdMNaYhTTgw14gWe4wp6zpEwyjm2e2x7k32C
	eQTgPHMDfjAMcJmWxnwZFnSaaPO/pXkyfyUGkHmcskOJjgsDvfrgG1FonfVLPKBEBnJ3COyHnJM
	7BptXZUjl0zEEsOekvAUTT9UlZX9e2eyfyawc1T9w22Tow7YHykhr40sJkhyx/fq7cP6RDpusnm
	jY04EKkCIJf5XUCJ6UnzkCxmgdwxXssmauRr/iSn1hUPvmwPvLe5HrKKY5kK7c5k0dxB+eLacd3
	0m2GMW4TgIj7e3PFy0Pl8KsXcgGPXdZv2nCVHFF4IQIfW1OvXXZQGjgyXk2jdSow/q4zSCb8pvS
	w3cR1RB2kSXfOWGx7dclnBURVfB4oWD9/74DKkBdC8qYdarxxq1+rDC0GowaG0uUlFMmuikp1WP
	XHqgWgTWhQ83Ai42NsyqVM=
X-Received: by 2002:a17:90b:5863:b0:366:479e:63a5 with SMTP id 98e67ed59e1d1-36a676f5008mr20487157a91.2.1779912614533;
        Wed, 27 May 2026 13:10:14 -0700 (PDT)
Received: from wakbuild.c.googlers.com (27.117.125.34.bc.googleusercontent.com. [34.125.117.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d9416csm21875253a91.3.2026.05.27.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:10:14 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Wed, 27 May 2026 20:09:50 +0000
Subject: [PATCH RESEND v5 2/4] i2c: designware: Convert PCI driver to use
 shutdown hook
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-dw-i2c-v5-2-3483057f8d67@wkennington.com>
References: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
In-Reply-To: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Convert the PCI driver to use the new i2c_dw_shutdown() hook, allowing
the controller to gracefully NACK controller requests during system
shutdown.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f21f9877c040..ab21d4414681 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -356,10 +356,24 @@ static const struct pci_device_id i2c_designware_pci_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, i2c_designware_pci_ids);
 
+static void i2c_dw_pci_shutdown(struct pci_dev *pdev)
+{
+	struct dw_i2c_dev *i_dev;
+
+	i_dev = pci_get_drvdata(pdev);
+	if (!i_dev)
+		return;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		i2c_dw_shutdown(i_dev);
+}
+
 static struct pci_driver dw_i2c_driver = {
 	.name		= DRIVER_NAME,
 	.probe		= i2c_dw_pci_probe,
 	.remove		= i2c_dw_pci_remove,
+	.shutdown	= i2c_dw_pci_shutdown,
 	.driver         = {
 		.pm	= pm_ptr(&i2c_dw_dev_pm_ops),
 	},

-- 
2.54.0.794.g4f17f83d09-goog

