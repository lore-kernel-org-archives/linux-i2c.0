Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B654652;
	Thu, 30 Apr 2026 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527110; cv=fail; b=rX6suTL+199Gk7disUoVDIiBruF0FD+y8PqHSMIY+85a9nwnxqVyerNOlm6Z+hSPZ5RAqetBvfHbrNNE6ceQYjYwbCsDspBsweWrrte8DMTvxHkMXm633Xx9KMmbAxh5cGzu5+3FOD2uibVt7AI4K788jCZgLd1tGheTaOfk+Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527110; c=relaxed/simple;
	bh=NjGrIu41rlmWyDWUEPep2wv42EfiLfjyJGRCGNKNZXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hz3U9b5dWG9JArviXEJyZYKuPjzfdv20pFAjd6FPsQm/zzE4fOEKimKUetTmo10nI6Sl8Ggq4LmYCsmucnX+du9UFfj6aea5c/vmkFmeWjE3xxDWH0M1/hsmqlFLZptyI2WTR1tl0iUxO3ms8GdK8fq/IPpPfmeKzQG/T1dQWeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O+ZV8co5; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O+ZV8co5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdtTQQ1y9mUzOoR6sdSiee4EWOm2yVeRuOBQwDCzGjxLu6ZLe9qkrqLdAe2Rpt7N+eob2psyaRV9dfbFa6dcubRD1EYU2yJQwM3Us4AklBUedqEPx7EVG6Qg7UoqvdUfm37mJboUosBy1TP/fipVHMWcNTP+pmfE8umxLDr3wGNPWFcbRWwasCn4Wev97089BrkhK8XSSD612H4TQVOdBOv0g3DjlWn0ca2AaPUvaYScVYdfHK7gZVTJL9gQJfuHqO8Oe6SljP6z9de2/pHyzqSSbYR/9Iswm9XkgjEEIfX0lR0YA6rp+fUb0pY1zHXtRpgKuZHE0F5xOTxbjLpHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZacdwEi1zCXlvIYO0WMJRY7arDvmN0Z9YQhm+IOSPF8=;
 b=nh4Ve6sqQclvW0cjsIFVWTpXtNSj/4X6IpEC0w4Gfbb1805kD4RUPPDqp+6JCIPjlFuA22xptqeGIugyf+6DdaqzYafpqHUHa7Wjh894iAvBHF854ptVzB+esNyOMblolo36wUcrdLdY7RRaXzqIV90KLPXQ0FW7EejouTrSDMwN4cxmX3ABTOw1vflWMjU8zhfiVRoLkm+dzr4cMn3MGHnYrY1tRnTPGy0pKdR37sG+c8ZPoPFSJkY3l0R5uZ7DX2BFJdAfa6QQEcy0xEBP6NcKU24nOxvrufITJcJMjVkJjFLipVzXbB4Q8ZC6BY5YW7BWLVKLoN1lzJ4UXFwcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZacdwEi1zCXlvIYO0WMJRY7arDvmN0Z9YQhm+IOSPF8=;
 b=O+ZV8co5TwEKZSsLQKCDhbk5xvII5m30G0OEK2nq4yh5VAUYXlrXOktmLO7JzJFbbnFpNupvGbscgib4nT619zHyzCFTx89YdNvDN/Til/h2LVbVjJJLDLeSuc146lR4dzZ4fEfsUsm/pMvVtyjjbhJqMT7OxSCeaGMr7IVfjPA=
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 05:31:42 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:59:cafe::65) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Thu,
 30 Apr 2026 05:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 05:31:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Apr
 2026 00:31:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Apr
 2026 00:31:12 -0500
Received: from xhdsivadur40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 00:31:10 -0500
From: Ajay Neeli <ajay.neeli@amd.com>
To: <git@amd.com>, <andi.shyti@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <michal.simek@amd.com>, <srinivas.goud@amd.com>,
	<radhey.shyam.pandey@amd.com>, Ajay Neeli <ajay.neeli@amd.com>
Subject: [PATCH v4] i2c: cadence: Add shutdown handler
Date: Thu, 30 Apr 2026 11:00:50 +0530
Message-ID: <20260430053050.3590173-1-ajay.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ajay.neeli@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5079a6-59bd-47bc-3178-08dea679c2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	52cYAAIsu/XqQvPPhVVbtIqteMoT+oQn/f3Xg5qoW3K/0q6AUxFAvULPcT5imC7pCbTYmK/300g55EA5bkK0qTtqcz78sDjVupGKZFMHVId+q9KX+p29r6plKNIQpji1q0NuqLxuSnHABMa5jsCDPfXXVentA/iP0pIjamu7lq0gbV6/kPJIqFqdfnmMxKSgjK9uFmFQ+Z+SD6oqxdyI+RKeFE0qtU+aQtFb6/35B70D0zduVT962mq47LzkI3+4C0eHKV2Mzpc0tX8j6u/lx4j7fXNSpkiS965uE4oFpU/uUTaJ3FAexChLcl/O92qfnz3JPrpdjvcep0Sx5Q0rSoU3mOTHNzGsHpyKO7PDPN4RaP6bLEv4rqbp1xw1NZa8ceON9rlFGH9PcVCMHzWIX2CIvbtLOt54TRoFPbJUKVU26uDy4UdZqLCeOXn03bLoiL4ozhGmsnRA1V4sTmfXdYL3WjaoG1Q3UNnB9kgtg3Bv00CyTmNio5RCv/wYCeJoX/1eJBnVeOZORvPb4AHzmIVdvrSxleZc4bFWyZVeUIJo3Uoh5hbITay4Ctf64QlI/wchDcRAOGhyiBzRARk1ERQT6/5vfuLKHiuM7xrtW78nbOf5tDSz7YCeBc8Z/i0jQ4dtPHGlDwoucFq3wGle/GA2jtUZcuj1Gdb1dMk9JLICZpl5raK/f6o2CzN8SP4/lgf4IrewUkwCjm6I1NPJ6JDfQwivLdczO8oAZCVbuWLwsVgGJ5lh3ibhsdzv/BazFSLWHVbXJztzmtFmIFviWw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l6RW30fqTSPFRTk7gmuUTO2HIPyH0ZWmDpyn9zHzhPRze/ykqvAN1/k8HuEHmhXtBgAFxVecYj8wpg51wTkfWmUqE69B9VO2L1ZyXi6c33cblEPESJMP8X4uxXbTQg2uZVsA7/YZpwMqiPetur2fmLjn7tGF6m0fEl5LvggPZJOMAd/JT1lcl5pf1+lQ6Zrkht8hpqgZ4esG+g0lXxf8nYnqtHXoSNjoad0TLQUGm6H9ypu8AymvqZWcWvMHIiXeoykHYbkLjLy4r4pIj65hjPeE6aId+wyq6fmjqmtT2qa/oziMU5g12vZm8+hK7zHfVyEnVjCPCYmcoKYbqnaT3ya2LmSZecujOMcmZALfT24v9R9UoXKDRsdAtzpx+7TpWs66BgdmtbyDrlt51LMiojmHfNkI87QbERdc5yO7iwudDgAATWvQ/IZSKjRIsHB+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 05:31:42.1010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5079a6-59bd-47bc-3178-08dea679c2bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

During system reboot or kexec, in-flight I2C transfers can cause
spurious interrupts or leave the bus in an undefined state. Add a
shutdown handler that marks the adapter suspended and resets the
controller, ensuring a clean handoff.

Signed-off-by: Ajay Neeli <ajay.neeli@amd.com>
---
Link: https://lore.kernel.org/linux-i2c/20250730122907.18909-1-ajay.neeli@amd.com/

Changes v3->v4:
- Replaced disable_irq() with cdns_i2c_master_reset() to avoid
  potential deadlocks during shutdown
- Added pm_runtime_status_suspended() check to skip register access
  when clocks are disabled

Changes v2->v3:
Corrected a typo that caused a build error in v2

Changes in v1->v2:
Disable interrupts
---
 drivers/i2c/busses/i2c-cadence.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 0fb728ade92e..da8770182a18 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -1635,6 +1635,25 @@ static void cdns_i2c_remove(struct platform_device *pdev)
 	reset_control_assert(id->reset);
 }
 
+/**
+ * cdns_i2c_shutdown - Prepare I2C controller for system shutdown
+ * @pdev:	Handle to the platform device structure
+ *
+ * Mark the adapter as suspended and reset the controller to ensure a clean
+ * handoff during system reboot or kexec.
+ */
+static void cdns_i2c_shutdown(struct platform_device *pdev)
+{
+	struct cdns_i2c *id = platform_get_drvdata(pdev);
+
+	/* Mark the adapter as suspended to prevent further I2C transfers */
+	i2c_mark_adapter_suspended(&id->adap);
+
+	/* Reset the controller state if active - clocks are disabled when suspended */
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		cdns_i2c_master_reset(&id->adap);
+}
+
 static struct platform_driver cdns_i2c_drv = {
 	.driver = {
 		.name  = DRIVER_NAME,
@@ -1643,6 +1662,7 @@ static struct platform_driver cdns_i2c_drv = {
 	},
 	.probe  = cdns_i2c_probe,
 	.remove = cdns_i2c_remove,
+	.shutdown = cdns_i2c_shutdown,
 };
 
 module_platform_driver(cdns_i2c_drv);
-- 
2.43.0

