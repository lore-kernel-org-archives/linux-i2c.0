Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A839B4A3;
	Wed, 17 Jun 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688054; cv=none; b=tYlPWnjpuwiiavsipWqWA8YjOC/wqmYZtcz6SuF1UmBsz9mmJQbwK6UP9F3JT3cjSWGjed/dr60q/cCQUAehWcycpB1U9Ka062PAhvrrTTqCSR7gvR9PvI6xt7GcWSO7BYF0Qq1hpLchi1W3Wx6Bq8ampKVlz6hFazCHTgEdTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688054; c=relaxed/simple;
	bh=ZpgnrNkO3omg4iNYCmKn4yO+2nWBlrQqyd6aKqXTtB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URCrzDBfWKfEuBPtjsCSdwzRR76QSivsv8VIEKqRTtEu6KVTLz6eRPaqErJZWwkucYSJaN9IDrHy1FDB4ZXkjWxqBOGhxjQmkQO6yvWibSB6zbznGdSl5Alio8Y4okKKjuoCCyroElCFOUnXaJ+LWlaIab0YYrUVXa7mJun3Gko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZgb5nvz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZgb5nvz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781688051; x=1813224051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZpgnrNkO3omg4iNYCmKn4yO+2nWBlrQqyd6aKqXTtB4=;
  b=kZgb5nvzELTxZc4doPT3zbE2UUA357ootXZBItrq5NdXIR2CBtb+ofrJ
   EJgpgAB9AhF0HFYIie+RfFkLK+1hpdJgjQIYS6QG64qFAF3bBHtQyylgz
   LNoZNwrq2jRqpdkY9rp1YXIEJLB/5AMmbLIK5Jh8ePRYDXZihY6I8V1mv
   ZOsjDp1Yc+7EifW1dqi4vDgETshrUG+eCIkjoPXDmuzEBT9iiSzvMs/hr
   m/PEI5vM/AfnvbZ5ajDE09TvgvbSWo81A5wsQ/MKMQdkbxUIrNmQfRudc
   pUbwhGCBmo5cmQIQj/6o5opiW0+9q+yGOuCz6JlZbCNa6+lByxlt8cpVh
   g==;
X-CSE-ConnectionGUID: 2bfGm8+ESOG18nkYUGHWGg==
X-CSE-MsgGUID: 8o0Qz7HSQv21z6qpIDNi+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93961740"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93961740"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:20:50 -0700
X-CSE-ConnectionGUID: 0OvTrRUURrKQyeSSNGXdyA==
X-CSE-MsgGUID: ftbp4uzpSEeqvV1cvWsGnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="286131108"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 17 Jun 2026 02:20:49 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6887E95; Wed, 17 Jun 2026 11:20:47 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	hardikprakash.official@gmail.com
Subject: [PATCH v1 1/1] i2c: acpi: Free resource list at appropriate time
Date: Wed, 17 Jun 2026 11:20:46 +0200
Message-ID: <20260617092046.2649219-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do unneeded "double free" (emptying an empty list) in one case.
At the same time we shadow a real error code. Address them by
refactoring the code in question.

Both are not critical issues at all, they just make code robust
against any possible future changes in the flow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index e5fddacae9a4..c13cf29a9092 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -168,9 +168,12 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
 				     i2c_acpi_fill_info, lookup);
+	if (ret < 0)
+		return ret;
+
 	acpi_dev_free_resource_list(&resource_list);
 
-	if (ret < 0 || !info->addr)
+	if (!info->addr)
 		return -EINVAL;
 
 	return 0;
-- 
2.50.1

