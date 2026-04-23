Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8A1E9906
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776904126; cv=none; b=J7CdwnH8uE16bpm+RMzSWFc4a7HTfSvQUW505Uh13TnaEiewwEmEf++VVN4wSHd3Sz7hDteiVqkK2sFCYixIy2P0gqvxg48hWJLyuj+GN+HZbVV8M4h8zXnbM4ZPiMtXrRx1LKIo1iiAhv+Ak5tnM2fhkYWgn807SgZYiYZRSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776904126; c=relaxed/simple;
	bh=fLuh2yYCliD3/tO4zPDbjuOR6Zrc8covuDSXJPtOtGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMW7BtlUKr6vGimHM3hvlFoH4Rl5IG+v5Qf5IWwmykxA0THNv1NL6/r+iihU60cMHX3ThHZBRgAXq8KJ1owoZlCUyDBN7pmuIUb+UlvxAelrRIslMmhlv3AJJwZlwL5B4tKQrH6L89hRCyeaOyfC1uPL6nPyNb7NVaO1X0n0uOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=qwEMjfR8; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="qwEMjfR8"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2e622a9da9cso7124752eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 17:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1776904124; x=1777508924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8Zq/XP2zPjzoG7Ee7KkAJncAAl85yYbm00SL2RgdzU=;
        b=qwEMjfR8bJ86el3SwemWZsa2zhM9t0AY8OsDuKiHD1F/UHyP/Fn4us8oCmw9I0mhZ9
         hT1qHChA8edPyUOMOrlTcf1IHCE8M3HWnh1fy0l0h/hWzKQDYksQrNFRacsZdHQHGWtk
         miXeqqEmqMuImCK5+7EJQkY/A1h/425tkDrt4J7WzknF544vwePebK0K+17FREOmbMG/
         0AcV4I12hpKOwb5VQz9oPgr2hIB8QDlyaa9z4NtknfDFHe89cU+GbrzSLT1uU9dKGnDN
         Wfb0YaVnxJDuvacmjgDcPseRPu4GyZROwNHgNE0wDFll+iLmL8HjL+N5UHdV+H2OsJP+
         90ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776904124; x=1777508924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8Zq/XP2zPjzoG7Ee7KkAJncAAl85yYbm00SL2RgdzU=;
        b=EOvdJuoiywwkpdAetfYrAS45pGzvcaWlEZ5fXlqd4cnc5i95CuBhxE4L6FjiABLOcn
         W5KhDW6gi4AocW0fs/lHfhLyB6HvAMgkF/SDWMagqAy2PYt8Vatu3LmSG/sDsDfX5TEQ
         I7jowXEtBNhNMPJF18kDkRWHvMSw/X3Qi0m/cUMXb1XPNM4lUg5cXKCRSBzMNHnJuOql
         a8jdv74bvteNsBCs3ZCl4No6yJbCWGIyHPyDpnIxysx532w7vFTt/2eY50HgoOFijKFF
         NzLdfpuQAGkAyoFPqwUGGRJ+59yqBx/B1/M7dzvIcaL/HKX+XXBCn0NJ4kw0xZDswCAx
         c9mg==
X-Forwarded-Encrypted: i=1; AFNElJ/rbpZrb1cvyUql2Kwc0/SRfsWJvRKYie6uci3+MEMSux4K98qHABEO+Wrxwh9kUfpxYkNQ/0OShOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzysAMfNIldyFmUjQsOElJKaz8OSkUswZONQeT626P6Bxj46i+W
	QRzFVJffU/FLIyi9g5ZJNnSS5Wl4pQ8KZ6jJf1Pi0BHoegZexCLh3v6BHEwjzTx90rTDxMFcHEd
	Te7sksWE4sA==
X-Gm-Gg: AeBDietW8zMTP9y9l+yXK5nHYRVDiorX8fnac+ZUWGn+2PSxx/Cyx+W9VasyFRs1TKK
	dF23yAcZIDoAK0gAHkpJW9c9KIRUo+E7Rzl7qEruXOdWsV2VZpT+Vnq3a6lYU7v3CcAWumRw+fO
	Aj9enNgLUtZP6Qw9Ryu6jTsCZ+Y7vBKqepm8nM7loTAyH1BSySQoqxLjIfyx7ozDzQ0himgRIwc
	50zYwE3x49gPK80/Rcy2sxckfCfzTrgTf2bZUpHNra7FzJwbjiRNRgTF4khAjpnqjVVUtXLDnnY
	VXQ36/nS7jK6s/vEoiyJD2u0nS34Tl+dQ5hK/+GpOqAcW361OxCtyjIHv+ImDxafagWqj2+w1bg
	1HdbBfpB96b6ai1ZTJZby/ONFxSWywZ3loFeSmChaf5C8GEaTVykOQkyKsw89s/fydB72WYiE7+
	7Q8mwGI4ZXZpihH9QA5HW/dFUM8XNKmAQu8dgB3qgoF/nNOuNKnM9hSFQduBR4Ih5bJQOYQ/7VW
	bKUbQgrnNr3U4tOCDv4EvKaFg==
X-Received: by 2002:a05:7300:2203:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2e47951a762mr18055125eec.28.1776904124283;
        Wed, 22 Apr 2026 17:28:44 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2a00:79e0:2ed2:c:c318:833d:66c6:43a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d4bdaf7sm24632628eec.25.2026.04.22.17.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 17:28:43 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: "William A. Kennington III" <wak@google.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: designware: Handle active slave and shutdown cleanly
Date: Wed, 22 Apr 2026 17:28:36 -0700
Message-ID: <20260423002838.83171-1-william@wkennington.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "William A. Kennington III" <wak@google.com>

When the I2C master attempts a new transaction while the slave
controller is shutting down or restarting, it can lead to bus lockups
and system bootloops if the hardware enters an inconsistent state.

Address this by ensuring that the internal state machines are properly
cleared when disabling the controller if slave activity is detected.

Additionally, add a shutdown hook that gracefully sets the slave
disable bit before disabling the controller. This guarantees that any
incoming requests from the master are immediately NACKed during
shutdown, preventing the bus from hanging.

Signed-off-by: William A. Kennington III <wak@google.com>
(cherry picked from src/hw/icebreaker commit 2e825fbffc3b20b5148dde046cb56346ffbe301b)
---
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

