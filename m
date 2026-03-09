Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D077313291;
	Mon,  9 Mar 2026 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093664; cv=fail; b=io5+4pcMr5qLwsBQSCZz26hWizhBJgz61LoqXF8bIkzmRrbsljFiysDzDRe0IB6aRcj2IVlZtfVIrQeaU69UJNWvTaUX87pt9XkNN4Ab9T1mcJPf+3R+j/4ftIon8ZgU2CHjmO8EjM41GEJTXoNMsyauqQY08zKE7r+mNmH5aaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093664; c=relaxed/simple;
	bh=exqApVg/OtNAAfxsdEMYrfQq/Dpe0ED+Yw0VBM8I984=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VVh/WrvR+IrrBkt3ENldV3fFb26fhqkO+MgEYmchs+LUwv9tVrI6vowrLVp4bpf2WUewimQI7c6ps3tnkZ/X+sPxlipKNWJUDg0dHiTdftiybgfUWXhNITIvrd3cN25nxaByzM/yv3E7Mufgi0X0dMXNeJ88dOyPoc8ZTL3OwOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbaUaYQf; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbaUaYQf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBojKvnLblljNcr6FTtcotgx9EbXfW7pu0Az8lkXml+HzU22H+r0NQemFyJON6UWG3q4tMkPrpNB0U+aK10Tju5alloGvxOLlQo3RiekHLoObsv5jfA+wj1Db8BQ5Xf/vxJ8JuRUiNZgZPY2qbsWfU3dHMNKK0Mns+6sIjhLQLEsYk02JQoUDcdQJUQKrqBV9QaE0qNnbOrXDXUyusS/GEEny1195taIWSmr6juxRB9DepX9/cGf7rLTiHpOT6z0hmqpvAm+izxJuVS9spqAv/2ZLzeN7wsXJfARWoIqRkrg6oWjVVJBZLEf6caxTCLiAWUw5iTneUyF411nkl35dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMxC4NYh/ubHr20mhCVGrEZwD/BADmgtlw97Nv0kGFw=;
 b=BWUYNY0zk81spmfM27RlulxjM11W5RGbU5kG/DER3o0K6DSWGyKSNvy6MYzhwPY66Vp/kPbw2f0+L/r6FcpT1pkiJ/yneLHhfqPQuT4ApZjUVukQxxuM1YeaQQZTTtO4hM2dQe2QIkvVmdVW9P2fmouWZW9DA/0CZZj+oQK04B1NHrdgr30u6TuBugKG9i8IFTGU3CkefRAdTilmiqU0x2tzFwQSKG/iIv5X9GBvGoQWbcz6QCaXDQfOMJ36PegErpT2WBm5biEXbx0VDdi/U7P6lI0Hm4AgnuHCT3YiJSV38sOqK4qU5Xbqa55oue7IyyN4JiqHpeKddXT8hirdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMxC4NYh/ubHr20mhCVGrEZwD/BADmgtlw97Nv0kGFw=;
 b=gbaUaYQfayzQRkyaSd0iiSxg22rlSyLoqrZC5dckUWsg/eg/ndmOeyZsef9AOLUocm7xERLK4YKZdYWaQQxQIchYBGz9qqQ0jC1eAG55p4YSDXEQ41/vW/Ie+HXTrdAZM0ypiiXFhPPnB0NK0kx6sQadr7LSUoPugBoqloW8kwM=
Received: from BYAPR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:74::31)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 22:00:55 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::62) by BYAPR05CA0054.outlook.office365.com
 (2603:10b6:a03:74::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 22:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 9 Mar 2026 22:00:55 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 17:00:54 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <andi.shyti@kernel.org>, <mika.westerberg@linux.intel.com>,
	<andriy.shevchenko@linux.intel.com>, <jsd@semihalf.com>
CC: <rafael.j.wysocki@intel.com>, <mlimonci@amd.com>, <benjamin.chan@amd.com>,
	<bin.du@amd.com>, <king.li@amd.com>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Pratap Nirujogi <pratap.nirujogi@amd.com>,
	Bin Du <Bin.Du@amd.com>
Subject: [PATCH v1] i2c: designware: amdisp: Fix null pointer dereference in runtime resume
Date: Mon, 9 Mar 2026 18:00:01 -0400
Message-ID: <20260309220038.1420996-1-pratap.nirujogi@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 951af5b9-4389-466f-e04e-08de7e2756a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	MAt/tVysCdK2z+8qfG6eDadWNVB+6qJ8g3BI4rOGLXth/uPVxcl1DGJz0IojeK9j4Z/Odl4hGBNiPVi+ZySaxOpAw2eLaGGiZfwjUMLlg0hn+NX+Ir+Lpb3z+D1xVoo0MnRwZBwrZIIHpRJQKXTCj5NtxCuDgt1ZwYPnFrSH3u44yPJNZtahtIPAeIiCCJPTergbuUTMPwiHj786Kbs095LDje1qv4x7ZUIdMRhezN4/r3fze7WCIZn9mLhVvRjkHkdrMF7SMdtIqej+jjLYg2P29g0fq2phodNC/BbbADO1f3twLMgu7YK30nc8BIJ42ApLd84XuTY+QkQnJM6NtCs+6bnK9edu8g50TtFFr/dIvO/nVN2GkuNCv1x9063RUG069uyESzpxx3a5ZNPRc5DgAR1Pwpxy1ujGpIJJnai2WH2sK2JJmYBJf8+rgnK2j8B/MwlV21bssvp6oID1E33qY2F8iw8M3F94lcW8LFlg0fu3c7jrR5JlEtFQME6t9KDkxBW4I6JBALffNJxK6YBAay+5sVRcSmTGy9UK3nZLvleTEilajzzNZ9wFqHfDK5dMZis74NIRPPoBWNptUYWTo4jipBX2QXPbeNHX3zcAMaYw/xsCOtWWTFYARGDrisZp8GpbgF2P5+JFlv5ejKnMBnsknA7elJcJH24ULYdkyuga6n0aqYtpL9boGu5yfY7e8WG2BXfwdWDtKm9y4ZbMmWF8mc8tCpCLxBpze9SAHkPj1tcyYwmIRkKbkZL3OPTlynFoUEmrNjUB1OEPAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k94ffurJXFKPgerS1yYlasHHbwwogfv8Vd10c7F354boixDCw27gEfbkIPLJ9E0W6SlQe7nRwxlU73tdkecJeC8ee+Ve2Y93Y1jp1HlFti9zqykkfN4qMTxZuEX5DrfYy21nsM6JwKj2JQClkccOvWBqAGN+5MmUpC+PnXQCwsfT+aE0U/nLv5Ic11XPJcO4Q1ZgTEPlzmcFRzCadgX4Y2mgYyJn0wW8hoR/5d8FlVu+nWaav/vKv2STHZklqrOiN4MF8tGk6K3wf2oANA+z+W8HW8scQI2ZYbNpiBjiGSlGD4YH8CHepzMU0x8wSfvaPA4wWx4eZ+LLddZoODNnWGmNcsE57fcTwVA94RTIkqd9v12C1oshSX8XjlrsEvF4ymDt11UFZwc8x6qE835SU9r6Ecmh6r+nkTW2tMv3/mNNlRweOKeC5hvMx2D+/g5g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 22:00:55.4918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951af5b9-4389-466f-e04e-08de7e2756a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

Add NULL check for i_dev->map before calling i2c_dw_init() in the
runtime resume path. The regmap may not be initialized yet when
runtime PM tries to resume the device early in the probe sequence,
leading to a NULL pointer dereference. Skip the i2c_dw_init() call
if regmap is not yet created.

This race condition occurs when runtime PM resume is triggered before
i2c_dw_probe() completes the regmap initialization and was observed in
kernel v7.0 where the order of device enumeration has changed because
of the changes in registering the device sources in the device hierarchy.

Co-developed-by: Bin Du <Bin.Du@amd.com>
Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/i2c/busses/i2c-designware-amdisp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
index c48728ad9f6f2..cd7ee55fbe1ee 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -153,7 +153,10 @@ static int amd_isp_dw_i2c_plat_runtime_resume(struct device *dev)
 		return -ENODEV;
 
 	i2c_dw_prepare_clk(i_dev, true);
-	i2c_dw_init(i_dev);
+
+	/* Skip i2c_dw_init if regmap not yet created by i2c_dw_probe */
+	if (i_dev->map)
+		i2c_dw_init(i_dev);
 
 	return 0;
 }
-- 
2.43.0

