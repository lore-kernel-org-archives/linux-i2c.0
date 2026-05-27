Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738C376BE0;
	Wed, 27 May 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872773; cv=fail; b=rZQHkqcfvOZ0LgbiODxJr53wpwplqyQaIdDXc3/HHu3pzHfBQAguziqOaGMd8QClJ6xhbcDR7BdDVvvLDXoutA+EJlqlVTkuqWD7NmZV7yHcKqixyoh08ZTsl1pASZ0FalUDT8yenZRrEro4Y2Y6zwpl9drXteapImF4voKSSoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872773; c=relaxed/simple;
	bh=vvJW6BBmiKWAl24S2E1VzBJzL3NwtvmDkNAgw27DdzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=so/PBQ5q+s6o5ah3oMm4m1mBz97Dka7zTM45zgo6/ArH2aPIcxu1fHK11cDbLris3leHSTHO9FWWDPwcUYgtOVrZ521f2UPseHtx/RNc1JWZfuL2+sb8/IDpCyCaiV8WJ+y6SE73UPYZRZbmpTTj/wxHqqU+RFsekUmXlKkELsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMmZVXfXW8y3dw0ghr5j3a3vwwmE6wqS6suG/KD1JnBue/aRL3GaS1qV/+pAEkCvh5gC/Opb6A/T6MGZngojoHnzYuU+Is6fVcFCXB5bxPu3wm4679gG+o/pO8BRJ+XD3pNvtvrNR4FRaBTGeP9GUmRgaWpg9RSdkOsotk8StSAYFipW1mjoq9O+AhLcWaeOZv3TlKZ1ASd/yxBGc8+1BZpT0W4OC0KS/qpMyaJdmcnP+Ua/PylLR1Mv8V+nAES76L2JoKQzShr1XAbpWf8U6xnjkZAZGfEf9Q7VbEZQLXDsRoUhzfdRvQVvyjwwKDVE5YMeQHqE4dWe/hC13oWerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYVqDjhuqhgkyfVz+7bevV6sp32RoO2cjavLNLTT+EM=;
 b=Hst9205EA3KqbanBb+oON3445uJJedic1Sfw/R5g16222HcA9dXIWCi/Go4SEZJQf88Y5CSMFFIvtZBqMVIcL4guuxd62rSBsq8vyYLgnAIosdRgc9V+91HJZHGVr8Ojv/fVu+/EZOdTyFv2y+lFc2/s9q33e3tLJr5eU9aaGRNvYGjoq0zn8VC9SwFqI+mTqyoubh4JVmaK+4ZLIIrpLDBBrnahMbjxrTwojfywAyIsxj5g3Zs01dyCVcu3W9uXQPOw0JeG0we+AFKId2tUA0hKD+8sBmk0H0KleEf/8YPIt+4P07nlUIvh/P87c7iqFUX8fcrH5fsWqhTGeVzOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1301.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 08:50:49 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:50:49 +0000
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
Subject: [PATCH v2 3/3] i2c: starfive: Add StarFive JHB100 I2C master/slave support
Date: Wed, 27 May 2026 16:50:39 +0800
Message-Id: <20260527085039.44435-4-lianfeng.ouyang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13d5c255-e309-45cb-4f69-08debbcd0cdd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R73CJt0R04Hh+ndEpelFsPEWuF1jvK6ObbCAIj9/ZTImovuCGMZsH37u4XoU8oWTYM/r92yN0B5SHGr3cKflcN82vIOo88Lr+Ybk2YNFeqNHH+SViUTaNRTIgJeynUO3TjieT1kXxO/ol6iL3Ob5Pca54k6ylZ/ArABwzLZGUcgaR1QmX0CXd5U9GlRcYrWyACyeyJBO4nld7n4C7Vqm78guk59FZu0Zwdna7HwlCy20V4kICleYIFm+moVWxg1JNyMxxSmR1W8jw83lutOdEPB1HGStJevLMGljQvuU8hdQ3fPSdF7KPCONCHmDkk9gQ2LevKfe9FGJhcNcP29AbFclfUGtekk/KGED7FFvkUBvd/iOB9eTdNWebFD1SLWNg8G30X7eJrAgu+otdB1/EqVcArk2zOxYFazsMLxasHA4iMiTXDiP+h47HpZGDQWpssaYAB2ogTdLGWh6H8qXKsQ+7fuPmzuBrHNH0Kngxscm3nHSC5vViawxwOwPaZTSAcsW3kyuXfhbQnNKcBZ/Lx6esIT8Bd8PSEHp+2dIQDwuBsw2sKVFqJFc+qKaZHUI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5KNHE1+htqKzNs4kSkenFbO7FedMlJz5nr50o+sbCGxctmKIIBaSmXu2y9k/?=
 =?us-ascii?Q?qpRhld620eyabXCDhDgSvnHnDplK+44PLzfjlCFOiq3/82+qpK7fZpTfb0or?=
 =?us-ascii?Q?Lw2AEZX0QS1WvHt8ko4L21tOZ+tfM0fbO3hSOh27LhfSeik2IeLCuuvM4wYo?=
 =?us-ascii?Q?Sormjr5Un3iZzHt4nYTst459g15WGgy1FMM9+iiqKhhSckYsv8BbiSsL0s3i?=
 =?us-ascii?Q?XN8ZpaFm/dBnHLfrACbxX5fwh9DKk+VmlfFCZ9l5G5+Vj17Ieo6SfnY4yRFN?=
 =?us-ascii?Q?ZfjKVYi1H+06EpNSHP6iSp8S2oXBzUtfEYhKpxskMZhgVqpt66t3+SyTHCkz?=
 =?us-ascii?Q?vUVtca5isyVk62LJX8mCuC22k2KjJdeEecbZbej9x4gW/KD4JVKxoVnKyTX0?=
 =?us-ascii?Q?sQTtjoIZBQzlM4gUuPgpW/T/cHvN8zOpNoGd2huqcJZ3JlSrgoGypfLdfV0Q?=
 =?us-ascii?Q?sZQ9WWrK3vAZZXXrt/TfXju4dGO94sjZKZynkYead3Ji4a9hEV8GDujmYzIs?=
 =?us-ascii?Q?4Xpf4Kb2Ksbtm4dinNRD6/NrFvOM3/iE7DrcC4FGsBIY06I/S0ythi8fCVpT?=
 =?us-ascii?Q?NBUHB+kowJSxjrai+eFeNL+D7YUjh+P5kaSR6WccYNpFvqXTql+RsnwA1dyn?=
 =?us-ascii?Q?nbpvWvFxqsaPGoQdNi5VUnp5FDZN0QzpBR7xRtUkZBUsv18dF3s111G7EL+c?=
 =?us-ascii?Q?GcB5WICtXJDEiTDRm2wvsvPz9gwdI++hRabpFqYOB43gKz4tSRdLiNmrwaAU?=
 =?us-ascii?Q?L5MXOqLTW1c+rUpajE5P1FXdfwuRkE/tBag/1GR5FRJUUH63I26VAyvsQpQx?=
 =?us-ascii?Q?N7pp4afehLzxbtJqYYtos1Iuc/bi556uLRBLbb0HrXUAQ3Dqy7xOpYukr6cS?=
 =?us-ascii?Q?ib5VFB4KOTnO4E/e1jo6fKxOQe6cdGfjeHH1ESkOHrj9Ke39DTtX/jd3oY3E?=
 =?us-ascii?Q?/d9w7Ecx8Pp4BCA3Yk4W3lNXIEHgs65w7H3pZUV7YXUfeSLO/22JBTb1cfh5?=
 =?us-ascii?Q?Qg7t6ivPUA10eNtjMOC6OVLFZo82kCjd7HfsB3ymd0WgTCZSBa+RIZfVp6CE?=
 =?us-ascii?Q?ODJ2UYpGhzCdDyKIjv0aSH5hLP28PRjP4kVuPXXTqJsWGgFs4jOrFgW66leR?=
 =?us-ascii?Q?ejHNE7qlRWg7FHKzFsf6ax2XWYrr18eYLnWy096UJwh8XKaTChaP89KN/BLC?=
 =?us-ascii?Q?rK9EhQbxtvklhKUr0PUkomQGDYiHuuiVxfT6eq+jFyzUB3exNJo9iUBat9lg?=
 =?us-ascii?Q?JlWwxMX335cmgxLoSO5L4GGyYOd+p6NSvgo5mY4aFSPjCfwOnLJk2I3OZClw?=
 =?us-ascii?Q?VkkAXfXw/38i0yGBikBPWUKlR4ciYoygTJCd6siluTnrj2yqgibcf0oo/pE9?=
 =?us-ascii?Q?cYUd/15S83BBQ832CsQgn82CEh8/aECIW5PpcXKUyF0UXd0995rBv1TCCGVq?=
 =?us-ascii?Q?6NP7m7/pttcJIR9nP75aZsNLUpfwh1KVbjIIVkjhBNel/yy73bra+dza+qgg?=
 =?us-ascii?Q?WoFYk2/cT1RSkELxs2j03xRgSpZ9q4JjLPJ0kPQsRd8XUabLre30QXV2jiUL?=
 =?us-ascii?Q?sML6P84zHvGAf76vkD8h5VVU9qD68kMvukQOh1FI/LC9MA5c8R4ZCsrTOi8C?=
 =?us-ascii?Q?FO2RuCb/hj5E1yQKt5w5QGCnaqZZVRbTlCDEfLQzSlIrWtgzs+AyiHKGCbSw?=
 =?us-ascii?Q?zrXDKFC23zWp0iFaBYrIlnwh0RM5t8xUWlrQeRV+8npb0mcfRcDr3uIkDJyK?=
 =?us-ascii?Q?1F3GjuVtxjzpWzK+u6KPXbzJZ1++p+q4X1q4m5Z/wqLfkcR52N0V?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d5c255-e309-45cb-4f69-08debbcd0cdd
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:50:49.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUawpys5FDjpQHdRJJaRcTEbrVEl6snX36egC3e8bc278VvtbNMSJM60fwZqQrKjuSlP+YKozcV/ojyIVWi/MB6PJ/JioRZTNb0ebsOt124YN1EgbVrAHQj4dorA+/EO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1301

From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

Add support for the Starfive I2C controller found on the StarFive JHB100
platform. The controller supports both master and slave modes and uses
a different register layout compared to the standard DesignWare I2C IP.

Currently, due to the following differences, i2c designware cannot be
fully reused
1.  For high and low level counting settings at different rates, i2c
    starfive can use IC_SCL-H/LCNT to set SS, FM, FM+, UFM
2.  Interrupt clearing is achieved by writing 1 to the corresponding
    bit of INTR_CLR, while designware reads different clearing registers
3.  Master and slave require separate probe callbacks and cannot rely
    solely on the runtime mode switching provided by i2c_dw_set_mode().
4.  The value of FIFO depth is not obtained through registers, but
written through DTS

The driver leverages the common i2c-designware-core infrastructure
exported by the previous patch, while implementing its own timing
calculation, FIFO configuration, and interrupt handling to accommodate
the register offsets and bit definitions.

Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
---
 MAINTAINERS                              |   7 +
 drivers/i2c/busses/Kconfig               |  24 ++
 drivers/i2c/busses/Makefile              |   3 +
 drivers/i2c/busses/i2c-starfive-core.h   | 164 ++++++++
 drivers/i2c/busses/i2c-starfive-master.c | 470 +++++++++++++++++++++++
 drivers/i2c/busses/i2c-starfive-slave.c  | 180 +++++++++
 6 files changed, 848 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-starfive-core.h
 create mode 100644 drivers/i2c/busses/i2c-starfive-master.c
 create mode 100644 drivers/i2c/busses/i2c-starfive-slave.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d3a6b3f6b6a0..7a6bc33b1118 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25319,6 +25319,13 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/starfive/jhb100*
 
+Starfive JHB100 I2C DRIVER
+M:	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
+L:	linux-i2c@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml
+F:	drivers/i2c/busses/i2c-starfive-*
+
 STARFIVE JHB100 PINCTRL DRIVERS
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 M:	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 7cb6b9b864a7..7630b19e706c 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -640,6 +640,30 @@ config I2C_DESIGNWARE_PCI
 
 endif
 
+config I2C_STARFIVE
+	tristate "Starfive i2c adapter"
+	select REGMAP
+	help
+	  This is a driver for the Starfive I2C controller,
+	  a variant of the DesignWare I2C IP with a different register layout.
+	  It shares common infrastructure with the standard DesignWare I2C
+	  driver (I2C_DESIGNWARE_CORE)
+
+if I2C_STARFIVE
+
+config I2C_STARFIVE_SLAVE
+	bool "Starfive i2c slave"
+	default I2C_STARFIVE
+	select I2C_SLAVE
+	help
+	  If you say yes to this option, support will be included for the
+	  Starfive i2c slave adapter.
+
+	  This is not a standalone module, this module compiles together with
+	  i2c-starfive-core.
+
+endif
+
 config I2C_DIGICOLOR
 	tristate "Conexant Digicolor I2C driver"
 	depends on ARCH_DIGICOLOR || COMPILE_TEST
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 547123ab351f..1f6f56394bc9 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -61,6 +61,9 @@ i2c-designware-platform-$(CONFIG_I2C_DESIGNWARE_BAYTRAIL) += i2c-designware-bayt
 obj-$(CONFIG_I2C_DESIGNWARE_AMDISP) += i2c-designware-amdisp.o
 obj-$(CONFIG_I2C_DESIGNWARE_PCI)			+= i2c-designware-pci.o
 i2c-designware-pci-y					:= i2c-designware-pcidrv.o
+obj-$(CONFIG_I2C_STARFIVE) 				+= i2c-starfive.o
+i2c-starfive-y						+= i2c-starfive-master.o
+i2c-starfive-$(CONFIG_I2C_STARFIVE_SLAVE) 		+= i2c-starfive-slave.o
 obj-$(CONFIG_I2C_DIGICOLOR)	+= i2c-digicolor.o
 obj-$(CONFIG_I2C_EG20T)		+= i2c-eg20t.o
 obj-$(CONFIG_I2C_EMEV2)		+= i2c-emev2.o
diff --git a/drivers/i2c/busses/i2c-starfive-core.h b/drivers/i2c/busses/i2c-starfive-core.h
new file mode 100644
index 000000000000..eb38d7215208
--- /dev/null
+++ b/drivers/i2c/busses/i2c-starfive-core.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Starfive JHB100 I2C adapter driver.
+ *
+ * Based on the Starfive JHB100 I2C adapter driver.
+ *
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (C) 2007 MontaVista Software Inc.
+ * Copyright (C) 2009 Provigent Ltd.
+ */
+
+#include <linux/bits.h>
+#include <linux/compiler_types.h>
+#include <linux/completion.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define SF_REG_FLAG				BIT(31)
+
+#define IC_DFLT_OPERATION_REG_OFFSET		(SF_REG_FLAG | 0x00)
+#define IC_DFLT_I2C_REG_OFFSET			(SF_REG_FLAG | 0x20)
+#define IC_DFLT_SMBUS_REG_OFFSET		(SF_REG_FLAG | 0xFC)
+
+#define DW_IC_DEFAULT_FUNCTIONALITY		(I2C_FUNC_I2C | \
+						 I2C_FUNC_SMBUS_BYTE | \
+						 I2C_FUNC_SMBUS_BYTE_DATA | \
+						 I2C_FUNC_SMBUS_WORD_DATA | \
+						 I2C_FUNC_SMBUS_BLOCK_DATA | \
+						 I2C_FUNC_SMBUS_I2C_BLOCK)
+
+/*
+ * Registers offset
+ */
+#define SF_IC_ENABLE				(IC_DFLT_OPERATION_REG_OFFSET + 0x04)
+#define DW_IC_ENABLE_TX_CMD_BLOCK		BIT(2)
+#define SF_IC_ENABLE_DAR_EN			BIT(16)
+#define SF_IC_ENABLE_DAR2_EN			BIT(17)
+#define SF_IC_ENABLE_DAR3_EN			BIT(18)
+#define SF_IC_ENABLE_DAR4_EN			BIT(19)
+#define SF_IC_CAPABILITIES			(IC_DFLT_OPERATION_REG_OFFSET + 0x0c)
+#define SF_IC_CAPABILITIES_IC_SMBUS		BIT(10)
+#define SF_IC_SMBUS_CAPABILITIES		(IC_DFLT_OPERATION_REG_OFFSET + 0x18)
+#define SF_IC_SMBUS_CAPABILITIES_SMBUS_ARP	BIT(2)
+
+#define SF_IC_CTRL				(IC_DFLT_I2C_REG_OFFSET + 0x04)
+#define SF_IC_CTRL_OP_MODE			BIT(0)
+#define SF_IC_CTRL_SPEED_STD			BIT(4)
+#define SF_IC_CTRL_SPEED_FAST			(2 << 4)
+#define SF_IC_CTRL_SPEED_HIGH			(3 << 4)
+#define SF_IC_CTRL_SPEED_MASK			GENMASK(5, 4)
+#define SF_IC_CTRL_10BITADDR_TGT		BIT(8)
+#define SF_IC_CTRL_10BITADDR_CTRLR		BIT(9)
+#undef DW_IC_CON_10BITADDR_MASTER
+#define DW_IC_CON_10BITADDR_MASTER		BIT(9)
+#define SF_IC_CTRL_STOP_DET_IFADDRESSED		BIT(10)
+#define SF_IC_CTRL_TX_EMPTY_CTRL		BIT(11)
+#define SF_IC_CTRL_RX_FIFO_FULL_HLD_CTRL	BIT(12)
+#define SF_IC_CTRL_BUS_CLEAR_CTRL		BIT(14)
+#undef DW_IC_CON_BUS_CLEAR_CTRL
+#define DW_IC_CON_BUS_CLEAR_CTRL		BIT(14)
+#define SF_IC_TAR				(IC_DFLT_I2C_REG_OFFSET + 0x08)
+#define SF_IC_TAR_SPECIAL			BIT(11)
+#define SF_IC_TAR_SMBUS_QUICK_CMD		BIT(16)
+#define SF_IC_DAR				(IC_DFLT_I2C_REG_OFFSET + 0x0C)
+#define SF_IC_SCL_HCNT				(IC_DFLT_I2C_REG_OFFSET + 0x24)
+#define SF_IC_SCL_LCNT				(IC_DFLT_I2C_REG_OFFSET + 0x28)
+#define SF_IC_HS_SCL_HCNT			(IC_DFLT_I2C_REG_OFFSET + 0x2c)
+#define SF_IC_HS_SCL_LCNT			(IC_DFLT_I2C_REG_OFFSET + 0x30)
+#define SF_IC_SDA_HOLD				(IC_DFLT_I2C_REG_OFFSET + 0x34)
+#define DW_IC_SDA_HOLD_TX_SHIFT			0
+#define DW_IC_SDA_HOLD_TX_MASK			GENMASK(15, 0)
+#define SF_IC_SPKLEN				(IC_DFLT_I2C_REG_OFFSET + 0x3c)
+#define SF_IC_HS_SPKLEN				(IC_DFLT_I2C_REG_OFFSET + 0x40)
+#define SF_IC_SCL_STUCK_AT_LOW_TIMEOUT		(IC_DFLT_I2C_REG_OFFSET + 0x44)
+#define SF_IC_SCL_STUCK_AT_LOW_TIMEOUT_MAX	(IC_DFLT_I2C_REG_OFFSET + 0x48)
+#define SF_IC_SDA_STUCK_AT_LOW_TIMEOUT		(IC_DFLT_I2C_REG_OFFSET + 0x4c)
+#define SF_IC_DATA_CMD				(IC_DFLT_I2C_REG_OFFSET + 0x58)
+#define SF_IC_DATA_CMD_DAT			GENMASK(7, 0)
+#define SF_IC_DATA_CMD_CMD			BIT(8)
+#define SF_IC_DATA_CMD_STOP			BIT(9)
+#define SF_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
+#define SF_IC_RX_TL				(IC_DFLT_I2C_REG_OFFSET + 0x5c)
+#define SF_IC_TX_TL				(IC_DFLT_I2C_REG_OFFSET + 0x60)
+#define SF_IC_INTR_STAT				(IC_DFLT_I2C_REG_OFFSET + 0x74)
+#define SF_IC_INTR_SCL_STUCK_AT_LOW		BIT(14)
+#define SF_IC_INTR_MASK				(IC_DFLT_I2C_REG_OFFSET + 0x78)
+#define SF_IC_RAW_INTR_STAT			(IC_DFLT_I2C_REG_OFFSET + 0x7c)
+#define SF_IC_INTR_CLR				(IC_DFLT_I2C_REG_OFFSET + 0x80)
+#define SF_IC_CLR_INTR				BIT(0)
+#define SF_IC_CLR_RX_UNDER			BIT(1)
+#define SF_IC_CLR_RX_OVER			BIT(2)
+#define SF_IC_CLR_TX_OVER			BIT(3)
+#define SF_IC_CLR_RD_REQ			BIT(4)
+#define SF_IC_CLR_TX_ABRT			BIT(5)
+#define SF_IC_CLR_RX_DONE			BIT(6)
+#define SF_IC_CLR_ACTIVITY			BIT(7)
+#define SF_IC_CLR_STOP_DET			BIT(8)
+#define SF_IC_CLR_START_DET			BIT(9)
+#define SF_IC_CLR_GEN_CALL			BIT(10)
+#define SF_IC_CLR_RESTART_DET			BIT(11)
+#define SF_IC_CLR_SCL_STUCK_DET			BIT(12)
+#define SF_IC_ENABLE_STATUS			(IC_DFLT_I2C_REG_OFFSET + 0x84)
+#define SF_IC_TX_TRMNT_SOURCE			(IC_DFLT_I2C_REG_OFFSET + 0x88)
+#define SF_IC_STATUS				(IC_DFLT_I2C_REG_OFFSET + 0x8c)
+#define SF_IC_STATUS_ACTIVITY			BIT(0)
+#define SF_IC_STATUS_TFE			BIT(2)
+#define SF_IC_STATUS_RFNE			BIT(3)
+#define SF_IC_STATUS_CTRLR_ACTIVITY		BIT(5)
+#define SF_IC_STATUS_TGT_ACTIVITY		BIT(6)
+#define SF_IC_TXFLR				(IC_DFLT_I2C_REG_OFFSET + 0x90)
+#define SF_IC_RXFLR				(IC_DFLT_I2C_REG_OFFSET + 0x94)
+#define SF_IC_COMP_VERSION			(IC_DFLT_I2C_REG_OFFSET + 0xa4)
+#define SF_IC_COMP_TYPE				(IC_DFLT_I2C_REG_OFFSET + 0xa8)
+
+#define SF_IC_SMBUS_ARP_CTRL			(IC_DFLT_SMBUS_REG_OFFSET + 0x8)
+#define SF_IC_SMBUS_ARP_CTRL_NARP_DEVICE_TYPE	0
+#define SF_IC_SMBUS_INTR_STAT			(IC_DFLT_SMBUS_REG_OFFSET + 0x28)
+#define SF_IC_R_SMBUS_ALERT_DET			BIT(10)
+#define SF_IC_SMBUS_INTR_MASK			(IC_DFLT_SMBUS_REG_OFFSET + 0x2c)
+#define SF_IC_SMBUS_INTR_CLR			(IC_DFLT_SMBUS_REG_OFFSET + 0x34)
+#define SF_IC_CLR_SMBUS_ALERT_DET		BIT(10)
+
+/* error code */
+#define DW_IC_ERR_TX_ABRT			0x1
+
+#undef TXGBE_RX_FIFO_DEPTH
+#define TXGBE_RX_FIFO_DEPTH			0
+
+/* make (dev->master_cfg & DW_IC_CON_RESTART_EN) always true*/
+#undef DW_IC_CON_RESTART_EN
+#define DW_IC_CON_RESTART_EN			0xffffffff
+
+extern const struct i2c_algorithm i2c_dw_slave_algo;
+int sf_reg_read(void *context, unsigned int reg, unsigned int *val);
+int sf_reg_write(void *context, unsigned int reg, unsigned int val);
+int i2c_sf_probe_slave(struct dw_i2c_dev *dev);
+void i2c_dw_read_clear_intrbits_common(struct dw_i2c_dev *dev);
+void i2c_dw_write_timings(struct dw_i2c_dev *dev);
+void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode);
+int i2c_dw_set_timings_master(struct dw_i2c_dev *dev);
+void i2c_sf_configure_master(struct dw_i2c_dev *dev);
+void i2c_sf_configure_slave(struct dw_i2c_dev *dev);
+
+static inline void __i2c_dw_enable(struct dw_i2c_dev *dev)
+{
+	int val;
+
+	dev->status |= STATUS_ACTIVE;
+	regmap_read(dev->map, DW_IC_ENABLE, &val);
+	regmap_write(dev->map, DW_IC_ENABLE,
+		     ((val & ~DW_IC_ENABLE_TX_CMD_BLOCK) | DW_IC_ENABLE_ENABLE));
+}
+
+static inline void __i2c_dw_disable_nowait(struct dw_i2c_dev *dev)
+{
+	int val;
+
+	regmap_read(dev->map, DW_IC_ENABLE, &val);
+	regmap_write(dev->map, DW_IC_ENABLE, val & ~DW_IC_ENABLE_ENABLE);
+	dev->status &= ~STATUS_ACTIVE;
+}
diff --git a/drivers/i2c/busses/i2c-starfive-master.c b/drivers/i2c/busses/i2c-starfive-master.c
new file mode 100644
index 000000000000..94fe041cf46d
--- /dev/null
+++ b/drivers/i2c/busses/i2c-starfive-master.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Starfive JHB100 I2C adapter driver (master only).
+ * *
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (C) 2007 MontaVista Software Inc.
+ * Copyright (C) 2009 Provigent Ltd.
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/units.h>
+
+#include "i2c-designware-core.h"
+
+#define AMD_TIMEOUT_MIN_US	25
+#define AMD_TIMEOUT_MAX_US	250
+#define AMD_MASTERCFG_MASK	GENMASK(15, 0)
+
+#define REG_MAP_NONE		0xffff
+
+struct starfive_reg_desc {
+	u32 sf_addr;
+	u32 dw_addr;
+};
+
+static const struct starfive_reg_desc sf_dw_reg_map[] = {
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_CTRL},		/* 0x0 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_TAR},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_CAPABILITIES,	.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_DATA_CMD},	/* 0x10 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_SMBUS_CAPABILITIES,	.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0x20 */
+	{ .sf_addr = SF_IC_CTRL,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_DAR,			.dw_addr = SF_IC_INTR_STAT},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_INTR_MASK},	/* 0x30 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_RAW_INTR_STAT},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_INTR_CLR},	/* 0x40 */
+	{ .sf_addr = SF_IC_SCL_HCNT,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_SCL_LCNT,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_HS_SCL_HCNT,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_HS_SCL_LCNT,		.dw_addr = REG_MAP_NONE},	/* 0x50 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_SPKLEN,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_HS_SPKLEN,		.dw_addr = REG_MAP_NONE},	/* 0x60 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_ENABLE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_STATUS},	/* 0x70 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_TXFLR},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_RXFLR},
+	{ .sf_addr = SF_IC_RX_TL,		.dw_addr = SF_IC_SDA_HOLD},
+	{ .sf_addr = SF_IC_TX_TL,		.dw_addr = SF_IC_TX_TRMNT_SOURCE},	/* 0x80 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0x90 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_ENABLE_STATUS},
+	{ .sf_addr = SF_IC_INTR_CLR,		.dw_addr = REG_MAP_NONE},	/* 0xA0 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0xB0 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0xC0 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_SMBUS_INTR_MASK},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0xD0 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0xE0 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0xF0 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = SF_IC_COMP_VERSION},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0x100 */
+	{ .sf_addr = SF_IC_SMBUS_ARP_CTRL,	.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0x110 */
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},	/* 0x120 */
+	{ .sf_addr = SF_IC_SMBUS_INTR_STAT,	.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = REG_MAP_NONE,		.dw_addr = REG_MAP_NONE},
+	{ .sf_addr = SF_IC_SMBUS_INTR_CLR,	.dw_addr = REG_MAP_NONE},	/* 0x130 */
+};
+
+int sf_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct dw_i2c_dev *dev = context;
+	unsigned int reg_v, reg_nof, idx;
+
+	reg_nof = reg & ~SF_REG_FLAG;
+	idx = reg_nof >> 2;
+
+	if (idx >= ARRAY_SIZE(sf_dw_reg_map))
+		return -EINVAL;
+
+	const struct starfive_reg_desc *desc = &sf_dw_reg_map[idx];
+
+	if (reg & SF_REG_FLAG)
+		reg_v = desc->sf_addr;
+	else
+		reg_v = desc->dw_addr;
+
+	if (reg_v == 0xff) {
+		dev_err(dev->dev, "sf reg read 0x%x error!\n", reg_nof);
+		return -EINVAL;
+	}
+
+	if (reg_v == SF_IC_INTR_CLR)
+		writel(SF_IC_CLR_INTR, dev->base + (reg_v & ~SF_REG_FLAG));
+	else
+		*val = readl(dev->base + (reg_v & ~SF_REG_FLAG));
+
+	return 0;
+}
+
+int sf_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct dw_i2c_dev *dev = context;
+	unsigned int reg_v, reg_nof, idx;
+
+	reg_nof = reg & ~SF_REG_FLAG;
+	idx = reg_nof >> 2;
+
+	if (idx >= ARRAY_SIZE(sf_dw_reg_map))
+		return -EINVAL;
+
+	const struct starfive_reg_desc *desc = &sf_dw_reg_map[idx];
+
+	if (reg & SF_REG_FLAG)
+		reg_v = desc->sf_addr;
+	else
+		reg_v = desc->dw_addr;
+
+	if (reg_v == 0xff) {
+		dev_err(dev->dev, "sf reg read 0x%x error!\n", reg_nof);
+		return -EINVAL;
+	}
+
+	writel(val, dev->base + (reg_v & ~SF_REG_FLAG));
+
+	return 0;
+}
+
+/**
+ * i2c_sf_scl_hcnt() -  Calculate SCL HCNT
+ * @ic_clk: Input clock in kHz
+ * @thigh: Duration in ns of logic 1 to generate
+ * @tr: SCL rise time in ns
+ * @spk_cnt: Spike count
+ */
+static u32 i2c_sf_scl_hcnt(u32 ic_clk, u32 thigh, u32 tr, u32 spk_cnt)
+{
+	u64 min_thigh_cnt, rise_cnt;
+
+	/* Formula: cnt = f_kHz * t_ns * 10^(-6) */
+	min_thigh_cnt = DIV_ROUND_CLOSEST_ULL((u64)ic_clk * thigh, MICRO);
+	rise_cnt = DIV_ROUND_CLOSEST_ULL((u64)ic_clk * tr, MICRO);
+
+	return max(5, min_thigh_cnt + rise_cnt - spk_cnt - 3);
+}
+
+/**
+ * i2c_sf_scl_lcnt() -  Calculate SCL LCNT
+ * @ic_clk: Input clock in kHz
+ * @tlow: Duration in ns of logic 0 to generate
+ * @tf: SCL fall time in ns
+ */
+static u32 i2c_sf_scl_lcnt(u32 ic_clk, u32 tlow, u32 tf)
+{
+	u64 min_tlow_cnt, fall_cnt;
+
+	/* Formula: cnt = f_kHz * t_ns * 10^(-6) */
+	min_tlow_cnt = DIV_ROUND_CLOSEST_ULL((u64)ic_clk * tlow, MICRO);
+	fall_cnt = DIV_ROUND_CLOSEST_ULL((u64)ic_clk * tf, MICRO);
+
+	return max(6, min_tlow_cnt + fall_cnt);
+}
+
+int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
+{
+	u32 scl_falling_time = 0, scl_rising_time = 0;
+	u32 scl_high_time = 0, scl_low_time = 0;
+	struct i2c_timings *t = &dev->timings;
+	unsigned int comp_param1;
+	u32 ic_clk, spk_cnt;
+	int ret;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(dev->map, SF_IC_CTRL, &comp_param1);
+	i2c_dw_release_lock(dev);
+	if (ret)
+		return ret;
+
+	ic_clk = i2c_dw_clk_rate(dev);
+
+	/* 50ns maximum spike */
+	spk_cnt = DIV_ROUND_CLOSEST_ULL((u64)ic_clk * 50, MICRO);
+
+	regmap_write(dev->map, SF_IC_HS_SPKLEN, spk_cnt);
+	regmap_write(dev->map, SF_IC_SPKLEN, spk_cnt);
+
+	/* Parse user defined rise time and fall time*/
+	if (t->scl_rise_ns)
+		scl_rising_time = t->scl_rise_ns;
+
+	if (t->scl_fall_ns)
+		scl_falling_time = t->scl_fall_ns;
+
+	/* Ensure the rise time and fall time should not lower than t_rise_max
+	 * and t_fall_max specification, else it would run faster than expected
+	 * frequency
+	 */
+	switch (t->bus_freq_hz) {
+	case I2C_MAX_STANDARD_MODE_FREQ:
+		scl_rising_time = max(scl_rising_time, 1000);
+		scl_falling_time = max(scl_falling_time, 300);
+		scl_high_time = 4000;	/* tHIGH_min = 4.0 us */
+		scl_low_time = 4700;	/* tLOW_min = 4.7 us */
+		break;
+	case I2C_MAX_FAST_MODE_FREQ:
+		scl_rising_time = max(scl_rising_time, 300);
+		scl_falling_time = max(scl_falling_time, 300);
+		scl_high_time = 600;	/* tHIGH_min = 600 ns */
+		scl_low_time = 1300;	/* tLOW_min = 1.3 us */
+		break;
+	case I2C_MAX_FAST_MODE_PLUS_FREQ:
+		scl_rising_time = max(scl_rising_time, 120);
+		scl_falling_time = max(scl_falling_time, 120);
+		scl_high_time = 260;	/* tHIGH_min = 260 ns */
+		scl_low_time = 500;	/* tLOW_min = 500 ns */
+		break;
+	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
+		scl_rising_time = max(scl_rising_time, 40);
+		scl_falling_time = max(scl_falling_time, 40);
+		scl_high_time = 60;	/* tHIGH_min = 60 ns */
+		scl_low_time = 160;	/* tLOW_min = 160 ns */
+		break;
+	default:
+		scl_rising_time = max(scl_rising_time, 1000);
+		scl_falling_time = max(scl_falling_time, 300);
+		scl_high_time = 4000;	/* tHIGH_min = 4.0 us */
+		scl_low_time = 4700;	/* tLOW_min = 4.7 us */
+		break;
+	}
+
+	ic_clk = i2c_dw_clk_rate(dev);
+
+	if (!dev->scl_hcnt || !dev->scl_lcnt) {
+		dev->scl_hcnt = i2c_sf_scl_hcnt(ic_clk, scl_high_time, scl_rising_time, spk_cnt);
+		dev->scl_lcnt = i2c_sf_scl_lcnt(ic_clk, scl_low_time, scl_falling_time);
+	}
+
+	dev_dbg(dev->dev, "Bus speed: %s\n", i2c_freq_mode_string(t->bus_freq_hz));
+
+	/* Check is high speed possible and fall back to fast mode if not */
+	if ((dev->master_cfg & SF_IC_CTRL_SPEED_MASK) == SF_IC_CTRL_SPEED_HIGH) {
+		if ((comp_param1 & SF_IC_CTRL_SPEED_MASK) != SF_IC_CTRL_SPEED_HIGH) {
+			dev_err(dev->dev, "High Speed not supported!\n");
+			t->bus_freq_hz = I2C_MAX_FAST_MODE_FREQ;
+			dev->master_cfg &= ~SF_IC_CTRL_SPEED_MASK;
+			dev->master_cfg |= SF_IC_CTRL_SPEED_FAST;
+			dev->hs_hcnt = 0;
+			dev->hs_lcnt = 0;
+
+			/* Replace with I2C_MAX_FAST_MODE_PLUS_FREQ */
+			scl_rising_time = max(scl_rising_time, 120);
+			scl_falling_time = max(scl_falling_time, 120);
+			scl_high_time = 260;	/* tHIGH_min = 260 ns */
+			scl_low_time = 500;	/* tLOW_min = 500 ns */
+
+			dev->scl_hcnt = i2c_sf_scl_hcnt(ic_clk, scl_high_time,
+							scl_rising_time, spk_cnt);
+			dev->scl_lcnt = i2c_sf_scl_lcnt(ic_clk, scl_low_time,
+							scl_falling_time);
+		} else if (!dev->hs_hcnt || !dev->hs_lcnt) {
+			dev->hs_hcnt = dev->scl_hcnt;
+			dev->hs_lcnt = dev->scl_lcnt;
+		}
+		dev_dbg(dev->dev, "High Speed Mode HCNT:LCNT = %d:%d\n",
+			dev->hs_hcnt, dev->hs_lcnt);
+	} else {
+		dev_dbg(dev->dev, "HCNT:LCNT: %d:%d\n", dev->scl_hcnt, dev->scl_lcnt);
+	}
+
+	return 0;
+}
+
+void i2c_dw_write_timings(struct dw_i2c_dev *dev)
+{
+	/* Write standard speed timing parameters */
+	regmap_write(dev->map, SF_IC_SCL_HCNT, dev->scl_hcnt);
+	regmap_write(dev->map, SF_IC_SCL_LCNT, dev->scl_lcnt);
+
+	/* Write high speed timing parameters if supported */
+	if (dev->hs_hcnt && dev->hs_lcnt) {
+		regmap_write(dev->map, SF_IC_HS_SCL_HCNT, dev->hs_hcnt);
+		regmap_write(dev->map, SF_IC_HS_SCL_LCNT, dev->hs_lcnt);
+	}
+}
+
+void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
+{
+	/* Configure Tx/Rx FIFO threshold levels */
+	regmap_write(dev->map, SF_IC_TX_TL, dev->tx_fifo_depth / 2);
+	regmap_write(dev->map, SF_IC_RX_TL, 0);
+
+	/* Configure the I2C master */
+	regmap_write(dev->map, SF_IC_CTRL, dev->master_cfg);
+}
+
+static int i2c_sf_set_sda_hold_time(struct dw_i2c_dev *dev)
+{
+	int ret = regmap_write_bits(dev->map,
+			DW_IC_SDA_HOLD,
+			DW_IC_SDA_HOLD_TX_MASK,
+			dev->sda_hold_time);
+	return ret;
+}
+
+void i2c_dw_read_clear_intrbits_common(struct dw_i2c_dev *dev)
+{
+	unsigned int stat;
+
+	/*
+	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
+	 * The unmasked raw version of interrupt status bits is available
+	 * in the IC_RAW_INTR_STAT register.
+	 *
+	 * That is,
+	 *   stat = readl(IC_INTR_STAT);
+	 * equals to,
+	 *   stat = readl(IC_RAW_INTR_STAT) & readl(IC_INTR_MASK);
+	 *
+	 * The raw version might be useful for debugging purposes.
+	 */
+	regmap_read(dev->map, DW_IC_INTR_STAT, &stat);
+	/*
+	 * Do not use the IC_CLR_INTR register to clear interrupts, or
+	 * you'll miss some interrupts, triggered during the period from
+	 * readl(IC_INTR_STAT) to readl(IC_CLR_INTR).
+	 *
+	 * Instead, use the separately-prepared IC_CLR_* registers.
+	 */
+	if (stat & DW_IC_INTR_RX_UNDER)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_RX_UNDER);
+	if (stat & DW_IC_INTR_RX_OVER)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_RX_OVER);
+	if (stat & DW_IC_INTR_TX_OVER)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_TX_OVER);
+	if (stat & DW_IC_INTR_RD_REQ)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_RD_REQ);
+	if (stat & DW_IC_INTR_RX_DONE)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_RX_DONE);
+	if (stat & DW_IC_INTR_ACTIVITY)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_ACTIVITY);
+	if (stat & DW_IC_INTR_START_DET)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_START_DET);
+	if (stat & DW_IC_INTR_GEN_CALL)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_GEN_CALL);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_read_clear_intrbits_common);
+
+u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
+{
+	unsigned int stat;
+
+	/*
+	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
+	 * The unmasked raw version of interrupt status bits is available
+	 * in the IC_RAW_INTR_STAT register.
+	 *
+	 * That is,
+	 *   stat = readl(IC_INTR_STAT);
+	 * equals to,
+	 *   stat = readl(IC_RAW_INTR_STAT) & readl(IC_INTR_MASK);
+	 *
+	 * The raw version might be useful for debugging purposes.
+	 */
+	regmap_read(dev->map, DW_IC_INTR_STAT, &stat);
+
+	if (stat & DW_IC_INTR_TX_ABRT) {
+		/*
+		 * The IC_TX_ABRT_SOURCE register is cleared whenever
+		 * the IC_CLR_TX_ABRT is read.  Preserve it beforehand.
+		 */
+		regmap_read(dev->map, DW_IC_TX_ABRT_SOURCE, &dev->abort_source);
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_TX_ABRT);
+	}
+	if ((stat & DW_IC_INTR_STOP_DET) &&
+	    (dev->rx_outstanding == 0 || (stat & DW_IC_INTR_RX_FULL)))
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_STOP_DET);
+	if (stat & DW_IC_INTR_RESTART_DET)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_RESTART_DET);
+	if (stat & SF_IC_INTR_SCL_STUCK_AT_LOW)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_SCL_STUCK_DET);
+
+	i2c_dw_read_clear_intrbits_common(dev);
+
+	return stat;
+}
+
+void i2c_sf_configure_master(struct dw_i2c_dev *dev)
+{
+	struct i2c_timings *t = &dev->timings;
+
+	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY |
+		I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_PEC;
+
+	dev->master_cfg = SF_IC_CTRL_OP_MODE;
+
+	dev->mode = DW_IC_MASTER;
+
+	switch (t->bus_freq_hz) {
+	case I2C_MAX_STANDARD_MODE_FREQ:
+		dev->master_cfg |= SF_IC_CTRL_SPEED_STD;
+		break;
+	case I2C_MAX_FAST_MODE_FREQ:
+		dev->master_cfg |= SF_IC_CTRL_SPEED_FAST;
+		break;
+	case I2C_MAX_FAST_MODE_PLUS_FREQ:
+		dev->master_cfg |= SF_IC_CTRL_SPEED_FAST;
+		break;
+	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
+		dev->master_cfg |= SF_IC_CTRL_SPEED_HIGH;
+		break;
+	default:
+		dev->master_cfg |= SF_IC_CTRL_SPEED_FAST;
+	}
+
+	dev->set_sda_hold_time = i2c_sf_set_sda_hold_time;
+}
+
+MODULE_AUTHOR("Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>");
+MODULE_DESCRIPTION("Starfive JHB100 I2C bus master adapter");
+MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-starfive-slave.c b/drivers/i2c/busses/i2c-starfive-slave.c
new file mode 100644
index 000000000000..06c3ead35841
--- /dev/null
+++ b/drivers/i2c/busses/i2c-starfive-slave.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Starfive JHB100 I2C adapter driver (slave only).
+ *
+ * Based on the Starfive JHB100 I2C adapter driver (master).
+ *
+ * Copyright (C) 2016 Synopsys Inc.
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "i2c-designware-core.h"
+
+void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode)
+{
+	if (dev->mode == DW_IC_SLAVE && mode == DW_IC_SLAVE) {
+		regmap_write(dev->map, SF_IC_DAR, dev->slave->addr);
+		__i2c_dw_enable(dev);
+		dev->status = 0;
+	}
+}
+
+static void i2c_sf_configure_fifo_slave(struct dw_i2c_dev *dev)
+{
+	/* Configure the I2C slave. */
+	regmap_write(dev->map, SF_IC_CTRL, 0);
+	regmap_write(dev->map, SF_IC_CTRL, dev->slave_cfg);
+	regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
+}
+
+/**
+ * i2c_sf_init_slave() - Initialize the Starfive i2c slave hardware
+ * @dev: device private data
+ *
+ * This function configures and enables the I2C in slave mode.
+ * This function is called during I2C init function, and in case of timeout at
+ * run time.
+ */
+static int i2c_sf_init_slave(struct dw_i2c_dev *dev)
+{
+	int ret;
+	int r_value;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	/* Disable the adapter. */
+	__i2c_dw_disable(dev);
+
+	/* Write SDA hold time if supported */
+	if (dev->sda_hold_time)
+		regmap_write(dev->map, DW_IC_SDA_HOLD, dev->sda_hold_time);
+
+	regmap_read(dev->map, SF_IC_CAPABILITIES, &r_value);
+	if (r_value & SF_IC_CAPABILITIES_IC_SMBUS) {
+		regmap_read(dev->map, SF_IC_SMBUS_CAPABILITIES, &r_value);
+		if (r_value & SF_IC_SMBUS_CAPABILITIES_SMBUS_ARP) {
+			regmap_write(dev->map, DW_IC_ENABLE, SF_IC_ENABLE_DAR_EN);
+			regmap_write(dev->map, SF_IC_SMBUS_ARP_CTRL,
+				     SF_IC_SMBUS_ARP_CTRL_NARP_DEVICE_TYPE);
+		}
+	}
+
+	i2c_sf_configure_fifo_slave(dev);
+	i2c_dw_release_lock(dev);
+
+	return 0;
+}
+
+u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
+{
+	unsigned int stat;
+	unsigned int smbus_stat;
+
+	/*
+	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
+	 * The unmasked raw version of interrupt status bits is available
+	 * in the IC_RAW_INTR_STAT register.
+	 *
+	 * That is,
+	 *   stat = readl(IC_INTR_STAT);
+	 * equals to,
+	 *   stat = readl(IC_RAW_INTR_STAT) & readl(IC_INTR_MASK);
+	 *
+	 * The raw version might be useful for debugging purposes.
+	 */
+	regmap_read(dev->map, DW_IC_INTR_STAT, &stat);
+	regmap_read(dev->map, SF_IC_SMBUS_INTR_STAT, &smbus_stat);
+
+	/*
+	 * Do not use the IC_CLR_INTR register to clear interrupts, or
+	 * you'll miss some interrupts, triggered during the period from
+	 * readl(IC_INTR_STAT) to readl(IC_CLR_INTR).
+	 *
+	 * Instead, use the separately-prepared IC_CLR_* registers.
+	 */
+
+	if (stat & DW_IC_INTR_TX_ABRT)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_TX_ABRT);
+	if (stat & DW_IC_INTR_STOP_DET)
+		regmap_write(dev->map, SF_IC_INTR_CLR, SF_IC_CLR_STOP_DET);
+	if (smbus_stat & SF_IC_R_SMBUS_ALERT_DET)
+		regmap_write(dev->map, SF_IC_SMBUS_INTR_CLR, SF_IC_CLR_SMBUS_ALERT_DET);
+
+	i2c_dw_read_clear_intrbits_common(dev);
+
+	return stat;
+}
+
+#if IS_ENABLED(CONFIG_I2C_STARFIVE_SLAVE)
+static int i2c_sf_xfer_ms(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	if (!dev->ms_adapter)
+		return -ENXIO;
+
+	return i2c_dw_xfer(dev->ms_adapter, msgs, num);
+}
+#endif
+
+const struct i2c_algorithm i2c_dw_slave_algo = {
+	.master_xfer = i2c_sf_xfer_ms,
+	.functionality = i2c_dw_func,
+	.reg_slave = i2c_dw_reg_slave,
+	.unreg_slave = i2c_dw_unreg_slave,
+};
+
+void i2c_sf_configure_slave(struct dw_i2c_dev *dev)
+{
+	dev->functionality = I2C_FUNC_SLAVE | DW_IC_DEFAULT_FUNCTIONALITY;
+
+	dev->slave_cfg = SF_IC_CTRL_RX_FIFO_FULL_HLD_CTRL |
+			 SF_IC_CTRL_STOP_DET_IFADDRESSED;
+
+	dev->mode = DW_IC_SLAVE;
+}
+
+int i2c_sf_probe_slave(struct dw_i2c_dev *dev)
+{
+	struct i2c_adapter *adap = &dev->adapter;
+	struct device_node *ms_node;
+	int ret;
+
+	ret = i2c_sf_init_slave(dev);
+	if (ret)
+		return ret;
+
+	snprintf(adap->name, sizeof(adap->name), "Starfive JHB100 I2C Slave adapter");
+
+	/* Get the specified I2C master adapter from DTS for MCTP */
+	ms_node = of_parse_phandle(dev->dev->of_node, "starfive,mctp-i2c-ms", 0);
+	if (ms_node) {
+		struct platform_device *ms_pdev = of_find_device_by_node(ms_node);
+
+		if (ms_pdev) {
+			struct dw_i2c_dev *ms_dev = platform_get_drvdata(ms_pdev);
+
+			if (ms_dev)
+				dev->ms_adapter = &ms_dev->adapter;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i2c_sf_probe_slave);
+
+MODULE_AUTHOR("Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>");
+MODULE_DESCRIPTION("Starfive JHB100 I2C bus slave adapter");
+MODULE_LICENSE("GPL");
-- 
2.43.0

