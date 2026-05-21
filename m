Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B512F385D6A;
	Thu, 21 May 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335986; cv=fail; b=N78GdLTg2UtubayJZEg4VrmV4Be3plIMNO1RyVmmHoO3SY7wdD1alBE7Z41E0ncHYbQVG3sx+1dajVZV6I05ugp++JoTKQa2EVAM4vgWZYNgu853eEGyNO9Jc6f4dK7nfHNyv/HaXgNtCp4MB9sNWD1Ln99qbU0qP64NnO9u2UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335986; c=relaxed/simple;
	bh=2sXTknih1DN+NnE7lpUY5hzvo/PXuM6EBbDzXwj4VaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liQOUISd1qJNfKXlDyIuauC+3xS9q4gPgPemy+YeEvaGMTi0bFL4I8Y7JmoH4jJ5o6OWAZqB7C4ag5djRZWMJy56z+8dj+8SSr/nyMyIST3nqndL4yzjlBrq5eZkFcxnwWisvLRwhCCfNzhXegsYmODFIZugBjoHB4wB5BuLPXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzBHTr3AujT+jCcpOH3+rulN70DVea/sOwbIPF820i5JiHGpZxeHf78qqnSFp4jvAg8O5MDDE5TFk3MUOPybV8aYuWySUR8IVn2GC3kHpDMvgv9dNtqU8yziyV27TjsIEF7rQh/hcG4ns4CM2vYFgnY/tD0ihepty8z5mV6o+vupyY+h+Mf5hYLFp8ebRoOZZDhFU0yN8pxMA+WYdooXAH/vtVPME4OlXIjlpq72Lr+F755fgSC92cv8jDmu1qKTjnc0Keq66FU+CInzsBIKtcT762BXlm1FzFPk8qspAnOq+KJVJMvaFPnVhi6diAWFtEXZW5YtzMkseskSrh5wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEdy0aoLOHoNAbd4hyI9FRnLnF/WSLLtj+61xTMbWYo=;
 b=fM6aFHlKZk9gdxm66Cdt3HGc31NyUGjSmdBW4YULWgOxtVnN24RudmM5iYk6a4hKZWnJI1kZcKo1ndbPeaAKXIZKOFuHIyVuV+jB2VXOnxzegAqvXAWgTKEdYgMMY+M4qWHuI7Jw5BAaMnbIflmHbY5CK7OWoiJjirXFW/48tdEpQeAgSRP1+qUqO0ZifgiWgB6RZP4IoYVmEBBXOraLLdlf9ImjSiayoaKgjpbElXv52CuTThRBWp97NpGAaIBSDSkL8UcMA4yXRqPzC5eNIctevTWkIQj4D/YQp500pCaE0TbFFN1hXzOv/oSRBsDgHvnpNTuVAfO3SCIrTZv/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 03:43:49 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 03:43:49 +0000
From: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Subject: [PATCH v1 2/3] i2c: designware: Export symbols and add __weak for DWC I2C driver
Date: Thu, 21 May 2026 11:43:39 +0800
Message-Id: <20260521034340.27837-3-lianfeng.ouyang@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
References: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1302:EE_
X-MS-Office365-Filtering-Correlation-Id: 69149620-8bb1-4ed8-40f0-08deb6eb2b16
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|22082099003|18002099003|56012099003|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	yeVSoywKMp6zwCzMhtNR6pNAOaQUd5yXX0eBh9ZQ6dyrEbv0Q4KevoGw+A8W3ilCj1wtc2SZAar2QHfH9Xifq32NDbWdqdbdEGb8y4mOV9bUiQQuXSyZVOD8eSst9Px3RlsVn5YOlNqrMGP6NZrKmUMZraHftJT3ioJeUmZ1f0L3py8iTKGhyZ6fjvJKfFHTBT4VZCPAFK6+nbiAPl4xe1b/pI1ErPeoa8uMWB+IGh5fzpVI4be04mHut4vKn0WSN8dQm5cg6UgzDiZOhDx37GhltNyMn7uqubntag/D1tO/l4auhbkjXZmx3+zigsCi67nsW+bCJLZEdl3gte70V+iayg9QoYA2QIr5xdXyb9DMjOcmZghl/gQUDRuUcx2xMscq9qeTNmhPB/GGeCWj8aqlAHBHty7un1e+Ve8i4w1wBWpCO+MW44NsTD/BWEpsEmZOlHkZGDFbG0S1wdzK8AOwj77jL0th9Z6Xj+dhcn41ZMY7DRj+FwMVdk6DTvp6BNKGVl5H1fgwvw3PSC24dpM9TSKEHluRcknVlsXsmDEv+ge5zw+HccQxe3JdifY3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(22082099003)(18002099003)(56012099003)(38350700014)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bbo6GNUKCyEYHXx/2HkWJBZRPN2ejeJY0AWeIT1lcsbdrkNfGfrrsn/bd+0r?=
 =?us-ascii?Q?kP9iFPiuaqVJgtGtEL/iT0s7AjWjv+YaKtr0ncW9BqyBPCBLL6bMQVyrgnK9?=
 =?us-ascii?Q?lRGARlE6KbG+/iMb8Xja0ndRDhbTJxKuyUqsKwOYW7YZcrrJj4wlhjf25MRK?=
 =?us-ascii?Q?lU1GQboPLRb76umYYzOFEedowc+9mdGolgGdQnqa/TRBdI5h5L/zNwMsQ3aJ?=
 =?us-ascii?Q?BDrvKjZPCTjsabu2Wa7R4lDMeKvDSYgzpWTY2abru87dHYmwZ+lYtGU/O16Z?=
 =?us-ascii?Q?lcBFfAekC6u6ulMIi1baT8Y5Tn22qxT8rkmNxGYVOiRofQ9nQ1S2sS0dYxrP?=
 =?us-ascii?Q?Cc/U7/PL4VFBOTBMr3aLxLjRJyWicFhfp2sWcuHKEkD9StM8OoBKlZ7R0+1k?=
 =?us-ascii?Q?POkR3VpXSSjlOzuIHLMWNFIKKZNm3xT6D9On9BwczpGE1Gsigl9yNn9V7seA?=
 =?us-ascii?Q?Q6c89egvPXYyG0L+8aUKsVnrE0ISbVZFWbB3eAuqVJ+KREmf6CdzRrnJuw9K?=
 =?us-ascii?Q?PaKpecS5jAeqv/T/diKKQ9vhEAMaOcRK7eLyyJ4h4YT9JlmUJXKCNf4ld7Zk?=
 =?us-ascii?Q?My2RhcjZ/bRaWdcsYLgDfZBiz0wg3RzT8ZxzG9er+bnjphoMGXotOhFhFLcv?=
 =?us-ascii?Q?MNXczUEFlfbSfODWxvSwwqkvFli7j08t1nBJmEtiWX6ur+rM3qkrAmomrs+x?=
 =?us-ascii?Q?8vrkMVO1tn5wQODONw3xlekdUNmUPrxij2IPh1VN6tiwa7fNqrNTlWpotl1J?=
 =?us-ascii?Q?L2LzVixM0d9XMKgiBcwtey4CgwaInS48DCdS0ak89dcOsJkOgvL5H9bhEC5b?=
 =?us-ascii?Q?SUYWxtojn6FzW5cuFdhHvHZhuoKddNRNves/2JGSC1ByzEd0GkFG+qtCG2Er?=
 =?us-ascii?Q?ChsG+LoS90H/gEEYdyxEAiI4CnlRjXm2v7qUVqzTgpESyl7ElZDnr0eZos/w?=
 =?us-ascii?Q?ofygdPOxU9pwjHgpsoqLGeeR5DzDuAMIL00JU5ICiTTpM0TB7kE5o3W8d6H9?=
 =?us-ascii?Q?ffE5Br5X/GsJNRdWQKcsHU9+9+yWv+ZsBrfMTy0NeCrs6EuIL+yyu2kHqlDB?=
 =?us-ascii?Q?92d7AZEUgmbV4cRmU4AdfGrsVW8YSyuCkXdyKLR3fweaK4VWWQca3MqWpiBu?=
 =?us-ascii?Q?NK0HLLuNVRnG0QVwSLM5nEuSDa7aw+HWD6kilGfvAYSwBMG3Jw8AkZybFkDY?=
 =?us-ascii?Q?MuxM3EWvmZbNF+nCttOdBxzjH6rJZuqPr8QaJ3tApR0eCev6WoRqP2jxtZZt?=
 =?us-ascii?Q?n4bbuWEfkmby8wWAekpwf0r4AawEDPiHnntZSHCDR28kpqRVyv2Sra65i/0D?=
 =?us-ascii?Q?QLSuumEF6X8zBUSvyWC5MQ1iLbKpjXt3xNKGNbdEYFenXTJH7c9vJ5ZeymDe?=
 =?us-ascii?Q?0KFF+C1YhI2O31l3qQn6B/GUENXO13cG1DaxxMNHMEOeJOYcD4xVZQm4e3YK?=
 =?us-ascii?Q?cr06jIeQdASeqIYy/HR3+SIn6Vz05qHtKRqTbZCm57bvNp87kEy/fKTFanR/?=
 =?us-ascii?Q?e9/dGvww+HugpTiethQxDFDDuzCK6g2I7xbWVhWBbALr0JUu1TV/oN6jriT+?=
 =?us-ascii?Q?7Ov2W8ABWCteznTyxqP1fCpCBROKC8d+r0o7PSb09CCMYxYSVX7ryVhzxtxK?=
 =?us-ascii?Q?/1WyL29l3YFZdNQQTtDWxbZlebInov7DRp/NscBZj6loBARA7cMuq2OdYkfQ?=
 =?us-ascii?Q?9WRZF49lpf1OVpeET10Ck2955CWClLI2+RsUysh8XRQ6gxN+J/pMMhyfw1sa?=
 =?us-ascii?Q?gpot2ZbT0LbY9559V/7kcooTUVx1nomeTyWRGIWd8C+1abxvPmne?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69149620-8bb1-4ed8-40f0-08deb6eb2b16
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:43:49.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpS4f5cs99wNmHHuqu4NZ/RwHQiEthMR3TOEn7v9xbVqIcYNmpM04N8nL8/f0TMJke3xO8w9HeXowcl9zBO1XPEYHzoOQc3V1cXKxLIUct6PrNhEb7UWaxJQj62yFn7x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1302

From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

The upcoming StarFive DWC I2C driver is based on the DesignWare I2C
core but requires its own probe and configuration routines due to
register layout differences.

Export several key functions (i2c_dw_probe_master, i2c_dw_init,
i2c_dw_xfer_init, i2c_dw_read_clear_intrbits, etc.) and mark them as
__weak. This allows the DWC driver to reuse the common infrastructure
while overriding the implementations where needed, promoting code
sharing without sacrificing flexibility for the DWC variant.

Additionally, extend the register map configuration and introduce the
MODEL_STARFIVE flag to accommodate the DWC IP's different register
space.

Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
---
 drivers/i2c/busses/i2c-designware-common.c  | 57 ++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h    | 25 +++++++++
 drivers/i2c/busses/i2c-designware-master.c  | 14 +++--
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 +++
 drivers/i2c/busses/i2c-designware-slave.c   |  4 +-
 5 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..cfeec5d338bb 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -167,6 +167,11 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
 		map_cfg.max_register = AMD_UCSI_INTR_REG;
 
+#if IS_ENABLED(CONFIG_I2C_DWC_CORE)
+	if ((dev->flags & MODEL_MASK) == MODEL_STARFIVE)
+		map_cfg.max_register = DWC_IC_SMBUS_INTR_CLR;
+#endif
+
 	if (reg == swab32(DW_IC_COMP_TYPE_VALUE)) {
 		map_cfg.reg_read = dw_reg_read_swab;
 		map_cfg.reg_write = dw_reg_write_swab;
@@ -411,7 +416,7 @@ static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
  *
  * The controller must be disabled before this function is called.
  */
-void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode)
+__weak void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode)
 {
 	if (mode == DW_IC_SLAVE && !dev->slave)
 		mode = DW_IC_MASTER;
@@ -430,7 +435,7 @@ void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode)
  *
  * Return: 0 on success, or negative errno otherwise.
  */
-int i2c_dw_init(struct dw_i2c_dev *dev)
+__weak int i2c_dw_init(struct dw_i2c_dev *dev)
 {
 	int ret;
 
@@ -806,10 +811,25 @@ static int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
+#if IS_ENABLED(CONFIG_I2C_DWC_CORE)
+	u32 tx_fifo_cfg = 8, rx_fifo_cfg = 8;
+
+#ifdef CONFIG_OF
+	ret = of_property_read_u32(dev->dev->of_node, "dwc-i2c-tx-fifo-depth", &tx_fifo_cfg);
+	if (!ret && (tx_fifo_cfg < 2 || tx_fifo_cfg > 256))
+		tx_fifo_cfg = 8;
+
+	ret = of_property_read_u32(dev->dev->of_node, "dwc-i2c-rx-fifo-depth", &rx_fifo_cfg);
+	if (!ret && (rx_fifo_cfg < 2 || rx_fifo_cfg > 256))
+		rx_fifo_cfg = 8;
+#endif
+	param = rx_fifo_cfg << 8 | tx_fifo_cfg << 16;
+#else
 	ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &param);
 	i2c_dw_release_lock(dev);
 	if (ret)
 		return ret;
+#endif
 
 	tx_fifo_depth = FIELD_GET(DW_IC_FIFO_TX_FIELD, param) + 1;
 	rx_fifo_depth = FIELD_GET(DW_IC_FIFO_RX_FIELD, param) + 1;
@@ -835,7 +855,9 @@ u32 i2c_dw_func(struct i2c_adapter *adap)
 
 void i2c_dw_disable(struct dw_i2c_dev *dev)
 {
+#if !IS_ENABLED(CONFIG_I2C_DWC_CORE)
 	unsigned int dummy;
+#endif
 	int ret;
 
 	ret = i2c_dw_acquire_lock(dev);
@@ -847,7 +869,12 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
 
 	/* Disable all interrupts */
 	__i2c_dw_write_intr_mask(dev, 0);
+
+#if IS_ENABLED(CONFIG_I2C_DWC_CORE)
+	regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_CLR_INTR);
+#else
 	regmap_read(dev->map, DW_IC_CLR_INTR, &dummy);
+#endif
 
 	i2c_dw_release_lock(dev);
 }
@@ -896,6 +923,12 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
+#if IS_ENABLED(CONFIG_I2C_DWC_CORE)
+	if (dev->mode == DW_IC_SLAVE)
+		i2c_dw_probe_slave(dev);
+	else
+		i2c_dw_probe_master(dev);
+#else
 	ret = i2c_dw_probe_master(dev);
 	if (ret)
 		return ret;
@@ -906,10 +939,16 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 
 	if (!adap->name[0])
 		strscpy(adap->name, "Synopsys DesignWare I2C adapter");
+#endif
 
 	adap->retries = 3;
 	adap->algo = &i2c_dw_algo;
+#if IS_ENABLED(CONFIG_I2C_DWC_SLAVE)
+	if (dev->mode == DW_IC_SLAVE)
+		adap->algo = &i2c_dw_slave_algo;
+#else
 	adap->quirks = &i2c_dw_quirks;
+#endif
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
 
@@ -938,16 +977,18 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (!dev->emptyfifo_hold_master)
 		irq_flags |= IRQF_NO_THREAD;
 
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		return ret;
+	if (!IS_ENABLED(CONFIG_I2C_DWC_CORE) || dev->mode == DW_IC_MASTER) {
+		ret = i2c_dw_acquire_lock(dev);
+		if (ret)
+			return ret;
 
-	__i2c_dw_write_intr_mask(dev, 0);
-	i2c_dw_release_lock(dev);
+		__i2c_dw_write_intr_mask(dev, 0);
+		i2c_dw_release_lock(dev);
+	}
 
 	if (!(dev->flags & ACCESS_POLLING)) {
 		ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
-				       irq_flags, dev_name(dev->dev), dev);
+				irq_flags, dev_name(dev->dev), dev);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9d8d104cc391..263bff23dd3b 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -321,6 +321,11 @@ struct dw_i2c_dev {
 	u32			bus_capacitance_pF;
 	bool			clk_freq_optimized;
 	bool			emptyfifo_hold_master;
+#if IS_ENABLED(CONFIG_I2C_DWC_CORE)
+	u16			scl_hcnt;
+	u16			scl_lcnt;
+	struct i2c_adapter	*ms_adapter; /* Bind another I2C master controller */
+#endif
 };
 
 #define ACCESS_INTR_MASK			BIT(0)
@@ -328,6 +333,7 @@ struct dw_i2c_dev {
 #define ARBITRATION_SEMAPHORE			BIT(2)
 #define ACCESS_POLLING				BIT(3)
 
+#define MODEL_STARFIVE				BIT(9)
 #define MODEL_AMD_NAVI_GPU			BIT(10)
 #define MODEL_WANGXUN_SP			BIT(11)
 #define MODEL_MASK				GENMASK(11, 8)
@@ -359,8 +365,16 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev);
 u32 i2c_dw_func(struct i2c_adapter *adap);
 irqreturn_t i2c_dw_isr_master(struct dw_i2c_dev *dev);
 
+void i2c_dw_xfer_init(struct dw_i2c_dev *dev);
+int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev);
+u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev);
+u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev);
+
 extern const struct dev_pm_ops i2c_dw_dev_pm_ops;
 
+#if IS_ENABLED(CONFIG_I2C_DWC_CORE)
+#include "i2c-dwc-core.h"
+#else
 static inline void __i2c_dw_enable(struct dw_i2c_dev *dev)
 {
 	dev->status |= STATUS_ACTIVE;
@@ -372,6 +386,7 @@ static inline void __i2c_dw_disable_nowait(struct dw_i2c_dev *dev)
 	regmap_write(dev->map, DW_IC_ENABLE, 0);
 	dev->status &= ~STATUS_ACTIVE;
 }
+#endif
 
 static inline void __i2c_dw_write_intr_mask(struct dw_i2c_dev *dev,
 					    unsigned int intr_mask)
@@ -409,11 +424,21 @@ static inline void i2c_dw_configure_slave(struct dw_i2c_dev *dev) { }
 static inline irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev) { return IRQ_NONE; }
 #endif
 
+#if IS_ENABLED(CONFIG_I2C_DWC_CORE)
+static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
+{
+	if (device_is_compatible(dev->dev, "starfive,jhb100-dwc-i2c-slave"))
+		i2c_dw_configure_slave(dev);
+	else
+		i2c_dw_configure_master(dev);
+}
+#else
 static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
 {
 	i2c_dw_configure_slave(dev);
 	i2c_dw_configure_master(dev);
 }
+#endif
 
 int i2c_dw_probe(struct dw_i2c_dev *dev);
 int i2c_dw_init(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index de929b91d5ea..ef15f590ac5c 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -185,7 +185,7 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	return 0;
 }
 
-static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
+__weak void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 ic_con = 0, ic_tar = 0;
@@ -397,8 +397,12 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			 * IC_RESTART_EN are set, we must manually
 			 * set restart bit between messages.
 			 */
+#if IS_ENABLED(CONFIG_I2C_DWC_CORE)
+			if (dev->msg_write_idx > 0)
+#else
 			if ((dev->master_cfg & DW_IC_CON_RESTART_EN) &&
 					(dev->msg_write_idx > 0))
+#endif
 				need_restart = true;
 		}
 
@@ -570,7 +574,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 	}
 }
 
-static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
+__weak u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
 	unsigned int stat, dummy;
 
@@ -921,7 +925,7 @@ int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	return i2c_dw_xfer_common(dev, msgs, num);
 }
 
-void i2c_dw_configure_master(struct dw_i2c_dev *dev)
+__weak void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 {
 	struct i2c_timings *t = &dev->timings;
 
@@ -967,7 +971,7 @@ static void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
 	i2c_dw_init(dev);
 }
 
-static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
+int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 {
 	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
 	struct i2c_adapter *adap = &dev->adapter;
@@ -1006,7 +1010,7 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	return 0;
 }
 
-int i2c_dw_probe_master(struct dw_i2c_dev *dev)
+__weak int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 {
 	unsigned int ic_con;
 	int ret;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 426ffec06e22..a637c5ab0ea4 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -151,6 +151,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (device_property_present(device, "wx,i2c-snps-model"))
 		flags = MODEL_WANGXUN_SP | ACCESS_POLLING;
 
+	if (device_is_compatible(device, "starfive,jhb100-dwc-i2c-master") ||
+	    device_is_compatible(device, "starfive,jhb100-dwc-i2c-slave"))
+		flags |= MODEL_STARFIVE;
+
 	dev->dev = device;
 	dev->irq = irq;
 	dev->flags = flags;
@@ -255,6 +259,8 @@ static const struct of_device_id dw_i2c_of_match[] = {
 	{ .compatible = "mobileye,eyeq6lplus-i2c" },
 	{ .compatible = "mscc,ocelot-i2c" },
 	{ .compatible = "snps,designware-i2c" },
+	{ .compatible = "starfive,jhb100-dwc-i2c-master" },
+	{ .compatible = "starfive,jhb100-dwc-i2c-slave" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index ad0d5fbfa6d5..7b03dc88286a 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -61,7 +61,7 @@ int i2c_dw_unreg_slave(struct i2c_client *slave)
 	return 0;
 }
 
-static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
+__weak u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 {
 	unsigned int stat, dummy;
 
@@ -176,7 +176,7 @@ irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev)
 	return IRQ_HANDLED;
 }
 
-void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
+__weak void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 {
 	if (dev->flags & ACCESS_POLLING)
 		return;
-- 
2.43.0

