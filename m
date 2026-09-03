Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108413EEAD8;
	Thu,  3 Sep 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463265; cv=fail; b=oMffOrmiIIsfb4Qnr9IiUG1DyKYgPP5iEz9Yytms5o4rfYhB0fVOvDVXp+2ya0d+3q8XbvFUoG9DHcMZtZ4pPvWqeuv98nZ5mq9MNcSRdHvPD0CDHHs6fzZAn42syUWSZF4m/CpM+lTLVjvA2Jabu1II9T2kNsvMpBERtFOIDQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463265; c=relaxed/simple;
	bh=kBG7JB1HUHF9YGiGJUkQWPVBXNvzJ+Sbu+LsrhRdJfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeSoShFLvpojG89J1FkoCt68/4g20NLK6KzwNdWU544i0EYfynkuvfUrCszuc/sCyaVre7A9HLIk96yY/KU5Ox4y5/iUeSSu/LdruNiAvkYcXCBazPAb2iyznYy1VewWQVOHoj1NAJS3FGcPy9tfC8PnL3Z4+N053O3gWTSmy/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kFwRwOLU; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kFwRwOLU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viUbpLB9yg6jE51d2EVnxozgqlAXo3uWl67NhATlEXhTt62i6U4QctGHNg980/FHAC81gUm01F/M6FKjmnc6CugZUzzd22ASZWn6GYmfinryH2+LPXVjD9gWnabGJhRXMteR+FpqsTC+h5uZIqen5N9IU8Lk4G9KBd7rSwOxmjIHgWoP0UA2wuhVH22EdCwT5Vkg8SrZ1uGlkNrYXxu78wPokG9Dl5Yc3q863SEZXxpi9xxgdPecjIoHXa8UmjswTeu8Z7cL02gidhX9LHjCJnJCYoxRAEKuFANCsYm0aYR4vT+nkCvTd65KBDDs/g0hngwBJo4wo0hCrKFDQEbwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NoZDDKdZAQt3LVexNxELn34Es3F/PegtKn6o7HV3F0=;
 b=cFNEsR2bnO1O11EKFN3bQUJ0DyWfkbgKzw0cF3U60nCnbxaWJUaIq8CQzlg4nqwn+T9Z3FQ1BqtmRR5kf+O6W7udO1TswpirMyL9v8455XuQVjjeHjwJ/3bhMbOvjMkO1ed1+3HVBvKY0sgQWwwYMYav+G0K+aCmC2zS2ynGm1d1tdIk6cLsbf3X/MlsAWYY7yWMFqkvX9jGmLe/392Kb0EdWX+B0IeYSJVzemcIsYqRp7w10UpWUV8JbFCfKMCIhVqEEZuz+JDlpoQNDw+PeM3hTibRX2hq1aHJAk49eV7GqG7lotRljfO9EEpPbXZWzGcKdAhb9YJS33Sua3hPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NoZDDKdZAQt3LVexNxELn34Es3F/PegtKn6o7HV3F0=;
 b=kFwRwOLUrVS1Nk7Dimsk18STIOcVTJvsh28ASB8CCONgqZBbPyGzMUP/AJOInw2ON6moB2SeDc9mctlvzfLCgzGm61J85fzxrW4+Nx+nYbfHnSfnHHYS4/YbBqOKvYoRaEyIkpiNYTZxYjko3U2adYXaf/Xy9ZmWS5V4YFZrmOKnIh5RihqivqYYBKxdpUsllJkakjuzJlvpLrX9G5iFpLzW45aFhLfAVn2Rj1QHbG2vKz0IbphlJQuDclKXrbbNq31Vn9S1junp9BMohYQYGPLpojDAVl+7gM/e0Gj5Om8obuckCAeSxTdfqq+Gwh5/GPABdeBYNpKhREnXlRllwg==
Received: from CH5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610:1f0::7)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 19:20:47 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::59) by CH5PR05CA0017.outlook.office365.com
 (2603:10b6:610:1f0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Thu, 3
 Sep 2026 19:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 19:20:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:20:19 -0700
Received: from vdi.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:20:18 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v1 3/3] i2c: mlxbf: Remove unused slave GW PEC handling
Date: Thu, 3 Sep 2026 15:20:01 -0400
Message-ID: <20260903192001.114263-4-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903192001.114263-1-cbabroski@nvidia.com>
References: <20260903192001.114263-1-cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: c78fef5c-2076-4044-bbf1-08df09f0756a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+7VZk0a7sej5K/QMS5HYqhdmMfqnNU+Vu9CtPh6sGoFvomyaYbwR0sBypl9mUqiMftehboP28dwqS0skFIdMJrdBBtrc9V5FW8XADJQBbU8GpolkaT7fZZllfXD5GTqHEU0+y3wObsRJATx4PXoojeGJQycH7yir+7NFN+9eaZAdcwkSmXaXYHxuAEFNRdUzyPz0MlCQrgEuw3ikERZ9CreMnXMzde6RcSvFfG9JVZqCSGVLzYXv3/jSGWXsc78OKTZftWmL57OfOmIx2CIQnQVbnGzVKCE/BscMqkwxvbwACqo2/ELMGyxcbx+iWj0hn5g6kZbsVBlbjvkyc2n0Tt9Omfr1MJsi/nyJokL/j15NV7GXEWoje8lb3sdHC/5tVdaTU6J/4vHk9zSFDm8L9WHmv32MPFPVo+aw5jhUuptG4lkfY1Z819lDGIRL0Z1sk3fMh9Dp0ET/nRZxjDjxNgFx9bBkUefgagGwMRXgl2X1sdANyaq92ECXHa6VgsMsAP0InAdrTBtKbSrOo92+jYDmii65THaPHXXOb667D8aQ6oVI1m6Zh+y0olr4t3ZqIfvc19Kd42qxtbcaVvKj/HCXYVq3RbYIe9WSMyav1imCSLyzktodjzYc/I0MBePeHgdSgkBC3h4Y8oZCHlitCjJc7NhrC+wVVjNCxz/eYo5yhGjfkmEEKmC5yQoSms9zLy5kMfgfzTrEXzFbyzxRJg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f7F0+BGXGakmkBuKCY3gxrj4Gtoj93oTS8SA0SDe7ZqvaLlrHSlxuSX1iAuAyvPvUP9YJbkPghEkv7YtgUKb2mYBHkGwtLyH5s7ivrhjPPV8z6+mN6FQBVMNxflwI4u9t1og59nxj/Ah3SHyNFsmY6ykt0ldSAv2c5gdKc/E9iN51wAPTf+Wdisfsx/pyIFOvhl1BtmbBZ6sK9GNR+1gu4mtnfOE9gtFcJqro9JFkTsAsf7z2i/IwqQPYILnPE5TAytPzVxkzKiVDsViWyBMzyFmemNrnyx5RiYf+RFT7Cu/heuGY+3S1kvmP/eSupKBZf/Sz+FdZzdhNTCm7Cg9+A/w58UOMsrXTS5qv3Rr5b8Zzrh6TPI/AAmGYCMLj6kHYjQtiyQH1irNpgyBB0Ol0ljOqJ6LvWpxn9bsfKqs+eEBDjJ31/28469ytGXP0Ki3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 19:20:47.4801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78fef5c-2076-4044-bbf1-08df09f0756a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

The slave gateway control word write always cleared its SEND_PEC bit,
since PEC is not supported on the slave path. Remove the dead pec_en
local variable, the corresponding register write, and the now-unused
MLXBF_I2C_SLAVE_SEND_PEC_SHIFT definition.

Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 2d2dc234db7a..deaf22df68d0 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -288,7 +288,6 @@
 	(MLXBF_I2C_SLAVE_BUSY_BIT | MLXBF_I2C_SLAVE_WRITE_BIT)
 
 #define MLXBF_I2C_SLAVE_WRITE_BYTES_MASK  GENMASK(28, 22) /* Number of bytes to write. */
-#define MLXBF_I2C_SLAVE_SEND_PEC_SHIFT    21 /* Send PEC byte shift. */
 
 /* SMBus slave GW Data descriptor. */
 #define MLXBF_I2C_SLAVE_DATA_DESC_ADDR   0x80
@@ -1822,7 +1821,7 @@ static struct i2c_client *mlxbf_i2c_get_slave_from_addr(
 static int mlxbf_i2c_irq_send(struct mlxbf_i2c_priv *priv, u8 recv_bytes)
 {
 	u8 data_desc[MLXBF_I2C_SLAVE_DATA_DESC_SIZE] = { 0 };
-	u8 write_size, pec_en, addr, value, byte_cnt;
+	u8 write_size, addr, value, byte_cnt;
 	struct i2c_client *slave;
 	u32 control32, data32;
 	int ret = 0;
@@ -1888,12 +1887,9 @@ static int mlxbf_i2c_irq_send(struct mlxbf_i2c_priv *priv, u8 recv_bytes)
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

