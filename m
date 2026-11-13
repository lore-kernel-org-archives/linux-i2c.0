Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559183;
	b=RAhT3RkK1ewgu2xZOJLJ+6rjlG8PRFQePkaMfRmTtot2uCP39GFN9V5sPHUqoH6qJk8f
	 zBIxleZkN42/3f4LK4nDdLtCC/YMFZfRcbUzRN4uU3/sWyG1aTTdmjDyUgjtQAvHf9Jvj
	 j6i7mI0KPavsHqqAe04HxVHrVkMjFtvlif0+em528//lkfQeA/f95g6k1OyTsxtx0SlIu
	 ILP8irHEe1tBYG5jadK7f0b+niwlrOF4EGuvd48KvOpNA5qY4v519HSLsJBk0jN96k3a0
	 CnMG5g4F3dnOuHyibmPv0hcMThIy57cs34f3NHoeNQzUqzCVSW2GuuhRDOAvtiO127w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559183;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I2tO/nVipIuSEk5oXD89iJaagz6EjrPkA4O6Hp10oWY=;
	b=Jgl3mvO29adrJnWhOKgJzcAYD9/didP+bsoR1acp+67Ltvawbq3F52Cc3ftwpcMH+qMF
	 On/ckOrvsJns3pWY0+bN9SYmhssJjPhkzeD+DAnwMWJlPTjLVe20leT7QEXQv41qiH1VN
	 HzKNu6wiYlRLXBb80exz8hxdqJUmZW/X1uZ4IZS+YcxJpquM3HVX+9ccukDLNIseKMkuV
	 l0deOUmUvFzNahkJhx+AvVSp6t3tQJ1w4CDZkNC5FH1voYkcbjx034N2sN5/FPdu/CizH
	 okbsEg2NMNEMMwUTihd39CW7GpUzvqWm38ZQFihH/Dl2bsXf0sch8ZXgyv8Ro9RyyOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WZ7CLdSd;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168C60A2611;
	Fri, 13 Nov 2026 08:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4168C60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WZ7CLdSd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794559183; x=1826095183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RkaUg1TnP8iq0WZ2/X6DQ6hMitMiehVfWhA9KaLyZU8=;
  b=WZ7CLdSdF3BIfuZ8OMWylF8FGv2ovN9KwBFxDVJIrvz3X/+EUurZ0iUO
   sFhMYmWtkOIG/BNbNrCmptai2BFdbfBpHVjIkSH6gq5d+KiThLkQQbQLA
   PfZDhmxp4RLcRUKcWlj6mHmklew0JGgCTML6WhDDAWuInElRUxkVs1IRu
   fQHHM9Hiabv3USY2UYR4Xuumh+ANrl/icrL4O97GxmdOOhRJb5mgLea/k
   DDT2G3qRa5KvxRCsjqCstDgkU50R24QtsxnrCmVtC1VJH1rTlH6mkcFzI
   iCkWiqHOU0rRmAAIi9oLvBp1dn8vwz/RdFzh8FTVN1WbHwYfMWsFDlpTu
   Q==;
X-CSE-ConnectionGUID: MfiPVRHFQLOhBZKNGplcOA==
X-CSE-MsgGUID: ZsSuBicQSR281nXDiAKPkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3435784"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3435784"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 00:39:43 -0800
X-CSE-ConnectionGUID: z3/vNLXrS9aMri+L6hNTdw==
X-CSE-MsgGUID: yCvnhUfpSHygY0MXahAz4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8869298"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2026 00:39:41 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0F0E399; Fri, 13 Nov 2026 09:39:40 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	penhouse24@proton.me,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Date: Fri, 13 Nov 2026 09:39:40 +0100
Message-ID: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
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
well but since this is not a standard ACPI ID match it also via DMI
strings just to be on the safe side.

Reported-by: penhouse24@proton.me
Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..98a8d63e3fb8 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/list.h>
@@ -356,6 +357,16 @@ static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] = {
 	{ }
 };
 
+static const struct dmi_system_id i2c_acpi_dell_xps_17_9720_dmi_ids[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 17 9720"),
+		},
+	},
+	{ }
+};
+
 static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	/*
 	 * When a 400KHz freq is used on this model of ELAN touchpad in Linux,
@@ -377,6 +388,14 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	{ .id = "ELAN0678" },
 	{ .id = "ELAN06FA" },
 	{ .id = "ELAN1300" },
+	{
+		/*
+		 * Some Dell XPS 17 9720 systems do not use standard
+		 * ACPI IDs so we need to match also via DMI strings.
+		 */
+		.id = "VEN_04F3",
+		.driver_data = (kernel_ulong_t)i2c_acpi_dell_xps_17_9720_dmi_ids,
+	},
 	{ }
 };
 
@@ -385,6 +404,7 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 {
 	struct i2c_acpi_lookup *lookup = data;
 	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	const struct acpi_device_id *id;
 
 	if (!adev || i2c_acpi_do_lookup(adev, lookup))
 		return AE_OK;
@@ -398,7 +418,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
 		lookup->force_speed = I2C_MAX_FAST_MODE_FREQ;
 
-	if (acpi_match_device_ids(adev, i2c_acpi_force_100khz_device_ids) == 0)
+	id = acpi_match_acpi_device(i2c_acpi_force_100khz_device_ids, adev);
+	if (id && (!id->driver_data ||
+		   dmi_check_system((const struct dmi_system_id *)id->driver_data)))
 		lookup->force_speed = I2C_MAX_STANDARD_MODE_FREQ;
 
 	return AE_OK;
-- 
2.53.0

