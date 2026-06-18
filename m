Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF33ECBDA;
	Thu, 18 Jun 2026 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792031; cv=none; b=sCr0erkQTfcfdnQ8wKm+VNwrRadDs7/l2u3MaD1Jt+GFZUy7ij0zdcm/mORax1eK+0eYNd+Zmojw/A5Ybiy7LMmp8T6ZOVUOWaGnHh/gofHotNgh/bQYL9fwh56xw7VEDO0jVwrblNOkEznorVGfWXsUw5VO5HrHOUEXZg3op0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792031; c=relaxed/simple;
	bh=c35aNIkV5X0e2CdvOHzOzzA2KKJcqxXs0jF4rkgX65Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E56PU9ccIdrgvJS4yENgjiF9WwgP+R7MQuSAxVnxrb50rL1WYbMDHokA5OEFrq2n1V+vzGs7trdfmmIk2MCAZATGVQLALke0qMPbu6l1CBYaMJSR3UYUmhJvSyh4zcQ+Z7WGRHEIMt0Yb+j3b4Jl21pdHzv9wX4fpIQzu+/feHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPg7Or6Y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPg7Or6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781792030; x=1813328030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c35aNIkV5X0e2CdvOHzOzzA2KKJcqxXs0jF4rkgX65Y=;
  b=UPg7Or6Y8N98Bw1rzOahlx3RJrPkZirEoKWe9+BqccSvTsRIwh1tIiCd
   yvGyL+M1jLwuQ/0yi8kWH2RJBq6ExwpcIPN/Du5bpniucAPYqk8WA8sel
   zBQWJGNXJ5HValUrLtxinfuv0yYYALj4RG/Qc6sAbbmTY3m74kdCRt0Qo
   8kmQtVd2TKqtEMjqfikUpy4E2DETLVrc1DVY8l09APCbSCUjnYWg5anUr
   uzFfP6G+TodozN4wSfMs7seDjl+LWcHPxvUKCk0upgMB/BGdkS9MwmBlr
   uUGC7prmfQTT0j5GNIbpSWEmlNKKldjdGWTzzzipYOBssv+7J91kybNby
   g==;
X-CSE-ConnectionGUID: ydHFdYI7QEOip/DzMyyuiw==
X-CSE-MsgGUID: c56gQPRZQxW5xkl6GiFqPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82719416"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82719416"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:13:49 -0700
X-CSE-ConnectionGUID: F7y8i78zS2mHJ93NEJ+6iQ==
X-CSE-MsgGUID: fc7aJJkhQfGFgedu5qILvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="272456743"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jun 2026 07:13:48 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1E15F98; Thu, 18 Jun 2026 16:13:47 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daire McNamara <daire.mcnamara@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] i2c: microchip-corei2c: Use generic definitions for bus frequencies
Date: Thu, 18 Jun 2026 16:13:46 +0200
Message-ID: <20260618141346.3241286-1-andriy.shevchenko@linux.intel.com>
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
 drivers/i2c/busses/i2c-microchip-corei2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-microchip-corei2c.c b/drivers/i2c/busses/i2c-microchip-corei2c.c
index c8599733633e..330e150ef6d5 100644
--- a/drivers/i2c/busses/i2c-microchip-corei2c.c
+++ b/drivers/i2c/busses/i2c-microchip-corei2c.c
@@ -565,10 +565,10 @@ static int mchp_corei2c_probe(struct platform_device *pdev)
 				       &idev->bus_clk_rate);
 	if (ret || !idev->bus_clk_rate) {
 		dev_info(&pdev->dev, "default to 100kHz\n");
-		idev->bus_clk_rate = 100000;
+		idev->bus_clk_rate = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
-	if (idev->bus_clk_rate > 400000)
+	if (idev->bus_clk_rate > I2C_MAX_FAST_MODE_FREQ)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "clock-frequency too high: %d\n",
 				     idev->bus_clk_rate);
-- 
2.50.1

