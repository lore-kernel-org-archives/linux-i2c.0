Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022095.outbound.protection.outlook.com [52.101.48.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC938E8B2;
	Fri, 12 Jun 2026 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228298; cv=fail; b=evgxuFBnn8gCf/U8QuTgVUIL6dMCX5mjnze5k8i1qgB4sp+NZSz4tcg6K+cocrBvcQKDDxgUENGz0oo5nPnmnwDFttJgZReuJac1VHe9OxDnVKvcAT/08QwlXJqnTT6wbGS4iUa6WmPK+Cu1jDT6jm5PeTe/3zsGYrXFi321YRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228298; c=relaxed/simple;
	bh=MK3OswMhVZmw/T7fK7dq9GX/ghxdskdK82VTH194LCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oeGYlVmy3FyOKa/USlmcoE1WTcPIilqJc1oWVRvZX1FX/tFRcEWRZt9HC3UCTfCiucTYl2vZ0JBOiplQOFveCA5dsISq8evy7K5fN8EquziYbAObfw5Sy9O9AoMCGhz+e0TvB0LjF+bV+i6rw4PApcfzARpxp9WfYsqatS7/ukY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=XJENkXVe; arc=fail smtp.client-ip=52.101.48.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="XJENkXVe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/t0gQJs91wt8ZW4d9bxpkvbdEHlMQPQPNs9fEv7MPKzItM+NlurWOxOskH5+yzUqle1jVWwSC+QOj8pt2J74qBAlBy+k8PXQhCsaBcrPJeSj1wjK8gb6Tsx9vH1qgPMQspUpm52Eeo5i9UbRqUI8jTtBd23eZkUaXNunKmPtFnojxDtR742ThebyqT2kUM4cSRK6BcF+qk0LDswaTNGAJjRYQXBFnLhkapiAqpUy5pl0fufVRIQnfqCUrsN/s8rUQFGH8IKWghVVi/FscVJyp29ORUfO/n/ct42APrMxYL81+8yex2LA5X5PgKHg6hsQMZdWOLC9wG57buXMAG5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfSxdNYmNgkg+5z0UqbdnOVxDBUxyFjYlgRWmS/GfNw=;
 b=cAkRM1rgKfU9ozFja+1CjZD5FWPw8hWJ8lcrA2yHM4WX00T8Qe7zvVrfwW0BAd23szAnu0KK3+yJsdXTMQLWafUAFTTR0+f8E+EUV2GunOngMH3FwbaVpq6sve0clGAlAdGtMj8jK9DVL2ZwjUx4e1XJMTc14aq9Bn36u35Z1LJjKBvoMVp8ISaPAfOZ1Uef1CDOzxux0R/UafUorq9p0q9qRiGJejwFRSEpMNSeSmkyMCnZALdzQNnyrehls4Qhqb51Muk0kGKwETDVu5/vf+6H43y9bSf2wP62M+5f8w+r4t2++0b6dSg3RJabE07TTd3iI1caSMCtpKsPeKHlMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfSxdNYmNgkg+5z0UqbdnOVxDBUxyFjYlgRWmS/GfNw=;
 b=XJENkXVeROEZmBDRKszCiPybeYbsLk8mTBh2u/F+o4rLSrZgnDms+RcEnVH3yf652spewvasBMuDVocauvhlnunt/sJThwNBm2fIC1691rxipugBmFddSLmGIaqaq5eWAkI6tAQzjINrcLvCywy3ZwIQD92rL9+bIdD7n/7h/UWKef9apsHjUsDX54vc4nXAk++zuIY7tPxUygKOx5Q2dtYbFOiXkWvW/NY6JOBdIeklll2UPXDxLMB0soKzaoZMYwo+Yb9887QFtl0ZQ5WWATqHLsJUFpZBZksJl5chndMF0GIBi/yNkcoaBp65t/VNLBdfLLNCRu1voYEKSkHrIw==
Received: from BL1PR13CA0432.namprd13.prod.outlook.com (2603:10b6:208:2c3::17)
 by SJ0PR18MB3818.namprd18.prod.outlook.com (2603:10b6:a03:2ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 01:38:11 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::2a) by BL1PR13CA0432.outlook.office365.com
 (2603:10b6:208:2c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Fri,
 12 Jun 2026 01:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Fri, 12 Jun 2026 01:38:10 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id EE3204186B5B;
	Thu, 11 Jun 2026 18:35:35 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Thu, 11 Jun 2026 18:37:30 -0700
Subject: [PATCH RESEND v2 2/2] i2c: cadence: Add support for Axiado AX3000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-axiado-ax3000-cadence-i2c-support-v2-2-cfdad0534afa@axiado.com>
References: <20260611-axiado-ax3000-cadence-i2c-support-v2-0-cfdad0534afa@axiado.com>
In-Reply-To: <20260611-axiado-ax3000-cadence-i2c-support-v2-0-cfdad0534afa@axiado.com>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Swark Yang <syang@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; i=syang@axiado.com;
 h=from:subject:message-id; bh=MK3OswMhVZmw/T7fK7dq9GX/ghxdskdK82VTH194LCI=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhiztZEZXXs2kY6dCDsmmMqs5S5yLCfhdt/Zo+bLDz9/ud
 kzvvyHUUcrCIMbBICumyPJV51v+yVzte517V5bCzGFlAhnCwMUpABO5NYeR4f+m5fMmCJXyS73/
 E7hgQk31pLcLV1lmuZx4/5PH5ytrTD8jQ6+38ouL2y74Tk0Wk7H94SRYta38/FKLf3ppx3e5sZm
 dYQMA
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SJ0PR18MB3818:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b12b8f-9e30-4d78-3a10-08dec82342f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|23010399003|36860700016|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	a/B/f3ytEaX9J8ysKqoQJGtxQVHlPf0f431mIXTTCOMx9oEqG413/Zb274MhEsbQcfNv5TR2F7UUnpmHNBIAzhXs/RQrxitS0OEJ5mx4CFh6HWljEN6kH277/rvcyV7DUVIMzTAelJsHyiq1osdk/CpY62rFoIrGlFwZeXwR1skEgF2rPypLphORw+3KvRdY8yaBftgjlu109Jd0167IYe7prsi6BHZS67AFZ6fmtm513uejUl//0HAt3cLqo+/dxycLr0X49PsdSSZ7TfIqS3uGUvO9l/uhLPg/LWZCzT0QW+0SU6eVoN5EHl1BjMmTEdSWFjCE6FWWSzX9fxN3s3MI6uRRhAUs2jk0kfgxDMmhr1Vs/rTyVdOBc+zXLOkVmTL2RBLNWdMbPS8neyQ7bhn+LpPW+wqra+jMVSa8GS6+b25bghq6u52/ypmnbEJhKfRonZKsMaPhXhu8RCF2nN17bTXzLJqiF+dCfIWgZJBM3w4cX0qpqfN5RY6e2M88Vl3nyJS0jVVyYvkvYmdJePMkIgbKt9rKl+Kn/BRfSiYU7CrHRgBDKTogXlVvMnCqpLDtHdf++oXr38CJloQX59byOmNTVQdlgRTfvIi+uVjmmXQaEAzZCIV89gAJ5TxxlJdkr1bmrgszAucd20pfgV+1C34GNJdnDG255MJdU4FCxs4khM6iafBpMX2If86iG0ge4H/bo3krG4sKYJOsHbMzxmp50iS3xjR8LV3eFqk=
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JQox2XWHlxcxiJjI5dhvg4jN9OZFbbM4kV19M6EfGhWVe56GtOWaC5duFfanS4DZI28OfngWaDjWT6QzEIOHdgyxcEDdxEbZF5zXSc+0fJdoN+oxUdpUrbgNL+IluCmuxxw/NYB0T2GkMjgX8ki3RbTybMuDreKUU1BZTf4bk32N38JVNkbkP8NNALdbSrPeeNidArYje+RCRl6QuYV03ZLg03dco89W4Vl/x1lBqPvfchNGqqFYby4PNzYC5sTg6TwQ+7EZ0Wotu7+tqOWU7q5HOR5BWx4zvNv2EETrkVi1i6NG2vUFNnSNFaDZ2K4lOltXpjJ22pcNHFaaqBU+b55FRwrIA8M0Hzah4EWDpcNV7m+/uZaZ61MbB5egRlsqjhhwOaKTN1v/JbVq8gCy9VKNfUT37sP0AULVXJ8jX9xdrvX3R1cdLRoA1qWqTKwA
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:38:10.3994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b12b8f-9e30-4d78-3a10-08dec82342f1
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3818

The Axiado AX3000 SoC integrates a Cadence I2C controller
that supports SMBus Quick commands.

Introduce the "axiado,ax3000-i2c" compatible string and
add a new quirk CDNS_I2C_QUIRK_SMBUS_QUICK to enable
this functionality. This allows the controller to support
I2C_FUNC_SMBUS_QUICK, enabling features such as bus scanning
via quick write commands.

Signed-off-by: Swark Yang <syang@axiado.com>
---
 drivers/i2c/busses/i2c-cadence.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 0fb728ade92e..8079c045f936 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -128,6 +128,7 @@
 #define CDNS_I2C_TIMEOUT_MAX	0xFF
 
 #define CDNS_I2C_BROKEN_HOLD_BIT	BIT(0)
+#define CDNS_I2C_QUIRKS_ENABLE_SMBUS_QUICK_CFG BIT(1)
 #define CDNS_I2C_POLL_US	100000
 #define CDNS_I2C_POLL_US_ATOMIC	10
 #define CDNS_I2C_TIMEOUT_US	500000
@@ -1175,10 +1176,14 @@ static int cdns_i2c_master_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg
  */
 static u32 cdns_i2c_func(struct i2c_adapter *adap)
 {
+	struct cdns_i2c *id = adap->algo_data;
 	u32 func = I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR |
 			(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) |
 			I2C_FUNC_SMBUS_BLOCK_DATA;
 
+	if (id->quirks & CDNS_I2C_QUIRKS_ENABLE_SMBUS_QUICK_CFG)
+		func |= I2C_FUNC_SMBUS_QUICK;
+
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	func |= I2C_FUNC_SLAVE;
 #endif
@@ -1442,9 +1447,14 @@ static const struct cdns_platform_data r1p10_i2c_def = {
 	.quirks = CDNS_I2C_BROKEN_HOLD_BIT,
 };
 
+static const struct cdns_platform_data ax3000_i2c_def = {
+	.quirks = CDNS_I2C_QUIRKS_ENABLE_SMBUS_QUICK_CFG,
+};
+
 static const struct of_device_id cdns_i2c_of_match[] = {
 	{ .compatible = "cdns,i2c-r1p10", .data = &r1p10_i2c_def },
 	{ .compatible = "cdns,i2c-r1p14",},
+	{ .compatible = "axiado,ax3000-i2c", .data = &ax3000_i2c_def },
 	{ /* end of table */ }
 };
 MODULE_DEVICE_TABLE(of, cdns_i2c_of_match);

-- 
2.34.1

