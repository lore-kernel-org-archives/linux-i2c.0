Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3637AA6A;
	Thu, 16 Jul 2026 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186287; cv=fail; b=ZwdmQ6UPq3piLIa0PYnYN/oUGzqkkbCnSqVhpbsGcrsQADVfrKl0wuFRVZVAef2I9FV8dMLkaDfCtyqAIIELCDb5jNZ2zORBPd76J1DnGT7zwtudBNXoBIrSueqpcH4aghSYoZPxAWF0xrtzUW+LPRmKs7c7f8xQlkMtxDyq/ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186287; c=relaxed/simple;
	bh=8Tcvu/zqtDE5eP/cZZvg+/XIKzkAC4jsZAkuHnJ8bDI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X3Mds7lCIFD7AP68Dk81Zq2qzki+bNQCCbAJhffQrBOzR/qlmamfnwxIaHbDTQ6mErTBd0Bep6OHlC4Qox19ocrpvc191exCvM/DRvYQgc/PZzMHLhKg5nsgPX4DfiyjPlIOGE3s07LU+K+8gz94K7WIBh1uMSpdMbaRNJfe2Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dM/SGVZr; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dM/SGVZr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRSjD00PmclO+x30qA4zLRDZlO6GfC1DupLQD+RVtO/dfIOTVQFOkUVdRh2Rvt1kf9cM2f/krKKtrLQPBMYwrYeuiG/nEYqaQd4qbLLsOuMybleTIlNUQ4sVglyAekHKaUg64Q9dhiiPZUGr4AlX0DrDipA//hYZNIPwkv9AdsXZRKz0ZaOXFgRfeGKziol6im3nZi8oPzPOUQbwJoRMuTOSeJQGYFWiWW4f1KoSdYr8iwx/hloe0NGUX/qY0Su/0wG68ma4IZlka3Op2z8FK0fh5Jj9f42CFXA32QCl/eednqwCvStQhz3l8HzfW44sN/I0+wKzyukBGCJOBiPD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2eber5aj46yfo0TnhZ6BAGN7Zcu+crc6X5LJfrRpRI=;
 b=qFNtYeqWI/aq+sGJMIftxA3B2m/GsuC5c+lSJDHmoa8TKpFbkGTnU0KOc4mYWjW23MghcPlInVRPUbeNLxjcQmfAo72zuSShY+NkCu3ISU45aSYObb6vI99KRTOhP34Nei1ALZ35KYzPQ+A5NTNpF+Z8TOysf6OhAT4W2M7kKz7Qn0uPc8gK9SbCEKDfjVfKESouem8lDRVWvcuichuQlUea2BFjR7zZUlmF8kDT/wdOlfQq4Fjr1SOybCh0qH51Z3bfsA3YfnFYLDpYEVSM4M8fUJ1nwBA7m2lzRH4Bgg8IjD+dOnRGJQTla766e3IsYuckaajHb1kZuvzNvvSbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2eber5aj46yfo0TnhZ6BAGN7Zcu+crc6X5LJfrRpRI=;
 b=dM/SGVZrySKsUN6dpdoQE/NEKkjt64sfHTraGFoAurAvDK9q1rZNUeJn+CDXBUMsxqewRfKFw7GdVK8Y7cBTy2o034bKU3+2CL2caFe+F1+EWEIbIcLMn+9EIMqGK2WwISeFrzxDKzpKveph3o7U3NObA/LGGvFdrXBFjIQd9CJmxp+3zY1Ty59Q6tZJzhRJCS6bg3qG64VbMLxDZEHAEXCytmgTM21M6KYNzkmCATHQESNl0v9KnGjuqnoIMXw0wxhhYXTkk2pHAsdBuKvhurNA6+h8a3ti0VnPsuXovgPmfuGdHCuJbjahfru8AhzoO09aPVyWq70q/a1WettCgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Thu, 16 Jul
 2026 07:17:56 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 07:17:56 +0000
From: carlos.song@oss.nxp.com
To: Markus.Elfring@web.de,
	aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v6 0/2] i2c: imx-lpi2c: fix probe error handling and reset controller
Date: Thu, 16 Jul 2026 15:19:55 +0800
Message-ID: <20260716071957.2670263-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|AMBPR04MB12334:EE_
X-MS-Office365-Filtering-Correlation-Id: 155e40b2-09d6-4109-96e8-08dee30a5bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|6133799003|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KdNZ4K1G1WQTCdMCj91/g4RELOK8JAQegntxaPwDLt6n8CoOt4bkyVnJlEUIj4/nCdCFR/x9EAD53falfLXEHOP5nBfZ9HlJeTDB+pFmijXHXYuLjtFEQM3jTitYTFsWnGaUVDI/XrHZjpv7FSg2jNIpVS1iRlqUZbXyXSdbVvrgZkCTp0l6NZ5dRcPNDEUVpoG/BZm1K8xiN+4HH+ef6srRpPCRuy3z6s8iANtA7oVSUKLW3V1RlJd3lY6ew6T2Bb4NrhKuXNOlVzWAuEPIoXmhCbDEeuQDnT0QF07kthMx5V8j9DR4X1HC6Yzgjh+A3dzKu6JK3Auq5NBuCGUZaqd8y17BQM8yovEQAN6Xz5b/xFDn54HvetqB67dYZfXMPe5kVWnTvlwZPfYqJaA9bzFqW83GznXvOR3mGGNMaBL3SxqiRB4kY3munQnSTnLhRuIvSlazYU+qcLaz4wE6UJexW1BPNEJYbSLXt0s/HHsShC85JdT6qZrEtG7mA4H/y6aksw6o4R1zg6miHRXa5Vok97hlgMsUvs3jHeMrpv0w08G2LZctE1i9p2dHImgXOpbDuyaDFuZojl2CK4hoOnP0uFu8wSwTuj86v6GiaxccdQ3MlG01GcN1D/HTLzANRwg6ajp1BpQTihuKdp/CxQwpimtz1X3wFafzzWqupzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(6133799003)(11063799006)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?abVzs0cNMz//5mVrotYOMxNdXe9fjfjS3zX63uvDjDTO0jlrg97Vbw8tOJsz?=
 =?us-ascii?Q?Z4ccDFjAXzwIDfGIAFRqiPfS2oaWGw31bEx8RCIDZdu32EtYsjQ6wUks4R7M?=
 =?us-ascii?Q?23k4N+NiWRA1qIW35tPflMTKjqVzk9wjBToQi2KkDmV3TlESMLZxT1s1SKIb?=
 =?us-ascii?Q?kQKnDyX2NBOYuUTwGpOZhwWgcYbRMHOYurzkJ/Pr74NeILN5o0s9pvka0dtY?=
 =?us-ascii?Q?KLSEGab1yX6xczf9ZpRuwodX8YAossAtQ71+2tN74G032OH9tdGh86qhZg8I?=
 =?us-ascii?Q?8Qkt28vup5Yul0beSqEFO90geTs7kaJWPsiiGEaNrUx6ZEbxOlp7LP3zx7lo?=
 =?us-ascii?Q?h7iuTjihLPqeNTNnxZ3baqPP7hhUWtefpo80hEhJmciKOqgnpA9oUWXwaqKE?=
 =?us-ascii?Q?Zm6duLEngZoKpBYhlsObeV8tbDzuQniylmPjtHxelumes2aNkOLzLCxq+r0Z?=
 =?us-ascii?Q?tPgCQXboS7+fXzc6RRrvLlRq48aEpNa1nzsfcJ1tCMQS15kB6u0YrVcjZC2h?=
 =?us-ascii?Q?2PCSQh076TATRPJ/RA4/CNiyjotQ3BaKLaoe3tM7tVRZBxCE0+pOxqd1Jy9V?=
 =?us-ascii?Q?I2FBKLaeEtiR/0S6riFGpPuMvvcLreMdzrhO+e0RuXIgwM0zZprrm7+23Yue?=
 =?us-ascii?Q?mKBxp3qITcm0U9pfZJrP4hSe7Ol//5e1jE8IqrszTvoZziAM8IB3SCehoife?=
 =?us-ascii?Q?e5NggXip+BfhgLGymNxV3V/2sPYx5tZQgj56kJn/qpwPxU/M+sziVzGx7u/4?=
 =?us-ascii?Q?Xcna0YiCmN+/mImHY9HcuWY4tOEyuOb3n/8ctNS46HyKZyyY82Kpq60Nz3hb?=
 =?us-ascii?Q?Ojs9INKELAi6rFX7EBgUzOvCfkHrBk86lUQLOD+s759nIVPFumw+KybPDaLS?=
 =?us-ascii?Q?wuqddDV4KTE6EzkbJCFMFF6R5/Xz2N5Nct/b4lbAjZNmjRbmGVKc+K1lXLGj?=
 =?us-ascii?Q?P/HOmcb5fsdyry9+lOtkCST28HXeN6bxCb1S00qNJai8GRl1set59ltBBtW9?=
 =?us-ascii?Q?U9/UHHB/ny1KZcRLwpcR2lVtrDxYzJsL+n2pgtIDVXB1Ek/hhWGx3smumsWN?=
 =?us-ascii?Q?V0/BelqC/nVkOojQbKlwn9LOBnHwQTKbpRiysjamkW35jjzcU/m7YZWMrSpR?=
 =?us-ascii?Q?si/XPN8cL6dx6pjKFghOY/7mE1O+0/Hh2V5Ft7dCaDpU+v863z3nPn8oAEzF?=
 =?us-ascii?Q?xLPwdVVgiN41pr8hDlI7lgz5aIykaAY8fOQpR2fjomeJk9M7ZUWHwqg7mzDg?=
 =?us-ascii?Q?Qia/FqLIlueZAkmpqzAenO6/Xfn3IQUTrNjy7eTo4fb5faLP2M82Z1y/9jn5?=
 =?us-ascii?Q?PZS+2U5X0tjww5ghVAsK43gV7jlhgXgs6jaefQ5DnczS6AVD8uoJdwY5zkqo?=
 =?us-ascii?Q?a/D9j18eGwgvTJQb6pkVHQ+hJZe4JVb/J5MlPoIONNBfZAVMSNQUhR1v/Wbf?=
 =?us-ascii?Q?+UM97Sm03dPnla466fm0kV4g0UfHsXXhUVk568ObDOoh4AVRM3B6DUiWIcGw?=
 =?us-ascii?Q?Yu2XvfdenqNnIgF/gzDax1qECaqNeEb5gROuqVUxx9x1Z+SSY1HYDIBljiPE?=
 =?us-ascii?Q?ZL0TAzeGEPwI9oIpIQ6fW8hLavleYYqDDspg26m9bYjFCE0oPxGmLrpdGSjz?=
 =?us-ascii?Q?QFAaWDtwnczujZdP+Qm6qoa01CnEEDf2vFhnxcGqDPSva8hwGF3CDxispupO?=
 =?us-ascii?Q?Inj46oxvQT/uhJ73oKvSKa/96voY3Uz7OwNtazQo+WAE66Tfe7QYuyqhUbsK?=
 =?us-ascii?Q?t8NOGnCpkVw6wJT+DN9iZwIOaFR98T+HJRLEVTjM7u0Gw/ItkiWm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155e40b2-09d6-4109-96e8-08dee30a5bea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:17:56.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UR/mc+mjQ2CCO12IMb/oKeaW3aSD8VMoJ2mVkoiLKcGLeUDPfd0hsF5t/jnwUTGMOtPryJiE0xOPm9BIAZQ92nst94ASYMk2aCV+fqd0dt8UA/YV49Jz3LeFbzBzTwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12334

From: Carlos Song <carlos.song@nxp.com>

During probe, two issues exist in the LPI2C driver:

1. The error paths do not properly unwind all acquired resources on
   failure. Clocks enabled before runtime PM initialization are never
   disabled on certain error paths, when probe fails after runtime PM
   is initialized, the previous error path called pm_runtime_put_sync(),
   however, due to different clock management strategies on different
   SoCs[1] (to avoid deadlocks between the global prepare_lock and runtime
   PM), the callback may only disable clocks without unpreparing them,
   causing an incomplete unwind.

2. The LPI2C controller may retain unexpected state from previous
   boot stages, causing the system to hang during probe.

This series addresses both issues. Patch 1 restructures the probe
error paths to ensure correct resource cleanup on failure. Patch 2
resets the Master and Target controller logic before IRQ registration
to clear any leftover state.

[1] https://lore.kernel.org/all/20251125084718.2156168-1-carlos.song@nxp.com/

Changes for v6:
  - According to Markus Elfring suggestion, use a consistent format
    dev_err_probe to return ret, it help avoid duplicate source code.

Changes for v5:
  - Remove devm_free_irq() and free_irq err label.
  - Change commit log to explain why not using runtime PM to manage clocks
    during the probe phase.

Changes for v4:
  - Split v3 into two patches per reviewer feedback:
    * Patch 1 contains only the error path restructuring.
    * Patch 2 contains only the controller reset and the IRQ
      relocation that is required by the reset ordering.

Changes for v3:
  - Reset the Target logic via LPI2C_SCR in addition to MCR.
  - Replace pm_runtime_put_sync() with pm_runtime_disable() +
    pm_runtime_set_suspended() + pm_runtime_put_noidle() to avoid
    triggering the suspend callback during error recovery.
  - Add clk_disable and free_irq labels for complete error unwinding.
  - Update commit log to cover the SCR reset rationale.

Changes for v2:
  - Jump to rpm_disable instead of returning directly if the IRQ
request fails.

Carlos Song (2):
  i2c: imx-lpi2c: properly unwind resources on probe failure
  i2c: imx-lpi2c: reset controller in probe stage

 drivers/i2c/busses/i2c-imx-lpi2c.c | 42 +++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

-- 
2.43.0

