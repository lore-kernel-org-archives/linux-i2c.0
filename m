Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020077.outbound.protection.outlook.com [52.101.225.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A692F0C7E;
	Mon, 21 Sep 2026 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996812; cv=fail; b=l6p7LkmvYmOr1VPSlVesmppj1impMw3ZChghk++/WGXNDUTOF40kH+SsJV93eJmoNW6n5gGF7sNAhRz2U2M2GRdiT9RBJEw9MSEAI+HnsKTOz1AiytgjBdPkl2Vc/wxEIe0sRpoxgabi0ctm47DI1jw7FSRFPVtWQyK3/k1swbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996812; c=relaxed/simple;
	bh=1zZ9c6K2Znmp8LFq8hes+dnnwt0/EXR/31994xs70Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPFLsZB1r6YfSVvDgG93kRtOEXIcx/wupHKE4bJ1JImngJL3PrHhBofxZL0d6tU+iPNIEz5D+4bmi/MxKDW2kGALbwTEBbSPyk9lActsboXU+zKT2wvePjWmM0TL3tlX4V1rL1EKRr7nBgy7pk856E7cO1yoG/rl/72y9X1Bxx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com; spf=pass smtp.mailfrom=ebytelogic.com; arc=fail smtp.client-ip=52.101.225.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ebytelogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnSDKGJ/IAk0QECEHcEkEtkRoangJtsuY/rXqcNJsyPLSEQjjXs4yNdmC6M8aKisK9idO39wted+sPleDvKyTsWKXpDYuBf+7NhdSDjFDVRsKmPR6xfsuypcqA+WmyXpJmEUj70kOKbQkaWsOPvYxQhjPLbtRWeW7+hB4g0p9S6bggxQTYcZjjrMYiwmSH7lhypvBPkgnlONPUgbb6ScFqZH9UEwxR/JBwU5Z70lXMUr/HAcBHIo38MZiiyJZtaWOkZOD7oxkTS7QJuI+njvGfiOG52xbgsGonOFDVakEbXG4uFBHeEYYdY33guu9fcTTVH0dHtTmMPZqzoqYopPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdroRQGCPM95AEgZbb/z3YpXKtbYRNlB1Solc71c3l0=;
 b=dbLBxTjJcR2T08l8iNFIcS9O5YWcmbAMiE7T4USTbO1EPHQzHmoPC7loZywJsxVK/KcME5T8VpVgiRIrn3Mp7lYqqgIFpoZiz+cSqkKuX1rdBnEOGiqoVl4Hjno6mfOkdjSHsHSHSA6X0AzlwhrO6GHasR/uRbyIhV15Q8p+WFbh0/7+b8ilsexlqTf4HJl3LuKXdH2fqJStY/ANp6eYMljKDA5vmaVFTOJBBxu3Ds53h/roB8saf8b2LGrvO0/vT1WDifC+8jA9PJq8pGfGRGKz7Soe0NQ3sZBvxr878GdHAAhcJvM8wKBtBfiS1HsPfKUn1iwQLHItW/P3D5ghzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ebytelogic.com; dmarc=pass action=none
 header.from=ebytelogic.com; dkim=pass header.d=ebytelogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ebytelogic.com;
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::97)
 by PN0P287MB1014.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:144::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:20:06 +0000
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e]) by PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:20:05 +0000
From: Hitesh Patel <hitesh@ebytelogic.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ravi@ebytelogic.com,
	Hitesh Patel <hitesh@ebytelogic.com>
Subject: [PATCH v2] i2c: qcom-cci: always enable SCL clock stretching
Date: Mon, 21 Sep 2026 18:49:54 +0530
Message-ID: <20260921131954.1690578-1-hitesh@ebytelogic.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914132328.976902-1-hitesh@ebytelogic.com>
References: <20260914132328.976902-1-hitesh@ebytelogic.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PEPF00000183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::49) To PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::97)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PPF28092842E:EE_|PN0P287MB1014:EE_
X-MS-Office365-Filtering-Correlation-Id: 26008f1a-f772-417d-1c69-08df17e30cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|52116014|376014|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6AHdbtdvhGKi2V8Q74eakZ/sU8VCbI7qYToRoC5EtWwhJkR6YI7HxubmWfZtcbEzbEys/RdrPE6DvPsaD8iFWd7Ubt1Qtb9EYeYPPsq6ds2RS/KJolL72YQJlEgh0DYnOH/GBpAEfto1nN5stLmHhCWAQyQe32DzJSAmfHEBKG1IOVHZvsetudBp23ClhvsycS59jCbq2adGBuliHChFVGVSQl+PpFAM2ww1YSCUu9acFY/dNVIlutWiF02F4lMpVVElEi2Dxts2faCFe0d+YMhdbpXi9YQDSblckfs5sOMUbTw4NY6xb21+L5WqwvX3vqacS1wXGGkGIHwO1+rD4/NfwmF4Cj3WRUNizC3LranrEKMRwxSaS4r+S44cekh3Txx6C5NzUvDDbf7RgsGIsjfX+ADocS4vePXNRbAzazWoUmFzYYI1oRAfK64Y689WKlBnSCB/wSHa9aEpz2+Wti8+3k0QsaTYyHZ6Lv9MPcUbcGGG2Y58unoWwBPco/TtxOJerYS179ZCx0N2xNjt7w0GvX87Y+h0TRN7ccoKdYTClnGEg6/tH7+LwE+V7vTzhLG5WRVzACOuoumc/dwhFrPZfDXsZb4BlozVwAgBvOy04x/5wza/3RIicAy/oA5B5zufR5Z5eM1TeDoL3zBywaH9kYPMY6CjRCpMYiydquk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(52116014)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gjvY9d/xokGkwfTuJ4o6SQX/nFySs2VJz6MebQwIREUMemkRBV0iEp+gKzC8?=
 =?us-ascii?Q?ZmszvXo2ASOECbjGW0svAjxRcj81/xCjweUwvdP86BP2uvyzkz1qchgqv+Gv?=
 =?us-ascii?Q?IfBqtHABQWajkYDbBuMRPsAYU6W//JAMG343NafCB1wl6UozVVwZ55Wlbuxx?=
 =?us-ascii?Q?tUYzxC4iBMLJFidd8WBcad3wAPO555rAaP+plkM1BGcz27KPpFFXUcq3TRyG?=
 =?us-ascii?Q?Zbfd324wDBi4qLU8L266J5uHM7s9CEG9WTgCEmbsf+IurPkBk7BbfWrgiFMa?=
 =?us-ascii?Q?4FaiX2mR7GlV247eq1G4CYXTLz4wK+ufIWXThJiTQuZxY9iZJLhxCH3AnkEO?=
 =?us-ascii?Q?q9Rut6dRfP9rhQHnM1gNuFUEYwbo2Z+532Nx8hsuC2FBG747y1i+6FkVjcg/?=
 =?us-ascii?Q?S6r36o5zDsDhz3jLMIssSf9TWMtzS0hCV9e8gDcwCDRDXv9CaV7WZkfClkO3?=
 =?us-ascii?Q?fDBLJal2Bw6jExHqTs1/ma670ur8cF+YCTWww2edB6Z5ni8LRKi7JARr6HTp?=
 =?us-ascii?Q?l4miIPjoUaxmg3GCBPXohVcrSmeRH+6ot05js+B4OpZUFoY90HF+TZ+qrFgm?=
 =?us-ascii?Q?0cVgJLI2h/pHt0eltbgRrQIzhILunNg3NTWI1vZlaMZO101AvfrL2P/CmyZx?=
 =?us-ascii?Q?1Vc4eX8ZmcQuGNlcFztjXyu4Z3EK3p/hYnn26fLOPTRXbEliU1c10NM9CSH0?=
 =?us-ascii?Q?xAntpMtN4YxZF2v9IJeAx4yXZYRHCrwqIbv3ZU4JtJHH2MXdLzsYq/CCCBIR?=
 =?us-ascii?Q?W+xi70fYaFoSghV1TQJpFmsqPiEBobmMWI2rz3pB/D+IsePTni/uYSjKKfr2?=
 =?us-ascii?Q?45GNsDiPesCq7SdjIiju80bFX607J2zCFIkCgn0hLF8tK32qUyA7bUKmR0AL?=
 =?us-ascii?Q?dXjLIpIk9s35qb9p96rJppleoZKK9mS+iLqA64K9FVmPJslqe7pJnpyt9i9p?=
 =?us-ascii?Q?w+hzJdcWuNYBBnyK9XPNyd+gLLOrRJGothZJbqoReeu2B54tMR8O64Z16t57?=
 =?us-ascii?Q?uP8XkR9ji5TAPR0fkdmJNJGcb0cKwsyRz/HvPawdKqBJOMlVJU++AkPsF2dH?=
 =?us-ascii?Q?q39ohuwFJYlPGzgNZVKU/6XMYtknzG4RIGEbCB/ydUK7DZ8iy04inqJqr6x+?=
 =?us-ascii?Q?ofKcL1x2fF0SNLnq29GKPoXXPqYo9Yo4yjIsG5G7bwUkFYUMAQWx07lM31Rg?=
 =?us-ascii?Q?W8Vn8wxbtsg3McYq2L3PXxC7MZ9kE1meVzENhglhxWbtu7OJcAxBI40DDKdN?=
 =?us-ascii?Q?bqTc7UGHXUxGovly0BCsP8miRvYaoC5nnQURuUY1dVvqgRibp+PID7mX1rN7?=
 =?us-ascii?Q?8PRhOrmDxqC+hwNF7P5Tvui27f7lbZ1eNT1BJ1YAyf8qzktwRwsut0FYtfbu?=
 =?us-ascii?Q?i3254P2WyvdQCxpLAlNgm5SMMrHK4TQtgl20h8FIwRL667SCMxXzw+R0iWot?=
 =?us-ascii?Q?y3ujR1+rM68f/r6vLfuqOoStI/rrUKBun7FxNysMyem1+1MnXUizOceQ5Eqp?=
 =?us-ascii?Q?78ie8Yl9ZZBEwCY1yPw9Ku+wG1nXc+/N94pILGgR2zDRNy4TVjmm+UtgZ6vt?=
 =?us-ascii?Q?iavcpFMpWH61ccsE8AGXrTRZ9vmXh5W/HU5xRFgbDqBiH07ESt0mjk7sC2Q3?=
 =?us-ascii?Q?n3cODx/uW5LASvtMrZEV6vpTBm2/diwnmjxp+cTIplqnK5AwLOOB+tAzU4ec?=
 =?us-ascii?Q?p+nUFZY5igP8TgSoSLk7CWM3wUJke8CBh+AYxewUzLMeIL0ynUpqKu+mXhiX?=
 =?us-ascii?Q?OPm6ciFlMBQKudx+bb5Bm5uH5zW9xpUMMQVjJIdtzUDicIKbndbbzZUj6POw?=
X-MS-Exchange-AntiSpam-MessageData-1: pG/p6CBc7mRzZg==
X-OriginatorOrg: ebytelogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26008f1a-f772-417d-1c69-08df17e30cd1
X-MS-Exchange-CrossTenant-AuthSource: PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:20:05.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 13bdb17c-4ae8-490c-90c1-ec8121ef96ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHpXM6+x7b+ZwGdjkLEJBCrf2GVABDUiJQScuULCK242xCV9f727nkXAjgGC/ulwzJnJeqT4DPBYIyU4EssL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1014

Every CCI timing table except the msm8953 fast-plus one leaves SCL
clock stretching disabled in MISC_CTL. A slave that holds SCL low is
then not waited for: the master keeps its own clock timing and the
transfer fails with a NACK or returns corrupt data.

This is hit with a camera reached through a GMSL serializer/
deserializer I2C tunnel (MAX9296A/MAX96717 on the RB3 Gen2 vision
mezzanine, SC7280 CCI v2 at 100 kHz). The deserializer acknowledges
the address locally, forwards the transaction over the coax link and
stretches SCL until the remote side has completed it, which takes well
over one clock period. Without stretching the register reads of the
sensor behind the link intermittently return garbage and writes are
dropped, which shows up as random sensor init failures.

Clock stretching is part of the I2C specification for every speed
mode and a device that does not stretch is unaffected by it, so there
is no reason to make it a per-table parameter. Set the bit
unconditionally and drop the scl_stretch_en field.

Signed-off-by: Hitesh Patel <hitesh@ebytelogic.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 873e901..fbd5507 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -27,6 +27,7 @@
 #define CCI_I2C_Mm_SDA_CTL_1(m)			(0x108 + 0x100 * (m))
 #define CCI_I2C_Mm_SDA_CTL_2(m)			(0x10c + 0x100 * (m))
 #define CCI_I2C_Mm_MISC_CTL(m)			(0x110 + 0x100 * (m))
+#define CCI_I2C_MISC_CTL_SCL_STRETCH_EN	BIT(8)
 
 #define CCI_I2C_Mm_READ_DATA(m)			(0x118 + 0x100 * (m))
 #define CCI_I2C_Mm_READ_BUF_LEVEL(m)		(0x11c + 0x100 * (m))
@@ -97,7 +98,6 @@ struct hw_params {
 	u16 thd_dat; /* data hold time */
 	u16 thd_sta; /* hold time (repeated) START condition */
 	u16 tbuf; /* bus free time between a STOP and START condition */
-	u8 scl_stretch_en;
 	u16 trdhld;
 	u16 tsp; /* pulse width of spikes suppressed by the input filter */
 };
@@ -263,7 +263,7 @@ static void cci_init(struct cci *cci)
 		val = hw->tbuf;
 		writel(val, cci->base + CCI_I2C_Mm_SDA_CTL_2(i));
 
-		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
+		val = CCI_I2C_MISC_CTL_SCL_STRETCH_EN | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
 }
@@ -659,7 +659,6 @@ static const struct cci_data cci_v1_data = {
 		.thd_dat = 10,
 		.thd_sta = 77,
 		.tbuf = 118,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 1
 	},
@@ -671,7 +670,6 @@ static const struct cci_data cci_v1_data = {
 		.thd_dat = 13,
 		.thd_sta = 18,
 		.tbuf = 32,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 3
 	},
@@ -692,7 +690,6 @@ static const struct cci_data cci_v1_5_data = {
 		.thd_dat = 10,
 		.thd_sta = 77,
 		.tbuf = 118,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 1
 	},
@@ -704,7 +701,6 @@ static const struct cci_data cci_v1_5_data = {
 		.thd_dat = 13,
 		.thd_sta = 18,
 		.tbuf = 32,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 3
 	},
@@ -725,7 +721,6 @@ static const struct cci_data cci_v2_data = {
 		.thd_dat = 22,
 		.thd_sta = 162,
 		.tbuf = 227,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 3
 	},
@@ -737,7 +732,6 @@ static const struct cci_data cci_v2_data = {
 		.thd_dat = 22,
 		.thd_sta = 35,
 		.tbuf = 62,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 3
 	},
@@ -749,7 +743,6 @@ static const struct cci_data cci_v2_data = {
 		.thd_dat = 16,
 		.thd_sta = 15,
 		.tbuf = 24,
-		.scl_stretch_en = 0,
 		.trdhld = 3,
 		.tsp = 3
 	},
@@ -770,7 +763,6 @@ static const struct cci_data cci_msm8953_data = {
 		.thd_dat = 10,
 		.thd_sta = 77,
 		.tbuf = 118,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 1
 	},
@@ -782,7 +774,6 @@ static const struct cci_data cci_msm8953_data = {
 		.thd_dat = 13,
 		.thd_sta = 18,
 		.tbuf = 32,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 3
 	},
@@ -794,7 +785,6 @@ static const struct cci_data cci_msm8953_data = {
 		.thd_dat = 16,
 		.thd_sta = 15,
 		.tbuf = 19,
-		.scl_stretch_en = 1,
 		.trdhld = 3,
 		.tsp = 3
 	},
-- 
2.43.0

base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
