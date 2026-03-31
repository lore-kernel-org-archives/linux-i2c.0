Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363FC27B353
	for <linux-i2c@vger.kernel.org>; Tue, 31 Mar 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981599; cv=fail; b=dooh0BHPHkP745bc0f1xm2aUh3V0e6XmwwoMrIjxMePmoOgUoFFhTt/fzQWK+lx7nTnEggDHBUWtJVm/N+7zk7L1B8cvYod3nxYZR0OTq+/5iwpuPgDlaxJo6vEc29lpnqzKnZ5MPotHfcSo6C9p9fT6DJ2Y9eQxrno61tycBJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981599; c=relaxed/simple;
	bh=IidOR8fCCG325wrW2pGti5ILb2iL6Us6O0vVuvgFlCg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m1uneK11O713pGMpES3xoh31mkjcXodvJcMxHo55zjVPdj22Gbnl/JhyAE54rSPiEE0jV/iAUnY+GOozXxZ9eogs1aev6nABv/pPiE7aAtZ5LtzwTyBEx4fNi5Y9HGBGgsPYY1GQJjAGrq+z/D0gH87G/JSmX6fxRhnvAifYNMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=VFnnWFe5; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="VFnnWFe5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB/iDoO3C9fXzYlsSVZmkHlZXNMMtvzSzQ5wqefREMLxltL9doS4853TuMX2+yo1B3QPi4HzjddKUIm0R1AIbS+0cvsoGUD3CEmBMQkfZO17yYC8m6b4Rmeg67b5aubWkElDryAVR+uoutFJFOXAAqfY7K5rk+SXIBWcRw3PjM4dYUP87y4QhC8anEvLdtuLRA3JEzNleva/rGx96EMyhGlaYmGQNVwfvUvfERNXQ1TAQV1liPw2HFoSsrIdkARNEP3wgBeB7/Ig8RqlOWWoCbWenirtENdVrYaZEdfhRIQ87qSFkxeIQ532CfW2MV/VOLXzlhrE/FasifeaPoEClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qReMN5SfeIHwURkAuYak6d4yGAxIBwayh55Pm1DYF1U=;
 b=EtjXdGY/KqcKFvFfWGWmzJ315lvypRm3gzFQ+ouK1g3ajfhdXNduuCnauf+gK3KKNVuQcq/BoKJoxS/nj/OrpIGiN8Sv2HNsBQSB8lrQp88tvyEHY9aO5IDtWzwCv6RNIqaVfib5I5vQFhpcrdXRVc7WONuR25NJSj2n+cadHNUqiZQo+znqePjGP09ApeEASGswrUbwDSlcCP5KipstDf8rqrQ1/ZQ3N01DKiaIBlZYY3zE8/GL4x6jvhUOStpPSROIoo6uOd2sbuG01T2b8dW2cml6rLYap/uRhaz7Hdq12Fx/aiAKYHDw6FvhtN6BVj2mcPHhBKv7cOMV3dwPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qReMN5SfeIHwURkAuYak6d4yGAxIBwayh55Pm1DYF1U=;
 b=VFnnWFe5PhEfvzvrb6h0diKcOr1oDzjsNbterqPs+0jC3VDH56SwWXhoGrw/P8vJ2GOOGbgbavGBcodL8egr71C5dNwDW+HgWztqq2lJoZDTrUtEVuHQxewukahSIhBDqakivFTk4+0jr4UfzqBUPnLBpLCpL54NxDuyxbcHtowZqJzMmNP7gb1fRR+zYl+OznpocDDpsk26p4yaYd1rNTtlKgHLUpSSyMHLKa9WwFH1aZOEIcwaINdQch5yQFwi4Y0totGXafqZ0YIWi8Yy1WxTkan/aAtZJ+1UU76X7TvuB9XJPDsBPVhuONoCn6Er5t/6DFZQLdaCEAvEzg3Ihw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from CH0PR08MB6954.namprd08.prod.outlook.com (2603:10b6:610:de::17)
 by CO1PR08MB6756.namprd08.prod.outlook.com (2603:10b6:303:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Tue, 31 Mar
 2026 18:26:35 +0000
Received: from CH0PR08MB6954.namprd08.prod.outlook.com
 ([fe80::22d4:b8e6:e5f1:108b]) by CH0PR08MB6954.namprd08.prod.outlook.com
 ([fe80::22d4:b8e6:e5f1:108b%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 18:26:35 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: linux-i2c@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] i2c: imx: zero-initialize dma_slave_config for eDMA
Date: Tue, 31 Mar 2026 14:26:32 -0400
Message-ID: <20260331182632.888110-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:610:76::34) To CH0PR08MB6954.namprd08.prod.outlook.com
 (2603:10b6:610:de::17)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR08MB6954:EE_|CO1PR08MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ff27ab-8683-4260-3d34-08de8f530a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	k1MWSeefOcp1+eWwb560v2gz/CDQKHlrNmxXcashDYpugIqfNq5EsaKnFd0dJFkBzfjMXhEwXCRcfZzDtzDt/wtvXWS9ihULycyyD02ukDJIZ5voCVLBlMZR6cww9BEWxvucINoXWLEptxkH4tUYJBS5xgCuKKkQWvMUZ+hH9hKDOU7j08WSQ3KPnw5iOD3GtNvUdydKb9mjyOaOQKtXkc+IimM9u0E8oVZKUVYWiYu+Ura65xtu/S6i+XcdcqzJoUFXmQ2I/bcEnB64aWq0vd34kw/1iQ6GmZc/Q27Pyuzp5oaU5SbMUib3cP47+CXw7mN+IrA5IH9aKEyKFhHkJUIo2LsOyNV/kUceO61XVTcSyHeDu3Ea09s/ZlWr1V0HGk8b1bg8tZ6JUyJ95S+rbRhxxZVI26NWe1oezqDUyZfyLJu45ZSz0kOONwgEMY+4AvfKwQbpycOXGA9BS8qoXmLcs84yQzM8S4skOQE5pUvzxKpDOzZqa1WBd7AdSlZiFd6XgF8ko+6DxyMDIXXa8d9jLML66MLsZDzWxI8K5nvU0DeFL5jWvQkN29QSZl5VDH85NcJ0eyTWR32Xvj1DuM3nv85dc9RDyAP60TuVxGegsTaB0pQoQ9M/X3Vo5geGBDng3Dpg4j5rbiiiy5G+hoOMPvKllUotHBRrIpZsBtRzksRFfAKxUhddri/Y5CtDgbWHJJ3LqvnSsl8JwarKe1bXZ/9PUCA5AmLN/dH26EE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR08MB6954.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D5lvOX1fLWRmSR4kq5TGHxmbOj2NRliPfg2MFgrNoCxxkonWsFCFlfUJfSl/?=
 =?us-ascii?Q?M6PeSTcWMJYGSNxT8TGy2gaYvDz1HDBSJbI2wOltvT3N24kDhgOFdkbN+R+4?=
 =?us-ascii?Q?6RfIwmwNL+1UO5X6Yp7TNSZkMallCgBUb3vKAIbediDTREHBB6TVb6S6xv2J?=
 =?us-ascii?Q?bST5Oh++xQiAPZp9AUut0K795spp8t+HiJ/twQgHbnpZQJIAqTpqFNgsIs9f?=
 =?us-ascii?Q?2JildnTpDYYL5x2/HC2vg44pizo3KrwI68l2F6015PSm02rM3hmE6Cdb+zwK?=
 =?us-ascii?Q?1KY050l1SGWTWpVGjRZ/2UzNHE+DHv6ljmXTK0OTJCDyCRwytFkw8PCg7x+j?=
 =?us-ascii?Q?HTAKEL+XL1xyZgc8O4vYTuW/3LLhRBgGMs9DX5ij8RpQDVNk46emC+Y3UhQy?=
 =?us-ascii?Q?7V9THaD7O4EUJqQfRchVYA3hfOckNumQ9WfICbPPZbQaD1kfcSAt3l7IyqR4?=
 =?us-ascii?Q?4rXw4JTOWkAj+7yaneOSu0E2oANNKQb4j4+zpFCQ5PxNPP2GajlnAyfbgXeb?=
 =?us-ascii?Q?ncV+aJHoeQyAX6OqwKzX+rvaD7F5MAXmXo0qp3kavlMM2eydd02aWv4Bql2E?=
 =?us-ascii?Q?Yp3gIZf+N+TbgENdSs0PHPe1bn4rV2U9UTkuJDfD2k/LoVX5hq+mR0/snHy9?=
 =?us-ascii?Q?XftZecOg10iVC556ee0ZNdSB1e36qFM5zX/AsPz4oiHtThksq0r2M0XlZWbb?=
 =?us-ascii?Q?FtZEWPBUuT6Rz9A9NM+WdqLOyPjI9y/vKRX42yVRxl/6Ydf7d5vv5JDcAVvd?=
 =?us-ascii?Q?hQjpbIv2H197tZnCet+caGLrV0rTcJXeZPRk3+Qq2VPHJTDEeUyoayUAv43M?=
 =?us-ascii?Q?L4JZUgJ+044ds5MfonRKcwC3OIGQjxv+BzP4Q+COPTUmWeRSxFovpNvp29X/?=
 =?us-ascii?Q?AQe3ADvfopH4khruiW14zidnbCUgDPZNniv4V9Tg96FLZCONLyytWahfjBxf?=
 =?us-ascii?Q?onqMyfsznNAuTtP4+NSJre2Jy00ZtFwIqOECaJjpLytodk326ZaCnBcRYGao?=
 =?us-ascii?Q?XoR/BoGob3b7qGG2ntwOhsikVs/IDZiVLk02NVtCnr9x7ABtPtUxZFI4Ibpd?=
 =?us-ascii?Q?qRHWONo7EN2TiS0MGaJfMkIxENq+vQYqsrHeRmX2GBDrf2TmjnYlWXZe6Wxt?=
 =?us-ascii?Q?6fUakZ2E4ZRVfXJ1mnoN6XF2q3/yZjnQeqnCQgTsk/O5abbGylG0BOGMBhUa?=
 =?us-ascii?Q?3dTXvUETXqwGxDFA7cgshlSq7FCGFF94Arvt7p60vTyorgu9W39HPtNsq78l?=
 =?us-ascii?Q?ulrmieyjXKe7+PZiNa17Fa4alyboyUUQqQ+S2LQThgkPz4ubmd2Ngr8APyfp?=
 =?us-ascii?Q?L5IuzUGZJQ6R1XDLKfpeOH52/uTsSK3eUapqB3cDJXI8x9eOtANtM80BJwoD?=
 =?us-ascii?Q?saIaD7ev1hORRTPASaba4ZaW63Czgiba/2LuDl4g/JyWwgwPuzn18lzPmkrm?=
 =?us-ascii?Q?Z6rBXkFf37CArpKzftWUPR9RYYrJ+65LHJwHqD8T8KCsfsulzLqm6rxDJ43k?=
 =?us-ascii?Q?N4XvWnRApsmmU17B4dYI5k2YJc1X9lEXRvzPtchVcMBciomUsqZyOdf9mhWw?=
 =?us-ascii?Q?n1FFnsUaEbM2+w5zg/VSBZhyc3e0iOoA8jitXe05XOTLoPkVeRtfOQl6Kl1D?=
 =?us-ascii?Q?Vn+ijBElCwcHGjHJQLdNlhhVYaK2zkBw9O/tu2KrGGZNmrWhB3vW/gs0jT4o?=
 =?us-ascii?Q?Nozr6+/051Mj48gKwfZo11ZUPcvx+BsqfRnU/HLyFRc7quAdU6yfbBMHYa8P?=
 =?us-ascii?Q?SjOnxK3Upugyu6XdDcCbqXqp1P9AlIA=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ff27ab-8683-4260-3d34-08de8f530a63
X-MS-Exchange-CrossTenant-AuthSource: CH0PR08MB6954.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:26:35.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XptkL0kctnOljoImebRVS7Vmr4RN2ggEzWxj3crdopAJhf3LJAF8RWAX2fC0AtrAWdb+9mcR+B2O2SF9u2yoyd8s3qTEX+bfkw9rMSBsBgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB6756

commit 66d88e16f204 ("dmaengine: fsl-edma: read/write multiple registers
in cyclic transactions") causes fsl_edma_fill_tcd() to read
dst_port_window_size and src_port_window_size when building transfer
control descriptors.

Initialize the structure so unset fields are explicitly zero.

Fixes: 66d88e16f204 ("dmaengine: fsl-edma: read/write multiple registers in cyclic transactions")

Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 452d120a210b..a208fefd3c3b 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -401,7 +401,7 @@ static void i2c_imx_reset_regs(struct imx_i2c_struct *i2c_imx)
 static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx, dma_addr_t phy_addr)
 {
 	struct imx_i2c_dma *dma;
-	struct dma_slave_config dma_sconfig;
+	struct dma_slave_config dma_sconfig = {};
 	struct device *dev = i2c_imx->adapter.dev.parent;
 	int ret;
 
-- 
2.43.0

