Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204273;
	b=af4/15fa/r0GMPHrIEx2Fhy23HpjgdqcMp7ltgjC/AXyPcIL3ZxUIUQgA/fUCpH6ll6c
	 YL8B6VnBpauwhxSdbZ7N8skBH9spGX9TWDu9vXXXkBOG0y03qOQn9c7XmMb3mvz3k3Jw4
	 hsHx6W6GQr7uAdjZsiqcpQdCKHMIZ6lLt3wxfyMZLP9+VlVmlhFu49gSo+BgqV7CEjTcf
	 kOZcJFLBKYJnVSnvpaMbUPiqD6jXjCdyF3jNMlWjki1QEwmrwciut8Lrdf/lkWKkEvv+A
	 tNr+WEdVWWLRCqgDMiMKTc5GdGiJMP9hJlmBG4843qSvh79lFnLA+WVA+kVJodjAPsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204273;
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
	bh=JaI/GskkGK73Yd5e34Ly2/QKA6MSoGh1fcMoK/mKmlA=;
	b=B9y+AzECpACcSpnTsUmMXwLoUJ+IJRnJ3ou7JiISowWRBHbki6R0rBB05JdamyUX8hou
	 lJ5rLc+z9e2zwCaiXtNGzZUMs5TZluysGfUxtsMoHj9KSqUZ6lqAErGZJUsu3xoJHlZJG
	 tiTaFT6cHfBWvYVTZU8c3qQhKDr5NXVGWtaTCJqBoUikGfl6e4Rv3e6XlcWjsfX1ZWKti
	 hcRvxzYcdlO3Kb15vr2vGYycT/Y3WsKXLoXG36DniXXsIfhOCmeXSh9moEFPLN38rR+BR
	 4L6yFBy/8MQvoCtDouKbQs4hOwirQz7qoDeumiCuNHLOyr63e4LLVBjQqzwPpWwp5QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q2n2DoNm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.41
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AC60A2600;
	Fri, 20 Nov 2026 19:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED3AC60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q2n2DoNm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAyzAJWOOHBU6DlUtPaOhh+KP58gf4ftysvqsbpXAawNFRSnzyXS3cFfMvQxpikCVM4RrF0Bzkd6kUfIk2Nl7UisUs4KOaIntwU4P04mbUTJN/ygC3cNXtzT2GtgaVCCbIfhf9sVAPBZFxYpS2prgAteE8x4QcNrLHLhnGlPOydtZ7FF5zCoDdY2ylOlTfrwwIZkfLs3udBtfgYS5XPKDDo0BV233JUJACnFeEveifw4ZOp4hpRQE/YGIBj5x6ob8IHvaXSiy6MUCU8v2qJ/UTI7bD/ckX+/YVgB2JSqUK7+YRdH0nIbAzq4WJg7VwtaJrO7+FVsKUisOmnRG/EYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaI/GskkGK73Yd5e34Ly2/QKA6MSoGh1fcMoK/mKmlA=;
 b=nh0SUUPOG+1Koafz/Dn2LBCf4s44+xfOnG6P9k9BsgsnUvGDbNhrA9Dn/xvUiCnE+mbAEimErcLJfhIP08Suja/3WT07/rqbyeWqObz+G/vupN7qQg/aJ8YqW2qU3PC2M9odSp7ZqaCTOWu74pO4hDm774bkonNd2o+39rzw3KNCloERVqQL7zCv/tlhhS8jzzLZWHr4VZHZw9gjt+LU0Haq+Ucvu5h6larKvwsjRxq0awihpFutMuuD88XEncqdEueBFtYdOwZv7mO1DD2leUvHRmP2vOb+zVBLJAMVbV942arjQvIv2CApA6YuRL6Q7zU+D14PJpihBPEwxxszIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaI/GskkGK73Yd5e34Ly2/QKA6MSoGh1fcMoK/mKmlA=;
 b=Q2n2DoNm1WLKyt3ncu1npIu38Lj2kCHaAEfLuh85DQAKvx5Z9w4xrajA/Opv6YufJDpr6SQlvROa9pCmDpbjBuMhf1gnmNJ4tMaJX235whqDyzdjmEdbgGaShEf8KrX3O4kbAeGT7HY4svWBchGxDx6pAfHtMsymUOpR2iHmB4KeSaz11+ISjnRd3Gu0ri8c4zSavlEkUM+lQ2NgSBzhTSErb+iVvPk0qDfjHqF2uytBuQtkmzZAPUAKfum2F39Uj+pALmYm+Wr/L1eHmr0Y7PT0syHbDFF95s14wsQf4jdI5xN5P1iXkII7afn6Sp2orN7mhnEdJG78JTWoWmkq3Q==
Received: from PH7P220CA0176.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::29)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:50:48 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::24) by PH7P220CA0176.outlook.office365.com
 (2603:10b6:510:33b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 19:50:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 19:50:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:50:25 -0800
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:50:23 -0800
From: Chris Babroski <cbabroski@nvidia.com>
To: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kblaiech@nvidia.com>, <asmaa@nvidia.com>, <andi.shyti@kernel.org>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH RESEND v1 2/3] i2c: mlxbf: Use GENMASK()/FIELD_PREP() for GW fields
Date: Fri, 20 Nov 2026 14:50:07 -0500
Message-ID: <d172bb034b5bb4667893af81e6beee1302171656.1795203929.git.cbabroski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: ac692267-fc95-4287-e2d9-08df473f92c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|11063799006|261026140227099003|261028144727099003|56012099006|261021123027099003|261021121427099003|261102123227099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	PW4ejDfiSYud30ANU2Jtg1J0t7pOWYxtlMDGSEwUuGuBR7TNsqlmR6pXI5yy6JgGET+ZZzaV57lsHgoEMdIv1AuqF4pPhHWIoY6bq6G+ZXmC+nXr5lregOL1UO2qhYbzfM8xhIKfuLl6XL0VKAaK6SYaMvNEDOgYZd00N45h+zYpZcpHamQjKzca/WIZ6q3kpOuv2TI4S7ovIr9rdzkWTYTDEwPNAHmRTZOvSUlkUpIAaTqU9WjVet+2W59akSdTO6OkUmaIGBErv4enDRb9LO9LH6WEcfK9nKcJL2/jpmYegk+IycsvqI4fr63SMWnouR4GK/9F6zSoA/Eo1SlrO0oT3BqxO1nrf4P1FITAqr6oKqDIgt1PIAGyy+Yf6WENXYdaMJ1FFTx2Jr0FbXe+Qhg9WeO0cvfta1VFFkqx2OS/qqVojKX++rkV+t1WUdyLmZk14czPF0yqRDtdMWzwQgW6AZGMopWm03mzmw+RXd1+rCgSnz1Jsnhjc8RgOlIY93z50Dqev9KR0YQDuTkX3HorZTSIVcmHOYdVn6bqSAq5aOL/97SC5EKtoy1GXCvr/EySRTuA4sMfqeRcZ+RqmfZ+Cqmr70Er//SauRajNFPBIxm8zkwMeflYDnrlIKS9DIhSH1WpYRIoiTgtsgzxKTSEEocUS2JrTdlNnT3zEBkRJaY7NbhzTy/bc7Iud6mZyKLrZVlO6ALlnkOcE6opoA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(261026140227099003)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261022105027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z4DT5jdsg/j/k8+3rYOlLSbxa1OfZIp11x1Z96mk8Atqd2aXh3FU7+xxds08TVgf4ZkPRtyVOZc52/wdu6EL9xDUTWwysQQETqcDCvNMbCChbfvj3CY5nMfGurlxley1TBKtNZJNfb17ykt39QhJmvDsh3olwwDwZuSMwQVvRrRb25tgeQ+jSQP46PulF91umf/QuEOAlR/5ueMC5/tQN0b7wJy34aEpTP7Wp1iKXP8yP7xk9QVXdfSCz6mNN2vYqskjR7Sm0GGcjGIPThti4oLrjGquc2rLu67zdQebE34/PzueaEsAqQQiKjMxhTazn6eWhjQdoOVoZPS8MwUH/pgGVKPIDRX54I34xV6ev46ks2BGNl0RcLF3r7XXIrQ9m19S5yTsHg/s11MBvk6TXAWfbhcFVyH9V8bgHksHPlsoBlB8y4Vp8gqOHnO1NrBP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:50:48.0711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac692267-fc95-4287-e2d9-08df473f92c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

Replace the explicit shift amounts and rol32() calls used to build the
master and slave gateway control words with GENMASK()/FIELD_PREP().
This makes the field widths explicit and matches the style used
elsewhere in the kernel for register field access.

Also change the single-bit master GW PARSE_EXP and SEND_PEC control
bits to be set with a plain conditional OR instead of rol32(), since
moving a boolean into position via a mask is no longer needed.

Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 375cbbce0fad..22874ec4b45a 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -219,7 +219,12 @@
 #define MLXBF_I2C_MASTER_BUSY_BIT         BIT(30) /* Busy bit. */
 #define MLXBF_I2C_MASTER_START_BIT        BIT(29) /* Control start. */
 #define MLXBF_I2C_MASTER_CTL_WRITE_BIT    BIT(28) /* Control write phase. */
+#define MLXBF_I2C_MASTER_WRITE_MASK       GENMASK(27, 21) /* Control write bytes */
+#define MLXBF_I2C_MASTER_SEND_PEC_BIT     BIT(20) /* Send PEC byte when set to 1 */
 #define MLXBF_I2C_MASTER_CTL_READ_BIT     BIT(19) /* Control read phase. */
+#define MLXBF_I2C_MASTER_SLV_ADDR_MASK    GENMASK(18, 12) /* Slave address */
+#define MLXBF_I2C_MASTER_PARSE_EXP_BIT    BIT(11) /* Control parse expected bytes */
+#define MLXBF_I2C_MASTER_READ_MASK        GENMASK(10, 4) /* Control read bytes */
 #define MLXBF_I2C_MASTER_STOP_BIT         BIT(3)  /* Control stop. */
 
 #define MLXBF_I2C_MASTER_ENABLE \
@@ -232,12 +237,6 @@
 #define MLXBF_I2C_MASTER_ENABLE_READ \
 	(MLXBF_I2C_MASTER_ENABLE | MLXBF_I2C_MASTER_CTL_READ_BIT)
 
-#define MLXBF_I2C_MASTER_WRITE_SHIFT      21 /* Control write bytes */
-#define MLXBF_I2C_MASTER_SEND_PEC_SHIFT   20 /* Send PEC byte when set to 1 */
-#define MLXBF_I2C_MASTER_PARSE_EXP_SHIFT  11 /* Control parse expected bytes */
-#define MLXBF_I2C_MASTER_SLV_ADDR_SHIFT   12 /* Slave address */
-#define MLXBF_I2C_MASTER_READ_SHIFT       4  /* Control read bytes */
-
 /* SMBus master GW Data descriptor. */
 #define MLXBF_I2C_MASTER_DATA_DESC_ADDR   0x80
 #define MLXBF_I2C_MASTER_DATA_DESC_SIZE   0x80 /* Size in bytes. */
@@ -288,7 +287,7 @@
 #define MLXBF_I2C_SLAVE_ENABLE \
 	(MLXBF_I2C_SLAVE_BUSY_BIT | MLXBF_I2C_SLAVE_WRITE_BIT)
 
-#define MLXBF_I2C_SLAVE_WRITE_BYTES_SHIFT 22 /* Number of bytes to write. */
+#define MLXBF_I2C_SLAVE_WRITE_BYTES_MASK  GENMASK(28, 22) /* Number of bytes to write. */
 #define MLXBF_I2C_SLAVE_SEND_PEC_SHIFT    21 /* Send PEC byte shift. */
 
 /* SMBus slave GW Data descriptor. */
@@ -643,14 +642,19 @@ static int mlxbf_i2c_smbus_enable(struct mlxbf_i2c_priv *priv, u8 slave,
 		command |= MLXBF_I2C_MASTER_STOP_BIT;
 	if (read) {
 		command |= MLXBF_I2C_MASTER_ENABLE_READ;
-		command |= rol32(len, MLXBF_I2C_MASTER_READ_SHIFT);
+		command |= FIELD_PREP(MLXBF_I2C_MASTER_READ_MASK, len);
 	} else {
 		command |= MLXBF_I2C_MASTER_ENABLE_WRITE;
-		command |= rol32(len, MLXBF_I2C_MASTER_WRITE_SHIFT);
+		command |= FIELD_PREP(MLXBF_I2C_MASTER_WRITE_MASK, len);
 	}
-	command |= rol32(slave, MLXBF_I2C_MASTER_SLV_ADDR_SHIFT);
-	command |= rol32(block_en, MLXBF_I2C_MASTER_PARSE_EXP_SHIFT);
-	command |= rol32(pec_en, MLXBF_I2C_MASTER_SEND_PEC_SHIFT);
+
+	if (block_en)
+		command |= MLXBF_I2C_MASTER_PARSE_EXP_BIT;
+
+	if (pec_en)
+		command |= MLXBF_I2C_MASTER_SEND_PEC_BIT;
+
+	command |= FIELD_PREP(MLXBF_I2C_MASTER_SLV_ADDR_MASK, slave);
 
 	/* Clear status bits. */
 	writel(0x0, priv->mst->io + MLXBF_I2C_SMBUS_MASTER_STATUS);
@@ -1887,7 +1891,7 @@ static int mlxbf_i2c_irq_send(struct mlxbf_i2c_priv *priv, u8 recv_bytes)
 
 	/* Prepare control word. */
 	control32 = MLXBF_I2C_SLAVE_ENABLE;
-	control32 |= rol32(write_size, MLXBF_I2C_SLAVE_WRITE_BYTES_SHIFT);
+	control32 |= FIELD_PREP(MLXBF_I2C_SLAVE_WRITE_BYTES_MASK, write_size);
 	control32 |= rol32(pec_en, MLXBF_I2C_SLAVE_SEND_PEC_SHIFT);
 
 	writel(control32, priv->slv->io + MLXBF_I2C_SMBUS_SLAVE_GW);
-- 
2.34.1

