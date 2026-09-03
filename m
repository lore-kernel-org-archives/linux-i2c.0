Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468073F326F;
	Thu,  3 Sep 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463265; cv=fail; b=SuO96eZ/TRiHYMBsusjw3O8ZbE7sg6EJXLc1FhX0BhZ0a/EuOh7wv7iMYGxgH9DB8iFViROFxJCl9wdOyB4izPsTMojrw4Im8Qg+mErQh2affSgs6gWsHy2OPIWXZr2zoO5UgXthoTUiDIBJ1F0HDdfJqqxyclvNH8Ve9fmuCkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463265; c=relaxed/simple;
	bh=WSty7POrxHuubrjL8qc1l/sbNrq/qcsPIXgEGlGr5gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qK24F/ZZNtkQa2BUgQT6+p+KPYP1PaIALVtBYqgDzpRKdnEkbSt1t9N8pOPlczJ/aYGv4hypjpqEAkbjqjeIEn6O0RlyVnqUPZmrXzsjUMwijns1EAGKxFIFoNH+d2qj20/jYwbjZ2FT9dNZ+JFxowdlbrx7isvYfCyCE0s5zs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iNmrbOks; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iNmrbOks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx5uN9NY3MVZSah/IPmEeI/Zl7Y77666qRZvJco70kGaLhldm95jiEk/CkuWVIhFPNZvu3vEfhmxiuSaBM891kzPEAXURTjINbR6hAl/XHGtNaQdDDonDcUJGjScbb4iOTbJVsXHAhKrO3Tf9R6wSJEZVK6DX8N86J/gy6Z+LaOblj7kOo9cSXamxS5xm6U1dl1zggYdYZU63aqRE/0XzFG9u7fYomgGEFcXayYXFL3PcnQtt+98WJmotW0ZBAi0DonmPKZ1JFC0dAfTVbuIjkGUuV/oriXqLJ2roPLYMLf4hQaSHJ4tMMQVoj99v4l/ngWKXnM2KZqytrRSXYjkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD9x1z3wiPM1Ga8e66LGCp0v3Bpu/rav0mT0ZgphOjk=;
 b=GFmtn8T00Li56PATTZUTRwBzb6qsxNNZnlQAjsv5rKeHspRIOaA9VHdhC+0FUMVHcuvlehIc+1KkAsA7eG1XYtwuqtoYkL+34xi7aCshWXDYlYf+Eyah5aveYQWzrh9NlbFNdrh2DoS2k+Vn4XYKn/tCYfWVhxDOCeZg69+Zo7MAc3caDL14qtrKgxaL/WqyK5U1c3/eLc8jhmU2SxlZYjaqqCU2r+SnoH5prVHy/7S0fo1czvuhBE0td2QJUmafDjLDrMZGWX1AbKI4EI/joQy+c32m44zEejjOQTRlo1ea7du1ZTfE6W8jC0Kj4H0O+mmG/gABuIMGIm8Cc4t76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD9x1z3wiPM1Ga8e66LGCp0v3Bpu/rav0mT0ZgphOjk=;
 b=iNmrbOksaFI+cgihyoFaVGA0oaCaBgcoxV0ZhE8JqQqYMGnWQVQs/c/URhzcCgzUH8xHxblJzRwqMUIqFSPHsYrmdK61cjGra23Hwe4LZB+5krOKf2nXMI59u4h5GWJ7VYWNJi86nHIP/+3zVh0yxT0UKAmDAt1T0MaBoocBEVWAAJ7Lbnewn+fx0mmm91w/WH0iDcM3fu76vdVNAjUiYTC65MuGv8T4RHkU9oXHJ9JsGImVZtefNT11slOHbWK177BsVJwHMGEHekf3Ww3YRSoUDyvRXYxhTGdCZFF44HrAPjUlyz36/tAfg5saMyOGz0Y4trhkTgAh1oBXLyrq/g==
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 19:20:47 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::a) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 19:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 19:20:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:20:18 -0700
Received: from vdi.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:20:17 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v1 2/3] i2c: mlxbf: Use GENMASK()/FIELD_PREP() for GW fields
Date: Thu, 3 Sep 2026 15:20:00 -0400
Message-ID: <20260903192001.114263-3-cbabroski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e7bcd0-4b8a-4246-c731-08df09f074ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PGWULStsDr3V0tcLb1ddWwe6Sk2AMu2Qf/qm2U0yweFysroVrVaKOtne9zjYU6zwV2Co54pUHrs0EbjQfzcOyAc+JYB+WqLxmytXvf9HbXjoxlfnXQBFiNcFYRbsBLrJMi4K3qOelhgokGwwdWQvdPki0vTRK//zSP7NvL00ncOlMTgqt02rx2k3To32LLfaS/RqQ1siSOxVYY4ljtYbyTx+5yZx4RD1ngCfyi0CjKO8BkA/5b9fgW3NV8amyCsVsUYsBBbyM76ZrgZD0OgAv4rj5ClguyMeonF9PaB9fRqM9RI+aPhx/OWVXU3w3amVrMspNWcbnv+zcaaRCncs0g6szZ6+vurtGHYmOeyhUK9IblIkexTzJ4sSplqjBEcOH/s1zClJr+ztmYsNbJcLWN9LVkWXspU2izTmdCFzY+C6RHL9hJ1Og+ditkXa4zu/vIFRviDIZ6Anz7eetp3czG9wNLWxyuL3VoeSS+8/CQa8vWxwpD/NKuZ4rqknEXsK95eOeSXeQue77UKz1AjPUZucC/qKkVUqVNofXI3d+e+9bNldM8+iAedgkTMBS1q5i+4fwOAczrLSCBU6RMiwMRzqClghl8SPvr5u46v8hAgay5vJ8NQHjrgE1gLC+izmH2AUrShelovxHnRBWxAsodLcEhXTjVwdNKckwy3R0wcdo3fXAxOLeTQ5/qr09pT0hc2+olVUHp9Bg0x9EQvp2Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t/9iVWhQ0Y5SoTMuSUo6c6G7EnKV3o4y19HqwsKPHSzuuxsYgS7a2TqKH5RD+YxZOkK2OjY4oAxux1VSWP2QpUL/XrpGpjK9pz7/WZ0KCDPB9xmPjSsQ2T6/yWyjWAN0nSo8z0zYeBxgij/40k8dEsIKn2jSmec6YPYZ4/55cQPcEk3yCsZ8pAcUucTrd/3g330S3o6ToBni9CGT6K7BEFVPeoHP9X7veoXqt+JJm0c9nzz9Mkh4YdnDM1rNaX6Bm1jxr4Abe4iZtFnRf0yXtDT6AdpTsM0gL93HnUUOtXh3W/6zHzEoaoaN9JDi2EWmMQaQ703bvL3JLKauVMZrq5ChsDQVyG8GYDek2Eq+rKBuyz1Qn/EclHneiBdqIpx/q6tRE1qpyTunhLwHYEwsd00Rgb+0qbaq/feHvu4dQrxfZuVE5GUfucqQJlJTYIxu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 19:20:46.3197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e7bcd0-4b8a-4246-c731-08df09f074ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243

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
index 93fc9f0ba72c..2d2dc234db7a 100644
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
@@ -1888,7 +1892,7 @@ static int mlxbf_i2c_irq_send(struct mlxbf_i2c_priv *priv, u8 recv_bytes)
 
 	/* Prepare control word. */
 	control32 = MLXBF_I2C_SLAVE_ENABLE;
-	control32 |= rol32(write_size, MLXBF_I2C_SLAVE_WRITE_BYTES_SHIFT);
+	control32 |= FIELD_PREP(MLXBF_I2C_SLAVE_WRITE_BYTES_MASK, write_size);
 	control32 |= rol32(pec_en, MLXBF_I2C_SLAVE_SEND_PEC_SHIFT);
 
 	writel(control32, priv->slv->io + MLXBF_I2C_SMBUS_SLAVE_GW);
-- 
2.34.1

