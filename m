Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73A501F5E;
	Wed, 16 Sep 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572079; cv=fail; b=E8el3TIuof/lEzZsChk8jy7xuIvDrRtimVOkIbbC0W7j4p961urcgLfMXW0QJLhKrCmXPzIFhzvxT7KfvEUemqAbQkNSdiV5vZ3b18oUKuqV5F0aXQjvbm7ODLzOltPg39FhoQ9MFq3gJaEaZpS5Xwb8PbfbD7qXRtJHs7I03iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572079; c=relaxed/simple;
	bh=fTodDLr+nyi+KRWTfxLsfqnWoNUB9EtScN9c86RLjbw=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=XsYqNsUEFuOxy3MBf02MUYKSDZVnyQGzYy7BS72iSRNdE5T4Dv+UOXXRWfmLxM/EwqIbNQHSAKs6tK0I/y3Bb6SWd1dB/Xfo1uqfZVy0D8WPBMqDZxUT6OY4jAGm73huQIsLo7cnxZHC4cHCpTV6Jek2tJ149bBtbYt6o4qZszA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RBP8xq28; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RBP8xq28"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMug0GCzs1AydHUZLzI+hnjbpVHY/hIlMRD6EpJ/oZVJLZsm+G/D13qPtK3LdOoKRoB/oQZOHmFM51tzY1icgMcPpb0NmQvHvwuBkY5ITKVFUCGSP3CJLaZpFVT7IrYyU1BfiYIDDDI2anwzGirmfduHeb1RmNvPZiC5YlX/NM6kJJp+EN3ze9CLXuBiHLwpm5Y6lSnce9Nhvxsa2cg/1+TwfOBgvszUx0hQI2Te9SILaI1ZnxV+2ll2xL6Rh9XtPPiCIgNTok1YXb4MUt/bvrL2ouUJD29aW10YMr3DMAxBKsMO5UVQZzieIbWLR9tiQl5qxybDWcDDhX66ubWmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipVMZzl2alJceUAJbkaECO2Hin2V2nk6DBICtBXBmRw=;
 b=zAd3oV1/OtrcUhKfSN2WOkPExEz3Kd+XSUXr7Kjezsz11LPjfYYZHZXCQYTqMHYtlcR+pbn80QjxHSyrWmdqlMCHJzfIivYIA8rueKvgn9QrS1tIUwgXT6TT0wn2N/+OvBQV7d8gyIRn/Zd+vgoiyPpuCA5L7Z5826CiWlYC3p16Od38LB6QigNAiwvtylFofofiegL51mHhyNQjiKp2Be9KGPsQexc8Ga41K+MKeVWvCCdZRUSatuJOd43fB6TMKTaZf1a1yUOPaB06/9iPaX/7vhe4dnYSTKSzwhwEKSvD7zo1m/AoVG13wXQKbOyOrNdXdVZt1h7AZqdC+C46IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipVMZzl2alJceUAJbkaECO2Hin2V2nk6DBICtBXBmRw=;
 b=RBP8xq28+kulX9xDgcuJny0GIXrh/62ZjKLfV2fkhwAMt32AcyyRiIymwdd1Xi7TC20YfRTcsfGOpcCIzHjSNSlEHFcieWje9e1CXmOhvD0goh8EY/HLbXmUSYshLfb/24VArxWfleWB4q/8vHpuB7iwuUxHWwp+Ryf6xqRpsK1ZDm0imz4kQH2yf1ephiweCNniXIYhp3Yy6onO6Q2oNZkU+0IihtieNfet+t+PcQ7W+bkI5tdj+NGUeuAvCfMgzLeMZrKqWBDJWGBQ/j1MnNxJbLthXqOFjg5H0b4y39cxNCsLMyoKJ+seChQPcR9TELhOlduraWLoPOm4J04Mgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11912.eurprd04.prod.outlook.com (2603:10a6:102:51a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:21:10 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:21:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:25:26 +0800
Subject: [PATCH] i2c: imx-lpi2c: use dmaengine_get_dma_device() for DMA
 mapping
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-i2c-dma-v1-1-6dd4f1916910@nxp.com>
X-B4-Tracking: v=1; b=H4sIAOW0qmoC/yXM3QpAMBjG8VvRe2zF0sStyAHbM17low2p5d4Nh
 7/6P08gD8fwVCeBHE72vC4ReZqQHrtlgGATTTKTKqtyJVhqYeZOoNKmkChQWkux3hwsX99T0/7
 2Rz9B7++c7vsB8Kn0C2sAAAA=
X-Change-ID: 20260916-i2c-dma-e9cd42e4e7ff
To: Dong Aisheng <aisheng.dong@nxp.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11912:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a4459f-63b1-4eaa-2c76-08df14062339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	x+kUFXI8rCNaYvr4JJMPXrGeHuC5NAwMhFaloBKlYr3qovblH/8jsgGHhC7XeOvJhm0R/mwk1Dg4yBC6hL0X/3SgzPvnetsnQW5HA6oi9VEWt2nIq7uNNLT2VkD9j2bDmFhW6VsvGvd3Sr6gJZ1IWuIlgduKjS8cEaTw5S0NES7L0Zb8wTrVHCafyZhGL23fxDIr6rgB/rLy6BEpKRytsBkPinDErqLRISaD0lD7LSiGJgQYf+Ganb5up/sCfZk/z0zqydJdEkYeENyi6aC+EqcwiMd2RpHXmSxaNovGJ0YHPs/hSJPRCvscqkfdLyemRkFpWMFTzZlZc6ElgXHcdr/3K/UxyaSFbq0EMN6U5NKiZ1yPbDpb8kN2L9LBWqSRQrKdcNrQTbDfcco1ZYXN/MaTCdAUCmZHqE8h2nWOLcykr02TNCrDwPM0ZjAy/DCiJXpxkGlT1rvOwPHdypPLDAe700BvSQj8O03gSF5WT2WMRDd6ji5ckK23P7fL96fiVlOHeNjYfZ06uOHVvrfa9KFAwripGnM8ODSsXT0FE3e1HJ6t740at/syScn4650UdX72zrfDJfVL9MOZv/L3Knan/ujHPoK/AV4tmYpAiI4dJXvvR3GyEG/JIlRNX/TyLwbX1i66WOKPVPXssW5ryA8sQPOlHB6CVpwyDHn6wKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJxdmJ0Mi91T2lvSm15dnBsMzQvamtiTjJ2Z1BOWHhHc0pMd0V3cWFzb2ht?=
 =?utf-8?B?SXhVZDU2VS9yMnUwV2VnTENIWjlyaDRVQ0JJaW9UekJVS1huM0laNHVNbHE4?=
 =?utf-8?B?eTgreFRIanZQZnVCa1pqVG9RV2xSUEF4ZmF4Y2o2NEMxNWpId1JwKzZpeUlt?=
 =?utf-8?B?em1NcnhNT24yVXluSEZGMWF0VzJyTDNIcnVrUGJaMUM0ZkJjdndRd25tN0Q3?=
 =?utf-8?B?dEVrUUdSRVAwSVRoR2Q3eVdZSGJYd1NSVFpZS1hxVGQ4Zkc0MnV5NStQd2Nk?=
 =?utf-8?B?UlhUcHAyMWdRRXpaOVZMVlZ2MDJWVGJRc3dxNklrQjZTWFRWNTV2Sk54M2Vp?=
 =?utf-8?B?UDJ4cFY4THZaYjhadUlxcGF6QjJ0SHE5ZHJhdUw3UUdpaDFucDVoWG11cERt?=
 =?utf-8?B?bzZ3bHRabjBML1FWN3NsSXVuZXRiTGEyWFlXTmJxQk5POG8yQTdtYklYazZx?=
 =?utf-8?B?S2hNaTY2ZlJ2bEJhSjgzU012UmdYdnMyeEZwRWF5SHdYMzl6N0dUMU9RazBL?=
 =?utf-8?B?ZnhWVXdsNHMvNHVSNWdMQ0tiVmVHVXhiYlZBT2g5c0hyY3M3ZmpWV3lXam9V?=
 =?utf-8?B?Uy9RK0xPdTRVeU9WTlF0Z3B4aS9BZEVDVFI1V0lmTDdPNytRZHZMRFVrVHJ4?=
 =?utf-8?B?ZnZtMTJ0QUZsazBqaDFqTUdLQ2tvNEFJUUJsanUrejY2cFpuR3M1Zmp2eUtr?=
 =?utf-8?B?V2haQnhZSWhWRlRWSDJHenFSUTNYdVFoZU95YnFMOEVoa3U5cDh2cUhINVdO?=
 =?utf-8?B?UlhZYlJwQmlVQUJHUTBHaXh1S1pLUmRiZEZBcUxtVkZTVUkveEVLZ2w4NEhP?=
 =?utf-8?B?amxZZ2JRTEludzBhNWV5amw5U284VGx6Ym1saWVQMWZ4VTE4ZXVFT21kcW8y?=
 =?utf-8?B?bzRiMEhHNTRIL0daS1FlTGxCeksrV1VPdTRycjhuT25JQVRZaUJpRThERjJn?=
 =?utf-8?B?UHBXWXJlTDJocTZiZHpIbkdDWWUwQTUxUDZQaGRrRk1PSkNTTG5yQWFwbHJn?=
 =?utf-8?B?YkZGY01sN0tORE1MRDJDQUZTZStCbDkyc29FZzNxMXZqQThCREYyc3E2eDVH?=
 =?utf-8?B?a0dDS3had0JmVXBKMTAzNFZDWUFkQks3aHhNckNUaEE5bG1DUm5laE1NV3Jk?=
 =?utf-8?B?NDh5WTVtTldzN3BWcUEySnI4OG1nQVVhT0hqYmo2LzI3K1NOanJkaGtZcFdM?=
 =?utf-8?B?WnhoM2hUekxCUnJia3lqazNGMEZGSzRueDZpYnV6UCtyQ2pWT3hkR3B5S0Rh?=
 =?utf-8?B?S21aYnFqN0R3dEFrZGVRRkU2VlFnNGVjUHE5STNqNXZ5dzd5S2h5WWdnSU1K?=
 =?utf-8?B?dSt0WWxiRXBmV01ydXR5M2REUFYyMWQ3K3ZOUlJiOHoxKy9RZEpaV0xJTG5o?=
 =?utf-8?B?TWlvRm53c3EzY2FEMFpOS2hJeFdNYVJvK0JnaGMyN2RreGphdDd4SGQ5OEM5?=
 =?utf-8?B?L1RyaTRzVkM4bTJiL2F2c0ZyTG02NkNBR0Y4a1lqZktVRmlYT3YzZTdrcWFD?=
 =?utf-8?B?R2JKYmhWbnVySTlHbyt4UzdHRmJWUTdHb3YzV0lpenpSZXN3OG02dEk5bGFr?=
 =?utf-8?B?SFVOejEwMGg5QjVyOHVHblp0TkJrci9OK1J0eEcvUnlySGk2OUp6eGxDWFFk?=
 =?utf-8?B?UFBEc2hlRGp3Q2Y0b0dnMTlucjE4ZjNKQ3h3eFhyc1pQeFRpRXE5eHlpbFdE?=
 =?utf-8?B?ajFDdng2Y2NpZk14M0ZBNGRETnUyMVUzaFYvN0hBR0J4Qko0OFcwWHB3ek1P?=
 =?utf-8?B?Y3VLcCtBNm1IL3I5elVwOVVKaHFhNW9PbkxBTGFxR28xdVVmeGZrRnlWQW9y?=
 =?utf-8?B?YVpORThrMHZRaENoeWNmU2ZsdnhWKzlaS2NsQm9qS2tFZGJoRDNzdkFtRGVH?=
 =?utf-8?B?Y0U4elo3U2hjUlQ1VWlRanlBdmVOMUpnanBReGhVSllNUXg4a3NVS1k0OG9Y?=
 =?utf-8?B?djRYd2hPczEwRmZsSXpNVnFJUThicGFHSnl3OHZMNy9rekJXVXcwQTNkcnFm?=
 =?utf-8?B?RzJwVXp2d2lUMUVYNCtvd0lkN1c3blBmT0Y0WXBTVzN5MzJ6UHQvd01WcjVv?=
 =?utf-8?B?dnlhaTJ5TlJqV1JLL3N3eDJTT3pVV1NBNmc3Z3ErT0FpdHQ1bzYyZHBab1Fx?=
 =?utf-8?B?MnIxVEtBWWtWL3RkSnI0dGZYSlpUQU5QQzZ6MEpmV1ZWRC9JYm5YUURVTXBo?=
 =?utf-8?B?RlVBU3VnTzNiZHZIRDQ1b1FmS1l3aHVBbGFUM3I2UmFkaHZzK1NWRXNFNElx?=
 =?utf-8?B?VXkwUEwrNkY5Q0E2SHgxZFNCR25RRGRVbloybU84SFA0NzdKQmllRDdGbEp3?=
 =?utf-8?B?b1FhTWlLUkQ5WTFLeGRyYjNHa0s2SmtocHlQY3MvcFhTaDFJT2hBSWdMVUZ4?=
 =?utf-8?Q?R3MwwR+fcJoNgQevbCedwYsqq+DPz2kR1CGt4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a4459f-63b1-4eaa-2c76-08df14062339
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:21:10.4342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvXuMVNlNrcA7UjZoeMfU8JFGuJVAzt5u6GUI5jeJ5Gq+KTzxHeKk4oFwJHWJFWsXrsoBlXanvENFZ2D0uNnFMOVPNCDJ8uBm3lEMlcY7Z/vyfzAK0PPBO0M0ztvpFmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11912

From: Peng Fan <peng.fan@nxp.com>

Replace all chan->device->dev references with
dmaengine_get_dma_device(chan) so that DMA mapping goes through the
correct device when the DMA controller has per-channel IOMMU domains
(chan_dma_dev=true). Without this, DMA map/unmap bypasses the IOMMU
context configured by the eDMA driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 49aabef7f115c..60547006f8b44 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -780,7 +780,7 @@ static void lpi2c_dma_unmap(struct lpi2c_imx_dma *dma)
 	struct dma_chan *chan = dma->dma_data_dir == DMA_FROM_DEVICE
 				? dma->chan_rx : dma->chan_tx;
 
-	dma_unmap_single(chan->device->dev, dma->dma_addr,
+	dma_unmap_single(dmaengine_get_dma_device(chan), dma->dma_addr,
 			 dma->dma_len, dma->dma_data_dir);
 
 	dma->dma_data_dir = DMA_NONE;
@@ -789,7 +789,7 @@ static void lpi2c_dma_unmap(struct lpi2c_imx_dma *dma)
 static void lpi2c_cleanup_rx_cmd_dma(struct lpi2c_imx_dma *dma)
 {
 	dmaengine_terminate_sync(dma->chan_tx);
-	dma_unmap_single(dma->chan_tx->device->dev, dma->dma_tx_addr,
+	dma_unmap_single(dmaengine_get_dma_device(dma->chan_tx), dma->dma_tx_addr,
 			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
 }
 
@@ -817,10 +817,10 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 	struct dma_chan *txchan = dma->chan_tx;
 	dma_cookie_t cookie;
 
-	dma->dma_tx_addr = dma_map_single(txchan->device->dev,
+	dma->dma_tx_addr = dma_map_single(dmaengine_get_dma_device(txchan),
 					  dma->rx_cmd_buf, dma->rx_cmd_buf_len,
 					  DMA_TO_DEVICE);
-	if (dma_mapping_error(txchan->device->dev, dma->dma_tx_addr)) {
+	if (dma_mapping_error(dmaengine_get_dma_device(txchan), dma->dma_tx_addr)) {
 		dev_err(&lpi2c_imx->adapter.dev, "DMA map failed, use pio\n");
 		return -EINVAL;
 	}
@@ -844,12 +844,12 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 	return 0;
 
 desc_prepare_err_exit:
-	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
+	dma_unmap_single(dmaengine_get_dma_device(txchan), dma->dma_tx_addr,
 			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
 	return -EINVAL;
 
 submit_err_exit:
-	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
+	dma_unmap_single(dmaengine_get_dma_device(txchan), dma->dma_tx_addr,
 			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
 	dmaengine_desc_free(rx_cmd_desc);
 	return -EINVAL;
@@ -872,9 +872,9 @@ static int lpi2c_dma_submit(struct lpi2c_imx_struct *lpi2c_imx)
 		dma->dma_transfer_dir = DMA_MEM_TO_DEV;
 	}
 
-	dma->dma_addr = dma_map_single(chan->device->dev,
+	dma->dma_addr = dma_map_single(dmaengine_get_dma_device(chan),
 				       dma->dma_buf, dma->dma_len, dma->dma_data_dir);
-	if (dma_mapping_error(chan->device->dev, dma->dma_addr)) {
+	if (dma_mapping_error(dmaengine_get_dma_device(chan), dma->dma_addr)) {
 		dev_err(&lpi2c_imx->adapter.dev, "DMA map failed, use pio\n");
 		return -EINVAL;
 	}
@@ -1085,7 +1085,7 @@ static int lpi2c_imx_dma_xfer(struct lpi2c_imx_struct *lpi2c_imx,
 	}
 
 	if (dma->dma_msg_flag & I2C_M_RD)
-		dma_unmap_single(dma->chan_tx->device->dev, dma->dma_tx_addr,
+		dma_unmap_single(dmaengine_get_dma_device(dma->chan_tx), dma->dma_tx_addr,
 				 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
 	lpi2c_dma_unmap(dma);
 

---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260916-i2c-dma-e9cd42e4e7ff

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

