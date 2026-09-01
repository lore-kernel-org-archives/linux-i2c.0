Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625D369D59;
	Tue,  1 Sep 2026 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246525; cv=fail; b=H9JStikvpN+8YdWuRN4in651K8ghYqDrpiZfICasvfgpkRHuhcTsrcj8wCaHpfvyTxYwJb6sAK6L55hnCyj3mVwvrNTrEa7F75Nd+Qtb54em8ZTXw024a6bflAGhE36DsizTgZDvMPxg6Tm9OtyEJ5O74ViNloKoaPgM1eiWhXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246525; c=relaxed/simple;
	bh=QVm9KhCY5j9oLd+JM8fuUkIih9v2oT0mn6fn2HAtLz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nj+/le6Tg31rxO+2axe8S2u+sxXNpJ5VwRKQFLEXn3YbQYi5Y+8FOQ2ZC6UikdGx+bQJ8Kft6VaIFUQPxWBEzaehCC66o/QazusAGYIcE2ewRkYU2FLp3q9tzR8qWLfmM+Enfd+sl9HdU1HuCxqZFq6W0Z+0Ukr9r4Ire7CpVtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OqdYeeLZ; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OqdYeeLZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTVCpbs0YCvJ1sy3byQQcB+RTC5/a3h55lbTIn+IfuNJtyiwfi2eDp+OwhoWK/jDnODS/Ssz9wGGZyR20TbHlFDLqYVIFkgb23Q35W4lap1Ed+l/SNAgflsWV3aZLfz/14G1/inLLg3zgKB73lrgLJSpBsXqyitE+cOB/h8u2YpX99ZkREWY1XxDMJ3v/eFiBYnU1fwNETKfV3oLymD7NYQfRQ+RrJ9bYTUMow1cDE+mOlsCW90C9Ia3cWlyIMpBhmW4z7Dfd18yaAfExN3aaMY6P0/869OHe86NSfI+Jc+PTkMW4lqx3wyyURioQFEu4FyEt7ijJGLJXSGQLvsi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s188PMhWfRoR23ZbdD0FLyTnc7RoFaHvQ5IhETadVds=;
 b=nBZUKviKbGFSIoBefWesugUysjuC264SmohPpBtsQd27wNVqeKBjvZFOGyzwkpbuf9Zsy0mYUn9erSbtaReMbUDZ2ymNbOIoVU2Nn6EXqZL3OESXJLMyweIGUp8vcZ5ZDdWANTzTmHd53lTOPiQyuy2yc8jasNFxwSopROeRonf8FnUQT//h2IhTEhE2P0MlBcOMHMxvW2dTmuaIhUrFMpvT5q5krk+H4/CiufHCrHHALK6oGffMu40HoYbYM7bFuq50ES5Dr7NQWPG2ZqN8Ua+G6FKqyCiqu0/WerfA7FD9gZovmP7sHbnCy8fna/JHdRC8gpFfQ+gqYAcjbWWemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s188PMhWfRoR23ZbdD0FLyTnc7RoFaHvQ5IhETadVds=;
 b=OqdYeeLZtviB7PcX/DXC9/KB6MmNNFr6+buELXt/0u2y+sSkSB8QiTLwNfH8OvtNWug6X4KtUrhowE1pO9/0NX9s6W8zYBXaWfe5SX2Nt5Q0ry0U+AVE5faMpkRO8JXu2zhCWCEe+gV6dMFwMRMUUndQwngT18miQx1A94g/ZYw=
Received: from DS3P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::10) by
 SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:08:33 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:8:45e:cafe::5b) by DS3P221CA0007.outlook.office365.com
 (2603:10b6:8:45e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 07:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 07:08:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:08:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:08:31 -0500
Received: from xhdharinit40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 02:08:29 -0500
From: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
To: <linux-i2c@vger.kernel.org>
CC: <michal.simek@amd.com>, <andi.shyti@kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Vasantha Likitha T
	<vasanthalikitha.tandra@amd.com>
Subject: [PATCH] i2c: xiic: Rework dynamic-mode RX FIFO drain in xiic_read_rx
Date: Tue, 1 Sep 2026 12:38:26 +0530
Message-ID: <20260901070826.1755154-1-vasanthalikitha.tandra@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 261ca125-b324-445e-5acd-08df07f7d56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	NwDvcTRwPCOG36TGlw0SXojRk+j79kgbqWVTUeuNBiIzoQIJUsnWbXPYmguyR4mMCfGeVo63WArFC539+Xz2BJHrNSGU/AxeFH4YvqoploYLQ5PT3IX11owFZXltzp5X62X7K/mkq6EIJW2RphF4iHDn+fAQ/wJZQmcDFTlm56n44b1A9lATyRVK+rymOkVMCUIdu6hzXPz+LxDrPi7wzAr/jUhIEVRfZG46usHDk/t5JTKgm6TdP7XkUubsRPIKNl4ehyJaQUlNYcp8W3+DRfuamT+Ne6/paTkgE1lcUMcQ5hgaxmEtBj13GaeIC2nc2T/xF2PQG9Wi1p9ywFud7EXTOGWGn6wNrBN7B1wAjN2EyXLFbDk3cUYRxUCSHoIrfgC2orkH636vS+WmrobO+k0/H7/xjQcsYXrGuED5X/1phU18Ibvs3f5qMZMq1qROmXEWpDO06XgaCOuzwhZ6VwAcr1t7HfSVfAT/IJWFEb/+nYanPHgiEV2ZQpiFeo7Xu8Ael54B8pwtrO9iO5tkvLDxANae87jzzPkTPKOmhFGmDcFYQDGgi91fRtxySc9+KFns2fI7X/RmqAgnyh3FmB5Oyzg6ZrrrgrLRGC9TWzjHTddAlbeXJD7JVoGygWjYe1mc8yE2KqHvDzYdtas/gBRvABKQEPCmKeQq1nLvQIx39PUwldPQE8J3MaEyySJS4y/OHkd/86nt9+lMxsGvvw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fNM2l8vHu5M/gqwmzQgqJfu6L66dSoWgrZbrt7V0TOLK2koKPkRSwuPW4iCkctmdVCxUNqAFD5Z10iLJHccrvFAk8vkgRGwq8S3aUexyWzHfIokebw+cDi1PDLZ7gdAMsRWv6FEPE7ICocuCMtYP3mUE3E9ENZRdtBpJFs5HxjL8tImfQvqt3PwCvVOVeZX0Cyoz44CBFapxXiwKSDNp350gDuFZlkKru0T5d7rTeGxFG8I5d4EkWsKR7bNbMPnbhFY1ZMqgY0uBP4V5yi6MHcMXyUeNT/HadFQG8YEEevCcXKsfQVdRd4sIwfiNB+sq/GL+lNMJU3Cw0PNb5TuDZt1P6qCQxTRpAmsU1CNcOKIfBJIagxI60cAGe+E84XiEUF68uWdFXSDmW8hb4XX2d38I091/lL5SjE4AN6MsH9sW3Pyt6+5qdHhfOhlWQ6XW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:08:32.7850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 261ca125-b324-445e-5acd-08df07f7d56a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

Programming the RFD (RX FIFO depth) threshold at runtime causes a
spurious SCL clock pulse which results in the STOP condition being
missed.

Fix this by programming RFD once, when the receive transfer starts, and
handling the final-byte sequencing in software: select how many bytes to
drain from the RX FIFO on each RX_FULL interrupt instead of
reprogramming RFD after every read.

RX_FULL is then always raised at the same threshold.  When fewer bytes
remain outstanding than the FIFO holds, drain only those and leave the
rest behind, so the retained bytes plus those still to arrive restore
occupancy to the threshold; otherwise drain the FIFO completely.  This
relies on RFO accounting for every byte received, or the threshold is
never reached again and the transfer stalls until the xiic_xfer()
timeout.

Fixes: acea4e4458b4 ("i2c: xiic: Add standard mode support for > 255 byte")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Co-developed-by: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
Signed-off-by: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>
---
 drivers/i2c/busses/i2c-xiic.c | 53 +++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 28015d77599d..81b163152953 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -580,6 +580,7 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
 {
 	u8 bytes_in_fifo, cr = 0, bytes_to_read = 0;
 	u32 bytes_rem = 0;
+	u32 rx_space;
 	int i;
 
 	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
@@ -591,12 +592,49 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
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
+	if (i2c->dynamic) {
+		/*
+		 * RFD is programmed by xiic_start_recv() and left untouched
+		 * here: reprogramming it mid-transfer emits a spurious SCL
+		 * pulse, causing the STOP condition to be missed.
+		 *
+		 * RX_FULL is therefore always raised at the same threshold.
+		 * When fewer bytes remain outstanding than are held in the
+		 * FIFO, drain only those; the retained bytes plus the final
+		 * incoming bytes restore occupancy to the threshold and raise
+		 * RX_FULL once more. This relies on RFO accounting for every
+		 * byte the controller has received; otherwise the threshold is
+		 * never reached again and the transfer stalls until the
+		 * xiic_xfer() timeout.
+		 */
+		bytes_rem = rx_space - bytes_in_fifo;
+
+		if (!bytes_rem) {
+			/* Every remaining byte is already in the FIFO */
+			bytes_to_read = bytes_in_fifo;
+		} else if (bytes_rem < bytes_in_fifo) {
+			/*
+			 * Drain only the outstanding bytes and leave the
+			 * rest behind, so that they and the bytes still to
+			 * arrive restore occupancy to the threshold.
+			 */
+			bytes_to_read = bytes_rem;
+		} else {
+			/*
+			 * At least as many bytes outstanding as are in the
+			 * FIFO, so it can be drained completely.
+			 */
+			bytes_to_read = bytes_in_fifo;
+		}
+	} else {
 		bytes_rem = xiic_rx_space(i2c) - bytes_in_fifo;
 
 		/* Set msg length if smbus_block_read */
@@ -637,15 +675,6 @@ static void xiic_read_rx(struct xiic_i2c *i2c)
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
2.43.0

