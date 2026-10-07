Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021134.outbound.protection.outlook.com [40.107.51.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A83DA7F6;
	Wed,  7 Oct 2026 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349325; cv=fail; b=eXq09J4ZPdX8tPoiERnYuSIGoVW52A6AGutvTbQvj3u4cTQIhpXkB5yqRT7bNCPhQzjmQUPEMmhyJQVXhWcW7/3/l5WWIC82oVbvNf9/IQ6ELXLd2brq/7v4VsT7lMX3mZ7IKX6QVnzF/TuxD3uHjVoq55k/QFtM/7bgcn7Xg5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349325; c=relaxed/simple;
	bh=X3hSQTYRVeSliAP652Yy5vmqKFYOBXOuVNQXKkx4MBk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s6bNdgEnBvr3+ADPUhXgHXXBYFjVrLi6nhSfLwVl9UQRFS0YLGD9NGSOgmSKUXYnULIgR/K6Aa3HWNYS/l+Iay7mNvTEh2LTZd7Z/2YKItZx/m4xxnRmTufLSnckKzn1HauxK7Uh4Eca4k3sSE4lsp8jp26ayJ5FExR6pmF1CQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com; spf=pass smtp.mailfrom=ebytelogic.com; arc=fail smtp.client-ip=40.107.51.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ebytelogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0UTj13ibUYTcIc6nn0141aCYZocW1Z9Q/X6T7dl2JrVaSZNxr7HDCy6yPamQDS4wrQQLkKooxvZVxwryVBzHSsB9hpOMSEW4oXNS46N0Z7AA3xHcFMUc+jGv3C30ET//BnBSp+koxdtnrsvCSWMZeq+7Nkkm8Y6TJbVFUoaL3WK9DpmsLGEJrqYaRrfVhC4Jhbm/pqVrmpIxoEbdpZQ3JwHzOTcDXBqyIjskJlvMjH0fbwRbWo/0HIEpVpaUcMkv3wBTsvn41IVVJaH6KpSLjvOY2XJdKGAdwTSGLvQ7nM0Dbn10G9x/dlQe2k33wPtOjBCNMsipJ1qF9HI0GEAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS3asAhk1Th+ShwYmVAxRnwpYcY0xvVwlDOtysZsQo8=;
 b=asqFHqLLzELWTWPY4RZ6QD3TbiQolYGUbE2x/Q3evE8jVkamt2ocjRthk+OOXZ2cmrqLeeq5w5E+d5bmrrjRi/bLp2k0VRNA2YOOtYdNXiDTLMZU2INqWSqDFL8T4GOKlXRSCS4L1JYwfzXZrmTDfBQWnFkCsPaX0LmXfFNVf+3j52OklI85fW2HUqar1FX5NLzzsXYHbkWMuThEhKnMV8Y6rlddcVD8+SKGQHWYa4N2jYgORuIoCF0iKhFv7BI9I1s8n7YeqDYNdoeFYfUBeUWNGbqvqsGSjPQ/ov+F1bwDXqPk+6AYNLQLhcqywTNwstVLOPWj8GiFuxlApyjFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ebytelogic.com; dmarc=pass action=none
 header.from=ebytelogic.com; dkim=pass header.d=ebytelogic.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ebytelogic.com;
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::97)
 by MA5P287MB5160.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 05:01:56 +0000
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e]) by PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 05:01:56 +0000
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
Subject: [PATCH v3] i2c: qcom-cci: always enable SCL clock stretching
Date: Wed,  7 Oct 2026 10:31:46 +0530
Message-ID: <20261007050147.274096-1-hitesh@ebytelogic.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::16) To PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::97)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PPF28092842E:EE_|MA5P287MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e57a43-7576-44c0-a908-08df24301c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|52116014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	qpJXrzJMuG57Rw0VJgp6vVsyaE6VuKHONzMbz+z4XtN8FMgzccmXWO/TPPGJopxUhFDrAVMlhopTdTYuQm4pp95eOyc2C1weVJHWSL705wsq5QMwEk3nXRMEvdvGwo4ibnqnwSmL70TnESE61AIJe8Dpg2XaTBZGzkZFUYfJYQ6KUyWMFFqgKNCtZvFxfhAos1Ryi2NC/jg8SEv0MKco/87FUCyAskSxD4QvcttlCXomMS/IS5XrP7C4Xd7ewoNewRFQGi5BjsWTr1sJwnP8+8cfbt3KL79RzGMayl44CW8lac5rz/l/ePjtrW7nARY7oL011Wswx9R2xblG1MV1hf0IMtzGsBKF4TDPLPZliDoqwgqsqh5oMhMG3KHeSyvIAZZL5klSFsIH6ZRPR99qPUYmwkYZLlGoHpcVWzAE0kHrlMzgYiFuxOD3Et4G6uumnUXTCPI5mcNUMHlIyIC1MEoLPo6WB3ylcuxCKs8czOSDVenfE6CaLFFVwbPXhY+Oe+21jUdIzna5h5WOZgiKd6kxi5/oLdAwrl54eZbMWlLQfnKW5c9nqUyVY5uiD9hvETJMgsW40Rtd9Zfrs7rhssDGA3UA1Tzwt8Vp7usfyvQI9ldJnwzHmZeFOi83fA/bfr2+iXepdGODsgCaA5Oy3rMeYRbTNbFe/wi8Feen30k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(52116014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idQ1LQw1oFZFYljFWHDLyovnxDfwqZAI8QSYxWazzAE7u84mk2DkF+MAP1r5?=
 =?us-ascii?Q?1ZBPTyM7XPSLXS78L/fXlc0e+ts2P8z1tztvN/MwwsfYRx+FJ7u8nx45I9cx?=
 =?us-ascii?Q?4mZU7LesPraaJxJKTFCbr4MMODmLyS16gBL/zlVPiGPIfVgQ4tzkFSePW+2t?=
 =?us-ascii?Q?aytQiMDvxYJuMGejSJBuie2wZpT5rY6m+xF5JxvFkyIWPO9GTHtx2xngmCLm?=
 =?us-ascii?Q?GKnf0iGqvb+AtPfCJrPArQdxASA9Z+cOLXn1rQHxyq+EoD3E7/Gnn9Gz7IcR?=
 =?us-ascii?Q?RDS7exy41IzLMwB2WBWLZD9Y2ozEU2QEQGV47iIiiPZQqr3x7WiUiqawWuUD?=
 =?us-ascii?Q?fS534PNSPZcmRuLarKczK7/264NB6l2F2NnP45MmwDrKC9nLHhJJFuRQkcVj?=
 =?us-ascii?Q?Gg5stK/R7UKtCgMmFsoXwoKGkfs7+BxGEzaltN7grCFT57EJgkX8iKH6z6Fj?=
 =?us-ascii?Q?b1ebd9Mtb3YhkfoqBOIvCaqCg+T1LD6H5O+31JNAgU2dTPn2bd6JP5DH21FK?=
 =?us-ascii?Q?QouYVYNiUVzsmJdqeMc9e2ddgojzEGKvOnJRBI5wsk0Sruq4zmGKPsoTFyS2?=
 =?us-ascii?Q?V3F6vNuwPwR6YTLMJizxbXo9GUU8PvDurT3XajQwR0NvNpSrjpDz1CAXAGiu?=
 =?us-ascii?Q?MN/irKDKLG42eJfgvKpQRJWLhq/HiI8gFSoY9dglLpXSOcP+nIkFj5FIZk4N?=
 =?us-ascii?Q?/ZdGXejWMqtY2/Fo9hul43+7AnV2fAL5IPZP2KLsEmkVuyViq4BTgZveG9oH?=
 =?us-ascii?Q?dJUAGkVWJuPWD4l7II/JvU0XKEXJxeXRRx5K8DRbnu8CGOIOdq6p6eDrvXOx?=
 =?us-ascii?Q?UXgpfaXTGWMFUZINBVXGybvVa1c5/PHptNKu6Lt/bZmds6aXJLhHoh8a8tZW?=
 =?us-ascii?Q?F9Wji20PwcTRVmoJlSHGl3FaerJpYjn9ZxuJ8Fcdp4Pjo1gMKgfxZn3sb40m?=
 =?us-ascii?Q?n3VTCWVmmBqX5XHeXP5gBib7q40hQERdpVqaXTuqXHu8QyiJqOkqvjJKbiZB?=
 =?us-ascii?Q?lKnXFtnSNxKno/N/K9m2RbVgaVkAWpChd+QjXx3xEzCcSTiqbGH8N3gNlLmR?=
 =?us-ascii?Q?JXcGGaWG3lVyJZk9TAHMqU8B2LkYAyL4ZlAZkWtY43D126WNGpxr8HPimfva?=
 =?us-ascii?Q?HgoWJVmWTi8B5MMGj/axfYZPobJFMElsZ5+R3r9Vywx/HFY0iGSkcqcerhPW?=
 =?us-ascii?Q?DWsZ0nkEqV6Rv31Vsq/HD/shBWn7baq2g8PI8P301K3iEXZpfaYKgqAyra1Q?=
 =?us-ascii?Q?dzwiR4C5job7nSRD6ui7pa/M+Op+OWWr4en+LAleaPFNkPRhgdMdcOKcmVQ9?=
 =?us-ascii?Q?H+FZIIX2ntChmpPMqg0GhQH8QyThi+w9kWS/Fyv4xRg/F1ApF23x3Ns88Gaf?=
 =?us-ascii?Q?fZoiKN3TSK5OCnfLM1i3YyivWoBuPsQyTW63aezoOjHbKM7JLrGyWG9luxZG?=
 =?us-ascii?Q?zUaiJShl0oa3mGXxjYe6+hj4LstPmRdD1Kl5UFU4JbDVFj/0LDaBIpDLEB6r?=
 =?us-ascii?Q?iGBX/PefLT1oPPGOtHtQDY/ZBX+hbRXfm41pv60cprR17ZVkUq9+7lCy1rMz?=
 =?us-ascii?Q?tpSmSXJkIyOIh5WSwroE/GOpmTMS8ITgUvP5ylYtXCOaSBFiPhjTc9GN/aEE?=
 =?us-ascii?Q?sM73IfbNlauySA7po2nwvLS3AxzTl4TeM39vLxr8RDKyLSSHpkWdLQpH+5pR?=
 =?us-ascii?Q?kv9ATsy8Pv6bATiQ16RwbpswX2JzhPi0odTKY5DCGft95/NVc67Rj8Shu3K6?=
 =?us-ascii?Q?Iag82wtrY1NPEa0Ew9DpajJpC9ljkdCyYe/z+dZ50Qjx5m6aV4PKalDNj+a2?=
X-MS-Exchange-AntiSpam-MessageData-1: QsZ2dWjZThX2+A==
X-OriginatorOrg: ebytelogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e57a43-7576-44c0-a908-08df24301c55
X-MS-Exchange-CrossTenant-AuthSource: PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 05:01:56.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 13bdb17c-4ae8-490c-90c1-ec8121ef96ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZOveZPZrnTzign8ptLjlYuDYvpm+wPMl2BebjSjhlRVEmf9iriZ5PkNDPmmfaphR1FCF78eqiLMNpDaLL+xlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB5160

The CCI timing tables leave SCL clock stretching disabled. A slave that
holds SCL low is then not waited for: the master keeps its own clock
timing and the transfer fails with a NACK or returns corrupt data.

This is hit with a camera reached through a GMSL serializer/deserializer
I2C tunnel (MAX9296A/MAX96717 on the RB3 Gen2 vision mezzanine). The
deserializer acknowledges the address locally, but forwards the
transaction over the coax link and stretches SCL until the remote side
has completed it, which takes well over one clock period at 100 kHz.
Without stretching the register reads of the sensor behind the link
intermittently return garbage and writes are dropped, which shows up as
random sensor init failures.

Clock stretching is part of the I2C specification for every speed mode
and a device that does not stretch is unaffected by enabling it, so set
the bit unconditionally in cci_init() and drop the per-table
scl_stretch_en field, which is zero in every table.

Signed-off-by: Hitesh Patel <hitesh@ebytelogic.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v3:
- Rebased on i2c/i2c-next, which reworked the timing tables; v2 no longer
  applied (Andi)
- The msm8953 table is gone on that branch, so scl_stretch_en is now zero
  in every table; commit message updated to match
- Collected Reviewed-by from Loic

Changes in v2:
- Set the bit unconditionally in cci_init() and drop the per-table
  scl_stretch_en field, instead of only fixing the v2 standard mode
  table (Konrad)
---
 drivers/i2c/busses/i2c-qcom-cci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 6d8be7b..04e3053 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -28,6 +28,7 @@
 #define CCI_I2C_Mm_SDA_CTL_1(m)			(0x108 + 0x100 * (m))
 #define CCI_I2C_Mm_SDA_CTL_2(m)			(0x10c + 0x100 * (m))
 #define CCI_I2C_Mm_MISC_CTL(m)			(0x110 + 0x100 * (m))
+#define CCI_I2C_MISC_CTL_SCL_STRETCH_EN	BIT(8)
 
 #define CCI_I2C_Mm_READ_DATA(m)			(0x118 + 0x100 * (m))
 #define CCI_I2C_Mm_READ_BUF_LEVEL(m)		(0x11c + 0x100 * (m))
@@ -105,7 +106,6 @@ struct hw_params {
 	u16 thd_dat; /* data hold time */
 	u16 thd_sta; /* hold time (repeated) START condition */
 	u16 tbuf; /* bus free time between a STOP and START condition */
-	u8 scl_stretch_en;
 	u16 trdhld;
 	u16 tsp; /* pulse width of spikes suppressed by the input filter */
 };
@@ -260,7 +260,6 @@ static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I2C_MODES] =
 		.thd_dat = 10,
 		.thd_sta = 77,
 		.tbuf = 118,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 1
 	},
@@ -272,7 +271,6 @@ static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I2C_MODES] =
 		.thd_dat = 13,
 		.thd_sta = 18,
 		.tbuf = 32,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 3
 	},
@@ -284,7 +282,6 @@ static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I2C_MODES] =
 		.thd_dat = 22,
 		.thd_sta = 162,
 		.tbuf = 227,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 3
 	},
@@ -296,7 +293,6 @@ static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I2C_MODES] =
 		.thd_dat = 22,
 		.thd_sta = 35,
 		.tbuf = 62,
-		.scl_stretch_en = 0,
 		.trdhld = 6,
 		.tsp = 3
 	},
@@ -308,7 +304,6 @@ static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I2C_MODES] =
 		.thd_dat = 16,
 		.thd_sta = 15,
 		.tbuf = 24,
-		.scl_stretch_en = 0,
 		.trdhld = 3,
 		.tsp = 3
 	},
@@ -368,7 +363,7 @@ static int cci_init(struct cci *cci)
 		val = hw->tbuf;
 		writel(val, cci->base + CCI_I2C_Mm_SDA_CTL_2(i));
 
-		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
+		val = CCI_I2C_MISC_CTL_SCL_STRETCH_EN | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
 
-- 
2.43.0

base-commit: 249fa862deccee0de8071e61fe9946f2fdeb3a8e
