Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E92D9484;
	Thu, 18 Jun 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789676; cv=none; b=O1yE65HfH0xU50QNBrSBv4WGLPAf1LHoX9dhTJlSaodU7cwWzNPOGeR+JkU957TG8Kb0m+M2CipPOgqdFu+P4XNPmvpoBiE/rAonitHYkcpyOzMLuBXeKBNMX2Fauuqk/EUCtz49dZF3kIEdPnEiuTaNQwTNOj0yzkVd0WnqAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789676; c=relaxed/simple;
	bh=4zXhhm0BMBSqPgGZ9yuBsjcuWV090RtcZX76rGBraw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzHGa3uzv6ht2DVLF2uZz8JuVCd3G/i9rJKYIW9pVBZEE716XqjlxxO12VyNra+wOl55FABpPWlrWoJF4wWa+B8Pi2VSlf75q39slf7QQ4v2eSvopFNdptvEb32P6O5PSoiAmEyNEF+jVPnJC5FLrifnIUZS20LYQgOFV+6LntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDROABMI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDROABMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781789675; x=1813325675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4zXhhm0BMBSqPgGZ9yuBsjcuWV090RtcZX76rGBraw4=;
  b=iDROABMI1h87bjgIVjWEkhWw0yLsMc5OlMlA65WhvMJiFSFyB7VOjGSN
   NFkN3ZX7z/ctDbt7aP5MUES8TdwUYe/ITc0Ld8uAAhhH9lHJ2a0hFmSjN
   ax82mnI46IZpttu0Ir+HKuyil40CLVrV0vSjczmVypQBd+iXL8L0tZuO4
   vJjzz8ker5hwh95phTdiIUeirOQJ9S5oCb3Lfxu49lKTz53UHx2sN9IBc
   ZtN40pjqw0tpeOj5HJen0olNaLWAZhVR/scNspyl+tdFTk7vVK1616pc5
   r7oWmoDXNP2vhnQdZx7L3gzkN+KqVlDMtv3FWzt0JvOq7Y62ASivp9t5N
   w==;
X-CSE-ConnectionGUID: YreYfCpVSI+vSG2R37Gm4g==
X-CSE-MsgGUID: n5qnxurqRIqhXhlLm4lsaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82716097"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82716097"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 06:34:34 -0700
X-CSE-ConnectionGUID: pHU/5p0vRMKdambu0Cr6tw==
X-CSE-MsgGUID: Yqj+Sly2Q4ad5VFHaVCn0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="244010617"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 18 Jun 2026 06:34:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9A12E98; Thu, 18 Jun 2026 15:34:31 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] i2c: davinci: Use generic definitions for bus frequencies
Date: Thu, 18 Jun 2026 15:34:29 +0200
Message-ID: <20260618133429.3214475-1-andriy.shevchenko@linux.intel.com>
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
 drivers/i2c/busses/i2c-davinci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 66c23535656b..67ce39cb000d 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,8 +117,6 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
-
 struct davinci_i2c_dev {
 	struct device           *dev;
 	void __iomem		*base;
@@ -760,7 +758,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
 	if (r)
-		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
+		prop = I2C_MAX_STANDARD_MODE_FREQ;
 
 	dev->bus_freq = prop / 1000;
 
-- 
2.50.1

