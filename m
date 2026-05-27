Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC25391E7F;
	Wed, 27 May 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873868; cv=fail; b=QSlsym5+Cqsrbrh6CBuv49XvHLEOGTKN2ktymzOZ6+Bm4mZgWpo1CbVx0dNUkcgoBJ9oheus8/gLaqiZ8QbCQa2ihvBqu8e6RKfh4tIn1hUZ30uQRE9n4ZNvYZ+3a7nZ3VFajPh6+w/wzLj6ZdesbZGSLs3hSU+M10YOAJEocHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873868; c=relaxed/simple;
	bh=lf2/8C+dRM8QAiPKfGuh8ep5AUYteUz0ju53SdlHZiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TYo80LLLKEQo+O1t4NASEvHtg8k0r0/oeTJSvFgWB6c8e8e7oJ3rLNQsBGg4BE7IAoaUcfNrOYawvgu3xYtqs05RgHbK9BGsnKtSUyoU1ry1RZMsvsuQsR1RFeo2jcFRWxaHiLVha/nj6mJoVbjcS0UBObCVzWaSQYMhnWRUp+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAioFP0QQLVAtuQdsgl82dlYGn0jZZn0nwV8lshYtSnVr2VuHHbp3D+2z+qeUSjCREDU+Q5ccHEBkVGQi+NB8qqtUIK9kgp9XkNgH3dnIBuzDZYb+JHOIVygQ/3p261o1eZg5Qckl/42xzUSVe6Eak9Yyyyv0s6Nmf/M+6IJ7c9DlHds4bojFK5WXYiovG9qH42pi57Hv3igzTCBObjGPeUG8HF6ObCtLSoSbJ60Ls431LVElhqav5kqBePR+X6aVkGBcIh1jaq+t1+pRUgvDL2CDmDzt1/9b4WCzvAYWr/D8xIvrEfV9FvqfZTntcGFQU5hRj5T0yVZ6VE0dkTezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9EefLSlYbJJhWOh6JWSB3Yqd8HYyXnD23ar4amjzWo=;
 b=cgXi2eTP8WUrJCqOJHImZZKDbUPB9iduu+N6bFkkbHPu+9s6yGzF5XFmpxaxTS/fdkS07EJzy2kHRKXZo0Zb42MHKWT5yQjb1mdpO6EFzAxhtvZroN8DgY1IHdmBW+T91VlJFNy2soGaB/z5frUZ7RTmrncyvGfoV6lA2kP7XhflILyb/T+4bO6A6rjGOMey7/sWfDdSCa82la/b6aVAMG80SkeFNGh/qQNc+0vOO+7BbhFelp69wa9BvwzVpVkhiVE0qfFujn8P7esEQCJBiJsVLqPRSvpymJijbZWEpDKYrS7CdVdXDDcJG7Mzg3jAIqM5fjDyWDdeaDqw+uAjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1301.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 08:50:48 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:50:48 +0000
From: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Subject: [PATCH v2 2/3] i2c: designware: Export symbols and add __weak for Starfive I2C driver
Date: Wed, 27 May 2026 16:50:38 +0800
Message-Id: <20260527085039.44435-3-lianfeng.ouyang@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1301:EE_
X-MS-Office365-Filtering-Correlation-Id: b40edd8e-cdf1-4e51-7bf3-08debbcd0c55
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UZkZ5c7c7sr+zz8/dMkTAWSd0Kc8kuCYe4NJNHo4Lhp83GWMAACYv4olqX0VNoqb31HGAgzK6+ywXNnmHQ82nHWNVkxAp3clvXaKja1xi5XV0G0UAo/z3uyfrtU79RxiwDhAIkuIBO85s2PCpCDO9uT6bXqx7/gvEleb2X8o8qX5uid3f6+uRLr7MMokh4jMsdh+Q12UVFqv5/q7mbW1AHHwWm0RBNFW8PynDbsanqCpjZPlUumAJFZe+gIObH5flb9GlpyvaZ8bJd66C5NOxq2hrikskcO8RxmFsnGIllqZRQfBPfQKyejnpcGkDEIPZ3h5M0WgmRjAuFiSS7GvfSfvZhIBPXxeF6ml2VZ7u/vX6zbHGoBbBiS+iGMIo6ahsIeag8Ia2C6UvfPdbXIQ0/KxqsIRa3GUZYps58jaBNLHYq5SVZX7VZ2v8t3gk6eLR5lRE6DaMQHrkDvdxNySWp2X2Fa55fy+pLRbb40LOfpal4cpw35Bhyr9A2TGInrt3FLmrIIjNtqEefT0Wfrq3rGQxin807OKB5DLNN/+iaZoM46IpHAoIdATdxsv9WbP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nMYXMERqrIA40Oex0IHyLZsbreQohFVrvYND6XOL+xMfWb4yzmCwGwL4qonc?=
 =?us-ascii?Q?99LgJ1isRzGjPTU7bvoqxsAcaBNJ2k6FlQhfBSGnMHYguObyfJ2ocbK9aZEg?=
 =?us-ascii?Q?fXXMCAq0c5wQ/58cqbYeltntMBxVAfeB6AkMyUJPQ7xSacc3CeeCH1hHmPVB?=
 =?us-ascii?Q?bGr0pT8qdNVeg+luPnZfW7DBYDBq2f2e++uJvVOx/Mj0XJ+hrUuTnuKQR0Dv?=
 =?us-ascii?Q?fvzbtZqy9sWzTcqSWB3oYhrrHMYjcL4SLPSfczM5Z637q/7rK9Ks/LEPCxi3?=
 =?us-ascii?Q?tAxsXGIEZhqaSr1YklvqOqh3wd7NnOsMkync/toc/idwjoGGp3N0ztAq0qBa?=
 =?us-ascii?Q?cxACfWgo+nLHAZBAM4t01vesrZg0vdFBp9sC/hsXL5dYtnxFtRuos0CQGUZw?=
 =?us-ascii?Q?R9myCY8LVUUu+wcgYyZwZimP4lcc3ro+ALW5b2K4vJwY5X3mFSsO/Ad5PrXf?=
 =?us-ascii?Q?gtE9WPcRbURYyVKzUvQ5cabO4/BFPsr/JdzJe9dZ4CyjtIksVLL+K1ao2m/0?=
 =?us-ascii?Q?t+vQZMn7LDosCXzFk8bgNbk3OSfh5rBe/FaYAJLWUNB6W4ntMXvn00iqi+dm?=
 =?us-ascii?Q?M97dd318a8x1QZ9vhwnrI7aa54IMTU4E82QE4u2FOzTVSgtHGBvok4K82az1?=
 =?us-ascii?Q?i8lSRfFadfzmovGuol7m+w1mPk5ZHVKkreWP+rWfWvkO8pUO4kTpe2L82LGM?=
 =?us-ascii?Q?lEpAWyAvpUDiLIn3pvitc0nuvlxLSgChuYS5gC7Oi0LIzv1s8K0ZgkFMACQl?=
 =?us-ascii?Q?/887taH+T3XNXHdxY9aMuXk7345ewU1V6BQ5NSAaze10K4y2973el6GiHj97?=
 =?us-ascii?Q?9wDh2v6iZipnZ91eetUPXsFvuM9TLBd6LOZs1enxrmQozTByHGAmqftAKdAF?=
 =?us-ascii?Q?56Yk5vfaJz8KyfXwC1BUX512PZumeQA/+NRDNWyDuNOsCpTF+649AJyANKzF?=
 =?us-ascii?Q?1n0VcXTXwjTZazmfcnRFjUBi0E75wpCQ1S9YDFu/ziNH9CthE+wtSVtEn7Je?=
 =?us-ascii?Q?XTJpFt7C+HhpeqV4C+dddeoTHXZ+5nDBrjQmm7vh/avxUxaUV+XFLWm37TH2?=
 =?us-ascii?Q?3NtHPdYYWu+bLOynee9PbTG+IxZekARm157G1FIRmK0kHPRv68VLFpa2LWam?=
 =?us-ascii?Q?sh4Pw4E+/qBHTIhsxZayiTZp7aAmixpGU5MgKeqxzZUh6MNsSWsF0qzKBngg?=
 =?us-ascii?Q?uKVlmkKVda+MdcOws4fLXvHOO2Qj504FOkLy5PDMASHw45LDAKwp7FrOA8fO?=
 =?us-ascii?Q?PxkWuGWxLParvBWmrBD7f16e+YpN/avYAKQFNTq+HhW3IIsJ5IJAuLgWiqwS?=
 =?us-ascii?Q?Hv4hgjYmE/jBfOqFCOcEJkEIE0qfmypOr8yaBP8sCzbgNCG1i1/m3twPvIw8?=
 =?us-ascii?Q?+AgMWylnb7cXq69xr5+8hV3639k9Vzl10cwOQTqJS6ANceY29Rd4dySO0Rkj?=
 =?us-ascii?Q?2FAtKRb/tHpShpephdlZI+Mzaic7MaNCi7aU8TCB8Dt479ArSZY36PfPxZIb?=
 =?us-ascii?Q?6CO1rpNwq6kfLdb9wJBhNLprV5neSe5Rop5oXIVzzCaVdra4bKpR3c/xFaO1?=
 =?us-ascii?Q?rRMRGP0rWEE8/y4ry/HUUZDQQbXYLlETC76SzCW2HdI2s7pouzjQnIo/hRFd?=
 =?us-ascii?Q?gPb63IA4fknoGaa4oBYJx1BTWRYl7tiunYNQYEtxfvqzC2TUnGqWHqbY6IJ9?=
 =?us-ascii?Q?UhvHDcG/TyCCl6Yf/9wuwItPUXZGy/DOK8tHKSXDGkAJZjMKXU8P7rr39xg0?=
 =?us-ascii?Q?vZYwJV1AO0/d/1otWJ0lOOf9M5DE/24lBnpiiDZfTso77yMhXKJx?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40edd8e-cdf1-4e51-7bf3-08debbcd0c55
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:50:48.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4qm0eUGFXbLD+KXG+CWngGcvlcApVsempMiMxbS+zN/K/85RGaZVyLRD2TLDlWYGl+jTupuxaUvPDCKsQxSwEOTkIb85Uhi56ZDLlkBJ63MF/JuSOJLxsrjsXEEZ1mz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1301

From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

Export several key functions (i2c_dw_probe_master, i2c_dw_init,
i2c_dw_xfer_init, i2c_dw_read_clear_intrbits, etc.) and mark them as
__weak. This allows the i2c starfive driver to reuse the common
infrastructure while overriding the implementations where needed.

Additionally, extend the register map configuration and introduce the
MODEL_STARFIVE flag to accommodate the starfive i2c  IP's different
register space.

Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
---
 drivers/i2c/busses/i2c-designware-common.c  | 72 ++++++++++++++++-----
 drivers/i2c/busses/i2c-designware-core.h    | 20 ++++++
 drivers/i2c/busses/i2c-designware-master.c  |  4 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 ++
 drivers/i2c/busses/i2c-designware-slave.c   |  2 +-
 5 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..034f6a446ab6 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -70,6 +70,7 @@ static const char *const abort_sources[] = {
 		"incorrect slave-transmitter mode configuration",
 };
 
+#if !IS_ENABLED(CONFIG_I2C_STARFIVE)
 static int dw_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
@@ -87,6 +88,7 @@ static int dw_reg_write(void *context, unsigned int reg, unsigned int val)
 
 	return 0;
 }
+#endif
 
 static int dw_reg_read_swab(void *context, unsigned int reg, unsigned int *val)
 {
@@ -143,9 +145,15 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 		.val_bits = 32,
 		.reg_stride = 4,
 		.disable_locking = true,
+#if IS_ENABLED(CONFIG_I2C_STARFIVE)
+		.reg_read = sf_reg_read,
+		.reg_write = sf_reg_write,
+		.max_register = SF_IC_SMBUS_INTR_CLR,
+#else
 		.reg_read = dw_reg_read,
 		.reg_write = dw_reg_write,
 		.max_register = DW_IC_COMP_TYPE,
+#endif
 	};
 	u32 reg;
 	int ret;
@@ -162,6 +170,10 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 		return ret;
 
 	reg = readl(dev->base + DW_IC_COMP_TYPE);
+
+	if ((dev->flags & MODEL_MASK) == MODEL_STARFIVE)
+		reg = readl(dev->base + (SF_IC_COMP_TYPE & (~SF_REG_FLAG)));
+
 	i2c_dw_release_lock(dev);
 
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
@@ -359,7 +371,7 @@ static inline u32 i2c_dw_acpi_round_bus_speed(struct device *device) { return 0;
 
 #endif	/* CONFIG_ACPI */
 
-static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
+__weak void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 {
 	switch (mode) {
 	case DW_IC_MASTER:
@@ -382,7 +394,7 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 	}
 }
 
-static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
+__weak void i2c_dw_write_timings(struct dw_i2c_dev *dev)
 {
 	/* Write standard speed timing parameters */
 	regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
@@ -411,7 +423,7 @@ static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
  *
  * The controller must be disabled before this function is called.
  */
-void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode)
+__weak void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode)
 {
 	if (mode == DW_IC_SLAVE && !dev->slave)
 		mode = DW_IC_MASTER;
@@ -806,10 +818,25 @@ static int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
+#if IS_ENABLED(CONFIG_I2C_STARFIVE)
+	u32 tx_fifo_cfg = 8, rx_fifo_cfg = 8;
+
+#ifdef CONFIG_OF
+	ret = of_property_read_u32(dev->dev->of_node, "starfive,i2c-tx-fifo-depth", &tx_fifo_cfg);
+	if (!ret && (tx_fifo_cfg < 2 || tx_fifo_cfg > 256))
+		tx_fifo_cfg = 8;
+
+	ret = of_property_read_u32(dev->dev->of_node, "starfive,i2c-rx-fifo-depth", &rx_fifo_cfg);
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
@@ -896,20 +923,29 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = i2c_dw_probe_master(dev);
-	if (ret)
-		return ret;
+	if (dev->mode == DW_IC_SLAVE) {
+		ret = i2c_sf_probe_slave(dev);
+	} else {
+		ret = i2c_dw_probe_master(dev);
+		if (ret)
+			return ret;
 
-	ret = i2c_dw_init(dev);
-	if (ret)
-		return ret;
+		ret = i2c_dw_init(dev);
+		if (ret)
+			return ret;
 
-	if (!adap->name[0])
-		strscpy(adap->name, "Synopsys DesignWare I2C adapter");
+		if (!adap->name[0])
+			strscpy(adap->name, "Synopsys DesignWare I2C adapter");
+	}
 
 	adap->retries = 3;
 	adap->algo = &i2c_dw_algo;
+#if IS_ENABLED(CONFIG_I2C_STARFIVE_SLAVE)
+	if (dev->mode == DW_IC_SLAVE)
+		adap->algo = &i2c_dw_slave_algo;
+#else
 	adap->quirks = &i2c_dw_quirks;
+#endif
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
 
@@ -938,16 +974,18 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (!dev->emptyfifo_hold_master)
 		irq_flags |= IRQF_NO_THREAD;
 
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		return ret;
+	if (!IS_ENABLED(CONFIG_I2C_STARFIVE) || dev->mode == DW_IC_MASTER) {
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
index 9d8d104cc391..87223f7e28aa 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -321,6 +321,11 @@ struct dw_i2c_dev {
 	u32			bus_capacitance_pF;
 	bool			clk_freq_optimized;
 	bool			emptyfifo_hold_master;
+#if IS_ENABLED(CONFIG_I2C_STARFIVE)
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
@@ -359,8 +365,14 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev);
 u32 i2c_dw_func(struct i2c_adapter *adap);
 irqreturn_t i2c_dw_isr_master(struct dw_i2c_dev *dev);
 
+u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev);
+u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev);
+
 extern const struct dev_pm_ops i2c_dw_dev_pm_ops;
 
+#if IS_ENABLED(CONFIG_I2C_STARFIVE)
+#include "i2c-starfive-core.h"
+#else
 static inline void __i2c_dw_enable(struct dw_i2c_dev *dev)
 {
 	dev->status |= STATUS_ACTIVE;
@@ -372,6 +384,7 @@ static inline void __i2c_dw_disable_nowait(struct dw_i2c_dev *dev)
 	regmap_write(dev->map, DW_IC_ENABLE, 0);
 	dev->status &= ~STATUS_ACTIVE;
 }
+#endif
 
 static inline void __i2c_dw_write_intr_mask(struct dw_i2c_dev *dev,
 					    unsigned int intr_mask)
@@ -411,8 +424,15 @@ static inline irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev) { return IRQ_
 
 static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
 {
+#if IS_ENABLED(CONFIG_I2C_STARFIVE)
+	if (device_is_compatible(dev->dev, "starfive,jhb100-i2c-slave"))
+		i2c_sf_configure_slave(dev);
+	else
+		i2c_sf_configure_master(dev);
+#else
 	i2c_dw_configure_slave(dev);
 	i2c_dw_configure_master(dev);
+#endif
 }
 
 int i2c_dw_probe(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index de929b91d5ea..f27c0fc761da 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -31,7 +31,7 @@
 #define AMD_TIMEOUT_MAX_US	250
 #define AMD_MASTERCFG_MASK	GENMASK(15, 0)
 
-static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
+__weak int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 {
 	unsigned int comp_param1;
 	u32 sda_falling_time, scl_falling_time;
@@ -570,7 +570,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 	}
 }
 
-static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
+__weak u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
 	unsigned int stat, dummy;
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 426ffec06e22..8c0f5c39e4ff 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -151,6 +151,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (device_property_present(device, "wx,i2c-snps-model"))
 		flags = MODEL_WANGXUN_SP | ACCESS_POLLING;
 
+	if (device_is_compatible(device, "starfive,jhb100-i2c-master") ||
+	    device_is_compatible(device, "starfive,jhb100-i2c-slave"))
+		flags |= MODEL_STARFIVE;
+
 	dev->dev = device;
 	dev->irq = irq;
 	dev->flags = flags;
@@ -255,6 +259,8 @@ static const struct of_device_id dw_i2c_of_match[] = {
 	{ .compatible = "mobileye,eyeq6lplus-i2c" },
 	{ .compatible = "mscc,ocelot-i2c" },
 	{ .compatible = "snps,designware-i2c" },
+	{ .compatible = "starfive,jhb100-i2c-master" },
+	{ .compatible = "starfive,jhb100-i2c-slave" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index ad0d5fbfa6d5..1b94e4fbaad1 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -61,7 +61,7 @@ int i2c_dw_unreg_slave(struct i2c_client *slave)
 	return 0;
 }
 
-static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
+__weak u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 {
 	unsigned int stat, dummy;
 
-- 
2.43.0

