Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204258;
	b=IDbhQ0FmFkywMo7j70w4ECE75guH9VGujTTCt7lnOWr338/s+6VKxZAcMVyBbWWC5RAP
	 fHSleEE3z0uQVqHen39kSnPHIvTVcSPDBXf3Rq1YmeBxXoqW4xpFv0yg4rqnNkCLue/D4
	 iLap2yRBlhhz/Gjwxzc1+K9dZ7sT6ncVMe+CXKxy6hzisPL/29cAPJARDuLyGsKinYOld
	 yqTR3V7Z4+yqfnmyR+mp74FPZY/J0VBWS95YFhXdxfKH8XLrZ05yATGRxatcyf0tNRQVV
	 WlO0ASSjJAM8cdtsJm4rLlD/0hCZ1EjiKvXqS1g2boBU5kCwSzjwa5gFOZdJbLmSvug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204258;
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
	bh=b1Da2gDHyuYV60D1+HJXEkmCxAkqVayaX/7gj7IPP/k=;
	b=Q/tu+bMkSwuBbFGsaZfuA9YmgQe1GwxDQOgO8ymsPtVSN/BY7wc0EyeMrbe3MPKIc3nf
	 iweJkAh4Vu02FbAfHR2tMTd8qjGD3FWkF5KOqFnLIKO48Pd5AFdR9uXZyg6E5js0ysylf
	 5SZ4+IdIIuUdXoYsMecqdsPXNXrk213tgiKCmuTx+yCDlaJGI+K3w8AzgNGtVp5Uu8TBz
	 sZJIA6wOa7WHtnpk+F4HGzbkftLKWJsX/QqLzXtTzB0g0S9YJRTZiBda0+Fz3tWNn3mla
	 VoM6ul0T6u47Jx+eUBclyh31WJ92OL0OBj8ilyaGTm6frc6SmKKrTWV/UUevXYsRRag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c2FzYdYF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.52
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D7606A33F;
	Fri, 20 Nov 2026 19:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A27D7606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c2FzYdYF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsHsRG3UpZfhyMru/UvqvwGCNgRy/E8LZDW+P9zJzTsp/wF5BZfkJLs9rXRvuMfjjjlvQhJgvg52UsPtE7xlUHiGHTJBfNL9IenWIil0/brq6rZ2WEWy2KAsHHJd+ybO+3tN4vKeyQZw/bTix5949Ob8nuE+Eww2W1cfMTPPQMA2PsHTbmeEja00HGQFu0BIQBdERl0nXuW2901FuBFhQHgtyR9bhIg55SzXpfGyGnsu0exfYzdf0Tc12LyjAoRhdkaU9xVleQ+asGCoXRCAHoqYKE//Ninb6drWSy2yC1bdAN7BlNu5zyJBNG+wxN+VrC+Oe3TEhB8TvgQSorN7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1Da2gDHyuYV60D1+HJXEkmCxAkqVayaX/7gj7IPP/k=;
 b=GYHgrghuKphKkf18F+8ZH2CPHalDcfqC3kEV7DvmQAuqRoeLnO9dEYm1DpAThnArmNpHH/XIh9L/DTE3262q0aHm+FXP2vhQD9tUufNqUceEoX1r/ipyku16chVH4AYOo7EP3QcsRp+/JkFdfQTxWmdgAaai4Xp5AmUkiTsUF/aA3BOX/t7+014rwYw6wWJlmR9/q792riW8r2oLXR3Efx8vGQyctBYv/m8XKj4FCHuM+GqOIxzOvt4Fh8irHcTBa+TUPcyJjeoCavtCK0laMgyF4ozdNkyJHuZix2gK1+BMDowIkW0zEhekL7Cm6yWHjRZEL7nDEFdLqTKIybYPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Da2gDHyuYV60D1+HJXEkmCxAkqVayaX/7gj7IPP/k=;
 b=c2FzYdYFLBlwOZO+T2n6bTauY7ujfXc7VyPjfYpTDfo/QWpudLZcjGC6yVauq2ugLl06BTtdjCEHb+AeSQm5IiSDTxM4UoiBUB7OoVofTjCCRmfA79eKWHhgZg9vRx4r9ws57FrQz50RQ7RgSSSqWVUCXnBmYU1tw7cZJNld1O0ooW8uB1ExpqLbNRtpoon24hV4zmFxQYtbo7PmQJTk62Kzn41iutblntxltdcgIGpkUCxTDk0a3tmSDFL8mpsCpWklPGRfk7lqqDMDT+AXPdLUWovH/IZQd/cGFZ66r9H4iccFSkD/dLXo08c3YSklqInHCg4fIVIvbRmiG+WEfA==
Received: from MW4PR03CA0299.namprd03.prod.outlook.com (2603:10b6:303:b5::34)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:50:49 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::52) by MW4PR03CA0299.outlook.office365.com
 (2603:10b6:303:b5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 19:50:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 19:50:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:50:27 -0800
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:50:25 -0800
From: Chris Babroski <cbabroski@nvidia.com>
To: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kblaiech@nvidia.com>, <asmaa@nvidia.com>, <andi.shyti@kernel.org>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH RESEND v1 3/3] i2c: mlxbf: Remove unused slave GW PEC handling
Date: Fri, 20 Nov 2026 14:50:08 -0500
Message-ID: <0c59e563f999e2c9c5bb41d62856d45bf7907526.1795203929.git.cbabroski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcbaeb8-2445-420f-c02d-08df473f9354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|261009223027099003|261021121427099003|261102123227099003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jasONnOv0NngQKmT3aPA0zjdat/KkBZdO5Mbza+HsdfZaOo3u77wDnSieEoD/1Mr677RQB/EoPBDhco9mI9oBHkqe5/4Mwe8NQXgohDpyw+zGsINSBBzp6tJGWUzGabr+YEf/gQlpJZBbYUkGV3JZe5MCgpgpc9eG1I8oCdGIZDCTMckRUhjz7UxOkEzEhI8ZRYE+GW0HjYCq34RrqvPixzZQEbRB92CUKv0V5W31y4S3pJaXO3E04tZBWxmBvZOo/u1DF0H8Qonn8CMWo9IZzRxO83jGI6/1uQftv0mrCVhKNA+Zx/23kHHHdImuyWp5DJtaEv1pl9L/y5MOhZoje0jCl2rojiVLupx+AAQvy3Grl8XEX1+R7gW4K7V83+NlM7jqrK4dcUOa/pDUjsm0m5++YMpFvaIqj92+yZfJbzmO8psRRmRGwCYuOYjKRl3ILxmLrR52j31fzDngnwdSE1X0RGEeygbQiQKue/0M8Nf/eTtaWUQNOSMXNPX7PG8yPl1eCEIAguuWK3X7Nxw3ghrousMqQY1X4ANENvyZ5OzwhIkMEGBlNS+CS7ANIWMgxaNAO6fgFThDihg4T9f1XJ/DCrcJeqyeAFTdX9D4ZzJ8LIceQUffVLiA/CJ0lAM6Bbi4ruSfQYU6toCur6T3KNslRXFY/kJq1XuepEx+8SrUHjhkT2Fm9xIUGzD8vnTCyh8k+OfDeCobslWpnCSSg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261102123227099003)(261021123027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o4J2TKBdANnOZipf0Mv2m32Suv080EMAt43QBdmu/r59LhLJ/v89CSIwSngX6wGmENpeUeNTXYdSrr+oGKp2VUuL8CzK0Dpp1YiE3hnos544lp4Y6CNNeIf/7iaFw0qpfXgznkPLlyOZll3/z465csyNcfCO3G1j5ytWwZUib1TGOlbtbFDkSqIFK4kh3Yd/ygltEXm3GoGYSCQo0+7UZVOD5UdeUBft53LiSS0BDqKljHL+ZBC9JNaJroC1pwvr+FK+kzYjxGquK70oMlicJBCJThhdAz4UoUc3XLm6AXXPzb+o9drPQB1Ly+BFJ7ciEsehufO+7vTCePm7k2/HDZkRwdffM+TGBO3Wyd8FlfKZ99eWoX6jlnbD5UOj/xX9jXYTV7gQSNqF5YEo/93aCLBGkcIpsW4O4lXa/T1prD3PH7JTe9GcWSazN9CagemO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:50:48.9886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcbaeb8-2445-420f-c02d-08df473f9354
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284

The slave gateway control word write always cleared its SEND_PEC bit,
since PEC is not supported on the slave path. Remove the dead pec_en
local variable, the corresponding register write, and the now-unused
MLXBF_I2C_SLAVE_SEND_PEC_SHIFT definition.

Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 22874ec4b45a..e330a0dc5505 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -288,7 +288,6 @@
 	(MLXBF_I2C_SLAVE_BUSY_BIT | MLXBF_I2C_SLAVE_WRITE_BIT)
 
 #define MLXBF_I2C_SLAVE_WRITE_BYTES_MASK  GENMASK(28, 22) /* Number of bytes to write. */
-#define MLXBF_I2C_SLAVE_SEND_PEC_SHIFT    21 /* Send PEC byte shift. */
 
 /* SMBus slave GW Data descriptor. */
 #define MLXBF_I2C_SLAVE_DATA_DESC_ADDR   0x80
@@ -1821,7 +1820,7 @@ static struct i2c_client *mlxbf_i2c_get_slave_from_addr(
 static int mlxbf_i2c_irq_send(struct mlxbf_i2c_priv *priv, u8 recv_bytes)
 {
 	u8 data_desc[MLXBF_I2C_SLAVE_DATA_DESC_SIZE] = { 0 };
-	u8 write_size, pec_en, addr, value, byte_cnt;
+	u8 write_size, addr, value, byte_cnt;
 	struct i2c_client *slave;
 	u32 control32, data32;
 	int ret = 0;
@@ -1887,12 +1886,9 @@ static int mlxbf_i2c_irq_send(struct mlxbf_i2c_priv *priv, u8 recv_bytes)
 	mlxbf_i2c_smbus_write_data(priv, data_desc, byte_cnt,
 				   MLXBF_I2C_SLAVE_DATA_DESC_ADDR, false);
 
-	pec_en = 0; /* Disable PEC since it is not supported. */
-
 	/* Prepare control word. */
 	control32 = MLXBF_I2C_SLAVE_ENABLE;
 	control32 |= FIELD_PREP(MLXBF_I2C_SLAVE_WRITE_BYTES_MASK, write_size);
-	control32 |= rol32(pec_en, MLXBF_I2C_SLAVE_SEND_PEC_SHIFT);
 
 	writel(control32, priv->slv->io + MLXBF_I2C_SMBUS_SLAVE_GW);
 
-- 
2.34.1

