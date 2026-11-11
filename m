Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383975;
	b=5Qo1PT4ZEkMi0KhR7AFSRJ14sEUPVm/CXb6vC8ZIFQUhULpXET+OpBtb7COLiQ5tKED9
	 SCIpeHmnVvQaj/GWXZQ4meGTWcQo3B0N8Wan6kqA/vCWoHWPjpnXox2MV7uKd8XzOd1K6
	 lhpgLBfBURljOEaF+Vy+fz79bYmIPOb8zXggr2tl53T7PfoB9OHEswsv53uE2h2tgff0M
	 oRZ2Gj2n2iaxP0cwGMHPH51vSfxcpANDqzawN7DvOW8GxQUstl4VYVnbrITeZQ8cVQyoj
	 NPYDaP1bNf8kKyUenwmb7DFq4pTYka3+KcYww3PyzJ88h8Jecw9pJ9PhoCo2OFGXQbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383975;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=ujZ/L43l1G/pn0XQs3mcwG6EM/wMWs7ELw5OGxD+Nro=;
	b=g2ahTtKOq3wVdeHZRFkXL7TkfYHtof7SBCaNbhXaXoSg/kkHDXLbK1p1milWNYAyIWBT
	 o1g43OrldxU4Qhb4IOk+ulM4pf95NDgZ4eP1WK1kXDw6tJGAStMkhDEbNzF+3FmfmXjqb
	 Ytq0MzDPbBjq0UfV3f8h2ED0WSG6WSDmtnkATnHcWFMW8Hucgj74MB0Xjyhe4zK3lvsMw
	 8z+IiyEdt0a7uZ7ggkGY2usTjmOgOTOM2lWXXTGJDwTBEKhXo7TuImeZeNLgA4lSpSwE8
	 oafNS5n36bAyvlOSX0CIZw1Tl41iZsKM5KCyI2u1zVWzMxVSbVT8plgpuOH9rGXKO3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnRuqdLp;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D2F606A31C;
	Wed, 11 Nov 2026 07:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67D2F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnRuqdLp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794383975; x=1825919975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j3j1x9sW1Hw6+0d46gWFWLVkQrt+ag5byaO7M00vo98=;
  b=cnRuqdLpfC2/BcoPwfvYGij2N0ECR6NhAfV5cTIR1CxHOfXbIpMLM6Wz
   jiNLsMjWMGprxZRH00LkSna4GsoeH7sLAtjji7aZE6WrHIJgL4dhdf4zM
   CHWhqRO0+aPZvqaHkXXDe538SzH4taI05C7xCtAATti+1s78jZXwE40nR
   6NWLv4o44+lyS5wCG7ivRMil+FI+0mKukTyt5K/OtbVKviuwGcq7GERIM
   8WCr14+IZ9jhpYPuoi8tyXXkc4JF9mmIc8tCFsiqLoD3Ultvj6BsQkmTH
   lACJIIa6DKGA0aE0tGzDtnRtep3KEQup385k27spjVteLRwly2cyt7La+
   w==;
X-CSE-ConnectionGUID: B41LpGIeRR6LRt1gOzPcJQ==
X-CSE-MsgGUID: mQ8sidgERQu2Higrj3vUug==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3044419"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3044419"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:59:34 -0800
X-CSE-ConnectionGUID: CROJImUgQ6m7WF8ccSRE7Q==
X-CSE-MsgGUID: t+vpCYCDQ5yraRjJvSvCUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8527675"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 23:59:32 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 744BC99; Wed, 11 Nov 2026 08:59:31 +0100 (CET)
Date: Wed, 11 Nov 2026 08:59:31 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: penhouse24@proton.me
Cc: "westeri@kernel.org" <westeri@kernel.org>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [BUG] i2c: acpi: Dell XPS 17 9720 ELAN 04F3:311C touchpad
 (VEN_04F3) needs 100 kHz like DLL0945
Message-ID: <20261111075931.GG259790@black.igk.intel.com>
References: <CYQ1dYF3ZUj0L_VRzN490SfuHRaulkT_y5NWcIEIl8OtpIgWgXyOlwEyUqZD_uz9bmVBXM2uLOo8bkyzcR-qCxNObstCqFUlK6lUYXK5euE=@proton.me>
 <20261109104542.GL176724@black.igk.intel.com>
 <lGd7ChJVtwyvhMVkRinryqLG3Lx32U7xoSjT4_inKH1pBNoAd4dvBKV1A4i9MOIVLKmgx8sVg98gfK-iUwb5Uoy0wX1CM2_c7I1vdTr2tYU=@proton.me>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lGd7ChJVtwyvhMVkRinryqLG3Lx32U7xoSjT4_inKH1pBNoAd4dvBKV1A4i9MOIVLKmgx8sVg98gfK-iUwb5Uoy0wX1CM2_c7I1vdTr2tYU=@proton.me>

Hi,

On Mon, Nov 09, 2026 at 08:57:13PM +0000, penhouse24@proton.me wrote:
> Hi Mika, 
> 
> Thank you for the response (I honestly wasn't expecting anyone to respond for this niche issue---so a welcome surprise). 
> 
> Yes my BIOS version (v1.41.0) is up to date. Currently, there are no updates available through Windows or from fwupd. I have received BIOS updates many times via Windows since purchasing this computer in 2022 and have had 0 change to this problem. 
> 
> For what it’s worth, the DSDT has a valid default ID. TPD0 starts with Name (ITPN, “DELL0AFF”), and _INI then overwrites it from the BIOS-provided TPHD variable, which yields “VEN_04F3”.
> 
> Please find attached the output of 'sudo dmidecode'. 
> 
> Thank you for helping me fix this. 

Can you try the below patch?

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..bed9260056b3 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/list.h>
@@ -356,6 +357,17 @@ static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] = {
 	{ }
 };
 
+static const struct dmi_system_id i2c_acpi_dell_xps_17_9720_dmi_ids[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 17 9720"),
+			DMI_MATCH(DMI_BIOS_VERSION, "1.41.0"),
+		},
+	},
+	{ }
+};
+
 static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	/*
 	 * When a 400KHz freq is used on this model of ELAN touchpad in Linux,
@@ -377,6 +389,14 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	{ .id = "ELAN0678" },
 	{ .id = "ELAN06FA" },
 	{ .id = "ELAN1300" },
+	{
+		/*
+		 * Some Dell XPS 17 9720 is not using standard ACPI IDs
+		 * so we need to match also via DMI strings.
+		 */
+		.id = "VEN_04F3",
+		.driver_data = (kernel_ulong_t)i2c_acpi_dell_xps_17_9720_dmi_ids,
+	},
 	{ }
 };
 
@@ -385,6 +405,7 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 {
 	struct i2c_acpi_lookup *lookup = data;
 	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	const struct acpi_device_id *id;
 
 	if (!adev || i2c_acpi_do_lookup(adev, lookup))
 		return AE_OK;
@@ -398,7 +419,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
 		lookup->force_speed = I2C_MAX_FAST_MODE_FREQ;
 
-	if (acpi_match_device_ids(adev, i2c_acpi_force_100khz_device_ids) == 0)
+	id = acpi_match_acpi_device(i2c_acpi_force_100khz_device_ids, adev);
+	if (id && (!id->driver_data ||
+		   dmi_check_system((const struct dmi_system_id *)id->driver_data)))
 		lookup->force_speed = I2C_MAX_STANDARD_MODE_FREQ;
 
 	return AE_OK;
