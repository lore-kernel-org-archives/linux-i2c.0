Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.205.14.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181304;
	b=olytr/ALaLeLAk+IPD8xUcGXoD1AjkJt/ozqQVEBLJMpKEqHsm1/12JDf8Wwh3HkMGYu
	 Pa0VNVprtSKKuZGdjusBkHWd1vNJptHGxJOFBTx4hRpOYQrv5BQVM+4FHuF+QpIc9pQ2r
	 WrhuXH3UYES4el0jh58BiQLibDtmyDtNmoN8gntua1DotfI0bhz76015NaY6s3GYneDYY
	 xyPa1z6VZ72y//Oj8+nOpJ7wY+o9UXiAv/SOZ+DLG8GnkdRE+BclhqIIdJ7H/1aJUd94J
	 pzQjCcWZj5aexjJOlFczF8XDaQF8b2TqpwwmGhtjqUNMJ+/mxLr3aDUhwwVQYmmZuKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181304;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8jrFjvFHOFHsErCDesl0ZRM1ilUy1pTb0EYlRwMOlzA=;
	b=GFNS0zFQ8w3HXTKtINEU4QLbl1sHa0MBgTj3Q0XhdEqtt4qHFPwidXhgdK9FluNv3xJC
	 iriIjOuqhxtCAuT9nVgL+sj47RUigl4ifpc38yruyQDvQgvqqH3ETrNK5wwov/Y6hCKRN
	 7z2eUG9r/ABn1iuzGPu4D42w9JAjUfIkm4HTZEHvuE0r808oGBSkl6MonXFwALFiOsmwW
	 t+CJAMx1H5PecDaYMwHnSZ+2IeOuHdGaw5Rg5Jzh3KRBgjCcFXWi3KPnDX6zLXWTkNyJw
	 KMOxYKArvQKexVCwhlGpbV+E8nipSGCAteq/8luh8NsxPDMLXbzMaMjRAlP+XT9mHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gpxsee.org;
	spf=pass smtp.mailfrom=gpxsee.org;
	arc=none smtp.remote-ip=37.205.14.76
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E2606A326
	for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 13:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D3E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id C78DDC093D;
	Fri, 20 Nov 2026 14:28:18 +0100 (CET)
From: tumic@gpxsee.org
To: Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 1/1] i2c: xiic: Fix broken PM suspend/resume
Date: Fri, 20 Nov 2026 14:27:31 +0100
Message-ID: <20261120132731.9920-2-tumic@gpxsee.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120132731.9920-1-tumic@gpxsee.org>
References: <20261120132731.9920-1-tumic@gpxsee.org>
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
the xiic HW on PCIe suspend/resume.

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
-- 
2.56.1

