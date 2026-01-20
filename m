Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADB2FB622;
	Tue, 20 Jan 2026 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914462; cv=none; b=Mf/HWTNVNFsIBZNIxniVrtkqvsoncPp+dXdwvxH1E5q3tqpqvngOoA02oCClZZZatR7REtkJlIcNiMLgiklP8/TkdM/gFIOVCQlaoD+B/SHqor3bs/xMozx8ZEiFPLGyrJ5GO8E1C4b7OVTR4uwAPDh6Mr+YlVH9DY1ooIXJGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914462; c=relaxed/simple;
	bh=GYaSpJqSkQK5J5AzRfILV2ps+ls0XxD97eujGg5yAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRZAVoTcy2yfHFtaThYMO5iQ9qEmQmfu10UT6Rm+RMjtrt+BviDXgs1OYrUR239xOhuWZCb2D1WmpgQNnY2DLHpxPvAzWROtTXk+Qgjvd2TjGRTXEqgVLcSRM1PDjOQ19AcIk/x7ujyOoS80i/wRnCyH6UZFhDmqrTAAtQQSPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNYmgEY+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNYmgEY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768914460; x=1800450460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GYaSpJqSkQK5J5AzRfILV2ps+ls0XxD97eujGg5yAPE=;
  b=eNYmgEY+LUIDNbMgITiAw+umDmLs3cnxQZ+awsK72/8evkYD1KQVOSZK
   jtb8awo/6tpFDXoBGtfWHa3MSPn/X3RNrMV3L6ga5Kf2DuGRUbeaMCJny
   CxLynxGtEiwZLTIC5lzJgwONsi3X3CRGMIQkMEnf1K7agohZUT9k9fPz2
   w62Pa/C5G0CvMJa597Y8OL9DmSrjNWNw41U3Fo0P7hlUGeO8TAy++XzRN
   PzI9wxZj3+qDoMcZWoXLYUbBAyySBM2Mo48mGZX4PRb5CeItBlwzHz0xS
   j/8C3t74qdXzv5fMDq/F8JXTgIG6Il5clUL30KjjL704hlazUvHMhmD69
   Q==;
X-CSE-ConnectionGUID: A6nvHF8fRAa+XwoMiWFrxw==
X-CSE-MsgGUID: Pr0w/9VFQXq9fiIW3irlIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73748534"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73748534"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:07:40 -0800
X-CSE-ConnectionGUID: gVbkaxPiT9m/CpesJZyJJg==
X-CSE-MsgGUID: +wK6q3rVSmeXMvkoC4f6Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="229053360"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jan 2026 05:07:38 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] i2c: designware: Remove an unnecessary condition
Date: Tue, 20 Jan 2026 14:07:28 +0100
Message-ID: <20260120130729.1679560-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>
References: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing also the high speed timing registers unconditionally.
The reset value for these registers is 0, so this should
always be safe.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 1a934283f650..3d78abd0e965 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -396,11 +396,9 @@ static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
 	regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
 	regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
 
-	/* Write high speed timing parameters if supported */
-	if (dev->hs_hcnt && dev->hs_lcnt) {
-		regmap_write(dev->map, DW_IC_HS_SCL_HCNT, dev->hs_hcnt);
-		regmap_write(dev->map, DW_IC_HS_SCL_LCNT, dev->hs_lcnt);
-	}
+	/* Write high speed timing parameters */
+	regmap_write(dev->map, DW_IC_HS_SCL_HCNT, dev->hs_hcnt);
+	regmap_write(dev->map, DW_IC_HS_SCL_LCNT, dev->hs_lcnt);
 }
 
 /**
-- 
2.50.1

