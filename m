Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAE3CE0AF;
	Tue, 26 May 2026 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785119; cv=fail; b=Mz/qcUyp3KlHY5+E+18Vv1qV60qUVhcLIuFHQBiXT9fWKIKV9KkCXO0pzDL3qPlylGfJ9nnnU/YaTvM4NyGLXmaedIGtAQ6gbdM5a+0o3sLK1DRZnj8i0abkmuQXuXJBAaJuCh2JzVty3Vuzp9R9y1ygpXUsy3xswsgSyFPhq0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785119; c=relaxed/simple;
	bh=EYUytPYWLFB3K7kM3kw0p4sakgSaoPZWVxH0kQKwcwk=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=iP90zqsdjAP+Ewh6C/EThtTXPbq7S0f68nZnQ3z/J+jYxv4IhOfGCCiTgUgEmnF0zzOnFm1kGzhstIssvWHH4nZozC2J0hYidYr4tYOV3UEGNpE5Hp5YKPl+p5kZC8Fpb8szv8Hn2ciiH3K90+SgHd3CTczXaSHLFwqbgo0WHc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SohEA29mV0dZGQyw7ePxJxYxhSWaet3tuUtgxOxtZBuHKjY5t5kzk/nGkbKzMoBG9u5BLPdlz3HZ1d3S57GzU8YNhWcsLpx6izYnVXHoM8zVsJbW/Uci3G6HVdghyt8ArqOL/xdC0xi7XlqRxLn6jgvL8E9+oYbw5kB3jGy+keN+EC6sLdvfHpvrI5lvHJE+V4gtykEpSn4VHQ9AZFzbdveRYrBYWNRcPzYPnqq60v1ZY8l2VxnYvYUtIyP4SWI2Or2pELtRBkzFkGvXM/vi3v1fJGfrgozSqHMNeLWn1Zm0Siqj4WuObYh3OOaKCjiJ9Ue08KCHGCws8Q4QVOk9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFQlqEb2mVks+bRNc/2rvNN8PuBfnFd+yU9V2RqABMU=;
 b=R/StiYxs9nIu3Sn4ADL/40kMLgpPBDI8HFYwP0M0IyekyQIm2B/6vQ/PC6hHAqB2hEW2QhDtBUFEU2sQUpW4FPMRLKJqDnBJSqoCyKP0vYDeN1fYMDzJJ3SecB9qYnvke0wWS8WiIr5UFj3cc0GxwyOsq/H7WnamMTnfqjg/3P7yuRP/K5Y6ofSdlDUJqfv3izBpdEqycTwYxAcSqDiCSAsnIK20+UAWSqxbXVe1Axb/dV/lAWpxBjM3kOgUnkVkUNK9zTFaOn9zMPkOp+fyIUcDijVUpcMKf2+uSPc6ZIibehEjSERUjk4CKxk2VO76a+8EV5LWpKZTWxoUrOi0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from BJSPR01MB0707.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::17) by BJSPR01MB0723.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:28:57 +0000
Received: from BJSPR01MB0707.CHNPR01.prod.partner.outlook.cn
 ([fe80::1c61:86e3:3a75:155d]) by
 BJSPR01MB0707.CHNPR01.prod.partner.outlook.cn ([fe80::1c61:86e3:3a75:155d%6])
 with mapi id 15.21.0048.019; Tue, 26 May 2026 08:28:57 +0000
From: Thomas Lin <thomas_lin@lecomputing.com>
Date: Tue, 26 May 2026 16:28:43 +0800
Subject: [PATCH] i2c: designware: Add ACPI ID LECA0003 for LECARC SoCs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-lecarc-i2c-acpi-id-v1-1-f0942bd491d2@lecomputing.com>
X-B4-Tracking: v=1; b=H4sIALpZFWoC/yXMSwqDQBCE4atIr9Ng2sfCqwQXM20ZW0RlJkpAv
 HtGs/wo6j8oIhgiNdlBAbtFW+aE5yMjHdz8BluXTJJLnVdS8wR1QdlE2elqaWZXiMJ3pRY9KB3
 XgN6+d/TV/h03P0I/V4nO8wcef6vCdgAAAA==
X-Change-ID: 20260526-lecarc-i2c-acpi-id-a32cebd4c3fe
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, jihua_tao@lecomputing.com, 
 Thomas Lin <thomas_lin@lecomputing.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779784136; l=1931;
 i=thomas_lin@lecomputing.com; s=20260518; h=from:subject:message-id;
 bh=EYUytPYWLFB3K7kM3kw0p4sakgSaoPZWVxH0kQKwcwk=;
 b=EyGtvr2lKkpa3gnQ4pquTzmbsQTzlsGk6JHfFaQ8tlb2cmK0Q8/UsFIY2zxvskbRtpEJAuaFa
 xGZcfeCjHSwDyJoQbUC52omN0H6XLpz3ikCiILD4Gphq6X++Qyb5zTC
X-Developer-Key: i=thomas_lin@lecomputing.com; a=ed25519;
 pk=d7V8RTvs1pxSx8mPaXNAe9XWo7K/eHkcVBWTjw1rwrQ=
X-ClientProxiedBy: BJSPR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::19) To BJSPR01MB0707.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0707:EE_|BJSPR01MB0723:EE_
X-MS-Office365-Filtering-Correlation-Id: ed50c87c-d93f-45cd-f04a-08debb00d4a3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	E1kfMSKpPHCkEw/l0KuE8ekJag7lxMfru/7NA/dChEMICSRtKsbc90+4d2FC0svq3M6eemK6yBHYOd0jYQMjaCty87J5RY8esiUB8jzLMXvxVpVswSFV4fsY1/N6QqtiSP/5/FJ6SHbts8+rYTZCzc9hyyB69Du15r0/eEzwq2TUe43md3YqYIZRBNd7j3sadSzvCLY2pN7gJbhKeCxdc0YbNdDkCaJgIGQ5yul0NnGkbs9lACAkG8h+9sUjosLMRnqOQBkQOMGUwZlhd4JuZYy2LuXrtlUzNoNn2IifpY+jjSDZQ9q4SUH1UHrGen4CC6dtA5AALpaJ0wJA7m9xKd2swLmqjtHccEOz7xga2vQhJ5FWmFCgt1A0Ck/QZSLGAVTjthKpgIjv+YpOvIaOJEggructHlCF3TKFOsQCX64pnFmNBD6Zc1xX7bjmKuEbDRdMXYLKTZVnMvcgbln+LAt1GUZ/KtYJA7klPHmChSj9cQG3JFOsVdw43UAPWJkEK1jgEGG7F/OL9It0IQ3fwpdPepIFLFfvL4272FS+v3xA46iGxZ5XaQ8bdC4Pa95d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0707.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9NaHVPUG52NnFQRE5OOHAvWU1oUmNJRXJmc3lhSUFJclZhMXZCYUg1T0Ra?=
 =?utf-8?B?NFp0aWtLaGlDYm1YYXFMZzVoV1V3M0lTOXQ1M1hDUEIwZXhld2hiNjRKOUhz?=
 =?utf-8?B?RDAveGFFOUNzbE9NcUFQTXRrRDM1SmVSVUo5VU16UnFKWEJvcmJmaFpqUnk3?=
 =?utf-8?B?RVdHSHU3bGxabEg0cW94TFh4eHl6T0lqVTFVRzNpZXMrL05nSmhHOUcxelRn?=
 =?utf-8?B?U1B0d3Ivc2FoblRpRDRBVVozd3VRVlRqMmMvTXdDM0graXErNFBKRVF6NzRP?=
 =?utf-8?B?T0N0RWdiT2wrbjQxUHBNWEFsZVZoc1hWbzB1UElrY3E0N3AwR3IwTlBSVXdq?=
 =?utf-8?B?WndHWFhOOGtXdURMRTBwWldMUU1oL0c1bk0rTUJ1VEk0blg0cEZpejhnazdv?=
 =?utf-8?B?cG83SWpVWlBBRzBDRkdRdmUxOS9uMWl6Q2xDazMrMzIyTThuZW1NQXBnS0Q5?=
 =?utf-8?B?YlVidkVGWGNneFZoQ0FMTERPYlRkdDVMMkQwOEdPMmp5Q0JxYTZKRFlCVVJo?=
 =?utf-8?B?SnQ0V0RGVjVUTFhIM1JCejh4emdMRkR1aHYvd0FkN0RGN0QzWTdhNmJiMkl6?=
 =?utf-8?B?TERoNVlXWXBWT2FTQ1JjRExtNFZFQkdJbEk0allESGxEd1k4c0t0MnJnQ256?=
 =?utf-8?B?N1FwVFpJcm5TZmVPMUNPWmNwR3p0NUxjb1BxdVc4YWIrcFM1QmYxZHhkeWZX?=
 =?utf-8?B?RzFEL2kwVSs0aDM0VXFYTjBwMTlkajhsYVlBdGoxdUNPeVA4Si9Eazl0aWl3?=
 =?utf-8?B?cElrbTF2cGFLSTVBK29nNlFiZTkyYXBHTngwdVJuQ2VhS284bGN1QWZObEdR?=
 =?utf-8?B?aERVWjNLWEtJVytNQ24waUhFM09obE5ad0dOQ0Y1VHgySmwzdzRiN0FXamtj?=
 =?utf-8?B?Yldydy9ZZDBpOUdVckNaWnVnS0E0dXlScFR2MHo1ZkVuTlF3VjVsZFFOTEJi?=
 =?utf-8?B?emtHTjUrVnphaGQ3NFVqeWd0T3d4WmkxTm4ybDdpNmRiK0hMK2kvdTRXeTFX?=
 =?utf-8?B?bk91UWc1OWpEMkNzQkJlZ0p4ZmdQRE9EeVJYY2xsMDlEZ0Fuby9UTGNabnBy?=
 =?utf-8?B?c0ppZ05EakdUWUFBTG4rTmlwNnc0emNsRzNyK0NrTVI3Y0xVQjArdmo4SHJK?=
 =?utf-8?B?d2lCT0NBSzFTZW9UQlM2UlB5NmNhRXBVTGFkVmlBbjErTU1NaEJZY21RMjRw?=
 =?utf-8?B?Z2NNUXpwWjNkOFpzaUVNQXREU1pzb04xL1d4YitaOUpWNzJITHZzcXYxUHY5?=
 =?utf-8?B?bm9YVFJpQ1lEaHc5d2kyOS94Z3FwdU1aZ1oyc2R0ZVhsNy83QlJlalU1VHdW?=
 =?utf-8?B?Vno0VHZxOUpXMDdKa1VXQmRBTmFndExVbUM2L0tUYmJpZzdkQ1IxQk1Cc2p4?=
 =?utf-8?B?SDQ0SFA1bElBWGR2VTd4Nm9lTWJoR0c5TkIzZ3M2U01CMHM3Y0o5bk1JQ2lZ?=
 =?utf-8?B?SWJQcWFtQVFiVWc4V2dqZ21KczZwdTNKNzVEOFVSU21tMTdmSUpnNjZMNmls?=
 =?utf-8?B?Y1ViZDhGOE01NUd6VEY1a3dUOTdsM2ZVTUpPR3ZIem15SFQyc1hZb0lHcXNS?=
 =?utf-8?B?ODg2VmQvb0NDd21nM09wYmxEZUZkajZtVWlkUHNuR0ZYVjVzaFhqSjVuckQz?=
 =?utf-8?B?OFpRQXE5NjlXSGs4QTNUeG9tdUNZeXpUVHkvRytyWDBkV0VFTkxDTm42M3Iv?=
 =?utf-8?B?VzVZcHhoTlUreUM4QWRBTTVoamEzM2lLWml0NVByVUFYTTgyZnVSTndRSnVi?=
 =?utf-8?B?cUdBcUgrY1prcUlwNnB0OHg1SG5ZZ0RybWlsNkNvcWdwYXlzc1VMNFBWZ0Yy?=
 =?utf-8?B?S3lSSEpuQUpFNHpPck5xd2crSms3M1IzUWN0WC9SR2NGL0RBSnBRZjNuNGdy?=
 =?utf-8?B?WVRWZmRuUzg1aVFjdTA0d0JEbUpMMnZIbHk3cFA2V0pGdXRlR05GZGFBcEtq?=
 =?utf-8?B?YlVZem4ycDI5eGExNXhCOTNDZUtkaFMwdmszb01qc3oxZkNxNHFiOVlYbUlj?=
 =?utf-8?B?dXV0eldTeGxSaGNTZTNtVlVWbGhxSVN2ZmNZbW5DY2VKT00xZkJHVEZ3Zytr?=
 =?utf-8?B?VCtTTVM5Q0hUMFdYVFYraHFaRURPbEZGalhLKzBKM1hFWGNtS1ZtZmVYMHFp?=
 =?utf-8?B?eXRaa3E4Y2gyZkNmMG1jQUY2bWJOQ21pV1Jsd2FJanhOcFRGcG1uMEJhcEpq?=
 =?utf-8?B?MHRUU0lGL1lOb0VwckVLTXJ4amZOb25ySHRvQjZCVGJaK2ZVWmJwVjEvbUhy?=
 =?utf-8?B?YnRobkxncm8xVjYvRmp4ZmxQYnVHdTdTbFdDcGczSDE0NEdYQThXMjAzSXRi?=
 =?utf-8?B?aGlISnA4TUN6dElMKzBCR0N4bUpHWExXaFBmaGhSTnZjWkxKU0FSalNlc3pK?=
 =?utf-8?Q?KdQJD6JkFYFDoiXA=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed50c87c-d93f-45cd-f04a-08debb00d4a3
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0707.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:28:57.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jL/sTX2+qGpg4ih0RqRyxudBs4vjO7mK9eaH18+UFzNWi0vAbjJWTFrm3RPKqtJW1XLS8Gum6/r13ZzhjFO1kXzG7kJUPIcibBEGq1LB0mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0723

Add ACPI ID "LECA0003" for LECARC SoCs that integrate
the DesignWare I2C controller.
Also add corresponding ACPI description in acpi_apd.c.

Signed-off-by: Thomas Lin <thomas_lin@lecomputing.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_apd.c                     | 7 +++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index bed0791c17fc..86678ee22a04 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -181,6 +181,12 @@ static const struct apd_device_desc hip08_spi_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 250000000,
 };
+
+static const struct apd_device_desc leca_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 250000000,
+};
+
 #endif /* CONFIG_ARM64 */
 
 #endif
@@ -251,6 +257,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "HISI02A2", APD_ADDR(hip08_i2c_desc) },
 	{ "HISI02A3", APD_ADDR(hip08_lite_i2c_desc) },
 	{ "HISI0173", APD_ADDR(hip08_spi_desc) },
+	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
 	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
 #endif
 	{ }
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..b435b4015f02 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -279,6 +279,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "INT3432", 0 },
 	{ "INT3433", 0 },
 	{ "INTC10EF", 0 },
+	{ "LECA0003", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);

---
base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
change-id: 20260526-lecarc-i2c-acpi-id-a32cebd4c3fe

Best regards,
--  
Thomas Lin <thomas_lin@lecomputing.com>

