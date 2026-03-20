Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E223148A7;
	Fri, 20 Mar 2026 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774037663; cv=fail; b=pAmQwhnrymGsgxytN2BsFq5KAgGkpeZ2rQo6w6QgbrDZgnlkNF41nARGjMjr7p9X2OWp2zrg4oOaxV7yf3YgTZVeHEPQw/2uUbb1nZI5I8/irZCsehSC+23+WM6Bxn+8u03UgWVLDD0f2wjsK42liO6d98/tG/4EYvO/wR378dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774037663; c=relaxed/simple;
	bh=Xm5G4PeNuUdgNtXTkRYfVo8DQXXYzW3tajhWNFGmqZ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V5YHBSS1F/Xhbsj33vjWT66wQR8S2wsDvEwv5+BEoiHXXT2Ne4iWARsbNwIjrbmu3ePU8R2+otnGTKLMMawsv12DBffgB78xT4Ddfd0dBDTtYz3B9nMVvqw/kcGeoEI3cYlPDs6pdr6rAP+n/PZN1GwNnbBhGaCX4Pc08ygu5zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dGd1KpM7; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dGd1KpM7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDTlhGGDByAaDrYm3WwBNLN0ArwscE0tXSBNNJDe9e0D+BtaiWw0Qqg0a8SDzA+y1d3p0GSbyXBiq6smIK/Jo5KIkLX6uCSCmcRlIl5fKGSCCHibDexA5/P549Uka7U5hRcz8XsOyvoVLtLliaMIGDzru2PjzLEzwOH70ulDEOnM0KqO+rqtbHB4DeHaH6wJi3GuhypoUmp4AR1YtNaiGBGUo1d5i9eUcmstvCnBPrYUMgyTwDbSfbyrQTttgaoVUFlhXGvHZo+VMywcFKqiwJJcGKzhaXgH8NvOjpT2WYDNzq5LO6D+3Cv7etCvjyXaaqQX/YkbH46Rysi/kzPYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBQpP4w88LpYs4WGztfrSplLgfGH17ou+yBlfJ7//Sw=;
 b=Wwo/b13V85ySs6vVJGwu5mgWVMmPmF7TlYbQIpLrW+vTcqW5+zmu6NQGSyWAgvz/Ch6wxFi3iGjhqG0sNVps3e329vtjXYgDvCuQ/7a8B8kj8g4WtUF81l10qQOwG79BZy2+coN9VQmpO8nVJdjiOK04ZoGiGDTs5vG4bCyU+xj9huSapHSWS7Vy4saqoZHNG4ZHgqRV3NYNPj0j9zlVbCLUXUxMZs1xWTPWsJBbuxIu9/jIY9C2qM0J5hlOofjaghkjE6S2U8+9g+Zq7ABO5S3NBtb2c77gHj6wE+jjSxikcbD0aEWZyQ/1xU2P7paMVlrX1ahrw2iGuXM1O/46Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBQpP4w88LpYs4WGztfrSplLgfGH17ou+yBlfJ7//Sw=;
 b=dGd1KpM7X24Y7zXw43Sl8Mz8fi/Cg6EyOjHhJtIjYw44d0Bmca5R+avswr8oQsVisF0ZltDGHkBGrH8uUKquISwqdyIycRQPOuskqogjpyZz72OsRNGxnyhYFvuyByJ8DT2EEp4t/5CgTHyDCC497htZb3+aGQ6f4Agt9fkeVy0=
Received: from BYAPR11CA0053.namprd11.prod.outlook.com (2603:10b6:a03:80::30)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 20:14:17 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::a) by BYAPR11CA0053.outlook.office365.com
 (2603:10b6:a03:80::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 20:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:14:16 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:14:15 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <andi.shyti@kernel.org>, <andriy.shevchenko@linux.intel.com>,
	<mlimonci@amd.com>, <mika.westerberg@linux.intel.com>, <jsd@semihalf.com>
CC: <rafael.j.wysocki@intel.com>, <benjamin.chan@amd.com>, <bin.du@amd.com>,
	<king.li@amd.com>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v2] i2c: designware: amdisp: Fix resume-probe race condition issue
Date: Fri, 20 Mar 2026 16:12:22 -0400
Message-ID: <20260320201302.3490570-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d1508b-050a-4787-e764-08de86bd436c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3uiR5c481UWM5oUtnfYYyn2U3A1JG0YBnqmy2kLlUhF2whuAloEvnhdGyHcac7WU5fBdtw5YSGrcj2jF0WpuZqSkKeWPWkKaD5BKSeXof6abwKKP5l+7Y681QRA0kpKhgp/mthBEeKYUL4tARz4ELoLbpxnLdwE64guyE78UTPqQG0axqRVYYXiKKXr4a/8YqVmQ0YkJExAcMfDWIlRnYoy6U6lrr+g8eElWbKMgz3+u2ac175MmAFmHq7Akav61vKz8EjjXyXCVQSsIUvgg1BgK2x5JQWjNaB7u/7xWEkcwIVq4+TFzr09yq8C3jbbkYStsidg80EufWYpzCSoKDt+eUp3UCBpybZIUb1un4y9+U/7FPM+40DOA8lPNQ7gRN1PKhJDvTS2nKlhpgwEDlzEccBGKkG/l7KtnQ18BrjKc7CEjsac/l0E8Ijb7Xoq/iItVroRpKf120guZBN902qN4Y3r7IzljXbNqzF59neoUko5rqlpMe9SIGzBGS+cGjJYV+eE5rDxk0Xk61FQJdO3CI8r/xzqJs7if6sWRrUfs0v1BJpWzhxPKMrhYf3brWWOBZaMUmaKBvZ++12P72Ifq1yhXwPEkK7Mg3UZbGVALr/dLGJCBhKGzsgG0XWy4J7icFIXvKnApTGQypPZ8IdMTnzgnpokCveGsPvwyVrDxIRGbwuApK9aOjuYT1TePp2n0Ot5HmZ0U4WlpsY/2NVoWDY6Aso9v+4LxMFZVxK64d9M9pM7Ryo1T49iAi4P0Nry55HsfLgTWHM29GWwrvA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5vRNCzW/40Kr5VlHu29H0ibQ14NemPnQBQaxTjDa+SzfGi3r9tHpOd5eDbs/zhRoBQnZ4Ck1J3EWbJQxPicSMwQT6V3BxUNGs9XyIZjg1gWjeyh9nfmePF1YFOHSKMrcl7qBfyDaV5zAQc9IMHD+HTbOZ6PfITa2OnGd17bmDUNBn212wsiWljdUMiVKiGESbngmIcB3Vt1t2uIrJNvruEV6d92CsnQlFVhCqI12pzQ1hi1HM5ElrGgrErqIgLHG1NDJhrTO2tM41Bn3XRwp3TSh2lR2DEPqePkYD1zw3WdYvW9BA3DtTwT60YS9oD79BiB86ryNGplTN5Z2G2MaWUe25xEvD5so6/YhP+Z/CAfTHX4Qkgqd2c/1rdChM6I77gBVKuwyPUSHvsx4qgJBw+eeAhRHGZKn6QhNG8R0baZjK0VA3hMKApamvmV/a/gL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:14:16.9995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d1508b-050a-4787-e764-08de86bd436c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

Identified resume-probe race condition in kernel v7.0 with the commit
38fa29b01a6a ("i2c: designware: Combine the init functions"),but this
issue existed from the beginning though not detected.

The amdisp i2c device requires ISP to be in power-on state for probe
to succeed. To meet this requirement, this device is added to genpd
to control ISP power using runtime PM. The pm_runtime_get_sync() called
before i2c_dw_probe() triggers PM resume, which powers on ISP and also
invokes the amdisp i2c runtime resume before the probe completes resulting
in this race condition and a NULL dereferencing issue in v7.0

Fix this race condition by using the genpd APIs directly during probe:
  - Call dev_pm_genpd_resume() to Power ON ISP before probe
  - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
  - Set the device to suspended state with pm_runtime_set_suspended()
  - Enable runtime PM only after the device is fully initialized

Fixes: d6263c468a761 ("i2c: amd-isp: Add ISP i2c-designware driver")
Co-developed-by: Bin Du <bin.du@amd.com>
Signed-off-by: Bin Du <bin.du@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
Changes v1 -> v2:

* Fixed resume-probe race condition issue
* Removed NULL check in runtime_resume
* Updated Fixes tag with appropriate commit
* Added Signed-off-by for Co-developed-by tag

 drivers/i2c/busses/i2c-designware-amdisp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
index c48728ad9f6f2..9f0ec0fae6f23 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/amd/isp4_misc.h>
 
@@ -76,22 +77,20 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
 
 	device_enable_async_suspend(&pdev->dev);
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-
+	dev_pm_genpd_resume(&pdev->dev);
 	ret = i2c_dw_probe(isp_i2c_dev);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "i2c_dw_probe failed\n");
 		goto error_release_rpm;
 	}
-
-	pm_runtime_put_sync(&pdev->dev);
+	dev_pm_genpd_suspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	return 0;
 
 error_release_rpm:
 	amd_isp_dw_i2c_plat_pm_cleanup(isp_i2c_dev);
-	pm_runtime_put_sync(&pdev->dev);
 	return ret;
 }
 
-- 
2.43.0

