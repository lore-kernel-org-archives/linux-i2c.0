Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83372DF132;
	Thu, 18 Jun 2026 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792256; cv=none; b=HoGPXEs+IU/jZruzLukztyuz/R1hAfYQltovsjf3HH3o3zlbgmaU4cryQB8uRauYcqWjbHvR5PkpUrSM7hpdTDALpqAgb9Qfcj5GmH6xgohdc2cepV4r0YjAoAU2W0f2aUr0tv0DkK87VtG82axomu28DFlj2saBMO93OxFHpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792256; c=relaxed/simple;
	bh=+VH0Lw0M21tcpHte4wL0B83y4owSz1NJvo/FVcUrwAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AK2zDbIafZMYp+lK7XNvPowDzAzx30huSG+qLgUmjJglpJ0I0T8FMUfewY587NHVVgmUyXisRnkd5WX0CFStQihF7Vl0xglokfxleVL9v3vORa6BPsIvp/vRr73ki7Pjm0PXufnS42QMn00id0qQ/2n/UYxU/Hy5GQ/mktjuznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLEnaYv1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLEnaYv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781792255; x=1813328255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+VH0Lw0M21tcpHte4wL0B83y4owSz1NJvo/FVcUrwAE=;
  b=aLEnaYv1o/9WoKeAtNyXFQjixmdPcR3Q1Yrlil23SMkxTIBGR6FyhBtH
   ZO9eIiIUrSbMiBsuFBAK0ZN5Bjz7ocQKf/tDhBtcdxMFdPwDpyQDTViEV
   8p/dL0VJUOwAlZ+oymxJP4GOQ0Pp0BkBOI6EbgvxqAcWeu+eplFbn0pHh
   KAW8lJbeav82aEd9EKVrFBRERPPlAdKHlU20HHvox0ZKWiWHr7BDqSlFz
   JcU1XZD7TUgbTefW4L7VtUJ36LOl1eA2cUYDthYrkN70SAfhr5bBXKGuZ
   5wHrUuASXX3nzngjAiB5vi3fkPy1DBt3c2BcFIUy0Eyhi+T4nac5SOaeH
   Q==;
X-CSE-ConnectionGUID: X0U/peFQROqSUH9QkGXeXA==
X-CSE-MsgGUID: C8R5EeKHSSa2B6++jakz/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82632234"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82632234"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:17:34 -0700
X-CSE-ConnectionGUID: tvlBX8kmRjm/1HGX1ebZjw==
X-CSE-MsgGUID: IjMkPXYmRLeZEdWGyjwBDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248442871"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2026 07:17:34 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BE19698; Thu, 18 Jun 2026 16:17:31 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 1/1] i2c: nomadik: Use generic definitions for bus frequencies
Date: Thu, 18 Jun 2026 16:17:30 +0200
Message-ID: <20260618141730.3243303-1-andriy.shevchenko@linux.intel.com>
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
 drivers/i2c/busses/i2c-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index b63ee51c1652..404709179d73 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1050,9 +1050,9 @@ static int nmk_i2c_eyeq5_probe(struct nmk_i2c_dev *priv)
 	if (id >= ARRAY_SIZE(nmk_i2c_eyeq5_masks))
 		return -ENOENT;
 
-	if (priv->clk_freq <= 400000)
+	if (priv->clk_freq <= I2C_MAX_FAST_MODE_FREQ)
 		speed_mode = I2C_EYEQ5_SPEED_FAST;
-	else if (priv->clk_freq <= 1000000)
+	else if (priv->clk_freq <= I2C_MAX_FAST_MODE_PLUS_FREQ)
 		speed_mode = I2C_EYEQ5_SPEED_FAST_PLUS;
 	else
 		speed_mode = I2C_EYEQ5_SPEED_HIGH_SPEED;
-- 
2.50.1

