Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1D33A02B;
	Mon, 28 Sep 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580879; cv=fail; b=PYVeyPankRkMDbDPQzq3+Fa3bylgi/QnqIig85tgBu99f5ROJZNZHSfUCFV1xVXXmtIVD3vd18kx6sFuyezs3/xttwP9QOuFCti/fzmgWzoeB8EPfWRctbmGLyK4Ncv4OPMzDxlCpCoSpG9hVwrSki4+m8Ut4wNxiwpwJFq/WDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580879; c=relaxed/simple;
	bh=9qhk302YiLTVxxDYYxM3jymFSt8D0+vJhd99/wdAU5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jZ6N2FRqIp8n6vkml4/Q7ck1ykouu3XLvPBSNnF8GrSpzWUtYYi3jxmxQzSPuiIjdjAr8Bkz1LyDus2xVCSbTkvw6zfku3MXxaG8lHel1kg+EZNgeC4vBo8cOL/6sXb+3aM+WY0bp6TbKb2b+8ThONXr2OYXfPQNlpYBb3XeKxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wRzUEunb; arc=fail smtp.client-ip=40.93.195.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wRzUEunb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0hQNyGCl8TwjmLKXjaReKI81rvuWXb0AcIamK3RezxQWjy1KEmeYYu5iWtPbh3JBtrCqeL8yqYAQlaYAYNUjFL+OPvKqRapk+IHv/4BIScZuurLhevA6Z5m7QHHiBhyPs08vBeexG7GkSHvJaPXLp6vJHuToiGBgzoHJRimfhI7ExGh5YSXuc8IS5X/tCjwEW6zoNi4qPRXDKfEcxs4m8P+Pt15r5b6l30kXtHfL4aogl7+q9c0+bAsklrgs7d4sCA+KsT0+UV4n1mQqNXLuj+i4MIOjz4OE7ZPoxqdZY//YytVmByoxqRM0roV1VMKqyH34b+YWVzNEGpeIO+QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7fd9/7f1bfoOBHRuGumIR49NyJ1p7LL5GWiYZiQaXk=;
 b=AzC5Fl3wz9RleM1mJPPOf/pyWomY5PW24KqCfjiliCqn6vSTrDWqH2T/XWTC6+w1fdBZMC1aMUesFAxGCXAkdwUW2Rd6euyOwBzH7zLGXuSbOaRLwBiily2Hj++0n7vCJsoVUcCKdwm7pCjHzdHBLaf38DZQU3u/31c+KPoWUTqi+UqTC7mup2eMtXBm3GdW4xYeJCg8F2CjPgi33+uUoBmNUfEd0PAVzeayJSGkUQkua1Kc3NFocXoeCPBjFePvNMANeRfICZ+0H2qLaPGwf34J0JfaNC5HaUlWaD28O1QODt35DMGN/yLwqMg97FF73ZMQKelJo8kPmou2RCxqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7fd9/7f1bfoOBHRuGumIR49NyJ1p7LL5GWiYZiQaXk=;
 b=wRzUEunbqhGozniCqmsrv+4Mu5Nx3AneINIlgjEuMiz0d8TDFkot+2xhHJbbUzQ3STdvkB/Z2XNpqa2kSvA2p0WQgtL6OOcT57nhtdA3S4XlrnFnBFuwrJvqyt54tnfstu/53gzmRGhA1/0+g83caCgD4XlHclwYxpFqX7Ni/o4=
Received: from CH0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:610:119::32)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Mon, 28 Sep
 2026 07:34:34 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::83) by CH0PR03CA0363.outlook.office365.com
 (2603:10b6:610:119::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 07:34:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 07:34:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 02:34:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 02:34:30 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 02:34:28 -0500
From: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
To: <linux-i2c@vger.kernel.org>
CC: <michal.simek@amd.com>, <andi.shyti@kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Vasantha Likitha T
	<vasanthalikitha.tandra@amd.com>
Subject: [PATCH v2] i2c: xiic: Rework dynamic-mode RX FIFO drain in xiic_read_rx
Date: Mon, 28 Sep 2026 13:04:25 +0530
Message-ID: <20260928073425.2597782-1-vasanthalikitha.tandra@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 472f69e7-5277-48f6-92bb-08df1d32f141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	LFlKDiWPM7ezS0CAnEDa79gjrq7sDEiwoGEe5DCRUq4YUv2KpBbWyxo6fWfIonbaT2i82crNKW+MRnMY1HMyFzV2LNWjkFqC1IDE0DcDyzZ7jkHMIaAGhM4JoMmWN116OC1WzYuDAJDvU1t1HWPo8vvwpPr14rEUuDt+fLOl4Yw8SfAePRpItxEX7DC52wVmf44g51zNcClgzyFOptFOY+pi5aw7728wIIaNl4eTYwMmz/EDBgUAXnSwmUdPaQD2ca/rumU40ZaO5uC7mE5a7shWNwVMJtgEV4llJfuH+9CIOTaQR31a4Acl8z1SjgLRIhGxifIRgWdYLXY0gaiMgVKWezu8hYC8Ouqg12GahNqOAFK56s0mYLNTaSTVeGmB6tICgf4a17lcMh57DZzZwDnDVGy2stdHo/jHyriscLYIasUonw739fP6EuFLu14tfeOWj/na41CoSfwawn+CtIOoY7xgY85xD6HLjZfZYY/b3ufqOdPLVqhukednyty041nLPzD9+NwSIpPj5MdRhFOYPc6pIvzD91USu6O9VVbmlzDsoh42fRB5So0idtyFCtS9inuJlGY2qV8PJshyhqcC+7PPrR8aiUx38McRbSuSmCnasoLstTpDFPSSK6FUmbWbEnZkOu2sMuxOMwVG+SoBtey7bNSCDyS2iBxnW8W7hIzPySSdrCGkRnufEoHCsi8V+Dgr2rUWdmjfxo+OJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9Yd2teZ5C9XAvc1I1/CjgTwKW7w9sELN6XIa+2N3Cm6p9NJ+K+GQtQ+Z8zFjOznwW1D+nevATonT+SE7rrkkDrChh6IU7XPwaPs3d67YNOx0SJm0pNWqms/O2QnwAlJPC3zkzSnPO5YEzlsZwflmYoDcc403xHU0QH8EzhgOSYTa1FAFitbhJC4t0qXQuBkSKgWtvHcuk/tUx5fPM0lDY/fNBZC8hy9mUV0ps1R8ofa18mcz1ecUpXL/epvUOsfTtrukXxHaviFQ2FzRvxilOhJUYtihpLZoEqpm1zXnUrLoQGVnoNnrnmEh2In01ZQ89ZMhKdn7Ibu5GmLdtEoBnsGg0jMCWxbhlx752sxX7LqHLk7tGbEfMxdmWd2CZMiNGZmCoYInhD2UlT10uqPojMJCEE60zPhZiOxdoATvp7LzJ2819LHKBZLeUp5OgqF2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 07:34:34.2709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472f69e7-5277-48f6-92bb-08df1d32f141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

Programming the RFD (RX FIFO depth) threshold at runtime causes a
spurious SCL clock pulse which results in the STOP condition being
missed.

Fix this by programming RFD once, when the receive transfer starts, and
handling the final-byte sequencing in software: select how many bytes to
drain from the RX FIFO on each RX_FULL interrupt instead of
reprogramming RFD after every read.

RX_FULL is then always raised at the same threshold. When fewer bytes
remain to be received after the current FIFO contents are accounted for,
drain only that remaining count and retain the other bytes in the FIFO.
The retained bytes together with the bytes still arriving restore the
FIFO occupancy to the fixed threshold. Otherwise, drain the FIFO
completely.

Fixes: e1d5b6598cdc ("i2c: Add support for Xilinx XPS IIC Bus Interface")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Co-developed-by: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
Signed-off-by: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
---
Changes in v2:
- Updated commit message and Fixes tag
- Removed dead code
- Reused cached rx_space
- Improved comment wording
---
 drivers/i2c/busses/i2c-xiic.c | 39 ++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..474540d4d611 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -578,7 +578,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 static void xiic_read_rx(struct xiic_i2c *i2c)
 {
 	u8 bytes_in_fifo, cr = 0, bytes_to_read = 0;
-	u32 bytes_rem = 0;
+	u32 bytes_rem;
+	u32 rx_space;
 	int i;
 
 	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
@@ -590,13 +591,32 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
 			xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
 
-	if (bytes_in_fifo > xiic_rx_space(i2c))
-		bytes_in_fifo = xiic_rx_space(i2c);
+	rx_space = xiic_rx_space(i2c);
+
+	/* Do not read more bytes than are still expected for this message */
+	if (bytes_in_fifo > rx_space)
+		bytes_in_fifo = rx_space;
 
 	bytes_to_read = bytes_in_fifo;
 
-	if (!i2c->dynamic) {
-		bytes_rem = xiic_rx_space(i2c) - bytes_in_fifo;
+	if (i2c->dynamic) {
+		/*
+		 * RFD is set by xiic_start_recv() and must not be changed during
+		 * a transfer, because reprogramming it may generate a spurious
+		 * SCL pulse and cause the STOP condition to be missed.
+		 */
+		bytes_rem = rx_space - bytes_in_fifo;
+
+		/*
+		 * If fewer bytes remain to arrive than are currently in the FIFO,
+		 * drain only that remaining count. The retained FIFO bytes together
+		 * with the bytes still arriving restore the FIFO occupancy to the
+		 * fixed threshold. Otherwise, drain the FIFO completely.
+		 */
+		if (bytes_rem && bytes_rem < bytes_in_fifo)
+			bytes_to_read = bytes_rem;
+	} else {
+		bytes_rem = rx_space - bytes_in_fifo;
 
 		/* Set msg length if smbus_block_read */
 		if (i2c->rx_msg->flags & I2C_M_RECV_LEN) {
@@ -636,15 +656,6 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
 		i2c->rx_msg->buf[i2c->rx_pos++] =
 			xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
 	}
-
-	if (i2c->dynamic) {
-		u8 bytes;
-
-		/* Receive remaining bytes if less than fifo depth */
-		bytes = min_t(u8, xiic_rx_space(i2c), IIC_RX_FIFO_DEPTH);
-		bytes--;
-		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, bytes);
-	}
 }
 
 static bool xiic_error_check(struct xiic_i2c *i2c)
-- 
2.44.4

