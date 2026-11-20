Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204284;
	b=o2I+KiQkbXvL3ieXCBVR/JCJsI4KtkHPho4lVADZbBP30zvg2FsgeFow9S5qDSdEwCP0
	 XKv+/shG1S13pgWws7mcCwDusJo9QiD1Snz0Owtf09r9uCpd3Yd8Lw9dBR1h+XYCsIETN
	 qN2lhTEaXtIDy6iOOWjkYtWFvJibwv428i80GIxX6hUaqmif7PmotZHxQdllemiUevE8+
	 raz86jknZco5njpYD/Amm7GGU+/B+mymn+h2CQa6xl/d/vcxh+66PsTbMK42ob2Flgk+6
	 QsFQrzJTbfBFb847uvBK8qPEXvkhZROqJ4LiO+TEtwukpY6NhIT+JQvUdMCNM6RAU1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204284;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UE/flMYo83UrBj6n1lGeWe1JDSc6BsbIRxv927V6xys=;
	b=A1m6GCA4uAvFhfsc/bh2tJHRFaKv9MHZg8+HZsiIN5txBkS1pzssetBDdslBfXCWsHSf
	 6LZhU/Cj8mxLqlM32TMBgR4msjSO+R44xke1x2OKrw6CSdnNF0ypxVHLrj+YM0sQrwZHH
	 +zs5sQF/YPdSemZme54sBK/BMhaIC1m/vHUVIhgNTW/7spMwDGnhdyragUdNFHkWngqL2
	 K+qSO/n+ginISjm4vA+QnFNcVLI5yUTJb3wazcn6lnqgFKt+GpZ5kNYg/fYmZz3wNJ7ef
	 sygix6DH61/5ed1XfhIOh9zeSHrYHbpiWsYoLMlxRBNgjQR41ggFAz2RRl2eJNBpD7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CtUG8fTQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.46
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFB606A6F9;
	Fri, 20 Nov 2026 19:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06FFB606A6F9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CtUG8fTQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSnWRwWZ3VHx5GisEUjN1Pos2apR3mT0vEjcgsC/8XbuftkUNGOXN59gBuaAl2/hRuSRNWc5vFA6IY1SgPimpeYCuB/WfJ7ELTrXG1CvqbKbcsLR+zz0wxL34a7scbtbnAw4owht3WHH4NOUXMtYV8/s8UJXLc7EAinLxdk93HaEQ8FSpqlZThQ85BMKc5WvEVhYS05RyOtOg+CBHGwF3FNj7WKMdyNMLbPMyPNR9FKOQlnl6nQG1274NDRfI43LxHtFdqcYRkwGTNtD04ShL1jjE75iogL+dfm6dt1/UNxAi0SJWFzfKTawORmf/iUjb3O7YYZoVsakfwj4k2h5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE/flMYo83UrBj6n1lGeWe1JDSc6BsbIRxv927V6xys=;
 b=uWD99ukjbllFX17vimITqiOWdrs+DFWSvDodxtOkZOWAW6tD9oT+r1v/ZuTqI2Uy7yvT2OdKG+mWU9H4YsrPYYTWXcxCsM2kWXZxPaxFNyFvXURpG/wvxuN53i6BQ8nfKTe3h74/S8/EbZWBSiWDlg+8kXWTL3CSiy1WG49IZHxof9VGTk8PMS02vP5dv0MPppdXYikknMPUAlRYIg1Xi5aOf/rJYGgO/3WXrRrEngrgU/2ytM2lXJJPZOr2OUXeCvfd9+ON7RkuUBZlc3cq8JaooVforx/jdZcCRytbq6oRl86bmZA7NgT4BDevYtwyABaF4qtcuQ0nlG7M55i+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE/flMYo83UrBj6n1lGeWe1JDSc6BsbIRxv927V6xys=;
 b=CtUG8fTQUfCmmn1M08xknNrdF/MBVucb931Zn+cop2ZbkROhOuLtviLAQZzoI9P9GSsa5qrcXhDb4busvpz2tixi52KK/+UrlstczOT2oVEbzAr8h9KDOSnDnR+DpPKww375C/86jZbR1mb+WCMxiuNkKFw91YM62i0HBA9p4yFqGH8V3wbuT+GaJfU/3o1trbN7xyD3d0a5kNwSwu97sNx7XeS+Oe8NhcrxlSOLg3CjTAnSTwtgdqcr9hSOsrgsyfx8bGFWOkfY6K8S1tzyyqQp2L95Fb8hdAxlSUqqcTKAA61zjizebmWPrNZa5W2oJxluQae5ndRBPB8mD3vUKQ==
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by IA0PPF95ABFC125.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 20 Nov
 2026 19:50:44 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::90) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 19:50:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 19:50:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:50:23 -0800
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:50:22 -0800
From: Chris Babroski <cbabroski@nvidia.com>
To: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kblaiech@nvidia.com>, <asmaa@nvidia.com>, <andi.shyti@kernel.org>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH RESEND v1 1/3] i2c: mlxbf: Fix master GW corruption from unmasked SMBus flags
Date: Fri, 20 Nov 2026 14:50:06 -0500
Message-ID: <326154d0c86433d5eef5aa2c4b937dbf2af1d8a6.1795203929.git.cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1795203929.git.cbabroski@nvidia.com>
References: <cover.1795203929.git.cbabroski@nvidia.com>
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
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|IA0PPF95ABFC125:EE_
X-MS-Office365-Filtering-Correlation-Id: d4333683-31da-4521-ae93-08df473f9068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|18002099003|22082099003|261009223027099003|261021121427099003|11063799006|10067099003|261021123027099003|261102123227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BtEMidisOKvN3mGzz2IYPnLbQzDS9EnwQA2Sd8TcDi96an22OafPlnzKbLk6V1EZKpURYEdijiJIRU8Z1y4ybhWTtNwcz7a9010IbnsolGHmD77/lQ2e/Z+S8fo5TarQ9gUR1yFk677IOW7ZzImbPdtKYrUnxURYq/NeCVFCbb5/HzEk4VQOYvwP1xFx5wRgS0qcToI3tYSe5kHu+TinwM7rnxddX6Wjf93/8dkN6njkz1tYoNYRg5+13yTMNt0b0Y6RA8ZQUod0idPmtYQCPjWR5M60Jji6F1gHk+JGo+EiQP54b2eN15kUbK4tQ6BaEQXgnlRStAA30Pi45wwUj17S9rvEU3eFdlp7KTdmf15ZtZW9eXD9vW0gn7BJ3eeNaF4IXm5tBaYBLOkPZrFa9Bes2uisiwuX+iyKee+qPeu+G0ytQVE6jgzOIbM5Jxco+Vh4Lpy8AFvyS2HgAhfGFtHKd6vYimHcPPD9nrfMr+TCurHg1hTW3dF7ahuwNy0XIGzYkeKRkGqxfxsceQYOLamulp00A7fm4k/NY9GoVG/FCy2Tg1vpElYZfD4Vr9f6pIcGRMuEzpWMkdKw0EJEKTaSY/pej25K6PWhHn5+38C4Qeck3mMJe6vTq7GjrQTmMCMoxkR+argAiCf6+KjRY1syjYEcmDkNR1VVq2VkoiWZWUlsSQ59BuEPp2DdIVjHIbl2Y4Otjlh+uU2rQDjFCQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(11063799006)(10067099003)(261021123027099003)(261102123227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JW68jgpLpvSWYsDGJ5lgPPkaeoFz2rfpvQWCYx4VPz84FLCGmcOFM+xdmZExk36U+ScxMTwO/gifIpgsuQBMyNwBur/yvpCajgW7s7/3/vGW/zrvn8MWlriTgZz2QZQrOPA5qNJ1Z7Cy+zxs+p9NJzJzLt88f2hrsmA+1GV2GiHdDoxjMXFTsn0Uw35sxsI1TnJF3LKoJh3KfrUjhQfc1N5EO4rQHMlJMpUlLDDqbIppToxSyEdPxm472723keNxQVxJP+Y2mHI0f7kTF3CRNqOgur/d8L3w4wMozgPtT1Qw8GZmYDqvbYuVeATKz88hkjm8BgxpSkhHtUEyvvYXnu/hCicCbmvgcjDA0BQJlZP14nNDMAhf5DD0K3xsdVu8qig+wgZZTpQKF3QpWQTHH8kChsNZ+CL4tU2nfrX7gCTQ9pVrAAZwQcaj+LuX+tFK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:50:44.0587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4333683-31da-4521-ae93-08df473f9068
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF95ABFC125

When the MLXBF_I2C_F_SMBUS_BLOCK and/or MLXBF_I2C_F_SMBUS_PEC flags are
set, the flag bitmask values are shifted and written to the master
gateway control register instead of the single-bit flag values. Shifting
and writing the bitmasks can corrupt adjacent bits in the master gateway
control register like the slave address used in read phases.

Convert the SMBus flags to boolean values before setting the master
gateway control register.

Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 432d9588f32d..375cbbce0fad 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -740,8 +740,8 @@ mlxbf_i2c_smbus_start_transaction(struct mlxbf_i2c_priv *priv,
 		 * submitted by the first operation only.
 		 */
 		if (op_idx == 0 && flags & MLXBF_I2C_F_SMBUS_OPERATION) {
-			block_en = flags & MLXBF_I2C_F_SMBUS_BLOCK;
-			pec_en = flags & MLXBF_I2C_F_SMBUS_PEC;
+			block_en = !!(flags & MLXBF_I2C_F_SMBUS_BLOCK);
+			pec_en = !!(flags & MLXBF_I2C_F_SMBUS_PEC);
 		}
 
 		if (flags & MLXBF_I2C_F_WRITE) {
-- 
2.34.1

