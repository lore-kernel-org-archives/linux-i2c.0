Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4A299931;
	Tue,  9 Jun 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998564; cv=fail; b=QPF/BfHiz91pWxiYjgNEuoDp9jaA65KICVphTY4mxbyUceZZv13PPtWu1IyatCoRATEp2rni7IQjOJ+BGItMsUP1FCpRg0O+utS+cDcnqICCzo2Fty3HmSh2HoiWTP+jZfxf+Yr8Q5K83QFkAXhgJfPjW5cTD2ZuXYO7FSxQAU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998564; c=relaxed/simple;
	bh=UYBGiZ2eu6C8iHPKmjSVBKHoJc82WFH5eHgzJVA/jgI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kcdXhsOSPB/Lx1XvkL8PU4B9BcPHhZUz/+tk1t4gMJwsXKgOKyomScqsEyCEslJb8XRpu43CDUuCYH3ey1SavYE6k44koKcN9q29o3l+8gpYo3MVykuSXFJWbYNU4k4vkutS3/Zq5nJGC3Aq59YmOpYoScZLAz8RsOE+V1tdzj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J+219aNV; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J+219aNV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3r3D0TNHry2Jp71RupcFOwanAbu9cMosqy+RlOuphsaoVfrwcuUIqC9n9zOs6L4dk3tzbihwbkFu3S6k6KIkbhuWBfeKAPsF/iaakOEc8wukMYTkY8++NK6RPcpxbj8uKosORVLQTzsg4b8Jk7BGpqbOcz3C2CBmAhdcFxogiieR5O11pJVt7otvh11qrCUPlewGeoYiVu+KOCdAAb4UOrDkq+6a/FW78krKmlS4JjtVXzWeKdCvq+lHcnjn3eiimIJaUuViOU3Ac8k4xGgDDvFyAQyqgukbFHkDVBiT3n8ApaYOky4jMy3TO7pCWj4jFxv3J55+era8skvRrL+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k24q97luPyuLBfwxlI0Lq42ZOCnAVMFQqsPBYDzdDVQ=;
 b=U7ib9WjDMLqXk0Czka558Y+VADVEiO2w+XmO+Bzs6eTpkqLNjkjAlKnG+Gn3SzTQu5NDCS3/L8ktn5BG3DL8nSH1PHi2SkaOTGYxal89+uMcY1LKigkDGA/rfcCkqEKce+ET916LFoBiwKEGJ47qhApxj8VYEpAnDYpRqh6GsO7NHpMpzVDffG+apv/hb3NlsG1P0sgxR7wfA0ZzeNv5CEQbKRPskdcsvkidiVvQWBBZ9e03Y4ciFUHeS7eKeAcO2mNNGrRLQP91ukkTjjvNp0aYzvJuZAKYsVDNxOyhe+06I+DwEDbj3YmAbd8HvPtVQUUJXtp7WNlGPqGGIn4K8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k24q97luPyuLBfwxlI0Lq42ZOCnAVMFQqsPBYDzdDVQ=;
 b=J+219aNVW4ciIs9UXL7aM+JGhz7AeZpyiGjDsmTAdeggyHiriqJiP7X+6EMqth4BsFM5E0OekSJhr+Zq2FkC0/t5GdrNeIZyQHa7SDQDGpHip02tfPX3KV1DMGP5NAw3SkFArYI10AldMV8pSTaMSd6voi4KGQxKVDcwYL2MqieCjaNh2sUaZJWA1u5R0IMH/GE1cXBF2/zqha9Xs63hf03E6/47CZVUlwp+LDrufyAzG59LPXZKNkCYOY1XkZLpkVcNiZCktzWNh/ccdxXh8AAWm1VilxkdpLZjS1soXjsRzuJT8ulof2x0cnIaUmjT+YYcb3pwQUlTNz9J7bUJHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 09:49:19 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 09:49:19 +0000
From: carlos.song@oss.nxp.com
To: aisheng.dong@nxp.com,
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
Subject: [PATCH v4 0/2] i2c: imx-lpi2c: fix probe error handling and reset controller
Date: Tue,  9 Jun 2026 17:51:17 +0800
Message-ID: <20260609095119.924029-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::7) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b90829-9021-4449-7fd0-08dec60c5fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Wbo4h/BiIedbCmUd41+hy+bRG+tZfwCTjPhoB4+AGwylq6Gl2VnuUK+YcEfGkaqiKwZ+46cUPePyr06cQGOTSLT2edKYJrmNRb7JVZnhNmVNcUwZA2++Sz1kXuHxYQY/6AWTy2Yan37FNe2ZKmFz0uIxmm14Ddb+6jB5NC3qK8JZUgB48c2mTs3n5v1sRbri2o4C2bRYnyBFZx43hhQXAV1AWwN1AvoE8TMzoofWGox9EqDbenIuECzHfp2UUymt8LfXmoVEvDE+9Qjj7BrEafFsrwTJannNOI57xaOeGlikPpbTv4s+Kv2nESu/oYpku+Y3DD7Ldjd3VxMnE6jEnb1QjwDGOCkTuy3DzijtCPOPXJomsy8exoUbJ0kYAkQWlIdYMhKcsrQJJzR1eXkYWSkC1o21kWT9nzqpcbmEm3Wdp5cv2d3yioS3vrNrO+kOr2YMvGPL+BbLMkvOAu5K6F8oxMuBaji/SRhQYa/7tAuMqAfLSSj7PdIJXFsNJlMLu8RH0ijiFeqSjKMGAGotfp9pB1kjaZkHx3YSyYPLSGX7jbTCqYGGG0h1V1QygofPFVz9mva2KJBNiGrLa7fPGdju+6ssUYrMKKkjlIc+B349TwsBgzV5u0yTGxgyOItbqLYdZJsrkRrRGxXF9NMbNwkwM/CnPtIrz05/27D250xyslwjB8MkGs8HK5k/l2WA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAMv/plRXUcwLbN7Z8ao7PG6WbBI/ZioMBqvtyzidWMW3BX7xQOqv2ZDs1X8?=
 =?us-ascii?Q?Xt5Sihf8lqNpcS8+cm93BjCEeQE3pzuuUrxaJhwmpUBuxlZCGnEC8wRFLiRY?=
 =?us-ascii?Q?AyIjj1kjBeREQQOIUlnbM2zeMPiGJfaC/83+emhUfTkV3tZ4Na+UAjFsPfxa?=
 =?us-ascii?Q?lhoaPFTsCoLMIB1kpfkQTVsJ7GAazs4DDklGCQMGFpVpW9ppZ8SHRWk40ZY7?=
 =?us-ascii?Q?3y/PzdfbFkHqYCHV/APo7ftymErYvHyW8/tDwKCAa8JyEJTIMc5Y5jJ4ZnWM?=
 =?us-ascii?Q?Qbh0XWmxEU2mj1N1KEHeWOpTADU3ogurImtGW1geswNlOH8+kiKzuMlOgDZ3?=
 =?us-ascii?Q?kkUpuxnMpeb9uNiedtgCnXJMBsMlC16bxLcKE1HfnX7BLi15ZZaStuYWykrk?=
 =?us-ascii?Q?UGuTblDx56r1HUbOituOH3EQ/Vvte1VvgZAZT07cwaRCVgcLyq3vGiw7Z9/h?=
 =?us-ascii?Q?arhSkqLOPdDYOYDfCyyHgGlHlMf8AXRmLPGuddlZ2k6shL7pMYZacIvjEz15?=
 =?us-ascii?Q?mnPO/ZSzHXTmsia7zU2Ww5EvQvrILcCKcQlAeykAFg25IvfQUggYKnrg2Oqc?=
 =?us-ascii?Q?IcoL7iznrAIelPfDBOY0clqGAuOy39KjqDN6TZUL6bnoGskYwND8a5zBKm6T?=
 =?us-ascii?Q?bRvTERgUzbStH5Fsfmo5BcImh6jzi8gVOaWGMbWnmRlvRBdBzv2csKpNJRi2?=
 =?us-ascii?Q?XqKwqprS2UpMkY//zTN28ppBYLobnk/hbRnvO6lZTTB8lue3+oC3TSEYpIBs?=
 =?us-ascii?Q?6zVsBqbXVIFGmRzIvzmzYPzcF0deNRYEsNIDtTBNpLjiE7uSFZ962UNCN5wa?=
 =?us-ascii?Q?NOkrCD5ib28hvfVim56wlfUW5qNLZj3LwMlVJezzufZqIp+jL2BnK4WUmQs2?=
 =?us-ascii?Q?CmlxfLRdtbi3IGNxy8oRmlZwyNH2Bcb8467GIufeaXtIrBZifcuoODx3ErW+?=
 =?us-ascii?Q?Xm3XUKL0yssDwcoUsFKMziVdsmlFEpJpRhKSLKp5+8MUC0vZE18tQXmgdTBw?=
 =?us-ascii?Q?sDc6uIABi2UUGn9MJ+fbSQHhjxvV4YP5gQDn5hBEC7IPtMhE2GCR+wf5i7na?=
 =?us-ascii?Q?mQV08fQI5YBkfV+/qZbkCd6SwMtzKGMTe61zDQq1Hiu2zQ/CQ/n8L+JQAwqJ?=
 =?us-ascii?Q?Rv6QYFTgF5L6i0HkIra/+C9GDZWlB2Jjjgw775Dp3/w4s14ABicvMm3ItSH1?=
 =?us-ascii?Q?u7eAFM7cDmdOp9eYyDYKgbo86kXmFS0FUY0QXx6fpEW3FnzdYEtpZgjGPVAE?=
 =?us-ascii?Q?yRtmzAdAKaKxixqDpYzcJ7Za9na1vdUv7d+J87n+FGFgTWhI3g6hWEp803a1?=
 =?us-ascii?Q?U+hMHO0JtmCQj98ZxOXybSv98dy1PJi1Tmr8ZQjwLJM8YtUDZzTSFo5Kxj/s?=
 =?us-ascii?Q?TR1dRI7zUiK6iODfreqAiLwW3T0vxM7/l6b4fEPjmbwSh0LVgsJr+e3EZJHY?=
 =?us-ascii?Q?MTnYioNKSTR80OUIrBamNhibjRxcXYAb25BpjDGDWvGXpLp68nWuaAZh1oS1?=
 =?us-ascii?Q?38KwG9D8rdBkxRuWL/XcT19e8LSD0LxGKspxn/W/akZjH/dLsV5DGo1YM0HV?=
 =?us-ascii?Q?73tansZX8mjAp92bKo89wE7ASsTqoMTHhS8AknilAl+h+tFH1aBng9mozx17?=
 =?us-ascii?Q?3Rbb50l7OGKk1Grs7q3vG6vKKjv3CSJkIDIl2/Qrda7LI3Dkrq+N6F8c0nsy?=
 =?us-ascii?Q?hGwN+cX/SXJF0J6ycdF1NRRjFsx64jD2nJ2QfwCp9QtTkM7fJICBEcsujDUp?=
 =?us-ascii?Q?mo9352o83IxVynyOEV5BRvDh0esOryrW4nqss4XalG1KbznQ685m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b90829-9021-4449-7fd0-08dec60c5fdc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:49:18.7815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SC9GI194hl7hvU37TzRNS3ZUGnYLmgLtW2QQkF0WAEUTFM8/7VlHbsMm4+qlTHgjyCa+M5wXbDkjf+lDmWBoWHSdKZKkcelx9RFjGl6dPxuOskWF1LAAM/3BUioSM/X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

From: Carlos Song <carlos.song@nxp.com>

During probe, two issues exist in the LPI2C driver:

1. The error paths do not properly unwind all acquired resources on
   failure. Clocks enabled before runtime PM initialization are never
   disabled on certain error paths, and pm_runtime_put_sync() may
   trigger the runtime suspend callback before resources are fully
   set up.

2. The LPI2C controller may retain unexpected state from previous
   boot stages, causing the system to hang during probe.

This series addresses both issues. Patch 1 restructures the probe
error paths to ensure correct resource cleanup on failure. Patch 2
resets the Master and Target controller logic before IRQ registration
to clear any leftover state.

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

 drivers/i2c/busses/i2c-imx-lpi2c.c | 52 +++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 16 deletions(-)

-- 
2.43.0

