Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56F23E342;
	Thu, 18 Jun 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792151; cv=none; b=I30mdBaPdwXmGVUQufqGlNwrhTltiCX6INeF/Ug5P2iLmQQVJYFSGsOzga4wpFmLNOvhwzfh6uyKbZepLNFet5BuOdusCCr2DHqH/0YeUoJ+9xZvG84WplkX+QC+H4BtOgFep+dLMMvZvDPrc8n9B8MhmwG7NLBi3aErmUzGRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792151; c=relaxed/simple;
	bh=vddAy5ljJpgZGzhYxM8Hf+nvKfKFBS1dXxFLfhxfAA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OW5VEKtW9fICIIhIjYbRy68v1o+aVskxLfkl+I4SRexadcwaPKkWCnHqXVMP9a/1DAe2xefmDbNBM6Xq97e6JELRSiRohnlq9ZrsleYFt7FwbDjosD1RqqwabSe+ak8yD4yOIEHhM1NxCLuP26ni6wD56zqJmy7SV0Q8i+hvjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkKtuEn/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkKtuEn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781792150; x=1813328150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vddAy5ljJpgZGzhYxM8Hf+nvKfKFBS1dXxFLfhxfAA4=;
  b=QkKtuEn/hCSXl8RrPysE6hsHokG6Pyn7IDFDUQfmwBgNqL4Xilri5+D3
   +HG5+54EYHVFspx8hIuJV3P3T63Dm5ePmdZeC247IJVbb+vWFv/5puWoN
   UoXwuqnOJemu2FE1JgoGHPGj015zac5whfucJcdDkoq6TIQrKpPu8BNV+
   udczyHnrmEm0Zd7+vrsk4nKhJBuxqWb3BLVlT9DB5cWKTfpNwgsfnkZoQ
   rdeuLXJe/IArNHLzFrpv9GfOnXSz6NcseWNQhvRGI3FPVMrVfGnJRYD9/
   FEqKyZJpo0O880Jb53HWrSqZ13wAvugU5t48tmFsAprT0ArkPD/8XPAlQ
   g==;
X-CSE-ConnectionGUID: RqmMvdQbSEmGAdYS4I1bnA==
X-CSE-MsgGUID: TUgTaJX1Qu+XTEXLntiiVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82629000"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82629000"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:15:49 -0700
X-CSE-ConnectionGUID: H4ApdHrdR5+cHJwOz79v2Q==
X-CSE-MsgGUID: tIIyp+oETFCWhpnOgiAzNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="242002044"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 18 Jun 2026 07:15:48 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 54EF498; Thu, 18 Jun 2026 16:15:47 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Richter <rric@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 1/1] i2c: octeon-core: Use generic definitions for bus frequencies
Date: Thu, 18 Jun 2026 16:15:46 +0200
Message-ID: <20260618141546.3241531-1-andriy.shevchenko@linux.intel.com>
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
 drivers/i2c/busses/i2c-octeon-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.h b/drivers/i2c/busses/i2c-octeon-core.h
index 32a44f2d6274..aba81477d7d4 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -235,7 +235,7 @@ static inline void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 	octeon_i2c_writeq_flush(data, i2c->twsi_base + OCTEON_REG_TWSI_INT(i2c));
 }
 
-#define IS_LS_FREQ(twsi_freq)	((twsi_freq) <= 400000)
+#define IS_LS_FREQ(twsi_freq)	((twsi_freq) <= I2C_MAX_FAST_MODE_FREQ)
 #define PCI_SUBSYS_DEVID_9XXX	0xB
 #define PCI_SUBSYS_MASK		GENMASK(15, 12)
 /**
-- 
2.50.1

