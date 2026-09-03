Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306994FB9D0;
	Thu,  3 Sep 2026 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463259; cv=fail; b=BbIQFiYjyZ6QaLlJWnJvPINlXbtMi83I5GXjGSXkSjTgoU+dUMPEJ1pTW7UTaH1U68XpyDnErNm1cghbdRfBLBIYEp/X7cg6uq+/CalMwxsZfJrJZV00lnD41XJ6c3fAM1Kq87V/rZmtBWNFbl/hp9PqxDrZxSoU0OGD1pmjNuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463259; c=relaxed/simple;
	bh=JHX+ClqCHmbl3yxHj1j1Qh14p/CoTzskApT/G878HHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+Ipolw9YGs9O0KrIfjv8WKS5Afh/SemXCmmiKkQU1hg3EACjqqZ7rHvCc4w3HGpBNIuoAeooooKP5my04Fwl4tmDe3yMmpAGK5lqmhvPX8+31oWdHo0NllSd7LhhkuaLBaL6L2B8SzqlZ7cGWJbie1TFVvo3em331PrQ0CFxz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/lp+ZIu; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/lp+ZIu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koxi0eJoJAgaaQT9TmdyrMSgAkIsHGZ5SpG4zUDudHXlwvDX30rw6OFfQ45/XXU+AVMbc6LQJUNoFG9GVpXBdOsnNdpA/AegB4X+zdxs849EfoLvKdr0mrel+dQ+tPA/UIfUDKHJuQTA/e/PWisB/cZ3/Bz59MddBI89jsAUvhSpNTzo0ONt5TwGxgIVhEGMHIDcJDpQOuPh/I3k6Av0Vtv55PPClRI8siYdERP6cuLQ+WAGhCpg4BhImHGYNj0U6dWcZ0/+PSDGE1NYtYlUUX9cMAAV5KnEftsYXPNmxejuu+1H7xy1hqa/jvrBZU2qgBLUsol9fNaHJ9kqx+/KWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pOfT5NABTVSjGQyUGnhcgDtMcasbgfkdEocM6q3KGo=;
 b=JuXGydAwfcWwQri3coGZ+mWVIIHrguKqvt6SQG6cCjmPEw6GMZPUMD0nxyxvmVwJzvz5A42FP4b38fdN6t8pjghWQ2ikMsOK60agn08L4wmhtJ3QsXW8N9eSysNVvRXNIWVxrEiUOqJAr0uwbZlTEaFC9YQDzkkIkt2E+WYZlwuCYwxboavwH87xlIZZXf3JIRG8iNMhemRZAsyo64k8+kpQKOKzGYv7Wz732ArT3bkgq989H4f4MGm6//ezz2wna9i5cEDQRCM4IL5RJwKHQyU2tEGXi7G5Vnqrt/srerhFah207HNTHNWzxhqWnj0BISzJYiqPwj+TyFkSXJVILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pOfT5NABTVSjGQyUGnhcgDtMcasbgfkdEocM6q3KGo=;
 b=O/lp+ZIuWSFsEAfIx+I9p4oFWwn+XT+Gg6Aj90oSopLre3QrDae4OR+Pme1u9KIUzLLMXCA0DtpLb20r1RMBhKitGx2JEjjlFMJeAis8+0w6404pVM43mFZCanaULEWn9gwZ4yit8TW0Kn5Msmttmz3WwtrBT2+jFcGtXqdYIE6ML8kXtngzMrNdUD7/OMPm6zVkh29mBGIBiRHAm8ZNF0aYM+2bUWIWh4tbRu9Jqo7BVxK/EehY+cNNL1SUJC1O/tC3CBe0/EQt+3BC4+znG1X77hT/0cz7eKP7z0FveBA/qFQdwRPeKOWrHtRdGulfZlSYowam8+pIEm7FrQQvlw==
Received: from CH5PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610:1f0::16)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 19:20:45 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::2) by CH5PR05CA0003.outlook.office365.com
 (2603:10b6:610:1f0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Thu, 3
 Sep 2026 19:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 19:20:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:20:17 -0700
Received: from vdi.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:20:16 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v1 1/3] i2c: mlxbf: Fix master GW corruption from unmasked SMBus flags
Date: Thu, 3 Sep 2026 15:19:59 -0400
Message-ID: <20260903192001.114263-2-cbabroski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 74483bc8-f51d-4769-6661-08df09f073b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NdU4eYKGzmkC3oNSTqoj/N+VIKum1b2NSGI/hI0kJGnQ6tF2O3eYCVTD+99ghEF0X2r6a1dvnoQTUJ2zGqYrkJAmTYYQG2sRl8mKgOX4PlracQORr71E5yqv+TfJIte1YfObTHtQSDJL7stDlsffbPSKBVEB8BG3XVEclj/5LbFR3gUdUggI3w5Bf1LTTSTUH6/173B/OY28p8YyfiLkb0C/Eq4GFntpa/IA9pqVfnxNjNtmUJZKTaoxTnLjZU0dEHgxvzHBOT1I0CB+NqPsdAcgk5N44X5HqXL3VlLhTKclVXNXQWkNZWhoJZDO1CiPrmecGAUsliubw7ODJhREIx7z9b6E3Oqhm/86lTsxvL/PDPd3wa6EMq1fT3qdMMbPKPAzKtjbjQ+t6DhUcDidPmj7gkBtsWEZHhziA1nCpbuzjajv7GlbzOBFGu7IkgWEBRRqAsLlq1b495/yD8I+IFOR6tB4CoETCEm3MNGbfVU1za5hynT2taKJsKmxkj7aIN1npr7H96mNZ3KPTS0W3gM0kq6SAyW5tEGvWWx/VnHxyUN7+rJeRptu159kKF3Xj+CJF63a38B7XMNHE/5kR7So1qp5v99PGMp7WEu271mLw0Z3oKsUTMM8/FdHTVJULGEEy7feArSbyo2JJXjD5GVlbvpGP/TePsMxlA7eD5HiokjfZGl4XrY4O33rf/ycO1PfrKpphxZVb7w0hPQvaA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6a36oWqHRBh3HKIUGxrYyP9YQzKjfRos0VR9S9eupM6VnXLFZw5j5GBPUTtj3cTYv0UITvoxjp19zbbDQreRb3pERTjPB+TvjCw5+U2mo6mBpb0iPUbCRjRSn3uEVN1ejE310CRGtf1xsFMxaahO2jQMr8ljtJ4vyRyd0XmGmeSXX0ucQ/8BAkV4Qn4BoU4fYIE757dIReKIqoHdYaaeVKTJkRLN2+CwgjGl6X0J4l6C04Mv6jAnIR9jdEgppQWdSMUh2K10ePT1N4ZOxhmBtYp/cBLXcFWGvZeaJ5zoGdEk/e4ssgk5Dtr3rnawuowO4C6hrAwpUvNHczY0WwssKR+ZK+RA8D/0FRk0HSDZbC8AawnGnaq9jMNm1wYcnvH3eWrEvsQsS6Uk71IWTtUgtA/IcN2HuU15X6tykJfk0AfEJfUUnql6K0vMCVEImrX9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 19:20:44.5924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74483bc8-f51d-4769-6661-08df09f073b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611

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
index 24ccc4546ab8..93fc9f0ba72c 100644
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

