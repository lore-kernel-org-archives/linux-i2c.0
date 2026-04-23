Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B61A239A
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905568; cv=none; b=uoBM65Prd4QO0/mQsxWTm8JlC9OJYKh23xfNmRwMcKR7TbTqJ2kRvjl8qbxM3PXWei5/3cNgEttDrytMuVmXLJ4ptBd31IKi1ZWQxO2LttFwtva9IOgbrUwKFbqAGT9VQJtC+N9xqICZ7jHQlrIFN3T0d7wKBR7SF8mu4jaAzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905568; c=relaxed/simple;
	bh=4HN/ZYFi+2HufjcFzqZH57HWeOHKbnG4l5nDjw72cE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDrmo4hxitZVt2J9kGwZ9iHyu/6ztQp4d1b3iB3cBhcUelXzvNB1/Cy13KPiGA30JJs7Nb5Ay7qLbWUX8UDSqDwxjWYyRs3nu4QLVdfPsQ4yvd0h3qYYUfWxhZz50YE4oxmgFd34xeWMpCuDoq96j9CSUQdxiX5elmfqrYnplxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=jENFxHlz; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="jENFxHlz"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c7212836bso16011821c88.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 17:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1776905566; x=1777510366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YL5uV0/k35OGHfrt+bWZEtJfKssUFFLJXG7HXn5YnTU=;
        b=jENFxHlzQhQMIbxeJBmtiJQZneZknVaeogmUQDYhX/phPAeM53/Fq7oMhGfG7JfCuF
         UM4KD/eEOCQyqTjS6tMAi50B11hSzZobcLTCAcbNy/TghH/+2yGhyh/tGh5bV0lJg0j1
         q/Ryme38xLPGtvKSN8QavZGHLRFSnA1GPRfpwDkvkR+62fvAzPHnaXUTUYI3dRv0ezAY
         +ABUe9AsW0CLVSt2DA+XpVJAfGsAIQa+ADHNzHoZ47/0V1DDXBg5hB4Bp0RH6fioSNI8
         +ZSELTS989GkeWU53JyQfDqvt52L8aRu2E+rWiuEWqp00ONvzNB8wI+KEZvuW+u4/IIO
         bJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776905566; x=1777510366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YL5uV0/k35OGHfrt+bWZEtJfKssUFFLJXG7HXn5YnTU=;
        b=CGuv88i1ddBARDB8xt46VPdxSMhQe7nn817nhhdO5zzq3IQDtgCS4gFamHI1k5UxQw
         YbCyZwhslT7PR3NYZSnKS01iSlMMgEWLxhv21dmlOjNFjJevzGrFfdCZNCKHe+kTGBps
         Lg6b70dg0o7rkAcQwF9y8h4KBn/dC66WpXKXj0BBu3xiNC7oxc++dPlTOViWjq8CBQuX
         ZDyi2NPCA3b90a/FfLL7K3JZRB6thlj5kmEfLpJ9oDrviA+ACJEp+CtnP9xfPfKHfEfr
         sehqsL/OaoVotjFSqnCB5iLxftcwxd4KADT16UFZlt8RAZHAhZbXi4o3MvGk7sTLH7h/
         XfRA==
X-Forwarded-Encrypted: i=1; AFNElJ/e8YUPKxAs8/cTr9iW3by78WrnUgr78+9GJtUuWd+0MKJUKM6AUaMf7muCC3eR4jWTuiWTaZpyPc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPhIAoETcFDdoY+6isNuYwdTrXX+U7MEsYtA+cIjB0/YYWqNW
	MJMxvjecNo4eFAWpM3vTjiQazTd931eqUqfq1Kf0+2iCyLKWdnhFmbM5cKrDMtdMDG0=
X-Gm-Gg: AeBDieuxgL6qV2uSHlEh4ft9Wh6TQEa9W4QV7Vp/v6YhpwRqEBO5tOE+DOH5UGIQi03
	zWT5b2B+bNkFRmK4uayzk5Yl5CPyDw/4NDlmByxJLFj0pbFRkDGP5IRetr1geGIZvFAgsxO/EWj
	iHJSftMkd09PzAJHJyT5m97CczwL8ArXUzUGjtbcovz1GFWo8lkmUD0X2XJ0pnWPsFtCVljHdUQ
	P9O2RC8Na6jS7+GbeTMpcclEL6ncWI+WvbjZgXU33NnPQxeWKtBbFNDHuxsQeoNDTZKZX6ZpO9A
	YrZbBB8sZTnz6mooYpI2JB2KMiRGwlMpNA1KRXfOs2fQrKvOyTRLPduPd1FeErfoBDAh0Xw5XSW
	m+xF21NxNQuEVdXbWW0FmH1o9fnjeHZ72sOlBkZchVP5w7vRuQkm0YE8/wK2O5fdk5+sYVL8o+g
	IdGJmB21s/j3kEhkRPUbfaCIQKfXXP9tQeFIIKkPpX086x5dOGFB8MNVdoMxwHtTR20RUztetWx
	oTAUvM/GQrhpyXHFFGdMF9pbQ==
X-Received: by 2002:a05:693c:2b04:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-2e479215120mr14232258eec.26.1776905565557;
        Wed, 22 Apr 2026 17:52:45 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2a00:79e0:2ed2:c:c318:833d:66c6:43a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm26139970eec.13.2026.04.22.17.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 17:52:45 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: "William A. Kennington III" <william@wkennington.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: designware: Handle active slave and shutdown cleanly
Date: Wed, 22 Apr 2026 17:51:05 -0700
Message-ID: <20260423005241.89054-1-william@wkennington.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260423002838.83171-1-william@wkennington.com>
References: <20260423002838.83171-1-william@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the I2C master attempts a new transaction while the slave
controller is shutting down or restarting, it can lead to bus lockups
and system bootloops if the hardware enters an inconsistent state.

Address this by ensuring that the internal state machines are properly
cleared when disabling the controller if slave activity is detected.

Additionally, add a shutdown hook that gracefully sets the slave
disable bit before disabling the controller. This guarantees that any
incoming requests from the master are immediately NACKed during
shutdown, preventing the bus from hanging.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
Changes since V1:
  - Fix description footers
  - Fix emails

 drivers/i2c/busses/i2c-designware-common.c  | 32 +++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-master.c  | 32 ++++++++++++---------
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 15 +++++++++-
 drivers/i2c/busses/i2c-designware-platdrv.c | 13 +++++++++
 5 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..31394d8fe612 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -633,6 +633,14 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 
 	abort_needed = (raw_intr_stats & DW_IC_INTR_MST_ON_HOLD) ||
 			(ic_stats & DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY);
+
+	/*
+	 * If we are in slave mode and there is activity, we should also
+	 * trigger an abort to clear the internal state machines.
+	 */
+	if (dev->mode == DW_IC_SLAVE && (ic_stats & DW_IC_STATUS_SLAVE_ACTIVITY))
+		abort_needed = true;
+
 	if (abort_needed) {
 		if (!(enable & DW_IC_ENABLE_ENABLE)) {
 			regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
@@ -1028,5 +1036,29 @@ EXPORT_GPL_DEV_PM_OPS(i2c_dw_dev_pm_ops) = {
 	RUNTIME_PM_OPS(i2c_dw_runtime_suspend, i2c_dw_runtime_resume, NULL)
 };
 
+void i2c_dw_shutdown(struct dw_i2c_dev *dev)
+{
+	unsigned int con;
+
+	/*
+	 * We only need to handle shutdown for slave mode to ensure
+	 * we NACK any incoming master requests. Master mode cleanup
+	 * is handled after each transfer in i2c_dw_xfer.
+	 */
+	if (dev->mode != DW_IC_SLAVE)
+		return;
+
+	/*
+	 * To quickly NACK the master during shutdown, we set the slave
+	 * disable bit while the controller is still enabled.
+	 */
+	regmap_read(dev->map, DW_IC_CON, &con);
+	con |= DW_IC_CON_SLAVE_DISABLE;
+	regmap_write(dev->map, DW_IC_CON, con);
+
+	i2c_dw_disable(dev);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_shutdown);
+
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9d8d104cc391..8b422249acbd 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -393,6 +393,7 @@ static inline void __i2c_dw_read_intr_mask(struct dw_i2c_dev *dev,
 
 void __i2c_dw_disable(struct dw_i2c_dev *dev);
 void i2c_dw_disable(struct dw_i2c_dev *dev);
+void i2c_dw_shutdown(struct dw_i2c_dev *dev);
 
 extern void i2c_dw_configure_master(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe_master(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index de929b91d5ea..5b3505faa352 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -785,19 +785,25 @@ __i2c_dw_xfer_one_part(struct dw_i2c_dev *dev, struct i2c_msg *msgs, size_t num)
 	 * IC_RAW_INTR_STAT.MASTER_ON_HOLD holding SCL low. Check if
 	 * controller is still ACTIVE before disabling I2C.
 	 */
-	if (i2c_dw_is_controller_active(dev))
-		dev_err(dev->dev, "controller active\n");
-
-	/*
-	 * We must disable the adapter before returning and signaling the end
-	 * of the current transfer. Otherwise the hardware might continue
-	 * generating interrupts which in turn causes a race condition with
-	 * the following transfer. Needs some more investigation if the
-	 * additional interrupts are a hardware bug or this driver doesn't
-	 * handle them correctly yet.
-	 */
-	__i2c_dw_disable_nowait(dev);
-
+	if (i2c_dw_is_controller_active(dev)) {
+		/*
+		 * If the controller is still active after the timeout, attempt a
+		 * bus recovery to clear any potentially locked state.
+		 */
+		dev_err(dev->dev, "controller active after xfer, recovering\n");
+		i2c_recover_bus(&dev->adapter);
+		i2c_dw_init(dev);
+	} else {
+		/*
+		 * We must disable the adapter before returning and signaling the end
+		 * of the current transfer. Otherwise the hardware might continue
+		 * generating interrupts which in turn causes a race condition with
+		 * the following transfer. Needs some more investigation if the
+		 * additional interrupts are a hardware bug or this driver doesn't
+		 * handle them correctly yet.
+		 */
+		__i2c_dw_disable_nowait(dev);
+	}
 	if (dev->msg_err)
 		return dev->msg_err;
 
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
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..7ff7c1631e64 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -289,9 +289,22 @@ static const struct platform_device_id dw_i2c_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, dw_i2c_platform_ids);
 
+static void dw_i2c_plat_shutdown(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	if (!i_dev)
+		return;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		i2c_dw_shutdown(i_dev);
+}
+
 static struct platform_driver dw_i2c_driver = {
 	.probe = dw_i2c_plat_probe,
 	.remove = dw_i2c_plat_remove,
+	.shutdown = dw_i2c_plat_shutdown,
 	.driver		= {
 		.name	= "i2c_designware",
 		.of_match_table = dw_i2c_of_match,
-- 
2.54.0.545.g6539524ca2-goog

