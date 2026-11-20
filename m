Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.205.14.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179890;
	b=eYHq0T2X5hEeBF9R10KAN+JYKCa7L4dMhwnRCqXx2WbiYjOBNWhxAvbysZnUYG22OjCP
	 J8wkjLaDIL66SOYLBnQpee1IWf+aJWEsTyzv0fZqfGV+C3IA9k8+eijxqkfL4UblXydDg
	 wpnbJPiStkUx46tzYSpL3mNoQLRZCS/eWZkLv6qcu85+LLamgCaX6GwZdRlyzMGg1RC1M
	 HsPcPn1zl0qoo+vQXBABorjxcnG5E3Tn4mChdvXsq6a2GAD0LUpA78ZaZkXBfNhdTzWEv
	 K6ngwiFEKqL1oNTsjmQA4/k+lOIT5atxVGyqKNJfiCr3bzgyRizmEHfY6E42pRfalpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179890;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GILqxYb8p5yo19CosH6Owa5dDUz944tPztYWV+5Ez50=;
	b=B8EhL0hLb6KkY51oxmCXfW5VmAarvD916RjfVCJ14JDqxC419KpPhE9lslN0ijRqxsc1
	 DC0GtfsHtjPAdY57zkb1ilHc4d/jBnKx6g5RazOnCKsvCuxS3PKhNyA5dO1j35LakfoiT
	 l0OUHcM4m/4axxTKEpR9fl6sKSgMxuqGwXWYaEZWgUDBwdzoK3jgSmP0zAHfUCd06hRAL
	 MC6yeVVkvw8MlJbFL9tR0y4eARuaITfTu+r7yiDsuFKcqAMYZm1J6sG0oQAM10yedoyP8
	 75+PdOv829UXjqpJXK0bwe+IrdR0z5q4Dc+PgP7w2EKzIAZ4rSgrbmUUXu5RNPQXjMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gpxsee.org;
	spf=pass smtp.mailfrom=gpxsee.org;
	arc=none smtp.remote-ip=37.205.14.76
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC3606A320
	for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 13:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EFC3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id ABD95BD05F;
	Fri, 20 Nov 2026 14:04:46 +0100 (CET)
From: tumic@gpxsee.org
To: Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: =?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: xiic: Fix broken PM suspend/resume
Date: Fri, 20 Nov 2026 14:04:14 +0100
Message-ID: <20261120130415.9262-1-tumic@gpxsee.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Add the missing PM suspend/resume callbacks that properly reconfigure
the XDMA HW on PCIe suspend/resume.

This is required in cases where the HW is on a PCIe card connected using
one of the Xilinx PCIe cores (e.g. XDMA) like in the case of the Digiteq
Automotive FG4 grabber card (mgb4 module).

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 drivers/i2c/busses/i2c-xiic.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ab7916745ad3..fc122ceb5631 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -252,6 +252,8 @@ static const struct timing_regs timing_reg_values[] = {
 
 static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num);
 static void __xiic_start_xfer(struct xiic_i2c *i2c);
+static int xiic_reinit(struct xiic_i2c *i2c);
+static void xiic_deinit(struct xiic_i2c *i2c);
 
 static int xiic_i2c_runtime_suspend(struct device *dev)
 {
@@ -276,6 +278,27 @@ static int xiic_i2c_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int xiic_i2c_suspend(struct device *dev)
+{
+	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+
+	xiic_deinit(i2c);
+
+	return 0;
+}
+
+static int xiic_i2c_resume(struct device *dev)
+{
+	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+	int ret;
+
+	ret = xiic_reinit(i2c);
+	if (ret)
+		dev_err(dev, "Reinitialization failed.\n");
+
+	return ret;
+}
+
 /*
  * For the register read and write functions, a little-endian and big-endian
  * version are necessary. Endianness is detected during the probe function.
@@ -1610,6 +1633,8 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops xiic_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(xiic_i2c_suspend,
+				      xiic_i2c_resume)
 	SET_RUNTIME_PM_OPS(xiic_i2c_runtime_suspend,
 			   xiic_i2c_runtime_resume, NULL)
 };

base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
-- 
2.56.1

