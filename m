Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB2368287;
	Thu, 18 Jun 2026 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788194; cv=none; b=JN6sVf3V7r1m/99a8fx7kU5DKjMLjJoiJTf9X0yZcOsVgZaJmNe+AV1AxjlQnnUO2dgImAonv8PtL9CY5xfpVMzk2pI41e+Bu64ZaxqkHW5R61wryW2BOHGxaZt//RDipYmaiXrBs1Wlm75yj3xTdxn9UH1xCpte1qo+0m1q2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788194; c=relaxed/simple;
	bh=t2sY6g9hByHB2M8K2YsDB0IUJTaJLj8nTbSpTHyibdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpTonO7fiIdmX0DOGa32t05CrewfCuqa1qfbsqCDFw/nLs6Hm1d7wdDVaEynUUlYN6oftDTs077gAoEYTTFQoOAN+zFTXuAXpTd1KRP2LipeWaCXgHpo/T/kXMkfmZ6TbweFD7sYFfCwji3sV/wkVrT2staOPsG9BKOnHTRjy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fj3ZCJTP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fj3ZCJTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781788193; x=1813324193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t2sY6g9hByHB2M8K2YsDB0IUJTaJLj8nTbSpTHyibdU=;
  b=Fj3ZCJTPWgKqtHd/qX++b9y53JjhoW7haoo36+N6T+lkWBwEobIyNdev
   kjsdGURBjssAAXfCfZlqxsqMV3uZ7xY5hKLPl4wVdNFQMGedPbaBmVKBD
   9VS7D0fIq0eoj6KBiTy/c86r16zhlEuHqcm7VIFI/JYd8Viq2aX2DCfgh
   mPjwn4Hcu++EDQEnms4sOmVldbQZXJqJXNQM0nsAWARCwemkJO73W8TmT
   fbT6rxYK0mzKRHkDkviVeY4vTfN/fvpc2kq10q+5KcfBETY7JMCOND2LW
   q37qAwTTpW8Fh6whi2N2Ggq/A5UqZ+56NtlAfyzw03AXn9FGbxwuvgof9
   A==;
X-CSE-ConnectionGUID: 09LkTn8UR26dqt7nW2mANg==
X-CSE-MsgGUID: ZfwwOH6pS8KFf1URyTI+zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93995628"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93995628"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 06:09:52 -0700
X-CSE-ConnectionGUID: eneU7bW8Qke86wLXSFGiXA==
X-CSE-MsgGUID: 4zllHn5uT5icgldsto+xlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="245990395"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 18 Jun 2026 06:09:51 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BE41F98; Thu, 18 Jun 2026 15:09:49 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 1/1] i2c: pnx: Use generic definitions for bus frequencies
Date: Thu, 18 Jun 2026 15:09:48 +0200
Message-ID: <20260618130948.3199768-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have generic definitions for bus frequencies, let's use them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-pnx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 8daa0008bd05..e1cc2b2bd628 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 
 #define I2C_PNX_TIMEOUT_DEFAULT		10 /* msec */
-#define I2C_PNX_SPEED_KHZ_DEFAULT	100
 #define I2C_PNX_REGION_SIZE		0x100
 
 struct i2c_pnx_mif {
@@ -606,12 +605,12 @@ static DEFINE_SIMPLE_DEV_PM_OPS(i2c_pnx_pm,
 
 static int i2c_pnx_probe(struct platform_device *pdev)
 {
+	u32 speed = I2C_MAX_STANDARD_MODE_FREQ;
 	unsigned long tmp;
 	int ret = 0;
 	struct i2c_pnx_algo_data *alg_data;
 	unsigned long freq;
 	struct resource *res;
-	u32 speed = I2C_PNX_SPEED_KHZ_DEFAULT * 1000;
 
 	alg_data = devm_kzalloc(&pdev->dev, sizeof(*alg_data), GFP_KERNEL);
 	if (!alg_data)
-- 
2.50.1

