Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6F3EC810;
	Tue, 29 Sep 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708780; cv=fail; b=Tv3BxtfYBNITHnJvOBg5TpTYWWNfNujyJm3SJi9o3XFOZF1O6w3yveTKypjc/vgH0oogpr5gOgZ6V3jqXb++kajriTaneHXH6+GR5PCfrxkAvSfj2Xw5/d2WdpJEQM8WbztHn5+sc8EX1UIc04MpRyLDcl6T7UFAY802tWzUk9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708780; c=relaxed/simple;
	bh=vkP9KAU07WWggg251LB37O0wEpbK8G1Ub4C/MYn8lrY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FpBtlrIqYVcRvs7hfbbjgzV1gEUJ7dZKTqcZ04MzZtd0fBhB/HZRazaQ7W4QUTfnhNi+2B2NIfRUoBodqD5YNv9gDP6mv0UtRjAk+tgURq0mkJh6sxLmPo8dSrrWiV+oyUzjL9NLiHivZYgGn/Xlhf+x9+yE6h1IO2JNqvmnGqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Pq66I8r6; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pq66I8r6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK7mvc6GzPwjq+POLurKmIKIvaOUsgv0jbwLSC563VamKtOGT/tks2vAI2PMV4dZC8Ch2WYotZZS46GxsugdKMAuPl3XJf+NIE5o5Y2QXFEaDCOF/xny+i6IZjZpQbfLP4+qQH3fpnaCluFaTWfGoLj7wLDa+s/m91ln/OrCcRUvO4iDn9VnU6zXc92o3uFq1h5GH0Mt1tkdElF30b4BrgWUwsqTVOCFrBZHSpqeplZSlWI3pNAiMH1BSl4Chhxlm7R6Mj8Sj9zhiRXEYfQoEDUSZdOnIu5p9gTAaZgR06tafZeVYMKW/uM2svNbaoG7Vs9DHel+4zgjatkkI3RQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BZnRrCw3xx5zyvxDwANSqHBJ3Jp43Yh2tibukRCdVk=;
 b=V8ymRLdIyEGOh7ZSH454+p02wNOalSOPO4EeoQtrH/bZrNUplwiocLkPSRAQMClO6RGx7BBuVi7YziEMDvbsnZKEHN1iKqlqRI4t0gUIdXgabIZacUCpR7MLSylDMJdUSOoPhPQE6hUyl+IIYsr5VrRz6INf14XSa9h39aXgON9nYVnZJcDJXc/fZnjGwKkNdIgEWhmrbH9MFcECGdr3UbCnTYkzMhrJIWMx5wBLszV/4+w2DOe9Fh5d34zG8PkiSvt8UUIzHX69y5p75CnXhLwSWqL7VFqTjWVDNmg1bx3thlf8Z7/iPj8UPCaEsur7GoxqzAMUzF4W1q6hti1RWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BZnRrCw3xx5zyvxDwANSqHBJ3Jp43Yh2tibukRCdVk=;
 b=Pq66I8r6ohkWvUXN4deO8cQUlHaziu78S1gOHECz4O4JLzyl2P/MqOeMMqL8Ua+Rzfuy18/DyJyYgeFCCXZ3hJMTcCcsxQ9VP3stYtl8tnHe0+h3OoJVLmD1O1pb3NdU7RSuc3+Vm4AdcthEdN4sfHNbDdqQ7Zz97oc0hj2Yc6S7U7fc+jR/ccA/AYMTYgrs8x50NE2MprbK0eLMEdgBaJ8zV42MDJvFS8qdXGK9BhHoiJEM42QMKC878PgOXrOuYk4a5oqUaj37o//sKsTYyT2iwT/COsmf4mP5oNYjMVoDfzPYr9NyGUVcLlM0GFEOPgTF8o4tfkj4COVG5wiajg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 19:06:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 19:06:15 +0000
From: Frank.Li@oss.nxp.com
To: Dong Aisheng <aisheng.dong@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-i2c@vger.kernel.org (open list:FREESCALE IMX LPI2C DRIVER),
	imx@lists.linux.dev (open list:FREESCALE IMX LPI2C DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT...),
	linux-kernel@vger.kernel.org (open list)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/1] i2c: imx-lpi2c: remove dmaengine_desc_free()
Date: Tue, 29 Sep 2026 15:06:05 -0400
Message-ID: <20260929190605.3516147-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013313.namprd07.prod.outlook.com
 (2603:10b6:518:1::4) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5a9114-72ef-4f9a-4e2a-08df1e5cbbd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|10067099003|11063799006|56012099006|5023799004|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	LHy9BQd8C/vUNXfN8Z+jxh1rA58JpTsc3rtQ+vK3LEQcZvan5VgBrwIveeRrW3ly+EnTcV7oRxWwZtiuUKjKa4DJh6L5IUchDb0SkYZMXCAFLJsRvPyHMpFvMEX6GXZIWLPp0wCJ1SUXrsiLuSalzbfaZM+0mZ5SufC0GPCKhNuJ91kn/+oE0rrUp9aGOhcpHCYDHCwGj3kPz+dy5Q75HK9qCEQzzipxiO7WKSaEzmErBdMGgjWsbUFjJ1/lszweBvOzesYNLaNf6CkaF/n+vPL4Wlo+HzDK+2Z39K23YJsWFYuatAnhaYIOOCuONjyKL/TbiT5hiUqMcWor2XRIslRWyd1DO7b0Ly59yiE8vR8NV0ME4sRiRi042S1ZVNGPa1ciDhD3LNMaedV0U/1oMsdHOcItSzg/mHLNhq6wJFIS5CD4MTyZ9u8qkK4vFXTxqyaclmjAqneFj7lkhkqpYtIQXlZYQvJOheLZzyyDxiCgFFQqn5ufFfN5OADNoXw3dL0wiQAhrQiTw2FR73mB8N5CVoNnZnCOHs5R9T0V2jZMr7dNLhvn/fFkdl5k0Q7Y95dbGacKTtIuRBmrwoC+PQOYsHundeIgXLP+b2ogkdw/e1WvjddmuZ+J3P378qTdz5L3zeVfPt8m9Uq2+5aokxihC2KttoSSE8popg2l0w8oJHmqLd/EbSyBh5CH2kn3pgva5FAGl3EtEb4Z3lkvVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbuQxf0atpBKCwjJ3QhwmS35MR0CH40tLLOoqNwXH1i114vBdU0Qjg45TNdg?=
 =?us-ascii?Q?fpXOYfSdRnqZXIkIEMYjS1gO2/DWCi4CAZbOGjmlrY2kcM5G+dmh+q8lu/Ac?=
 =?us-ascii?Q?WfRnseoMvNC/DwtGQvU38HBDSHf+zlzQpnfd6LGCh9uVWW2QS0wBUDFNAXOj?=
 =?us-ascii?Q?z2Bh2Dl11C8YE415nVj2ZMXTNURl5p3SM77z6zSfXCcFyOQL1FHEOkomjJp2?=
 =?us-ascii?Q?uXfzSuJv+tKKct3gpV6shixhO8bFgttubvv39eAdsnKURVmbBst4ULm8FIZk?=
 =?us-ascii?Q?6dafKWS3oCY3YucdNuLMTZYdCAQmOcc1GHFplp2cj3fRKMx2I/nMtFuhULtB?=
 =?us-ascii?Q?gmBOz12eSmdaFfIl7FNB9+zIV5jdCcD2Hf8DDjliXVap6PqRRdM1oS9m+GV3?=
 =?us-ascii?Q?annPsaSMfoC4jzVI0850T1Pb/UB4ntSQIS2DZR6UnUnDSwmKbia0Y19GqKsu?=
 =?us-ascii?Q?5Al5ky14Vl6BAoY3Grw1BPTkUbsNB9t0C1b3hF6oS9HGyx+mn/SsH1oioTIw?=
 =?us-ascii?Q?I98LNfzCD7jnqIchdxdzIrGAv9+JXJnkJttQ/q0/O+m7z3mfZAibBbrm1d8b?=
 =?us-ascii?Q?bkmYLiTvG7cVkN26XEjg6DfJ+KDF6CRepZ4K+7AyW5ngkVgUDBQr8Rjw5Z4g?=
 =?us-ascii?Q?lzK1DRn5Jw0mI3to06LBxrCuH3XLn6tPxU2V/pQkc6Lo1K/DP0gC08on79Fl?=
 =?us-ascii?Q?3nv5o0VTGBY/jrf979c4wRBEnpDV5BmzDVkmm445+miXoH76ahZgcPGd2r2s?=
 =?us-ascii?Q?cN6Pg/QBrRIQy2sP/TzYar0DJIpkuvbu4rArzENv4twnloCkUWkMsWBVbbx5?=
 =?us-ascii?Q?TTXsahMkBOdO9z6qVDJ/sXMIT3uEciZE8FHpPLNnD57UlYZzDYiJsjUc7g2z?=
 =?us-ascii?Q?wGZ28mt3M18BjbWU+XH6ZwuiyHikUDYfyrSp3vTHoOysqKtO4mRqLsQ+2KB+?=
 =?us-ascii?Q?L64/uY59DFc8guR6uHF570aedvBUynQRpWklolfK94s0rRxJXBjHsRqAr8vX?=
 =?us-ascii?Q?QN/9kqPNLwcLW0vSDqKiRRX9wu2eOQAG9ZyE+KB0BkhPh85ALQOhD3ghl3Za?=
 =?us-ascii?Q?nj083c321PE7QPnc5SYv5lwX4HgSN63ucTtQ/eISzVjewQOqTzbQnV8GJ7sW?=
 =?us-ascii?Q?V/LQLaafOWDapEAcKqvLIhPwFRPaDV/dEZ9reS8PTDycRk4izJUNH6byS1L8?=
 =?us-ascii?Q?XramIHjr69kd0nG7kTnzKnxtTQ2LffJkfFrTgZZ/ZE+A27PUbtbjDTrGSMNO?=
 =?us-ascii?Q?JDJmQK9I1BB4dU0fkb22Ube63Eo8bUTrR0NFpjgzkCFdOEcXAzwwAG2D681W?=
 =?us-ascii?Q?oluV/Ze9v9Him3ielRkQyuePv3Drp7+R4P8D+cBaqAj5xb2XV1MXeKThSZvp?=
 =?us-ascii?Q?sOL9cxg8kgfOSd32ACzWtuwcD3WCmyDTdwYWMnWINusQXBy4MEckaVZKaT4Z?=
 =?us-ascii?Q?+uDIxcbqM5IbB6vjCJ6ExHEFR121Oh6UYvKnKpYgO7RKPNTXbtUWyPGf138z?=
 =?us-ascii?Q?zmBVP37fngzoNayxymRfodx6sH5CPhitK/TlAN0VAXWoZLZT+MO4+RPE1bjR?=
 =?us-ascii?Q?0gLAfGMbamdjXPAguoG0uMyqOkgRZMWfTCfInt3dRbL0DoMaG64N8LHeWFmw?=
 =?us-ascii?Q?KBw1A8nAtfa1Vv8rl9ls4rYHx6lAfVnqI0ArxDdOO8RD2mevXAZhyumnEZgI?=
 =?us-ascii?Q?vzPb0thyzDs91WPnvCIJRzTfdPaoUZ+sgQsnjorH2RfRovVtWn6+BRgF/k5E?=
 =?us-ascii?Q?eWun2JKWotGSCn4K9Snza23eDAZhBspQBJF6+76Kl9+MnAWZQYaK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5a9114-72ef-4f9a-4e2a-08df1e5cbbd8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:06:15.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtQBmMuo+Q7cHjVptlcxzTVB9TpOmlIyHGOWDiEO3eTHhR0ykUMdbB1kN+dg+jUsc5rGGF21RftaxMQrZvEKeZJSLTJhQY7iZMSE/KdLUj32lUBG4PIxYVA/2znMAQSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363

From: Frank Li <Frank.Li@nxp.com>

dmaengine_desc_free() is designed for DMA_CTRL_REUSE. If DMA_CTRL_REUSE
is not set, dmaengine_desc_free() will return -EPERM.

	if (!dmaengine_desc_test_reuse(desc))
		return -EPERM;

So calling dmaengine_desc_free() does nothing. dmaengine_terminate_(a)sync()
will free all already allocated descriptors.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 49aabef7f115c..d6f266e2d6bea 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -851,7 +851,6 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 submit_err_exit:
 	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
 			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-	dmaengine_desc_free(rx_cmd_desc);
 	return -EINVAL;
 }
 
@@ -910,7 +909,6 @@ static int lpi2c_dma_submit(struct lpi2c_imx_struct *lpi2c_imx)
 
 submit_err_exit:
 	lpi2c_dma_unmap(dma);
-	dmaengine_desc_free(desc);
 	return -EINVAL;
 }
 
-- 
2.43.0

