Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB63AA1AF;
	Fri, 10 Apr 2026 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808650; cv=none; b=t86+D0j76Jzw4TF7MtsTXH4SK/SdhIBC6N9AUjHwKvwQhYfPzJCuCM3Uowby2Z2l2AE03LGZQW3upwGtSzt5iRPpMTaUN7KfJfm1V8/a6k0gNNbdysMjquhZei4qjr7Kzxh3WmCfzzRV6GKm73U7FUJaD3HT+GzntdkZdzKyP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808650; c=relaxed/simple;
	bh=vCijODpjyqlNRJUSxAJ5T/JrYkhfvxsjnf3TbcR8cp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBYkpZc+s++urZpvxJxuvmyaBneFGbGMmbeFzR0x+eysjrPJnK5/ay214y3tnLVKS2wdOYvl8yhfnMmgj9exTt7mDxWTVbRgNWl9rnMZLznnV/n1V6ET5a/GZKQPvN88Oy50ry7gfnYdVSX49rq1UbDalzu94R754In8cLMiAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyyjvPe8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyyjvPe8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775808649; x=1807344649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vCijODpjyqlNRJUSxAJ5T/JrYkhfvxsjnf3TbcR8cp0=;
  b=cyyjvPe86Ycx/5WqIMo9LEkgfmhZk94GbgLwONmqsN4x5TjPKapOqfea
   JH/w3NZHvyW/lBhoN+VtgHO4a/cIXC/q2yyB5ZqZbxBSmZLEU2ycENchw
   W52bKJNuNMvZZT91GuFpWbSZ0JCvHV1euIp23OaOLMNsmQYazfef3F5if
   wVxCp7JHdzVfsuzhVzyGjrOrk57ffbaAstb1OfC1F/HGN1qVuXEjrZig3
   jdpGQOIq8M8RNA8o0cE/MByRmdySf9dZnGqYTNgoYADTj7ZOYU3H8R1tE
   IPvs1EhwBswWPRmG/1BGJxdqtVnNm4RcBtm5g4lu4SBDVIFCPipBwYgOy
   g==;
X-CSE-ConnectionGUID: l7DqRUJQR+mvnS3wecPd2Q==
X-CSE-MsgGUID: bWXph0pORPyDyD0VBWDMOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76714580"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76714580"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:10:45 -0700
X-CSE-ConnectionGUID: 03/BNKj/Scqk7OOzmif1mw==
X-CSE-MsgGUID: WCB0fK0ER9mUj/wTiHdXlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="252173510"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.35])
  by fmviesa002.fm.intel.com with ESMTP; 10 Apr 2026 01:10:43 -0700
From: Arun T <arun.t@intel.com>
To: israel.a.cepeda.lopez@intel.com,
	hansg@kernel.org,
	andi.shyti@kernel.org
Cc: sakari.ailus@linux.intel.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arun.t@intel.com,
	miguel.vadillo@intel.com
Subject: [PATCH 2/2] i2c: usbio: Add ACPI device-id for NVL platforms
Date: Fri, 10 Apr 2026 13:34:08 +0530
Message-ID: <20260410080408.562311-1-arun.t@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device IDs of Nova Lake into i2c-usbio support list

Signed-off-by: Arun T <arun.t@intel.com>
Reviewed-by: Vadillo Miguel <miguel.vadillo@intel.com>
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

