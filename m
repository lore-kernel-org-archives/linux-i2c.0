Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C464E56E7;
	Tue,  8 Sep 2026 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861090; cv=fail; b=pkDWwS+OqW6Ccp5Ec9N7iz/uVjoHaYO7XZsQYF2+c991++ZTEo+UnLxyVh7Ua5/avHfGWTCXFkiJXhmN5KnZPamV12dwa4uV4Ccl0sSsy+QJqDONBXYVhOHTgbPbvpXTeHmfpl59QqBf50ThPFmJape8Jz/Rc12/u4KDN/qGbvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861090; c=relaxed/simple;
	bh=aKfqVeTxkaifxgxlbPnRKgUS2Cstyw4twB6HpBaj698=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A4brcaJwABJUGMl6f4dsXpdhrZCvYFBIjWhaBSWrcxAOPb/IuCSFSbJ6fMs8UtPkt2jzGGsxvI1SYrurG1hdVqxk5JLdIceLLqmsSun5nkJOB8TTYzyyh2/JcWiV4RvS6bzgCb4moeIdkWlmtWidJWrqCF3Cgpoe1lim7MARXfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwINWqHv; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwINWqHv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqL2IZdpKSarwVAWjbYnDQa4yBgK4KLz1Y/eD/7103pnaJh8pa2Ni3AhDiev9eOcR8LM8IJrtn2B8Mkiw5Aj2D/yi/6jHdNeZfugry8VQtP/9wDRCNpY6xmVuHRNv/nQWq4PoA9cLWaQzxXMUej7KX+FAHTv0QgZgFH/IiWJFqHdmZK5zh+vMzV41+DdhdVi5NaLHnh8AyGyvm5FZd57obpVNG0UYohnRU0zets6MvN9FYccL8YC9tXN/E13cn9uUqmkHn+DxsfDFUQD/wMwlQNgmLwgVNIEbcUSBu7QDSMLo+dXR3WKCZ0A8kGyFnBQQWoNjHTkpe+nzn1f1Y2alg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ8ilXLNMeQ7l1oAd+vAOU1OLCFXNPhgng5/EZJKPmU=;
 b=dZ4bUvYjqeWt65RF6lxazsvD7g4LdY99QGv7bxCzn0sqYXhgSh/CFJ5CPe9Ws/s6E4C9w850fOcilqdnHesrt8059k3n356jlceNLIKLrLPN9wYUbyQEsISC9cleTw/ZNyTSYUDoY0SdicyKBxSWSzYZieZ6TQHxjV9Qj7Mfm6D6mw99X4/Rz8pwZ+mUtmBRlIEFqTePtBNWn86jyuQTVHd+D6j44gFqBox+cr/OkgfTSyuxZIY9FZHiQ35CwDXZ2NBBWKhjygA4vRfgQ/KgEizt1EGlgfPPrNfRXxKQBua7WWwlJ5c0aN5e87RM0auqW5dprVOFspZ7876YGhn+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ8ilXLNMeQ7l1oAd+vAOU1OLCFXNPhgng5/EZJKPmU=;
 b=UwINWqHvDHsmADPnxAwAWn6artTpUMUXA4i+KkO3W3JJ9qMuhGzx2XUpWALrywIULCfkpupd0/GInCmHZc2Et/AauMPY6mHMZltvIqDGZe4JeppTfdTdbsSYejeS/0YAvQe/m/lLUIoCthwMFrwLYpclUp3BYmVEGyjXRBV2KUVmtWUeGtAKkDwN8QtOfbUD4Z8bCSqnAFOYoi8CGqvY4lWNaB70Dxhlyf9Du8NUCzzJo+ERJA6yb8Iwmzf3sWArap+/k6Hc35M+3ExcjCAoKXQRb9AhImEX6UUE0G576o8/aHStaJ3ZcyE4GBXv04eAVEc2zFC6bq0aLDQTKxqVPQ==
Received: from PH7PR02CA0025.namprd02.prod.outlook.com (2603:10b6:510:33d::14)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 09:51:22 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:510:33d:cafe::10) by PH7PR02CA0025.outlook.office365.com
 (2603:10b6:510:33d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 09:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 09:51:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 02:51:07 -0700
Received: from r-build-bsp-06.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:51:05 -0700
From: Felix Radensky <fradensky@nvidia.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jean Delvare
	<jdelvare@suse.com>, Vadim Pasternak <vadimp@nvidia.com>, Felix Radensky
	<fradensky@nvidia.com>
Subject: [PATCH] i2c: dev: Fix duplicate chardev registration during module init
Date: Tue, 8 Sep 2026 12:50:16 +0300
Message-ID: <20260908095016.1050174-1-fradensky@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: eea6ca65-6459-479c-f88c-08df0d8ebd4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|30052699003|82310400026|36860700016|1800799024|376014|10067099003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	G1BX0JyJMnIIg+8l3zZenpsWgAqd5/q9LhiIeZ3Phd5jOVZxwjf1fIq+DQs99ag8wnXpaEPcSO1+sfOzLZrbSip5VCLGQ0fY9IBqWFmYJzF8bSMXiqEi1ghI2jMpkhKsCh987UkcdcJvUf5gAsRPhPk36zZy+mxzYQbtQHoWmRm1pLAT8WrKw3zoiJIIRZcEqvT38VinzTGC5bSphecfsNgcRYhvTfpo0WZHpAUE2duy1GPPDcUwe5cCKqWhkDnXUwRtxiKz026tZCYQ1dmrh6DBXP+t2MJnN+bRBQoGMCh1s/gYFbFCrAyYh0thrgAbSpuuSbS4U6csdaBmowKmRtHmdc1eKrWowGiTPMNC6U0S6ijsPrDbWy2AiCIa6p9vsLAhc+pOTZenUF/IxZvznjZXNcLfjfckJXYq4/tfPnscPOuH22JtOKHF3YcPVGB9cX89/aKn3ts9VRIPQpQEpj8k9Supf7pkrhR9Vb/y6RfS5FPpSwe3XLiIeWf8o+F5fzs8Q7paRoKPsIa7oYyg47nh9IxzQPFvtVdzokhnVZ922JnWpBkPkavNo78B2iflQonSDllcs7yhVMHWSSDBArWh+cTqyi3bzb+UJWFayZ6XmAIhLY8VJUmlKJ9JlOV4yEUGQWCQ2sADAEjOEIcae0omFdXCHDcyNcTzMGfEDL4iuZ8ZNVEpsVtPoUzETe3pdfPGhsCd4/r6LkcfJ2CTsw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(30052699003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sT5TVX7yWJ/1rFEKYZEYTRbqFQ4GWGuEFSc8lODNnN70T/zpVr5ufcUGNHIvO63kHlDcQSBP6pK8dfReTUVxFw1y1NhgqCRlm0TYXaafV8LO1t0+pYEqJE1k0SCdE5qJiXri5hR1SgxJ409z5ig2TIQ+vE5po/Mr/vOKDgu4PlLlVTOLGVTuhdILQCkRY/W54L5aAb47a1+Mldc+2zjGswZvprva1Ckxw4Ni+nlMAZW4r26RiIdK4S8JICDKysXUCW8AlxNxiMb0XYbUGFWqG7ypCYUnSftl0QfUsm+6g778SRtiMgTIanoIgiPZAkUvURWMymWPlMLQQFQRGKWXi+ejKxvi1ShDbbf5wPTbmiWRjR0uZC9tQtyFvZ69uXGwgSvNlOn6AYNejMxpo/D1SPTFdRXQFcABoGdLiai/h+KwrSiqer5Xx9AkLg9k/Fjb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:51:22.2066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea6ca65-6459-479c-f88c-08df0d8ebd4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

i2c_dev_init() first registers a bus notifier and only then walks the
adapters that are already registered:

	res = bus_register_notifier(&i2c_bus_type, &i2cdev_notifier);
	if (res)
		goto out_unreg_class;

	/* Bind to already existing adapters right away */
	i2c_for_each_dev(NULL, i2c_dev_attach_adapter);

device_add() links a new device into the bus klist in bus_add_device(),
which runs before BUS_NOTIFY_ADD_DEVICE is emitted.  An adapter that is
registered while i2c_dev_init() is running can therefore be observed by
both paths: the notifier creates its chardev, and i2c_for_each_dev(),
which has no way to tell that the notifier already ran, tries to create
it a second time.

The second cdev_device_add() fails with -EEXIST:

  sysfs: cannot create duplicate filename '/devices/platform/mlxplat/i2c_mlxcpld.1/i2c-1/i2c-2/i2c-dev/i2c-2'
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   sysfs_warn_dup.cold+0x17/0x23
   sysfs_create_dir_ns+0xca/0xe0
   kobject_add_internal+0xba/0x250
   kobject_add+0x96/0xc0
   device_add+0xe2/0x890
   cdev_device_add+0x48/0x90
   i2cdev_attach_adapter+0x137/0x170 [i2c_dev]
   i2c_dev_attach_adapter+0xe/0xf60 [i2c_dev]
   bus_for_each_dev+0x88/0xe0
   i2c_for_each_dev+0x31/0x50
   i2c_dev_init+0x77/0xa0 [i2c_dev]
   do_one_initcall+0x58/0x2f0
   do_init_module+0x60/0x230
   </TASK>
  kobject: kobject_add_internal failed for i2c-2 with -EEXIST, don't try
  to register things with the same name in the same directory.

This is reproducible on systems where adapters appear asynchronously
while i2c-dev is being loaded, for example when an i2c mux instantiates
its child adapters from a deferred probe.

Registering the notifier before walking the bus is intentional, as the
reverse order would silently miss adapters registered in between, so the
attach path has to tolerate being called twice for the same adapter.
Make it idempotent: look for an existing i2c_dev while holding
i2c_dev_list_lock, which serialises the lookup against a parallel
insertion, and let the loser return -EBUSY.  i2cdev_attach_adapter()
already ignores get_free_i2c_dev() failures, so it just backs off.

Fixes: 9ea3e941d161 ("i2c-dev: Use standard bus notification mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Radensky <fradensky@nvidia.com>
---
 drivers/i2c/i2c-dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index e9577f9..d1de6d2 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -67,7 +67,7 @@ found:
 
 static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 {
-	struct i2c_dev *i2c_dev;
+	struct i2c_dev *i2c_dev, *tmp;
 
 	if (adap->nr >= I2C_MINORS) {
 		pr_err("Out of device minors (%d)\n", adap->nr);
@@ -80,6 +80,13 @@ static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 	i2c_dev->adap = adap;
 
 	spin_lock(&i2c_dev_list_lock);
+	list_for_each_entry(tmp, &i2c_dev_list, list) {
+		if (tmp->adap->nr == adap->nr) {
+			spin_unlock(&i2c_dev_list_lock);
+			kfree(i2c_dev);
+			return ERR_PTR(-EBUSY);
+		}
+	}
 	list_add_tail(&i2c_dev->list, &i2c_dev_list);
 	spin_unlock(&i2c_dev_list_lock);
 	return i2c_dev;
-- 
2.34.1

