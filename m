Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896D47CC9E;
	Wed, 21 Jan 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988887; cv=fail; b=l87lrdjlk/2EdrYPOBY0dib9sAZoXN7RIqjZH1KsDEsbDWcJE1ieXywatQFHNzhwzhxifTZPOSavdd6NzsZOvM3ti+wrNCmUeXSipFwCCiyxOj8jFYgRezPfcLmyi9bPJo/F5igkE19r/dU9lJwxVErclisrIEPtN+b5GYx1Dwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988887; c=relaxed/simple;
	bh=SSKUb+8sFb0Rp6fvUtYw255Z6z9m2LdnR/AMQQzJPj4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AKc8NsPvSwbL3uZgXlrMBt7LkG/HGDObqNqrQjvKDS+aSrJlyAMDtJ89/jnyay5iHKK+80bqyBZozyT4PALIa5GrooNS1boJ/9CAyiUiQrU+FoyD2JwlfzGvMcPW5240Kknx4mCjHZDoPCUQdVti5SFfTxgKc1BftMj8dZNDXGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TBRTmc+P; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TBRTmc+P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKvJNqlz253HEvGnBceYEJFYKtQirsFBcnpLT7L6zim8rQK/Ghjtcuk1GIVfMQFQQSNic6korxHgDROg7fBm4/6D2EvBuOXRmZDVukmebSMqtR679lwPqRUr/v9Urr/WQqJZebFIRRH6uWs+Qwo18EhKX4ZjCkHeqz2RadTKA+A8oVpykHQSZaGNCjjBxOcRBOkN+QijrydvdvoZadtNsemJdCBWO92wkYWnU5NvwUbtJPTeos9aLMkK4FRUjofZAphLmwSKlQdGCLTWlKkyjyWhMTclaxY9T6NMDdrGnZZJWJ+LiotmvzKOdvfQmuWWI7mSEgNa6ZQWIB5JPNteAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0IAsoHwYXi56wRUJMJaGdOTWAq5HjCDG4C8xjeIq+A=;
 b=AoW2EgRoFL0WMsf3tfGbtopx/hC9J2X4PKMuw5r5aKjT1vwcdlnl2kTzD/dF6EXd2svBjlCspOl3yUwu78TIJwOktAOCqP8DesXfvQbpD5LQlaK7yFnwriB0NwHwJNkGxnFUefysCJspgj3GK9n6GomHhI4PHzoV6OA14lz9C114kRcgxWDdaDk9eIsaNvPuxaoHhwq/zxRVSuQ1sC0W7D2sTFVEy9sDQTVQHb7nR8cpG7rpZptUt6Q9VTGTsq/Gv+FLHJp5iac58y7yIJ7vC7TZ0AV+T5ee+mXMKremd65MeVgnMnjkBLOpn93vkzXh1AvKsIXMmd6rC4h1TC/xiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0IAsoHwYXi56wRUJMJaGdOTWAq5HjCDG4C8xjeIq+A=;
 b=TBRTmc+PE7oMzqEVux83jWCNxmC21JP6TfTfDy0gvirigKncvtIvZ+TZ1pTsn6qsyUADAO33ztmv/nqU4juDVTTxv8By35FKKpP3ew0WQ8MQ4iYtEuXaMxi6EnUX/B9pfGqbSRrNlqImDlpMppJRJyYYKhTE9pvJctcew0IFgq9domL/YteZGwe6F0Yu3Zkp7SXjjoQj9FLeDw034e58h5nrbiEtuYtpUFTpZkTUhnjByxhkDsuRZhnDdJFgdY/XwctUv1YBbiCX+UNqnXC1JMBePdWQH7bMs4+jshY5aPQpvOJcz8NZKuIe35MeUfcxN6zpY/hk7zPk8vKCgBCAVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA1PR04MB10865.eurprd04.prod.outlook.com
 (2603:10a6:102:48a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:48:01 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1%3]) with mapi id 15.20.9520.009; Wed, 21 Jan 2026
 09:48:01 +0000
From: Carlos Song <carlos.song@nxp.com>
To: andi.shyti@kernel.org,
	aisheng.dong@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	vz@mleia.com,
	pandy.gao@nxp.com,
	B38611@freescale.com,
	wsa@kernel.org
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [Patch V3] i2c: imx-lpi2c: fix SMBus block read NACK after byte count
Date: Wed, 21 Jan 2026 17:48:37 +0800
Message-ID: <20260121094837.2651035-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0050.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::8) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: 99114791-1cfe-41b0-50f0-08de58d22a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|366016|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aF6n3OVkpy8nezUGdp479bD0OM3UfK4G3OEtxiWBH73GACG3A2qylEnLTV8L?=
 =?us-ascii?Q?YNLLHHpKEppJvLUKxldMosv2FzMSmU0lRGJoF27pzoHr7vfZ2yOnSWlYk0Cj?=
 =?us-ascii?Q?sg31JnznaXgW2JzqgD9IuWGyK2paGB+KdQnRcjG27O+/n5j29CBZH0KiS4y9?=
 =?us-ascii?Q?mjzIae9y4awcfR+o+cPTd2Xp5rh4/KSpG8rYRSMDOSDpUIlYaHypWKyWPYun?=
 =?us-ascii?Q?cWe9+1s0pc2BfVHaJ0nCgqYJhniTWHOH4Msx+jYpT+/3plUFksfua1PdNQpH?=
 =?us-ascii?Q?9RATLbmW3cFm2Ub2LSmT50T5t6UzHXGmvbs1PYo8ELrVUh5nRFX4lgEffLPo?=
 =?us-ascii?Q?Py+gisbcy4j4eMGjdDuwDKzeFV272A6D2+RWGmM1IYiaBceirTBpweGHsyTB?=
 =?us-ascii?Q?A0rrxzSvSeFe8HPs/943BxNrA44OAIoskjLKNnKayBZ//DUWLn4MReNeVLxA?=
 =?us-ascii?Q?oj+CG2+5uKU4vQFDcx7bbly493SCXTkxMlc+UFxG7t4KVHbcUUrWJER85N28?=
 =?us-ascii?Q?FgOeLcYwOFUyqpTTw2TjgQtvRbKvSvOw7N4teXSqpqJJoUOD79rTBvQfjqbQ?=
 =?us-ascii?Q?lRA5cm/BQ+kmpOmum/WQYi2lGl+jyyTqHSSixLrlosq4aGgiDVxnW071mb4d?=
 =?us-ascii?Q?etUCuj8hNKWHfeESS1kGkTEVNmn21CNW6qVoQd+p2b6O2uHkcqyAlslVscKF?=
 =?us-ascii?Q?kkX1qR8XjZyhNZfcImcA7HOVb4vq4M0mx/XQZNacyC2alLluGQBU2J0nDc1v?=
 =?us-ascii?Q?FqHQRGcGze+tX8Z6JbcRiNziS4/v10sGQFype4rkuYfuY2Lm2Vee5zDgMDDr?=
 =?us-ascii?Q?CvM8Fri1BxDrYQujQyQEOz9CppZhi56LTxjSqS0CxuDWdnGHYxGZi72l9yXY?=
 =?us-ascii?Q?Zhkl4i66jQmrxM/Cs9FQe/BiFZjRjt+CiOWDB+EJIToLkj9rYzxb5yGpHiDo?=
 =?us-ascii?Q?kWrympb0TaBe0R6HI/c3PRG1YZOCxLf5fgMry9E734hF5WiHqPV25SzzRXH/?=
 =?us-ascii?Q?hiCSCyybW4uVwbxrPu3YjM6qIp/k2oTmhp7MofjMIcP9YeFbS8IfXC4TMAcH?=
 =?us-ascii?Q?1eY06mGFjtZiKRbMucSkaWaVdJPgSc2VnklHT4kzCWOHWykj9Q37fflXoKxJ?=
 =?us-ascii?Q?DQfudabvzethAdwLUK4BFxw+Rj6i6wa1hPzCSIFZcM74ulJHXkPNThbpYdDH?=
 =?us-ascii?Q?l89hOHptbg5u3IHvl8oDWdRrly/YWukG6dZgFITtd3hUC3xzCB74QnYDMDgl?=
 =?us-ascii?Q?PKvETIJAII3S+HWKBzOp8wpHRQAnMvRx6OwjYNpWJa69f1mzVOerMLpobnk3?=
 =?us-ascii?Q?OZKfIpkFGmh8MWw0mtWcmjlPxuIYMLVkKedfqNCbnuFzyci/0E2FzME0CeEU?=
 =?us-ascii?Q?YjKwae4PPazmvtBTcPV/QKQ61a3wpsrBNiwq3FmGwDT7hcMLmvoMS5vWRqVK?=
 =?us-ascii?Q?q3lfuOzVPyERpPMWkpInWCjefpWjd4uiPXgKPjqzB14djsiONGC8i+Yt+qwL?=
 =?us-ascii?Q?1DMBP9NTBhi9QDMe1u6UXzhvRnYhIVk68AvzulbzqHyp8VkZEonqg7xfSgug?=
 =?us-ascii?Q?NkanWH+V3R/fX6vJkyRhB8Z8okd4KLknHJkIoi01oqXs0oCaonMz7pRXcJ4I?=
 =?us-ascii?Q?U6jw8dpRWl9J0XLagdm7ZEZzVUU6NviDGmwgL/whfbbQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(366016)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVfjNwcU+P7JuKgxrI/b2U2CKzOCAH2FMakfQ5TyBqmb+uPfEmHlX85UaK+Y?=
 =?us-ascii?Q?W0TAsrW7pFY3FDZ+0+UyH9MQL9MD2rvaZKwi2ty5Tai2eJVJ8OZeVIVPAIjp?=
 =?us-ascii?Q?DRecAFmx1PQS5bmCOyU4vldMQmz7B3jRNc2LjICX5SuCUWu2Iibp9LPugvEX?=
 =?us-ascii?Q?zlETW6aNFIaa4X6d+DbgJsKQ3g0qhiLiPZBmbFr9SdxmQiMLyM/v8wrTl1HN?=
 =?us-ascii?Q?D4wgxAj91cLZ//ysGd01g6NAeU486EX1jydyELFwnXuz0wCEOckrY7uUfQEq?=
 =?us-ascii?Q?P4Ozo3sQGLsRlthWA6LZn8v1bquht92Ozo4/MSgfrv8aw4V1GXger39WVthr?=
 =?us-ascii?Q?QsYeentzO6vvt6J4GVxkv3m44gmttKSme53X0xJkbNIuDEHmgtBOBHPqFkPF?=
 =?us-ascii?Q?iloA2uUA0kQE6hBsXHsfBNNpCM7fn7pnqb8aBtsobYHp6jc8loOlTchZlUhi?=
 =?us-ascii?Q?5CqfSGaEF65xiRwwKTILFfhpPxzrvtjZLpe6pcOBEPyG7V9PbIsqPeVGuelu?=
 =?us-ascii?Q?BiGI5owxzM5YPnk+/UjaWVV2rWMzfQy8txamUvF9DvoGlvooNiJWoqCNf8mq?=
 =?us-ascii?Q?VBZulhMdmxz0bMbU5ED8jhquZ1Sai1z/GthabSFwxfxKOTJe8+SOiUNxbixI?=
 =?us-ascii?Q?d8NUaFem/UBEtTSf2WQUyAeq+I+R2Mk8m2S+rtXKL1FEGiXE0q7A+hDado1o?=
 =?us-ascii?Q?4DHbrYhUN/m/CjBrGAGDoBQ52iYiTPIu4nE3O/lAVZz1tYthuxW0eojlXm0i?=
 =?us-ascii?Q?gkvqaLsSOLqPJEW23IpLA8JRA4QlAzgvVYD0hahJ4WH5XM/L0QSWtHjzpzAm?=
 =?us-ascii?Q?IUPC82a79EwoLqkxaU29nFNmBvuHPQR4nI2R/luLyGcvCZ7gPGk2OE9Dd+JK?=
 =?us-ascii?Q?gL56Hd/IsTl/Z6UreDZM6jhQJs3i5eZVIUEOF8VNWRtKIrjJEqmPoUdwzCyO?=
 =?us-ascii?Q?fzekEQruO7Jb0nW7YPyux2T99bL8nePBQjDdnnQu0oc92nE5F2kaFk1WMxE0?=
 =?us-ascii?Q?OMEXEGteV1QlHN2sq6EfYvCZd2un3i3fsnGRGuJZgr4CBvevbe3pq9UhKApn?=
 =?us-ascii?Q?q0dVKlrOz5IbJ1A0omk+1RXBKsqh8RIgaBzQYTtANDRX5ZvhJBRyJMJG3so3?=
 =?us-ascii?Q?w4GiZKFNCFZwvSB+7YqGp0H/XCBlDJo6kKJpGSh94TRZu1qcDDU6P2+viReq?=
 =?us-ascii?Q?Es0hjpNY4Xo6toYcbbTBwUu5baSGTy7aXELtXLQ3kjlV1SBE/mh8+qoaJAgw?=
 =?us-ascii?Q?dMhE8t8MmmNmlW9DblVj1Nceo/lNqLvNd4aveYSFHKaUriYKyucCfebdQyLB?=
 =?us-ascii?Q?+edwe1xVOybCTYlti4td3FXUYTfcM5taW2ixK7MONF2EwFXGcbiPl9+6yXRD?=
 =?us-ascii?Q?8RgfYmV0adGexcM73KrvY8O02Gtbhp4Y20yqdbpKH5L47tsO4U01eb/N1r9O?=
 =?us-ascii?Q?asEdeizqt/8SiVP3iVH5s5oH97n3vXrR1KEqys72M2cWr7xYMR1vOwKjVlbO?=
 =?us-ascii?Q?zBqv9X6ktfiELmbyx+H6qUZifJeNpP2J1wge11ZG2jfNIeDllbEZ1Yrea6cr?=
 =?us-ascii?Q?fgFxlC64/zS18F5/a9CV9I/0gD/nzxR5EhyMq6UVWDczGeIHQEZL7Mu2jlLJ?=
 =?us-ascii?Q?3D7mXalN/FVImY8aiQfi3HRyBGxSpNgpw5hozJo+ciCEKRVTXlwXaClp74NY?=
 =?us-ascii?Q?IiEUGYc7MYoeeePlWPzY+cfKkHkxhuuSiNhsTdHIpEWYcV9DCaqeK09/qtGI?=
 =?us-ascii?Q?uGtVJq8hrw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99114791-1cfe-41b0-50f0-08de58d22a87
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:48:01.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFpIaZ0rG/qZShwIHL1TRiuUTiqa1vssAmbYAu4BZ6kGURQRJGKosQSeYL+8q7UENWf2u9Vu5c+65aBksqcMHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

The LPI2C controller sends a NACK at the end of a receive command
unless another receive command is already queued in MTDR. During
SMBus block reads, this causes the controller to NACK immediately
after receiving the block length byte, aborting the transfer before
the data bytes are read.

Fix this by queueing a second receive command as soon as the block
length byte is received, keeping MTDR non-empty and ensuring
continuous ACKs. The initial receive command reads the block length,
and the subsequent command reads the remaining data bytes according
to the reported length.

Fixes: a55fa9d0e42e ("i2c: imx-lpi2c: add low power i2c bus driver")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes since v2:
* Change patch name to clear "this is a fix patch".
* Change patch commit log and clear "what is fixing".
* Place MSR_RDF_ASSERT(x) by MSR_RDF_ASSERTED(x).
* Split this lpi2c_SMBus_block_read_single_byte() function to ensure
  return value is type aligned.
* Add return value for lpi2c_imx_read_init() to ensure transfer function
  return directly when meet error in smbus block read length byte stage.
* Don't read 1 bytes when block_len = 1 individually, insteadly all
  data bytes are read in IRQ handler or atomic_read function.
* Improve code comment to clear up every step logic.
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 106 ++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 2a3b8d4bb4df..897290e49b36 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -90,6 +90,7 @@
 #define MRDR_RXEMPTY	BIT(14)
 #define MDER_TDDE	BIT(0)
 #define MDER_RDDE	BIT(1)
+#define MSR_RDF_ASSERTED(x) FIELD_GET(MSR_RDF, (x))
 
 #define SCR_SEN		BIT(0)
 #define SCR_RST		BIT(1)
@@ -482,7 +483,7 @@ static bool lpi2c_imx_write_txfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atom
 
 static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomic)
 {
-	unsigned int blocklen, remaining;
+	unsigned int remaining;
 	unsigned int temp, data;
 
 	do {
@@ -493,15 +494,6 @@ static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomi
 		lpi2c_imx->rx_buf[lpi2c_imx->delivered++] = data & 0xff;
 	} while (1);
 
-	/*
-	 * First byte is the length of remaining packet in the SMBus block
-	 * data read. Add it to msgs->len.
-	 */
-	if (lpi2c_imx->block_data) {
-		blocklen = lpi2c_imx->rx_buf[0];
-		lpi2c_imx->msglen += blocklen;
-	}
-
 	remaining = lpi2c_imx->msglen - lpi2c_imx->delivered;
 
 	if (!remaining) {
@@ -514,12 +506,7 @@ static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomi
 	lpi2c_imx_set_rx_watermark(lpi2c_imx);
 
 	/* multiple receive commands */
-	if (lpi2c_imx->block_data) {
-		lpi2c_imx->block_data = 0;
-		temp = remaining;
-		temp |= (RECV_DATA << 8);
-		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
-	} else if (!(lpi2c_imx->delivered & 0xff)) {
+	if (!(lpi2c_imx->delivered & 0xff)) {
 		temp = (remaining > CHUNK_DATA ? CHUNK_DATA : remaining) - 1;
 		temp |= (RECV_DATA << 8);
 		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
@@ -557,18 +544,77 @@ static int lpi2c_imx_write_atomic(struct lpi2c_imx_struct *lpi2c_imx,
 	return err;
 }
 
-static void lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
-				struct i2c_msg *msgs)
+static unsigned int lpi2c_SMBus_block_read_length_byte(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	unsigned int temp;
+	unsigned int data;
+
+	data = readl(lpi2c_imx->base + LPI2C_MRDR);
+	lpi2c_imx->rx_buf[lpi2c_imx->delivered++] = data & 0xff;
+
+	return data;
+}
+
+static int lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
+			       struct i2c_msg *msgs)
+{
+	unsigned int temp, val, block_len;
+	int ret;
 
 	lpi2c_imx->rx_buf = msgs->buf;
 	lpi2c_imx->block_data = msgs->flags & I2C_M_RECV_LEN;
 
 	lpi2c_imx_set_rx_watermark(lpi2c_imx);
-	temp = msgs->len > CHUNK_DATA ? CHUNK_DATA - 1 : msgs->len - 1;
-	temp |= (RECV_DATA << 8);
-	writel(temp, lpi2c_imx->base + LPI2C_MTDR);
+
+	if (!lpi2c_imx->block_data) {
+		temp = msgs->len > CHUNK_DATA ? CHUNK_DATA - 1 : msgs->len - 1;
+		temp |= (RECV_DATA << 8);
+		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
+	} else {
+		/*
+		 * The LPI2C controller automatically sends a NACK after the last byte of a
+		 * receive command, unless the next command in MTDR is also a receive command.
+		 * If MTDR is empty when a receive completes, a NACK is sent by default.
+		 *
+		 * To comply with the SMBus block read spec, we start with a 2-byte read:
+		 * The first byte in RXFIFO is the block length. Once this byte arrives, the
+		 * controller immediately updates MTDR with the next read command, ensuring
+		 * continuous ACK instead of NACK.
+		 *
+		 * The second byte is the first block data byte. Therefore, the subsequent
+		 * read command should request (block_len - 1) bytes, since one data byte
+		 * has already been read.
+		 */
+
+		writel((RECV_DATA << 8) | 0x01, lpi2c_imx->base + LPI2C_MTDR);
+
+		ret = readl_poll_timeout(lpi2c_imx->base + LPI2C_MSR, val,
+					 MSR_RDF_ASSERTED(val), 1, 1000);
+		if (ret) {
+			dev_err(&lpi2c_imx->adapter.dev, "SMBus read count failed %d\n", ret);
+			return ret;
+		}
+
+		/* Read block length byte and confirm this SMBus transfer meets protocol */
+		block_len = lpi2c_SMBus_block_read_length_byte(lpi2c_imx);
+		if (block_len == 0 || block_len > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&lpi2c_imx->adapter.dev, "Invalid SMBus block read length\n");
+			return -EPROTO;
+		}
+
+		/*
+		 * When block_len shows more bytes need to be read, update second read command to
+		 * keep MTDR non-empty and ensuring continuous ACKs. Only update command register
+		 * here. All block bytes will be read out at IRQ handler or lpi2c_imx_read_atomic()
+		 * function.
+		 */
+		if (block_len > 1)
+			writel((RECV_DATA << 8) | (block_len - 2), lpi2c_imx->base + LPI2C_MTDR);
+
+		lpi2c_imx->msglen += block_len;
+		msgs->len += block_len;
+	}
+
+	return 0;
 }
 
 static bool lpi2c_imx_read_chunk_atomic(struct lpi2c_imx_struct *lpi2c_imx)
@@ -620,6 +666,10 @@ static bool is_use_dma(struct lpi2c_imx_struct *lpi2c_imx, struct i2c_msg *msg)
 	if (pm_suspend_in_progress())
 		return false;
 
+	/* DMA is not suitable for SMBus block read */
+	if (msg->flags & I2C_M_RECV_LEN)
+		return false;
+
 	/*
 	 * When the length of data is less than I2C_DMA_THRESHOLD,
 	 * cpu mode is used directly to avoid low performance.
@@ -630,10 +680,14 @@ static bool is_use_dma(struct lpi2c_imx_struct *lpi2c_imx, struct i2c_msg *msg)
 static int lpi2c_imx_pio_xfer(struct lpi2c_imx_struct *lpi2c_imx,
 			      struct i2c_msg *msg)
 {
+	int ret;
+
 	reinit_completion(&lpi2c_imx->complete);
 
 	if (msg->flags & I2C_M_RD) {
-		lpi2c_imx_read_init(lpi2c_imx, msg);
+		ret = lpi2c_imx_read_init(lpi2c_imx, msg);
+		if (ret)
+			return ret;
 		lpi2c_imx_intctrl(lpi2c_imx, MIER_RDIE | MIER_NDIE);
 	} else {
 		lpi2c_imx_write(lpi2c_imx, msg);
@@ -645,8 +699,12 @@ static int lpi2c_imx_pio_xfer(struct lpi2c_imx_struct *lpi2c_imx,
 static int lpi2c_imx_pio_xfer_atomic(struct lpi2c_imx_struct *lpi2c_imx,
 				     struct i2c_msg *msg)
 {
+	int ret;
+
 	if (msg->flags & I2C_M_RD) {
-		lpi2c_imx_read_init(lpi2c_imx, msg);
+		ret = lpi2c_imx_read_init(lpi2c_imx, msg);
+		if (ret)
+			return ret;
 		return lpi2c_imx_read_atomic(lpi2c_imx, msg);
 	}
 
-- 
2.43.0

