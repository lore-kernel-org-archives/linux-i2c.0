Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF13C1970;
	Tue, 20 Jan 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914454; cv=none; b=eCt7Inf/DEX/o/kKqtFbUmE5Sfbh1iAYpg9EuGnIiRsD9zQsBlbMV9getUt4Zw61YdK3Pwuki6TjYEzE0EMklpVV2k5LoQ6D2MeSmA/AZZoEh6KZacDxrEQeBdOPChDlnh4N5V886f2mcMGQnf837yXz4gm2+izcIut+4OvKmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914454; c=relaxed/simple;
	bh=wKBr1KIf1UsTAWt+IV7jLMWFC5/LZBboG3aUWfKOh1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoEBx73LXcVNP4h3kWALD50E+h4qzKscWF/b81xN1aVda5y7p8jJDkRL/Eo3n9i3ylR7iVsj/8gJ/TtlECv/GzaC2yRhe0fVkKvJp/9ThxwlH4VFj+jCgHm+sCT6oZasNMjXAehujSXc4cG1XT3BKOHIZ7o6LJIsB5xokN5w3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hh1C7yEx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hh1C7yEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768914452; x=1800450452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wKBr1KIf1UsTAWt+IV7jLMWFC5/LZBboG3aUWfKOh1A=;
  b=hh1C7yExnnaS7C6kq6fe092DlnNPLp3jssUd+GBwRPt69T7XXFO5kUa0
   8LIjNtcxB0K8IuwQy2I5P8swY6QiMl6OatbvN4Yrt7yq1kz3ZyjEekQLV
   qRn/SVXpiBAMnmUIs1bK85jGoevuoxgi5rshDNVQLJ1dkS82bXbF46162
   IqdukBcZ0EYIXbq8DKgEpSSIJXQkOpjoEbM58NI+R96Sx4mx/OnzK+5Jn
   onxTaTULkVfJZlvyWAxd+9PC97gOIKVoUkcOFvbMnzr8sDfLo1AuBbCes
   MgQxvtypvVkr07/BHqpM0xpcSmEFRxa63d4Eow8xndElyTCTpapj5HXkI
   A==;
X-CSE-ConnectionGUID: lZcXxYLOSuObBCOhMQ+EKg==
X-CSE-MsgGUID: QJkeCyzMSUm2WuJX6EjEAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73748510"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73748510"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:07:32 -0800
X-CSE-ConnectionGUID: lWNqSnVOQ+yrjC9m4lU0RQ==
X-CSE-MsgGUID: j6a7r8YlSpCubT6/Br41fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="229053326"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jan 2026 05:07:30 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] i2c: designware: Enable mode swapping
Date: Tue, 20 Jan 2026 14:07:24 +0100
Message-ID: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changed since v2:
- Explaining the removal of the "target only" description in the commit message
- Added Acks and Reviewed-by tags from Mika and Andy

Changed since v1:
- The init cb is replaced with i2c_dw_init() also in i2c-designware-amdisp.c
- Checking I2C_FUNC_SLAVE in i2c_dw_reg_slave()

The original cover letter:

It's currently not possible to support MCTP or any other protocol that
requires support for both modes with the DesignWare I2C because the
driver can only be used in one mode. I'm assuming that the driver was
designed this way because the DesignWare I2C can not be operated as
I2C master and I2C slave simultaneously, however, that does not
actually mean both modes could not be supported at the same time. See
the patch 5/6 for more detailed explanation.

This series will enable support for both modes in the driver by
utilising a simple mode swap method, and that way make it possible to
support MCTP, IPMI, SMBus Host Notification Protocol, and any other
protocol requires the support for both modes with the DesignWare I2C.

thanks,

Heikki Krogerus (4):
  i2c: designware: Combine some of the common functions
  i2c: designware: Combine the init functions
  i2c: designware: Enable mode swapping
  i2c: designware: Remove an unnecessary condition

 drivers/i2c/busses/i2c-designware-amdisp.c |   4 +-
 drivers/i2c/busses/i2c-designware-common.c | 211 +++++++++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h   |  23 +--
 drivers/i2c/busses/i2c-designware-master.c | 173 ++---------------
 drivers/i2c/busses/i2c-designware-slave.c  | 126 ++----------
 5 files changed, 250 insertions(+), 287 deletions(-)

-- 
2.50.1

