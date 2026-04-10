Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F63CC9FE;
	Fri, 10 Apr 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830653; cv=none; b=N/h5VRR6yRofjpNdjV5yUxx1ME4ut9jNMvNugGmSvU8GoAK89JDQw0DBX/bjq/qozfp7ihjQ1m3f5Owb3djlHZAIeU5OKO/Kks8cLJWg4RctVXXFO1IluC3kMmBZLqvbdnwHoMMOr3YQu3Vl4J2MwucM2o0qWFl2UyqM7eGsUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830653; c=relaxed/simple;
	bh=sl+FzIBXVMlSZ/nJpC8urkN/gHCP6oH2evLkc1/HUSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1zzM1MLUD2YycF1WWlfiHDNUJgcAHAKkg9bntwftNNCBzINm+OFptUZXs4OFV9eZSvLJs8SuI8w/GKJUOomlWXIQb+vnJ5tcWo+N2SPUrItNAQzRostUg8c/Rh8+iLthSSqr+2EpS78xegR6G9jXcnQC99ZnWCgariUUQfquX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbCzY+C4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbCzY+C4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775830651; x=1807366651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sl+FzIBXVMlSZ/nJpC8urkN/gHCP6oH2evLkc1/HUSY=;
  b=JbCzY+C47hJWNucZFyv3q6cNuN9U68ElPUVDH8napKwkXmLy1KUtK3z7
   Y2qxRevbb/x1xQ9gLQBd63a+WSaRNQdkXALvvwxt4k1AvQWQ7LfOrKNo9
   goJeoogqvU017KifbJxf03vOlEyjxQshIirJNKLNoUHVnJ++bsGel3yRV
   JFRexQSgYVFN5eXqmGEdEhg5n1KOkoEPlbhP8gKiAGwG6G38ld9+GHjBM
   syPsgQwDCE5cfJ+FYby79S0LXk0heqTrAMIkvieF6Tuf7/m99TDCreef3
   Wj1cGhQxxREf6JI/1PUnawtF6Ls1JDym6dPXqed7N4Xu1aXGQxsrmPIAD
   A==;
X-CSE-ConnectionGUID: YTgk/oPyTbWYsLdyLO4pMw==
X-CSE-MsgGUID: ckep2zyAR12uICjcVJ9SSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="99487765"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="99487765"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 07:17:16 -0700
X-CSE-ConnectionGUID: IGxInb5JSEWBZwiGrz8Sxg==
X-CSE-MsgGUID: l82WWPJLS/yaqMUwl/eXZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="229016066"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.35])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 07:17:14 -0700
From: Arun T <arun.t@intel.com>
To: israel.a.cepeda.lopez@intel.com,
	hansg@kernel.org,
	andi.shyti@kernel.org
Cc: sakari.ailus@linux.intel.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arun.t@intel.com,
	miguel.vadillo@intel.com
Subject: [PATCH v2 0/2] Add Nova Lake (NVL) ACPI device IDs to the usbio GPIO and I2C drivers.
Date: Fri, 10 Apr 2026 19:40:37 +0530
Message-ID: <20260410141038.585760-1-arun.t@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add NVL ACPI device ID to USBIO gpio and i2c drivers.

Changes in v2:
	- Updated commit message sentence end.
	- Added Reviewed-by tag from Sakari Ailus to patch 1/2

Suggested by Sakari:
	- Add sentences end in a period.
	- Add Reviewed-by tag. 

Arun T (2):
  gpio: usbio: Add ACPI device-id for NVL platforms
  i2c: usbio: Add ACPI device-id for NVL platforms

 drivers/gpio/gpio-usbio.c      | 1 +
 drivers/i2c/busses/i2c-usbio.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.43.0

