Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A72DB7BA
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925707; cv=none; b=eLCptxjJD1LFE/WfrIEenSxRBFFim3rxKaNea2G7KzajuvXpjglN3IV9XNMoJUrFkir3U1uynNwLmeU5RCZq6FYVO4ISfW3QLbSS1n9s5x/C6rDKOIIz/HCKG5sFBKtAFo8Z8z1RjuCw+8d38ZbSBR4ECigBDEpC4JoK4JlM9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925707; c=relaxed/simple;
	bh=GBmG+unHRcZc6mbBhwjzyavT9fsgbW6tBtWkwJpdxtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUhqffMkxEAJmdcDfi/sXyxzzzTXpaTq0cOSjhS3K8ejU9ixENcTN5oV7lOCBZ2iEKyEy2ynqAz2J7bTxKkDC6Lkt7G8rvo0OW1eyhmXrDcI5eXIHc1odm2QzlqBTgGxXUpYC4hk8FcTNMVOZtN7D5b3wJyuycMfXhbC+3cxQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=JWOM4DV1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="JWOM4DV1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3652546e41aso1197263a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1777925705; x=1778530505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nazjXO7pkEvVPqio5XcywQP31C91oLcKtFCF7VL/ScM=;
        b=JWOM4DV1j4C/r//07HhQfKn1ABTgsF/OfugUPPy1CohPmw1PZbx0W3enZxJxdGMdqa
         paG0Rr5EYNG2aymtmGsF3pnMfoxDk0UOTCLlghJ/kgEbVzXkIdQHUbh2wcT92nnWYMdU
         EYEFse0wtxkHUXMUqunSjHyEqEgX2r3g23DPrCG6wlIYGmVgZ9u8i6fQiLv4270wjWKj
         tuKM43lxZbAWw4vd/jsThNAjRVVYfwtPaBJVtbRCgP4QrOcB81MYkf4yxkOth4wIBbLf
         YoKNl8lZ2QqE2gVVG7gJW6ieYQ1Iv1sEq1Dt5S/ydvjHCPgWJe2Z4MjLWyiehVUodykh
         a4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925705; x=1778530505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nazjXO7pkEvVPqio5XcywQP31C91oLcKtFCF7VL/ScM=;
        b=MHQQW29zzYXzlrSV4HhVXs1QEld8BXLEWj6obkGc7STGEfBygAiHYYYNiCv4n6C+3K
         PUwpYfBRnI2zlYtvb7OxU/e4GDsyOJwsqDUEVR1Vv/j1e6/fzAkF0yeBuuuIPqWyGceW
         RBpl3qCebXZ0oIURg2GaJJEZAvqLD3tyD7xeEk0cT4VO8WLsOsZXMSsb7pqxOdD6NcKM
         BzPjJNdDHNCuEDKtAFlXjkZ1hfU9DIvBprIdUdYe2FbUMGBBSBh7bQr0qzO8rL7uzGmH
         ZOaYNV6LHyOW+vZ27X5lRUY9OQkli0z9d5i1jXQlV3b29hYH6rAH6EMv4U7LnZ2dEYq0
         iLFA==
X-Gm-Message-State: AOJu0Yzl0BMi1Uz0wDVcjCUEpEIHS42FFY1kG7basOxmOOBj8ABWA3wt
	bapIDYPkYd1ylJq8dzP5Ihbbw5vPRDpk0HEKig2TdCnCgHi8FkDVfcSoG9sn88h2ef0=
X-Gm-Gg: AeBDieuR+ITlRobt/PPs38Gih/co01fKj0NXRS6CiR1/5XhC82cFDeAgK5MmTDxA1Ek
	J3qaOOgib+BKSZ6SMzlTKooBh41QjW33qpDqlSGk8Y4n2X2N8R/Qe7qHcCttsxD5v9UocHKhske
	ODYpzybGp3tRJDbfzYW62nZUDfYGnF5wkVMVUAsp/UQ8WC1HVFgyIKMPic9Ni/fDkaxLgtFntJh
	a9uLFXtF9Plsr+zIzgFR7gDRXSpPDO+ONuPHYXrJYp22A1y8I3BJWvi0irSz/8dlcYvH3XULLOs
	0yHqVBDwTh8/aXxrkbT03ufMKvC+cGLaljlpJwyLGWlxfssAANWfppnmAberaERt8YievcUSKsa
	FA4AsCLhSTbbxM5qfYBiSqwvs4cQbbjagS6RVnR1mBfMXpXg+JmSm40d5ttOEGD7fhSExHtYqlf
	5jONBv8/wS8rGVvYNLXIzIJMcV+wcCjK/a04e8gv8efHjsufgsZv4PWoszC8Rk+awQKAJvE0cBF
	w7zsRwJBJWRq4Ayucb/BnonnQ==
X-Received: by 2002:a17:90b:2e50:b0:35f:c1e1:a263 with SMTP id 98e67ed59e1d1-365774cc695mr324139a91.19.1777925705477;
        Mon, 04 May 2026 13:15:05 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2aa41sm20568593a91.4.2026.05.04.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:15:05 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Mon, 04 May 2026 20:15:03 +0000
Subject: [PATCH v3 2/4] i2c: designware: Convert PCI driver to use shutdown
 hook
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dw-i2c-v3-2-57e56135d602@wkennington.com>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
In-Reply-To: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Convert the PCI driver to use the new i2c_dw_shutdown() hook, allowing
the controller to gracefully NACK master requests during system shutdown.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f21f9877c040..87074655c0e7 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -356,11 +356,24 @@ static const struct pci_device_id i2c_designware_pci_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, i2c_designware_pci_ids);
 
+static void i2c_dw_pci_shutdown(struct pci_dev *pdev)
+{
+	struct dw_i2c_dev *i_dev = pci_get_drvdata(pdev);
+
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
-	.driver         = {
+	.shutdown	= i2c_dw_pci_shutdown,
+	.driver		= {
 		.pm	= pm_ptr(&i2c_dw_dev_pm_ops),
 	},
 	.id_table	= i2c_designware_pci_ids,

-- 
2.54.0.545.g6539524ca2-goog

