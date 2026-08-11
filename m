Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A43876B5
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461914; cv=none; b=eYWCAO1XZ3H8hXML+cJddNQx7XYeWmsLJdonrDsbLpqA802EGij009jwwuYrXaAhtAi0r5C+IGamUOS96z6gkiZxopRN2RfYbeV/Ex4ShiPL7qjXo/GhEBbCn9qQMtKO4xhQznB0n90EzKDMSPokLCJuej2mTWrFoLuTcp9+Byk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461914; c=relaxed/simple;
	bh=9zh0rWyRasPTKX6C/jp7BoJyZWBGuh3aHojR6LfaIt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucc8MEnLaXcq5Z8NY5PaXFW4Irr1KfkPra4gsTf4ourMauwWPBtojfL9nz/f1UQPW22Q8w8DFhP06lRsFI3U3XxNXmtGqYIp9n9Ivm3wjDeMJDezj6Kob+12QjQ8DDO5a2z88qDj8ZSu6TrKCu+C+pi+smjUclmOmLGEjVRUMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E27Cmsqs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E27Cmsqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786461913; x=1817997913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9zh0rWyRasPTKX6C/jp7BoJyZWBGuh3aHojR6LfaIt8=;
  b=E27CmsqsGenGonAk1TJSvxdLCJAQ7sFO9MC9KSMgm2e+VglljGCwh/7T
   GBeiDrP4FbTPylXz08wT6yHDCUVCL/dOyGGVxNq/QwgY61oTduGuL4iWk
   SxpV68xtxtk3/1+pfJWUlgD8BZLUTqe7TF/kvphimQBmCLUAtNvXqmGrD
   wBoXVDMLvqs296QO0zWJwjkZVHQ2jt3iV65dIOuOpdB58kCpJdpADfK23
   2ABStHLvNL8bENED/wp0yB6yoVWtF39PqiP7GebQURybyKfFgnU/pNI1t
   ojShhPrRinAcNZTpMbufMO7O8OjQc001k6AtjpaQZeN1iOuC7St2efynr
   w==;
X-CSE-ConnectionGUID: AmDGvHx1SgS5ftQuTfyoFg==
X-CSE-MsgGUID: wGwiNxReSZito2H92pHgDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87211473"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87211473"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 08:25:12 -0700
X-CSE-ConnectionGUID: FFCgBkFfTjS0QiZV6hUTjw==
X-CSE-MsgGUID: 3WEcY0wYTpa4xiINltd0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262054082"
Received: from slindbla-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.215])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 08:25:11 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C7761121BF2;
	Tue, 11 Aug 2026 18:25:08 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wtoLk-00000001fDh-3rXC;
	Tue, 11 Aug 2026 18:25:08 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>
Subject: [RESEND PATCH 1/1] i2c: ljca: Remove Wentong's e-mail address
Date: Tue, 11 Aug 2026 18:25:08 +0300
Message-ID: <20260811152508.396769-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wentong's e-mail address no longer works, remove it.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/i2c/busses/i2c-ljca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ljca.c b/drivers/i2c/busses/i2c-ljca.c
index 93274f0c2d72..f82336cd1ba8 100644
--- a/drivers/i2c/busses/i2c-ljca.c
+++ b/drivers/i2c/busses/i2c-ljca.c
@@ -335,7 +335,7 @@ static struct auxiliary_driver ljca_i2c_driver = {
 };
 module_auxiliary_driver(ljca_i2c_driver);
 
-MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
+MODULE_AUTHOR("Wentong Wu");
 MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
 MODULE_AUTHOR("Lixu Zhang <lixu.zhang@intel.com>");
 MODULE_DESCRIPTION("Intel La Jolla Cove Adapter USB-I2C driver");
-- 
2.47.3

