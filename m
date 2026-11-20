Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204258;
	b=Ny8Z9idmem+kH/GSmOn8Pls7bAdPmSld/9EMxwoigx0ZG4tOopeydCOU2fa1lJ6Z4pbq
	 M0hQSFht26gTyD0O5cbRjhamRAt6HX+9jYLFDIT5hEt6EPXRup+a68z+8x6q8RdbtxymY
	 dn78zeJr/CvF5ZPJ4PITNlnFgxCmKFiok/ON5OszapCE65IaXlRicZ8II0fRzwZeZnKT8
	 4DD73AwPzJVltS4U2jZamrzLEMsSREA+Wzh1W6DmRC6kH4Xe1PGA4ldHjanKnxsczRD98
	 kHAVNKUHrjGH8TVihscX9BaXJpjDeztXeLmnelGM3/Nmc5mll/6VyisAxDm9gwCQK7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204258;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3Gymt8W8zSy7Mi9nDy6iM3wq2YGYsYZhhJhaNmix9FQ=;
	b=SKciUP+iFT48iQyaNic9Ve7slXhMd4dPCV0vAotP0Zv+IZPeWCvH5VGNUcR5scFLFimY
	 JNHRdZIIo2/aXPfdVY96R3AkvRGZ/Gl9J7HhTeglaPH0CBMVpD7KNGQLsQUpoY+xMoAyD
	 Zzrpsw+oX0fqDGrhPCCFh+KNpAhoFVL5HpUJY0sOesnN30gTbcaEZ6u5+893N2WYM/nZG
	 laP/KrDV814RtsZ9b+DoVsjJLZjaFmUG8gRcyi3w7qIxzYXjQqUdSXrmsmPcaqrf6D7xj
	 p8vlLvB2xXjq1tKDhkzqqz2PFFtGGI3v1xgxMfpBUXbAO0Vj5I+jKpsElSqlp1NqI4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jtBT1axR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.27
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E8606A6E7;
	Fri, 20 Nov 2026 19:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 449E8606A6E7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jtBT1axR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlBeNlSiD6c3Pnp/f+ED436k+/XmsEz0jBEsOqSfVIsalV6pGLkUdnLqa6L8fhtnDJW2Mp5EF7VGBKudykbzPlQJpKSPmKfDbJEjh6QLeDiIxSv+1f+UO6ZAFOP0n56+fZXCY2VRBLZnh4EqMstSgQ7puhrhROzR+d9wLl/okhVfMZVXkyZFo7itT8d33SS7bblAJevZllwvdWvh1YaJnEznA8xaB2H3gL7UbCUeMWEmC9xRgAhyQUpCA8sWjMhjl9UrEsFqpgbzqzbU5Pa/1/vO6XtFnuBmtGcniEo8UUUF7lUkRB+iFitZLOmTYuCeu++E8F7YGQZvGxfsAEQBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gymt8W8zSy7Mi9nDy6iM3wq2YGYsYZhhJhaNmix9FQ=;
 b=UYdWQzXHxL2Yf4r5QwhEA019SzyumDwkfH6s0g/p36s1904aNMgWj1aII3ylgTy3BfLwqIT48YYY7RD6/lgKYGk8mtDGUnqDGRaNFCDtIsAuc3KMyjgWYMGtYOaAS0BHLF1+vbCRYI2VHc2oSaZxB1H5WShD7CPLQCT1RhNIjWXf7+25wNRccbzA/czve+NwU1BGZZwLI+4wnfaKZyRdlzwDo1FOTf67UmC6wvHTy0IISej1VuilVj7JUZcforL28Pd5v6omElLtlEzX8jRvnuQfiaHT6ettO+qx7mL1+C6DZZirYeHxIbPFl/HZgAo11HKhn7wfFPMqSXBtwHcBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gymt8W8zSy7Mi9nDy6iM3wq2YGYsYZhhJhaNmix9FQ=;
 b=jtBT1axR7s+DrluOhuFLfrJqtaHIyT6i4/BXT0pWnC1E6fQzI0OPeOSOgMftmRrobS9FhTyzxbNSjL75VnK56dU4pK62k5i1ZvyRqxtPumCm/kAfzcdVjazImXR2SIxceD/d6HUlvHGcKyb1AYevhzlPSwGAMAqXjw4nMbh2kAafAsVj4zBk6mSIdlqJc0QYpsC6R3RVv+f7r2hwNWJeiYPnaH+hZnmtBTBXVT4+o+5hEYzgsbpGpz+jz/sMiMFcnK7G4ftDhUHkoEhZIxFi2DQUoAL1bodKJ2HG+/eDnIl+koEfkrEcerO0ANnVjpLcwDfbdys3OhWTpLvwfuAcpg==
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:50:43 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::6e) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 19:50:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 19:50:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:50:22 -0800
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:50:20 -0800
From: Chris Babroski <cbabroski@nvidia.com>
To: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kblaiech@nvidia.com>, <asmaa@nvidia.com>, <andi.shyti@kernel.org>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH RESEND v1 0/3] i2c: mlxbf: Fix master GW corruption
Date: Fri, 20 Nov 2026 14:50:05 -0500
Message-ID: <cover.1795203929.git.cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 046569e8-11d1-4971-d065-08df473f8f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|56012099006|11063799006|261009223027099003|261102123227099003|261021123027099003|261021121427099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zsetJdU+psEu7wMmrg7xuoEER8MZjU65biRwzh5BcWUdjHCV+CMT0rfsQTDrDst5y8krx1lxeQEZR6MyTbQLcmPmw9zb7msaBRbca6MJpLEk6pA1U5g6PDn0UaWQnXAFSGINi4mzAeRKJ2VIZimd6hB8ONo4RVGjDDxsqvmnaf0I/pEcAnjN+j0JLVOhjekust5BHUAUuRxYwdwU+WnsC5qKAS1h4Ai2ZNIagFBirmVYal19v6wLAoI0s3OkdCXZ/CL7XHLXITipB6aGNPDZRyQm2AbgidlDLDnxdgmZu+xAz53CtaKBzvP8iPtWAgLIJc2+Hm4aSY80FN0fqOMjb5es1kxi2Nkwe78AR0Izybkapfv4SV3nWPimW5YQj8XoUREIhFLhBcRTmcLWKuMCZ17qhxRKUT47lLhCoARr/ZnNGeNAFa/8aSzQbZewIvpkHDjZB+nnHpRmmlKh0LD534666RBIQq36hHhu0+1yeqGSkUV3EnAhDbFycEK7Vh96oKXm4dbfXmHb1z458bxQdEfnGb6zY6NhHCObe+qQFfwHLEzremY4Dr9/O5x5U2MI/sdyC5ZeG7vXUbuukEs+pAmbV9ppA19Th3K+0D9XXY61U7BkmKpGX8Q9d1ZZW/XfuRbTXX4/V5+Zz9COfxQMNkFfLZBnjDcocuT2RuPr57YJWF7ZUkokScTIpSQw+mNFc0yBQv8quZuQvtJxgEyd9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TA4TiVj73t636mz4ZEdk8i9Fyl1DoibZVE+tf6Yg0JkigFOnnigP1gqjRFWETmhvfdLPobH/sl8wtx7O6GX8rKtiNZ1QYncuQS/pW8DH96Hqw/OSKMLlC+ibstk3H3sd9WO8MCpwk0cgWWbtzbHbMP+wPI8aGACGjOBlcCU/ZX74Vp3kqENprNo1EVji2s1CaZWqNG+dEuLncgX0+VRUwdG0D1cCr+5Ik/dFz6Ux+kpJETAPmy8oYw77iv/mDLfFrtCaa2BJRN+2OPUbyKpuf6KVrlfNXCoJ5sAwNZC0DVFT+y9qgSOWN64/h9KMcqOZSzaEL6rFcOjF/TjjJrqZAGQSDVPAyyXzXz4Q/cJxEc0rk476Vwllc8jvvDQtPjfPuU6juT96vdB9IbrKtaHJ1PAWpzJDeuI3hyOOPpSrBYOMhXEBBjgSb+lRXK3raYnk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:50:42.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046569e8-11d1-4971-d065-08df473f8f66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277

This patch series fixes a bug that corrupts the slave address used in read
phases and cleans up the code to prevent similar corruption scenarios from
occurring in the future.

When the MLXBF_I2C_F_SMBUS_BLOCK and/or MLXBF_I2C_F_SMBUS_PEC flags are set, the
flag bitmask values are shifted and written to the master gateway control
register instead of the single-bit flag values. This caused slave address
corruption in read phases (unlike write phases which use the data_desc[0] slave
address value).

Patch 1 fixes this corruption issue by converting the flags to booleans before
setting their values in the control register.

Patch 2 converts register field accesses from explicit shifts to
BIT()/GENMASK()/FIELD_PREP().

Patch 3 removes an unnecessary register write (dead code).

Chris Babroski (3):
  i2c: mlxbf: Fix master GW corruption from unmasked SMBus flags
  i2c: mlxbf: Use GENMASK()/FIELD_PREP() for GW fields
  i2c: mlxbf: Remove unused slave GW PEC handling

 drivers/i2c/busses/i2c-mlxbf.c | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)


base-commit: 9c19b1c078541841f6b68f815bb4ba5201ab2b65
-- 
2.34.1

