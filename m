Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987371;
	b=oOuf5PzxC0AoOBk9idP5Zk8FjPGg6EhwsVG5uDdc53p6gRZgaJqNAtrmnuaASW6aGxNe
	 hUPAVW9I4SitJPt53FVomQItNWTKBR9vjdzVNKrDYd/DIdHuXGFF3/v+gZaerUpdHqTs7
	 3tM1gI0bDIoZ3JAM0EaHZq9pL3lb+6Pq0a7EaLg5BbvjTdq0cDxToTfir7+KKw3O0qGv3
	 hUB3whRF3CX1Qy22T/lOGtFRgI8srthMKoBCJ18mckckyp671V50rsAJ72U3EX+w75Udr
	 Mzd2k36RCsyj0keOwExmMtTdc+TwyQQbreMsbLd1SHUN0nHqthStrmKaPcqtO/fr/wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987371;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A/0mal1gT23ax1jt3F7xiJrs4nTpR6/OVOgvxOsqvC4=;
	b=UUJWWDOrv/4dQ7oXD4wUBqq3NaJGdRJfSAa1CQb6SyFTlOussyFIqZRFEGZI1OXF8lZO
	 bbxyyJb5LRia5xDiWDg5+9234rk7XQcKoP6yEzj1Z+1Vvbh2uNubD9bXmGcf2zigSB0ji
	 a2qmGQ5QQwrYJNfTSi7h0cdNhvj4/+ZbXqAt0s0VqPrYfSU2i93rzrzTkg9+u8wEw166M
	 XG7XPw0HYIy6d/wOGeVDnRq7WTR7j0VWnN2RdTQP9y+0aCAYtf2SAlMdcAR2WZTHNMq73
	 BMWL3Hpa9c+evXUm6qEIeZSKI/XC8IHfy6TESTD35CcrBQHgB8aR5GmJn2O/Drwm4fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=njtDk+O8;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE06606A31C;
	Wed, 18 Nov 2026 07:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE06606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=njtDk+O8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794987371; x=1826523371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7O8vwd748uW90ZUv245wY3k+3x5RFIy1aPNSpj3UM3A=;
  b=njtDk+O8nkzYYrV3qTa4FKNkMUt3qAMfr5Eiz9ZTQlw2AvLbfX1vf7r7
   ZV+sIh2D31ER7dO3jIucRXEborCj8f1gb1d/KH9qiezX/3OWvbi9xj8Di
   ds/hsii1cTRxCY+Fvtogh1GesNEuqu7XkK9Whxvl7nY0YL/bkHvXgiitI
   o6GOn8sYqJhpcTfMBFNKaLwc2crv/YvHXSYSH4vEMfXzguJTECGfGVZ3b
   TKtt0Fx6ZzkwAbFW5IAnrLHKZgF4zL9omeY6bzt/+0e9swvm/293lRnjH
   jHH6l2dNiF5IhtO9RT530+lrEPjQn032s7HBd9e5ZuThQeJ+2BPpwLiii
   w==;
X-CSE-ConnectionGUID: zlCDpq3SQT+h+gz4tfsg+w==
X-CSE-MsgGUID: 9B1oLtBaSz+FYg2gUg4srQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3646005"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3646005"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:36:11 -0800
X-CSE-ConnectionGUID: w/Ee51MOTqyfwTmxDZlI3g==
X-CSE-MsgGUID: NiqgeGByRVCVemUOBavqGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10071718"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 17 Nov 2026 23:36:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8646F99; Wed, 18 Nov 2026 08:36:07 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	penhouse24@proton.me,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Date: Wed, 18 Nov 2026 08:36:07 +0100
Message-ID: <20261118073607.297350-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Dell XPS 17 9720 touchpad has the same lagging issue as with others
when run at 400 kHz as the ACPI tables describe. This particular system
does not use standard ACPI ID but it seems to use "Windows Device ID"
VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
well.

Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214597
Reported-by: penhouse24@proton.me
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v2: Drop the DMI match, add bugzilla link.

v1 can be found here:

https://lore.kernel.org/linux-i2c/20261113083940.2583439-1-mika.westerberg@linux.intel.com/

 drivers/i2c/i2c-core-acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..64fdf8ffb5ff 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -377,6 +377,12 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	{ .id = "ELAN0678" },
 	{ .id = "ELAN06FA" },
 	{ .id = "ELAN1300" },
+	/*
+	 * This is non-standard ACPI ID used by some Dell XPS 17 9720
+	 * systems. They do have the same issue when used with 400 kHz so
+	 * force 100 kHz.
+	 */
+	{ .id = "VEN_04F3" },
 	{ }
 };
 
-- 
2.50.1

