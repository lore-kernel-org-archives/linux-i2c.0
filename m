Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2723EAC9B;
	Wed, 20 May 2026 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289167; cv=fail; b=rnyF/pFkvbqDRHlPUkSeRgVHZ6SVnSyRugruocqVRXpqSerFJ2Wi6SAUjl3Jba5L8xrMpvCuGnGngk9EEx4LnxmJN+StE1fMWXDUiQ2Y95nJ7cM/MuC855EF7ewzKN3nq5TBEHW1nrHgRmaHoffTtJn0/kBdH2x5uasfzaXuE+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289167; c=relaxed/simple;
	bh=gShqvDQ1oh+182dqLMBabKLNUcKknh+YFCnjAhqP2W0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uNmkRGYb7M7v+HagMNgnEuR34pbLo1D9+f8vf81sSQTc69rsnrMI4obEV7hzWmj6qcHwplgWAieL0Mxf8bTT/IRR6BGNEY3elZMBEbLVWjxBQO3TZEQC5lt7O6B4SQxpVAcahOlijBe6Xl0xhImmkhqFIBgy+fPnUfKShrLO2jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PGdH4Xyn; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PGdH4Xyn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4ANExsO9A60R9h69l/YI706mntON0X5wkEuQJFuBCB3OkBEMYpQnT6peMBBzPLv3vpRUoNT8wdwSsVxOaOZ1uB0DtxC5grTgscmrcbgIjgIrRouUO2BNKDFx87P0PhzTz0KJFrDFmTgIVc1/2/8YYZlF3C1XH++MiTX2C4gp1wU2UJnNBLvQefrrGt31VDzWvhs36XLXYQzIC+3SufOCDnCGCCTRpNbvsZfplWaB6GHmzQrRi6S8WuWIOtg/1iyknfjgV6nHVeIxwNcas4gbULF9py34HSIvnrNcmTxm/o3aAaM3NsWeBXm+gQD9/k9cVJSTb0MLhFhQcuI0LNJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKfy+8VcHBf+3h5f8u/BB4u4lGZJfAgMU8V7HFMlPgM=;
 b=VSjROkc9UDScUhD/gWYdY91VnfKq6QcFTrj3ax3sf9hHcl9JE4A6kadnmfk2vO8VwYjvtigodY288g4sx7gEG1fr+og8PUP7BxUsvrzmvBgbEU9+DHgWF1nFjt7+XXr1aYHwaMPFVOmdczd+sHAMMVEtOmq2nd7EqNrUUFWPKrm1Fhd+th445rSl3UsbRZiJmtLq2nqWdTod4ZLMyC4JRpc6I6lCgoE/9qqiVdRb3a5QRQxPDXrYEaD4f9w8+12Uj9lidJXOIrtf2YwWjWfWGXzCQdX/gOG8d9SUmlHuoInN3TVRIaAt7YEADRfZlW83LM2Taz7ykKM6hCY/g6F5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKfy+8VcHBf+3h5f8u/BB4u4lGZJfAgMU8V7HFMlPgM=;
 b=PGdH4XynnZM/egx24dZboNJ8KNQYUZpPDJrlYYA4p50DrvYgMTlAA6EbWned17MCmxXZLAgL2GZoCwqPY0W0UQuskq9J4981PWHThIQHumuwjtAw+ggREiOAX47zvICXqP53oxCVpIHObNCeO6x3geNCKKIMm/V+1Bxdt3Lv9vg=
Received: from AS4P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::11)
 by AS2PR02MB9932.eurprd02.prod.outlook.com (2603:10a6:20b:607::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 14:59:21 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::96) by AS4P190CA0018.outlook.office365.com
 (2603:10a6:20b:5d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 14:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 14:59:21 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 20 May
 2026 16:59:20 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>
CC: <kernel@axis.com>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2] i2c: mux-mule: Remove error print for
 devm_add_action_or_reset()
User-Agent: a.out
Date: Wed, 20 May 2026 16:59:19 +0200
Message-ID: <pndfr3mnn3s.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|AS2PR02MB9932:EE_
X-MS-Office365-Filtering-Correlation-Id: 204ff43f-0122-49e4-8c60-08deb6805fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|11063799006|56012099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	PcCxL9wEx/Wi9Q+sOOjs4ygaLWCDGjO2ZXhd+wgdHFPDK5N4vfDzgp7mwV+AJoYqNnVVzCg8nvrzkjExBahTyLdcQByg+Jz0AIOPuA95vPPB4tPLqthGJSkuK3aoN69rlBeaRRBlwaK3+wRc36PtVrE/OiyYOgPRKKiQqPP6hRqh60vQ2vf8CMg9wcQQvwjR+UCAnyOle0bWF5nUFmU7EcWmUkTYj9YzcKNznRHPa0wXwBkeXeDq9w1PzqnMj2WU6UiW/n3N+qf+IWNaIXpHMwitUTCpEzr5U1d8IJqMXVilOKqnuMNOaBUNupfiRVFK9+CK1pHwU8NIDrV87SHn3//vE4+pjJbYXnTPb8uaAR2jpe/KJntyrKG017q5FPhU8RuAWhra5vU5rePPlPF6kuV/DsjSG9eI+G1He0NgxGg2lXpqojNKNcz/AJ6Lp5d/HFTsFCjNgqKZqxKd+E1VXRIvEYCVA2it2wrrImY8Uc9x5WoHuRQFNYGJdyhEVyBfZQJwr116muCs00/RoFhIsCpwmC5R4ragwPiioqcQI8hbSyWT9zRJ2MNZDM3G6oAGRqJiIZarY1ekHvNxcytfiFKxJUxfSqjRk/pkvItuo8yfhyALjObXnp/G+e9+PUvBObjx9dzbudb9c/1u87LdNEH0HpsARlK2/+bI7yoL3liBh6q1lheI2+zdg70XjSM6
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799006)(56012099003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GhjjjLsn73SEuK/piVDeIIE4tDJXUjRSYUTE7PLd+b9jHPWU0W5cd4R6hHxXjxGFwlzKmTEH3i8uQXI7pXRLxQDiNxEE/W7adZ+IHwuvlA/C2iOQwoRBAmvbimC7gIxykSCsuScQT3wTPswhBXoLfEjSt2SOHu0X9cSeoPb79rAGnDX2/qkJD9ZrVgrKi241d59mGv5HgxQmQNumBVdZ+wo5SCT3bMFewAPu5mpUwccg8ClaMeO0yGYDGwU2Ow6aJZFWZcFw4btdtultPs4argIe+/pb1Eb0CqmuEQRyUIa3KB0eWxsHQb2nFttqjtXRwP10t0zi3ti4QShFV/rMVig37OTAjavYV9byr0PDVgyCYQspwusj8V94vM8Mi9QR0ea6tqnzcGe0af5rKCVuqmhh9TdDgYWFbC9kd2PNBK2N+yhbhGnXKRWSMus8XoxT
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:59:21.1545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204ff43f-0122-49e4-8c60-08deb6805fc3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9932

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

Trying a resend since my last ping was unanswered [1]. All other patches
in the previous patch series v1 has been merged. I have added some more
people in the "To"-field in hope of a response this time.

[1] https://lore.kernel.org/lkml/pndldlij2va.a.out@axis.com/

 drivers/i2c/muxes/i2c-mux-mule.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-mule.c b/drivers/i2c/muxes/i2c-mux-mule.c
index d3b32b794172..14c7d3d86853 100644
--- a/drivers/i2c/muxes/i2c-mux-mule.c
+++ b/drivers/i2c/muxes/i2c-mux-mule.c
@@ -90,8 +90,7 @@ static int mule_i2c_mux_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(mux_dev, mule_i2c_mux_remove, muxc);
 	if (ret)
-		return dev_err_probe(mux_dev, ret,
-				     "Failed to register mux remove\n");
+		return ret;
 
 	/* Create device adapters */
 	for_each_child_of_node_scoped(mux_dev->of_node, dev) {

base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
-- 
2.43.0

