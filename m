Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371173815C8;
	Thu, 29 Jan 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682887; cv=none; b=cUCplNCfrKL2RkzisrPx8TlWVovT6OgVAPdcWo3vU9kBLDb8lXdJlI2cU5XQ1+eULSWYlU0AKhh8Vx5su0gKHO97+SXEgvmc5t8attw1f7RFSiBjleyWYjl9kl0cDZ3mEvK2kafqs1xdjp8BurJxrlXXyYwUtX1P+i09TICEEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682887; c=relaxed/simple;
	bh=sVvOe3FlT8omHswH4hGdbiPWJloLkYAIt6yvTfVgigM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnptwnCSeTuRrA7buK2VRVClANLrO+42zjTnpjTrXSzRDKmqWCuC1IKppUj9TZ6q2n5eku/rgz/1//nx70su66xgFX3qqG93lEFx66Zsse7phQNKFuEsacvqFgO/YDXk3XmU6B496Mhi7+TNaoa5pqHMyBuY6OMR2FGKrBMCdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pk+TLQPT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pk+TLQPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769682887; x=1801218887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sVvOe3FlT8omHswH4hGdbiPWJloLkYAIt6yvTfVgigM=;
  b=Pk+TLQPTG9bRqYuRrjvsgwur4/KjtoCHtdeKh1vkxOLAfD7TuDCBUAnq
   oDPlq01PwsfrGwZcU+bWblR0C7gLjgv6bJXPQSBZDPKybUKfoHCBb2k8p
   iGpvuGff1I9LYJaBtPOP30sVBaTgXhHKscdq9F3jWtxNEgqDa5Qf6/6BV
   e/R0wVz0jMNjtBATkyqwv9AI2QA4tJn1jcyZqz4+iTJUW/knlqcXyiIDW
   71dCHEa0PVEd2mzvHFQGkyqjgWenHm8HLPBs3rVGOdl8nvsICG6yw5KtH
   GpGxj9OU9y9F9U2DavTAOaVIHe/7XSljT7R2BRhMcGgphyocfnj7D5I2F
   Q==;
X-CSE-ConnectionGUID: 7WvkQ/6qQJKYNGxHW58Hnw==
X-CSE-MsgGUID: Iagej9TCRnejWLYZXsBOgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="93579119"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="93579119"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:34:46 -0800
X-CSE-ConnectionGUID: tY1glmQ2Rn6RKQ1lQkppNw==
X-CSE-MsgGUID: Cm6iuc0ARIKLNAaaq3Y/7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="246161931"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 29 Jan 2026 02:34:44 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id ABE4598; Thu, 29 Jan 2026 11:34:42 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Pratap Nirujogi <pratap.nirujogi@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Bin Du <bin.du@amd.com>
Subject: [PATCH v1 1/1] i2c: designware: Remove dead code in AMD ISP case
Date: Thu, 29 Jan 2026 11:34:38 +0100
Message-ID: <20260129103439.187478-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The I²C bus shared with P-Unit is Intel only thing as far as I know.
The AMD ISP driver has no relationship with P-Unit. Remove dead code
that seems copied without much thinking.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-amdisp.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
index ec9259dd2a4f..c48728ad9f6f 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -18,9 +18,6 @@
 static void amd_isp_dw_i2c_plat_pm_cleanup(struct dw_i2c_dev *i2c_dev)
 {
 	pm_runtime_disable(i2c_dev->dev);
-
-	if (i2c_dev->shared_with_punit)
-		pm_runtime_put_noidle(i2c_dev->dev);
 }
 
 static inline u32 amd_isp_dw_i2c_get_clk_rate(struct dw_i2c_dev *i2c_dev)
@@ -79,9 +76,6 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
 
 	device_enable_async_suspend(&pdev->dev);
 
-	if (isp_i2c_dev->shared_with_punit)
-		pm_runtime_get_noresume(&pdev->dev);
-
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -130,9 +124,6 @@ static int amd_isp_dw_i2c_plat_runtime_suspend(struct device *dev)
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
-	if (i_dev->shared_with_punit)
-		return 0;
-
 	i2c_dw_disable(i_dev);
 	i2c_dw_prepare_clk(i_dev, false);
 
@@ -161,9 +152,7 @@ static int amd_isp_dw_i2c_plat_runtime_resume(struct device *dev)
 	if (!i_dev)
 		return -ENODEV;
 
-	if (!i_dev->shared_with_punit)
-		i2c_dw_prepare_clk(i_dev, true);
-
+	i2c_dw_prepare_clk(i_dev, true);
 	i2c_dw_init(i_dev);
 
 	return 0;
-- 
2.50.1

