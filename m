Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278E3CCFA6;
	Fri, 10 Apr 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830654; cv=none; b=b0oV8uHcLeFokllWu2JSPeGuSFjvkwTRN4pRpD5AclR5pEGg8aWd0fBof+nOIjd1NmQE8OUbhWmuBrCM5JPShODgtWb69XVTMO57xzpfIkZxGjEo9gYJuktMc1pZGrQUIpP0psDOdyDsXt03zZyuewSQRxs9aF2wLuvRJA8LG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830654; c=relaxed/simple;
	bh=TkhF937qPnaF5uU9J6bvcAMZOLTlVaDAFOlnxS1nKFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeY3pxNCpN956viNTYB+BQ5bDeBM5PWPwOPpSeqkvLl5MXizXFIPMVSx95g0s/RQh0JP+mzXlNLHLRbKhtXMb4eqQCNzas0HRy1WXohtXTi8J5gAH5NdP/kq0crovEMS2NoFSoPEHTrECrsY84pXLIQvoGNMwZNjo1X1Z3Tm4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ingd5Tdm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ingd5Tdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775830653; x=1807366653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TkhF937qPnaF5uU9J6bvcAMZOLTlVaDAFOlnxS1nKFE=;
  b=Ingd5Tdmg26vnOJgK2SOY4zJ+AbYsAR42q6lyFIjxBFeHD6ma/MPMFb7
   CjQ9E8aedg2LnsgXTw/wO1/+P+wNxigH1IbOm/w3AM3NF6FYdBC1Fv0c8
   Od1ERQMWuhvmtkbIo0SdvGXf/WD3W5vUHg6wy6nLOPbR3Dveq5MurM+rv
   m/BBg5laYQpSZJ5vF90YrXLJQEbMVFg/750PWYWmU0wL5NlD8VPRX/N0B
   szO1zz3meRLNShFMOY7QIOszfTKzq/YqqSgHFYik4i5V4qc5d0OtU+2yP
   CXfQXC6d3Bv4zt/pIzr68Bayl0XLK+miD9Q8xDBdvKJ91nb/8c/YlWmMQ
   g==;
X-CSE-ConnectionGUID: ze/ToZFXSKG9DLvnpAc+Mw==
X-CSE-MsgGUID: MU8/9nYGRh+WU8KSxhTwuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="99487771"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="99487771"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 07:17:18 -0700
X-CSE-ConnectionGUID: 6DJaBzjRQ7q44ipwiC86Ng==
X-CSE-MsgGUID: EwslwZIHRlmwJX4IE7kQFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="229016071"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.35])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 07:17:17 -0700
From: Arun T <arun.t@intel.com>
To: israel.a.cepeda.lopez@intel.com,
	hansg@kernel.org,
	andi.shyti@kernel.org
Cc: sakari.ailus@linux.intel.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arun.t@intel.com,
	miguel.vadillo@intel.com
Subject: [PATCH v2 2/2] i2c: usbio: Add ACPI device-id for NVL platforms
Date: Fri, 10 Apr 2026 19:40:38 +0530
Message-ID: <20260410141038.585760-2-arun.t@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410141038.585760-1-arun.t@intel.com>
References: <20260410141038.585760-1-arun.t@intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device IDs of Nova Lake into i2c-usbio support list.

Signed-off-by: Arun T <arun.t@intel.com>
Reviewed-by: Vadillo Miguel <miguel.vadillo@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/i2c/busses/i2c-usbio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-usbio.c b/drivers/i2c/busses/i2c-usbio.c
index e7799abf6787..259754e5fd05 100644
--- a/drivers/i2c/busses/i2c-usbio.c
+++ b/drivers/i2c/busses/i2c-usbio.c
@@ -29,6 +29,7 @@ static const struct acpi_device_id usbio_i2c_acpi_hids[] = {
 	{ "INTC10B6" }, /* LNL */
 	{ "INTC10D2" }, /* MTL-CVF */
 	{ "INTC10E3" }, /* PTL */
+	{ "INTC1118" }, /* NVL */
 	{ }
 };
 
-- 
2.43.0

