Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2127.outbound.protection.partner.outlook.cn [139.219.146.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D0379C39;
	Thu, 21 May 2026 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336052; cv=fail; b=pZXgRiPsrlWDzBnGnWiiorxStQ58pe9S99bqsRAUv7mfopAeAfnTu80bk0FQFZF6/Z0Z4iwyni/gjPIA3auC5ZjtxHhHgSVsXiS/WXbztMvYPuQtJskfY70VK8ydNKobMS8FMyctDwNaAtIchDWHTxE5o5c7R1Xv9est35gDdU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336052; c=relaxed/simple;
	bh=WaheKzyxMBZbiSxBOvTnMo8vvP4eb+kcXy5U3SRBzDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cw1ubi/Ap2KEDbJbFUW9TL1Q8mSQyFnaydH4ZCe34r5IXOM3WDuU7abAPHDqMtmNC3ATi030fZBK0jY4/yoDnai0gsfjJzdjzi5vFZIQUSpTQdsxJB4PVhKK3Q+pqL6TS/eC/oGkcjkD5nVzCq6f/96TwwpeHmUgTa+gpKvB9no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etQVQuwW/YEHyP6LLfmjG4+s8qKz0C1VW7UHO/MtSBlzlW397ucEYvLtSzM5MEmA8Q9NCTZK1YeOU6zCGA5qlz3Qg92uzOYDVL067z9Fh85vjxddR98DKAn5Qr4Vr0g/RmWiLsrma8arrvJniAPu5MjVCpg6+MQBgGyy5gj/boejL1Tl0flyeyW9lDmCAKOBCziRz7z2Vt8HVLcbv3d0uOihWy1a8edSBPLbb8ZhcS5006IwifGR2xsT5uRULSal3jq0KZEolLG4+T/IGtA3Aw132f27LdFoI6YTsfQ5eu3BOYxSqQWoovAz1ei0ZZEidLjANkoCvPmTCi3noOQSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsGJpLtL4cafCS7zh89iiwUcKzWCmtD1jm0AUi8PhP0=;
 b=n8b1/ZqXZOXtyacM02qoROURKl5CiFhE1GeyNiO6vnE85yHSZly242f3PlXBSoQYO8YcokEDTYgyQFTW7yANx3lfDVNcBgSNvbuexgbkTc0984i5NiBHNjaPDT2h/FJ3SRFeaeaOjgAieXREkWCEqKoEDRg0MXX7lTPpQfyQqw5/lAkbslHbT2Zh74STr0dfHsvAiyNGKmr5Q9KQqQ1vVwZQJzAPjFREEQMuLahdI7ltL15cOgcdFz8wDbcVeIR4JBgKjL4CIW9IaxZ23wdo3m+2+jcpfUmmjfrXYxNKl75O4rdsJx0izw/QICjKcMKHeLtXAix1h+Z5YBwKbcJWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 03:43:50 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 03:43:50 +0000
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
Subject: [PATCH v1 3/3] i2c: dwc: Add StarFive JHB100 I2C master/slave support
Date: Thu, 21 May 2026 11:43:40 +0800
Message-Id: <20260521034340.27837-4-lianfeng.ouyang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3754cc2-70df-4136-8c28-08deb6eb2b99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|3023799007|22082099003|18002099003|56012099003|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	R+vZ9lz2AsT+KlL1vnJBl/+yjd5tm5M2Mg6zUgT3NsldRnKHpDxMwsduDbh8/QYPrtESGZO6U4Ctl+14O5S+aBoY3is5YwUKnI+ELQxnu0b4A2yJn+DCvl7eltLQZoIKfZZ292Fi4POn3rRKdmZ3OMme3uZpb6nik9gj0/sCTql7ILYutrduZMeCB5agWmXCu7nftnS25L22nyLPPIAYAiK+igVIofaoJBrnSI1AYr6330cS9/wgwGgJnyfQgIuAtREQlwrOFoPO+WUgFfPATpfe+NzQhH585zm4lbHa2seB3aHl1yB1apOoWSGXavG72yBOE83IhIPRIawXoelCi+52Cj5R+WXOMZFMgd8yS4JQ51wR1mbmn3kDdmaAtKB3uVuLFKaEYxYtlPkOlbAPVmxzdqHFNAWr2RgV1x+ne4HIl1Lw0NfUy3xPEuyxBVizG0xvdeA67zccRpv+l7k5y5rX8Wq6bEZagydBXd04ORgOZTdzK4khXFov+2wNqhlKGGmj3hM2tDn2SXX+2o6KchlON58ke/zbo+6MEeyNOwCiRVlBaRH+W5QtcRRUZhGQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(3023799007)(22082099003)(18002099003)(56012099003)(38350700014)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6U3MZ1HIO1fkfOcYWJ8IiMcgi4o+Ta3O21HflMB1+aQm/i+S2lGXGm/1Px56?=
 =?us-ascii?Q?jSbaajp/n+t4pc6Rgy6ZIXYrUuB3uJJKtlWNnaDbDMI1lK9o0LVma9Ltb/b/?=
 =?us-ascii?Q?wuKXHViihh/OjOo126/WQngYayoJALwvrg6Hun/gxB748GylRkL5feFhd9my?=
 =?us-ascii?Q?tA4qf3MFTdxkNiVqeOtGp97cgcWGl+aWqOdDCYL/cII9QcTBdobv8pdapl04?=
 =?us-ascii?Q?neSPpc8BMgnVZf8D2ox8bOtjDX9+kc6FY3FECyTXtFy96FCYq/TGK9tBMdnj?=
 =?us-ascii?Q?cGbmhXItH+rbM+CAQspipLjZfQch/SyssqWY8RpBV6AYQB/1xFq0UX/t70Yo?=
 =?us-ascii?Q?rx1TMOrXUXieLh+Fy5EqajTQ4R/UCVqHibDbGYZS3EleO+7qhmN8v0FxWt9g?=
 =?us-ascii?Q?3tflrVm+zbaMrfu5AAhSngBX+dSLWB+7P4CKNcfLJYFBfnafI/CpWJL7pCYH?=
 =?us-ascii?Q?a1WmEAKvfZSyDMIrLWUyROjTQhWU2abKhDz0RlVSOGPu4pdwWquVyMHlRls/?=
 =?us-ascii?Q?1zn6gkhZhKfLOAxJXJqj+CI753ug3QUbE4QIYzedG/ilEFpzLlPGOdWeQKb4?=
 =?us-ascii?Q?VN8MRUgBXBok53+/c9IYNDZsu+MP0oDMLFIXwdHmkYV+qw7mLhQ96c3E0oRc?=
 =?us-ascii?Q?Xui26uatEc4hWAYaDE1rE9P0acVgwwZ3E+8oWeXhYZROC1J2C7EbcPneAVpQ?=
 =?us-ascii?Q?dqc6r/uQmnAuSiGdlRKYCmiTSPrJRlxY2kdqJAbZdpYFwkhlyHSEEr5dJqPX?=
 =?us-ascii?Q?pxmzhpuWIo+wmS1CyRhp22QBmkIEdWrM+wotpM+rs4tZzKFhVZBBF9cMjQiG?=
 =?us-ascii?Q?DZ3+37qDw4FXov0zBadGvU4tN9MjFqIIS0AFN8XywpGyYjXijmBuebk0ttOK?=
 =?us-ascii?Q?Wr3enluSEmKCqJKWDZao/omxVbcm4+IXeLDSCcyBBVBAyHGqwXyRelcFQY2Q?=
 =?us-ascii?Q?yPFNbs2uWCnCa0mCGvcBZEHPvBNfQ2ZzzONU+uNkpRsoTkNqKZqBNi4ZdcC3?=
 =?us-ascii?Q?xeSQloJT8djuHTM0U20SOcPlG3tVuQ/C7FtHrg7OB3qXnZuFOOi6cFe/ex0D?=
 =?us-ascii?Q?N5LHQ7kVHKTMjAUEawoNDrcTenNWYhLPs+emDMlaYXwyu0tKHmqMUeS4LPZK?=
 =?us-ascii?Q?NKbLd8OLsXw32A0pGeNlg+koLmMuxE+xAEXK38xft3iwDuA7gAJyDWwSmVTv?=
 =?us-ascii?Q?2QjDhgRYvyk34XTl9CunonFiH1Kzs3pzK+LaGUy8oWkabiXFEF0doibdJQDK?=
 =?us-ascii?Q?9ASNWu61XZOOJxCrh8LPD79uMoF4GIkcSZAvC3LBSi2G97qVi0IsW1/yV6GM?=
 =?us-ascii?Q?6MgXQWBY1iQuRT528F+edAX6FqDiVM6Xmq/7/amt8Q/1D9ByTrU+bxsrPybH?=
 =?us-ascii?Q?wElB2xDhwZiOyEJtyhdeD3kdc0bW9toDVAmm7fY636SI/qYWHkvblnFI/9TW?=
 =?us-ascii?Q?rZI6HbeDgXO4LKmbv7M27MTDjm5QMdNrIvdcvWLQ3O1LFZBRwC2WCZHtJBuL?=
 =?us-ascii?Q?gUr2oM61Wk8tE0O+knLVcdxIdUsef0upTjxHt/PciUcT2h7VxQrNQJXe3XLa?=
 =?us-ascii?Q?hoG2imCdlwL3+2xtCTOltmkXQ6D0nsgzp2Ec+ijKDyo5rFF79vHzH7bZWgQO?=
 =?us-ascii?Q?JUHtTQ/Xs9zuDc4qDcl2vPPeRcEZhzdDE6ScM2KUE8TyhPgCQv4HPAtRO+UW?=
 =?us-ascii?Q?1rRWoS/ktasDm53IS5Le33922tnWfxlGwmvcbbNJFta8l/aJMaeEBE5HtScX?=
 =?us-ascii?Q?kSaOW2jpYvhCeM+1o439ly0wNuRKba0syIOEsDFR0/UWGPI+2CBn?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3754cc2-70df-4136-8c28-08deb6eb2b99
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:43:50.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qoc2+uRuFv0Ea1frkiJC8P8IZrFFUQlMyK2y045B7cd+zcYmEJP7oqybBcXB4Kpr/AzYhr+HnQgsvoAWh2GMMYvIo6S5TJ2fTwYb1ovnjDybN1uliPQ2WeDwSVGEuvWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1302

From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

Add support for the Synopsys DesignWare Core (DWC) I2C controller
found on the StarFive JHB100 platform. The controller supports both
master and slave modes and uses a different register layout compared
to the standard DesignWare I2C IP.

Key differences handled by this driver:
1.  All key registers have different offsets. The driver redefines
    these offsets in i2c-dwc-core.h.
2.  Interrupts are cleared by writing to a separate INTR_CLR register
    (write-1-to-clear), unlike the read-to-clear scheme of the
    standard IP.
3.  The IC_ENABLE register has an additional TX_CMD_BLOCK control bit
    which must be managed during enable/disable sequences.
4.  Master and slave require separate probe callbacks and cannot rely
    solely on the runtime mode switching provided by i2c_dw_set_mode().

The driver leverages the common i2c-designware-core infrastructure
exported by the previous patch, while implementing its own timing
calculation, FIFO configuration, and interrupt handling to accommodate
the DWC register offsets and bit definitions.

Signed-off-by: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
---
 MAINTAINERS                         |   7 +
 drivers/i2c/busses/Kconfig          |  34 +++
 drivers/i2c/busses/Makefile         |   3 +
 drivers/i2c/busses/i2c-dwc-core.h   | 184 ++++++++++++
 drivers/i2c/busses/i2c-dwc-master.c | 441 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-dwc-slave.c  | 180 ++++++++++++
 6 files changed, 849 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-dwc-core.h
 create mode 100644 drivers/i2c/busses/i2c-dwc-master.c
 create mode 100644 drivers/i2c/busses/i2c-dwc-slave.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d3a6b3f6b6a0..730388b94e56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25677,6 +25677,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Supported
 F:	drivers/i2c/busses/i2c-designware-*
 
+SYNOPSYS DWC I2C DRIVER
+M:	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
+L:	linux-i2c@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml
+F:	drivers/i2c/busses/i2c-dwc-*
+
 SYNOPSYS DESIGNWARE I2C DRIVER - AMDISP
 M:	Nirujogi Pratap <pratap.nirujogi@amd.com>
 M:	Bin Du <bin.du@amd.com>
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 7cb6b9b864a7..7775b4f40d88 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -640,6 +640,40 @@ config I2C_DESIGNWARE_PCI
 
 endif
 
+config I2C_DWC_CORE
+	tristate "Synopsys DWC I2C adapter"
+	select REGMAP
+	help
+	  This is a driver for the Synopsys DesignWare CORE (DWC) I2C controller,
+	  a variant of the DesignWare I2C IP with a different register layout.
+	  It shares common infrastructure with the standard DesignWare I2C
+	  driver (I2C_DESIGNWARE_CORE)
+
+if I2C_DWC_CORE
+
+config I2C_DWC_SLAVE
+	bool "Synopsys DWC Slave"
+	default I2C_DWC_CORE
+	select I2C_SLAVE
+	help
+	  If you say yes to this option, support will be included for the
+	  Synopsys DWC I2C slave adapter.
+
+	  This is not a standalone module, this module compiles together with
+	  i2c-dwc-core.
+
+config I2C_DWC_PLATFORM
+	tristate "Synopsys DWC Platform"
+	default I2C_DWC_CORE
+	help
+	  If you say yes to this option, support will be included for the
+	  Synopsys DWC I2C adapter.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-dwc-platform.
+
+endif
+
 config I2C_DIGICOLOR
 	tristate "Conexant Digicolor I2C driver"
 	depends on ARCH_DIGICOLOR || COMPILE_TEST
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 547123ab351f..3ed593011578 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -61,6 +61,9 @@ i2c-designware-platform-$(CONFIG_I2C_DESIGNWARE_BAYTRAIL) += i2c-designware-bayt
 obj-$(CONFIG_I2C_DESIGNWARE_AMDISP) += i2c-designware-amdisp.o
 obj-$(CONFIG_I2C_DESIGNWARE_PCI)			+= i2c-designware-pci.o
 i2c-designware-pci-y					:= i2c-designware-pcidrv.o
+obj-$(CONFIG_I2C_DWC_CORE) 				+= i2c-dwc-core.o
+i2c-dwc-core-y                                     	+= i2c-dwc-master.o
+i2c-dwc-core-$(CONFIG_I2C_DWC_SLAVE) 			+= i2c-dwc-slave.o
 obj-$(CONFIG_I2C_DIGICOLOR)	+= i2c-digicolor.o
 obj-$(CONFIG_I2C_EG20T)		+= i2c-eg20t.o
 obj-$(CONFIG_I2C_EMEV2)		+= i2c-emev2.o
diff --git a/drivers/i2c/busses/i2c-dwc-core.h b/drivers/i2c/busses/i2c-dwc-core.h
new file mode 100644
index 000000000000..eba2eaf116c9
--- /dev/null
+++ b/drivers/i2c/busses/i2c-dwc-core.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Synopsys DWC I2C adapter driver.
+ *
+ * Based on the TI DAVINCI I2C adapter driver.
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
+#define IC_DFLT_OPERATION_REG_OFFSET		0x00
+#define IC_DFLT_I2C_REG_OFFSET			0x20
+#define IC_DFLT_SMBUS_REG_OFFSET		0xFC
+
+#define DW_IC_DEFAULT_FUNCTIONALITY		(I2C_FUNC_I2C | \
+						 I2C_FUNC_SMBUS_BYTE | \
+						 I2C_FUNC_SMBUS_BYTE_DATA | \
+						 I2C_FUNC_SMBUS_WORD_DATA | \
+						 I2C_FUNC_SMBUS_BLOCK_DATA | \
+						 I2C_FUNC_SMBUS_I2C_BLOCK)
+
+#define DWC_IC_CTRL_OP_MODE			BIT(0)
+#define DWC_IC_CTRL_SPEED_STD			BIT(4)
+#define DWC_IC_CTRL_SPEED_FAST			(2 << 4)
+#define DWC_IC_CTRL_SPEED_HIGH			(3 << 4)
+#define DWC_IC_CTRL_SPEED_MASK			GENMASK(5, 4)
+#define DWC_IC_CTRL_10BITADDR_TGT		BIT(8)
+#define DWC_IC_CTRL_10BITADDR_CTRLR		BIT(9)
+#define DWC_IC_CTRL_STOP_DET_IFADDRESSED	BIT(10)
+#define DWC_IC_CTRL_TX_EMPTY_CTRL		BIT(11)
+#define DWC_IC_CTRL_RX_FIFO_FULL_HLD_CTRL	BIT(12)
+#define DWC_IC_CTRL_BUS_CLEAR_CTRL		BIT(14)
+
+#define DWC_IC_DATA_CMD_DAT			GENMASK(7, 0)
+#define DWC_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
+#define DWC_IC_DATA_CMD_STOP			BIT(9)
+#define DWC_IC_DATA_CMD_CMD			BIT(8)
+
+/*
+ * Registers offset
+ */
+#undef DW_IC_ENABLE
+#define DW_IC_ENABLE				(IC_DFLT_OPERATION_REG_OFFSET + 0x04)
+#define DWC_IC_CAPABILITIES			(IC_DFLT_OPERATION_REG_OFFSET + 0x0c)
+#define DWC_IC_SMBUS_CAPABILITIES		(IC_DFLT_OPERATION_REG_OFFSET + 0x18)
+
+#define DWC_IC_CTRL				(IC_DFLT_I2C_REG_OFFSET + 0x04)
+#undef DW_IC_TAR
+#define DW_IC_TAR				(IC_DFLT_I2C_REG_OFFSET + 0x08)
+#define DWC_IC_DAR				(IC_DFLT_I2C_REG_OFFSET + 0x0C)
+#define DWC_IC_SCL_HCNT				(IC_DFLT_I2C_REG_OFFSET + 0x24)
+#define DWC_IC_SCL_LCNT				(IC_DFLT_I2C_REG_OFFSET + 0x28)
+#define DWC_IC_HS_SCL_HCNT			(IC_DFLT_I2C_REG_OFFSET + 0x2c)
+#define DWC_IC_HS_SCL_LCNT			(IC_DFLT_I2C_REG_OFFSET + 0x30)
+#undef DW_IC_SDA_HOLD
+#define DW_IC_SDA_HOLD				(IC_DFLT_I2C_REG_OFFSET + 0x34)
+#define DWC_IC_SPKLEN				(IC_DFLT_I2C_REG_OFFSET + 0x3c)
+#define DWC_IC_HS_SPKLEN			(IC_DFLT_I2C_REG_OFFSET + 0x40)
+#define DWC_IC_SCL_STUCK_AT_LOW_TIMEOUT		(IC_DFLT_I2C_REG_OFFSET + 0x44)
+#define DWC_IC_SCL_STUCK_AT_LOW_TIMEOUT_MAX	(IC_DFLT_I2C_REG_OFFSET + 0x48)
+#define DWC_IC_SDA_STUCK_AT_LOW_TIMEOUT		(IC_DFLT_I2C_REG_OFFSET + 0x4c)
+#undef DW_IC_DATA_CMD
+#define DW_IC_DATA_CMD				(IC_DFLT_I2C_REG_OFFSET + 0x58)
+#define DWC_IC_RX_TL				(IC_DFLT_I2C_REG_OFFSET + 0x5c)
+#define DWC_IC_TX_TL				(IC_DFLT_I2C_REG_OFFSET + 0x60)
+#undef DW_IC_INTR_STAT
+#define DW_IC_INTR_STAT				(IC_DFLT_I2C_REG_OFFSET + 0x74)
+#undef DW_IC_INTR_MASK
+#define DW_IC_INTR_MASK				(IC_DFLT_I2C_REG_OFFSET + 0x78)
+#undef DW_IC_RAW_INTR_STAT
+#define DW_IC_RAW_INTR_STAT			(IC_DFLT_I2C_REG_OFFSET + 0x7c)
+#define DWC_IC_INTR_CLR				(IC_DFLT_I2C_REG_OFFSET + 0x80)
+#define DWC_CLR_INTR				BIT(0)
+#define DWC_IC_CLR_RX_UNDER			BIT(1)
+#define DWC_IC_CLR_RX_OVER			BIT(2)
+#define DWC_IC_CLR_TX_OVER			BIT(3)
+#define DWC_IC_CLR_RD_REQ			BIT(4)
+#define DWC_IC_CLR_TX_ABRT			BIT(5)
+#define DWC_IC_CLR_RX_DONE			BIT(6)
+#define DWC_IC_CLR_ACTIVITY			BIT(7)
+#define DWC_IC_CLR_STOP_DET			BIT(8)
+#define DWC_IC_CLR_START_DET			BIT(9)
+#define DWC_IC_CLR_GEN_CALL			BIT(10)
+#define DWC_IC_CLR_RESTART_DET			BIT(11)
+#define DWC_IC_CLR_SCL_STUCK_DET		BIT(12)
+#undef DW_IC_ENABLE_STATUS
+#define DW_IC_ENABLE_STATUS			(IC_DFLT_I2C_REG_OFFSET + 0x84)
+#define DWC_IC_TX_TRMNT_SOURCE			(IC_DFLT_I2C_REG_OFFSET + 0x88)
+#undef DW_IC_STATUS
+#define DW_IC_STATUS				(IC_DFLT_I2C_REG_OFFSET + 0x8c)
+#undef DW_IC_TXFLR
+#define DW_IC_TXFLR				(IC_DFLT_I2C_REG_OFFSET + 0x90)
+#undef DW_IC_RXFLR
+#define DW_IC_RXFLR				(IC_DFLT_I2C_REG_OFFSET + 0x94)
+#define DW_IC_COMP_PARAM_1			0xf4
+#undef DW_IC_COMP_VERSION
+#define DW_IC_COMP_VERSION			(IC_DFLT_I2C_REG_OFFSET + 0xa4)
+#define DWC_IC_SDA_HOLD_MIN_VERS		0x3131312A /* "111*" == v1.11* */
+
+#undef DW_IC_COMP_TYPE
+#define DW_IC_COMP_TYPE				(IC_DFLT_I2C_REG_OFFSET + 0xa8)
+#define DWC_IC_INTR_SCL_STUCK_AT_LOW		BIT(14)
+
+#define DWC_IC_STATUS_ACTIVITY			BIT(0)
+#define DWC_IC_STATUS_TFE			BIT(2)
+#define DWC_IC_STATUS_RFNE			BIT(3)
+#define DWC_IC_STATUS_CTRLR_ACTIVITY		BIT(5)
+#define DWC_IC_STATUS_TGT_ACTIVITY		BIT(6)
+
+#define DW_IC_SDA_HOLD_TX_SHIFT			0
+#define DW_IC_SDA_HOLD_TX_MASK			GENMASK(15, 0)
+
+#define DW_IC_ERR_TX_ABRT			0x1
+
+#define DWC_IC_TAR_SMBUS_QUICK_CMD		BIT(16)
+#define DWC_IC_TAR_SPECIAL			BIT(11)
+
+#define DWC_IC_COMP_PARAM_1_SPEED_MODE_HIGH	(BIT(4) | BIT(5))
+#define DWC_IC_COMP_PARAM_1_SPEED_MODE_MASK	GENMASK(5, 4)
+
+#define DWC_IC_SMBUS_ARP_CTRL			(IC_DFLT_SMBUS_REG_OFFSET + 0x8)
+#define DWC_IC_SMBUS_INTR_STAT			(IC_DFLT_SMBUS_REG_OFFSET + 0x28)
+#define DWC_IC_SMBUS_INTR_CLR			(IC_DFLT_SMBUS_REG_OFFSET + 0x34)
+#define DWC_CLR_SMBUS_ALERT_DET			BIT(10)
+#define DWC_R_SMBUS_ALERT_DET			BIT(10)
+
+#define DWC_IC_DAR4_EN				19
+#define DWC_IC_DAR3_EN				18
+#define DWC_IC_DAR2_EN				17
+#define DWC_IC_DAR_EN				16
+
+#define DWC_IC_ENABLE_DAR_EN			BIT(DWC_IC_DAR_EN)
+#define DWC_IC_ENABLE_DAR2_EN			BIT(DWC_IC_DAR2_EN)
+#define DWC_IC_ENABLE_DAR3_EN			BIT(DWC_IC_DAR3_EN)
+#define DWC_IC_ENABLE_DAR4_EN			BIT(DWC_IC_DAR4_EN)
+
+#define DW_IC_ENABLE_TX_CMD_BLOCK		BIT(2)
+
+#define DWC_IC_SMBUS				10
+
+#define DWC_IC_CAPABILITIES_IC_SMBUS		BIT(DWC_IC_SMBUS)
+
+#define DWC_IC_SMBUS_ARP			2
+
+#define DWC_IC_SMBUS_CAPABILITIES_SMBUS_ARP	BIT(DWC_IC_SMBUS_ARP)
+
+#define DWC_IC_SMBUS_ARP_CTRL_NARP_DEVICE_TYPE	0
+
+#undef TXGBE_RX_FIFO_DEPTH
+#define TXGBE_RX_FIFO_DEPTH			0
+
+extern const struct i2c_algorithm i2c_dw_slave_algo;
+int i2c_dw_probe_slave(struct dw_i2c_dev *dev);
+int i2c_dw_probe_master(struct dw_i2c_dev *dev);
+void i2c_dw_read_clear_intrbits_common(struct dw_i2c_dev *dev);
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
diff --git a/drivers/i2c/busses/i2c-dwc-master.c b/drivers/i2c/busses/i2c-dwc-master.c
new file mode 100644
index 000000000000..6e8d1828f99e
--- /dev/null
+++ b/drivers/i2c/busses/i2c-dwc-master.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Synopsys DWC I2C adapter driver (master only).
+ *
+ * Based on the TI DAVINCI I2C adapter driver.
+ *
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
+/**
+ * i2c_dwc_scl_hcnt() -  Calculate SCL HCNT
+ * @ic_clk: Input clock in kHz
+ * @thigh: Duration in ns of logic 1 to generate
+ * @tr: SCL rise time in ns
+ * @spk_cnt: Spike count
+ */
+static u32 i2c_dwc_scl_hcnt(u32 ic_clk, u32 thigh, u32 tr, u32 spk_cnt)
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
+ * i2c_dwc_scl_lcnt() -  Calculate SCL LCNT
+ * @ic_clk: Input clock in kHz
+ * @tlow: Duration in ns of logic 0 to generate
+ * @tf: SCL fall time in ns
+ */
+static u32 i2c_dwc_scl_lcnt(u32 ic_clk, u32 tlow, u32 tf)
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
+static void i2c_dwc_configure_fifo_master(struct dw_i2c_dev *dev)
+{
+	/* Configure Tx/Rx FIFO threshold levels */
+	regmap_write(dev->map, DWC_IC_TX_TL, dev->tx_fifo_depth / 2);
+	regmap_write(dev->map, DWC_IC_RX_TL, 0);
+
+	/* Configure the I2C master */
+	regmap_write(dev->map, DWC_IC_CTRL, dev->master_cfg);
+}
+
+static int i2c_dwc_set_timings_master(struct dw_i2c_dev *dev)
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
+	ret = regmap_read(dev->map, DWC_IC_CTRL, &comp_param1);
+	i2c_dw_release_lock(dev);
+	if (ret)
+		return ret;
+
+	ic_clk = i2c_dw_clk_rate(dev);
+
+	/* 50ns maximum spike */
+	spk_cnt = DIV_ROUND_CLOSEST_ULL((u64)ic_clk * 50, MICRO);
+
+	regmap_write(dev->map, DWC_IC_HS_SPKLEN, spk_cnt);
+	regmap_write(dev->map, DWC_IC_SPKLEN, spk_cnt);
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
+		dev->scl_hcnt = i2c_dwc_scl_hcnt(ic_clk, scl_high_time,
+						 scl_rising_time, spk_cnt);
+		dev->scl_lcnt = i2c_dwc_scl_lcnt(ic_clk, scl_low_time,
+						 scl_falling_time);
+	}
+
+	dev_dbg(dev->dev, "Bus speed: %s\n", i2c_freq_mode_string(t->bus_freq_hz));
+
+	/* Check is high speed possible and fall back to fast mode if not */
+	if ((dev->master_cfg & DWC_IC_CTRL_SPEED_MASK) == DWC_IC_CTRL_SPEED_HIGH) {
+		if ((comp_param1 & DWC_IC_COMP_PARAM_1_SPEED_MODE_MASK)
+			!= DWC_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
+			dev_err(dev->dev, "High Speed not supported!\n");
+			t->bus_freq_hz = I2C_MAX_FAST_MODE_FREQ;
+			dev->master_cfg &= ~DWC_IC_CTRL_SPEED_MASK;
+			dev->master_cfg |= DWC_IC_CTRL_SPEED_FAST;
+			dev->hs_hcnt = 0;
+			dev->hs_lcnt = 0;
+
+			/* Replace with I2C_MAX_FAST_MODE_PLUS_FREQ */
+			scl_rising_time = max(scl_rising_time, 120);
+			scl_falling_time = max(scl_falling_time, 120);
+			scl_high_time = 260;	/* tHIGH_min = 260 ns */
+			scl_low_time = 500;	/* tLOW_min = 500 ns */
+
+			dev->scl_hcnt = i2c_dwc_scl_hcnt(ic_clk, scl_high_time,
+							 scl_rising_time, spk_cnt);
+			dev->scl_lcnt = i2c_dwc_scl_lcnt(ic_clk, scl_low_time,
+							 scl_falling_time);
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
+int i2c_dw_init(struct dw_i2c_dev *dev)
+{
+	int ret;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	/* Disable the adapter */
+	__i2c_dw_disable(dev);
+
+	/* Write standard speed timing parameters */
+	regmap_write(dev->map, DWC_IC_SCL_HCNT, dev->scl_hcnt);
+	regmap_write(dev->map, DWC_IC_SCL_LCNT, dev->scl_lcnt);
+
+	/* Write high speed timing parameters if supported */
+	if (dev->hs_hcnt && dev->hs_lcnt) {
+		regmap_write(dev->map, DWC_IC_HS_SCL_HCNT, dev->hs_hcnt);
+		regmap_write(dev->map, DWC_IC_HS_SCL_LCNT, dev->hs_lcnt);
+	}
+
+	/* Write SDA hold time if supported */
+	if (dev->sda_hold_time)
+		regmap_write(dev->map, DW_IC_SDA_HOLD, dev->sda_hold_time);
+
+	i2c_dwc_configure_fifo_master(dev);
+	i2c_dw_release_lock(dev);
+
+	return 0;
+}
+
+static int i2c_dwc_set_sda_hold_time(struct dw_i2c_dev *dev)
+{
+	int ret = regmap_write_bits(dev->map,
+			DW_IC_SDA_HOLD,
+			DW_IC_SDA_HOLD_TX_MASK,
+			dev->sda_hold_time);
+	return ret;
+}
+
+void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
+{
+	struct i2c_msg *msgs = dev->msgs;
+	u32 ic_ctrl = 0, ic_tar = 0;
+	unsigned int dummy;
+
+	/* Disable the adapter */
+	__i2c_dw_disable(dev);
+
+	/* If the slave address is ten bit address, enable 10BITADDR */
+	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
+		ic_ctrl = DWC_IC_CTRL_10BITADDR_CTRLR;
+		/*
+		 * If I2C_DYNAMIC_TAR_UPDATE is set, the 10-bit addressing
+		 * mode has to be enabled via bit 12 of IC_TAR register.
+		 * We set it always as I2C_DYNAMIC_TAR_UPDATE can't be
+		 * detected from registers.
+		 */
+		ic_tar = DW_IC_TAR_10BITADDR_MASTER;
+	}
+
+	/* From i2c-core-smbus.c, I2C_SMBUS_QUICK intentionally has msg[0].len = 0 */
+	if (dev->msgs[0].len == 0)
+		ic_tar |= DWC_IC_TAR_SMBUS_QUICK_CMD | DWC_IC_TAR_SPECIAL;
+
+	regmap_update_bits(dev->map, DWC_IC_CTRL, DWC_IC_CTRL_10BITADDR_CTRLR,
+			   ic_ctrl);
+
+	/*
+	 * Set the slave (target) address and enable 10-bit addressing mode
+	 * if applicable.
+	 */
+	regmap_write(dev->map, DW_IC_TAR,
+		     msgs[dev->msg_write_idx].addr | ic_tar);
+
+	/* Enforce disabled interrupts (due to HW issues) */
+	regmap_write(dev->map, DW_IC_INTR_MASK, 0);
+
+	/* Enable the adapter */
+	__i2c_dw_enable(dev);
+
+	/* Dummy read to avoid the register getting stuck on Bay Trail */
+	regmap_read(dev->map, DW_IC_ENABLE_STATUS, &dummy);
+
+	/* Clear and enable interrupts */
+	regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_CLR_INTR);
+	regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_MASTER_MASK);
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
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_RX_UNDER);
+	if (stat & DW_IC_INTR_RX_OVER)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_RX_OVER);
+	if (stat & DW_IC_INTR_TX_OVER)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_TX_OVER);
+	if (stat & DW_IC_INTR_RD_REQ)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_RD_REQ);
+	if (stat & DW_IC_INTR_RX_DONE)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_RX_DONE);
+	if (stat & DW_IC_INTR_ACTIVITY)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_ACTIVITY);
+	if (stat & DW_IC_INTR_START_DET)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_START_DET);
+	if (stat & DW_IC_INTR_GEN_CALL)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_GEN_CALL);
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
+		regmap_read(dev->map, DWC_IC_TX_TRMNT_SOURCE, &dev->abort_source);
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_TX_ABRT);
+	}
+	if ((stat & DW_IC_INTR_STOP_DET) &&
+	    (dev->rx_outstanding == 0 || (stat & DW_IC_INTR_RX_FULL)))
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_STOP_DET);
+	if (stat & DW_IC_INTR_RESTART_DET)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_RESTART_DET);
+	if (stat & DWC_IC_INTR_SCL_STUCK_AT_LOW)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_SCL_STUCK_DET);
+
+	i2c_dw_read_clear_intrbits_common(dev);
+
+	return stat;
+}
+
+void i2c_dw_configure_master(struct dw_i2c_dev *dev)
+{
+	struct i2c_timings *t = &dev->timings;
+
+	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY |
+		I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_PEC;
+
+	dev->master_cfg = DWC_IC_CTRL_OP_MODE;
+
+	dev->mode = DW_IC_MASTER;
+
+	switch (t->bus_freq_hz) {
+	case I2C_MAX_STANDARD_MODE_FREQ:
+		dev->master_cfg |= DWC_IC_CTRL_SPEED_STD;
+		break;
+	case I2C_MAX_FAST_MODE_FREQ:
+		dev->master_cfg |= DWC_IC_CTRL_SPEED_FAST;
+		break;
+	case I2C_MAX_FAST_MODE_PLUS_FREQ:
+		dev->master_cfg |= DWC_IC_CTRL_SPEED_FAST;
+		break;
+	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
+		dev->master_cfg |= DWC_IC_CTRL_SPEED_HIGH;
+		break;
+	default:
+		dev->master_cfg |= DWC_IC_CTRL_SPEED_FAST;
+	}
+
+	dev->set_sda_hold_time = i2c_dwc_set_sda_hold_time;
+}
+
+int i2c_dw_probe_master(struct dw_i2c_dev *dev)
+{
+	struct i2c_adapter *adap = &dev->adapter;
+	unsigned int ic_ctrl;
+	int ret;
+
+	init_completion(&dev->cmd_complete);
+
+	ret = i2c_dwc_set_timings_master(dev);
+	if (ret)
+		return ret;
+
+	/* Lock the bus for accessing DWC_IC_CTRL */
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * On AMD platforms BIOS advertises the bus clear feature
+	 * and enables the SCL/SDA stuck low. SMU FW does the
+	 * bus recovery process. Driver should not ignore this BIOS
+	 * advertisement of bus clear feature.
+	 */
+	ret = regmap_read(dev->map, DWC_IC_CTRL, &ic_ctrl);
+	i2c_dw_release_lock(dev);
+	if (ret)
+		return ret;
+
+	if (ic_ctrl & DWC_IC_CTRL_BUS_CLEAR_CTRL)
+		dev->master_cfg |= DWC_IC_CTRL_BUS_CLEAR_CTRL;
+
+	ret = i2c_dw_init(dev);
+	if (ret)
+		return ret;
+
+	snprintf(adap->name, sizeof(adap->name),
+		 "Synopsys DWC I2C adapter");
+
+	ret = i2c_dw_init_recovery_info(dev);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+MODULE_AUTHOR("Sankarshan shukla <sashukla@synopsys.com>");
+MODULE_DESCRIPTION("Synopsys DWC I2C bus master adapter");
+MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-dwc-slave.c b/drivers/i2c/busses/i2c-dwc-slave.c
new file mode 100644
index 000000000000..5369eb881238
--- /dev/null
+++ b/drivers/i2c/busses/i2c-dwc-slave.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DWC I2C adapter driver (slave only).
+ *
+ * Based on the Synopsys DWC I2C adapter driver (master).
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
+		regmap_write(dev->map, DWC_IC_DAR, dev->slave->addr);
+		__i2c_dw_enable(dev);
+		dev->status = 0;
+	}
+}
+
+static void i2c_dwc_configure_fifo_slave(struct dw_i2c_dev *dev)
+{
+	/* Configure the I2C slave. */
+	regmap_write(dev->map, DWC_IC_CTRL, 0);
+	regmap_write(dev->map, DWC_IC_CTRL, dev->slave_cfg);
+	regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
+}
+
+/**
+ * i2c_dwc_init_slave() - Initialize the DWC i2c slave hardware
+ * @dev: device private data
+ *
+ * This function configures and enables the I2C in slave mode.
+ * This function is called during I2C init function, and in case of timeout at
+ * run time.
+ */
+static int i2c_dwc_init_slave(struct dw_i2c_dev *dev)
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
+	regmap_read(dev->map, DWC_IC_CAPABILITIES, &r_value);
+	if (r_value & DWC_IC_CAPABILITIES_IC_SMBUS) {
+		regmap_read(dev->map, DWC_IC_SMBUS_CAPABILITIES, &r_value);
+		if (r_value & DWC_IC_SMBUS_CAPABILITIES_SMBUS_ARP) {
+			regmap_write(dev->map, DW_IC_ENABLE, DWC_IC_ENABLE_DAR_EN);
+			regmap_write(dev->map, DWC_IC_SMBUS_ARP_CTRL,
+				     DWC_IC_SMBUS_ARP_CTRL_NARP_DEVICE_TYPE);
+		}
+	}
+
+	i2c_dwc_configure_fifo_slave(dev);
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
+	regmap_read(dev->map, DWC_IC_SMBUS_INTR_STAT, &smbus_stat);
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
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_TX_ABRT);
+	if (stat & DW_IC_INTR_STOP_DET)
+		regmap_write(dev->map, DWC_IC_INTR_CLR, DWC_IC_CLR_STOP_DET);
+	if (smbus_stat & DWC_R_SMBUS_ALERT_DET)
+		regmap_write(dev->map, DWC_IC_SMBUS_INTR_CLR, DWC_CLR_SMBUS_ALERT_DET);
+
+	i2c_dw_read_clear_intrbits_common(dev);
+
+	return stat;
+}
+
+#if IS_ENABLED(CONFIG_I2C_DWC_SLAVE)
+static int i2c_dwc_xfer_ms(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
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
+	.master_xfer = i2c_dwc_xfer_ms,
+	.functionality = i2c_dw_func,
+	.reg_slave = i2c_dw_reg_slave,
+	.unreg_slave = i2c_dw_unreg_slave,
+};
+
+void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
+{
+	dev->functionality = I2C_FUNC_SLAVE | DW_IC_DEFAULT_FUNCTIONALITY;
+
+	dev->slave_cfg = DWC_IC_CTRL_RX_FIFO_FULL_HLD_CTRL |
+			 DWC_IC_CTRL_STOP_DET_IFADDRESSED;
+
+	dev->mode = DW_IC_SLAVE;
+}
+
+int i2c_dw_probe_slave(struct dw_i2c_dev *dev)
+{
+	struct i2c_adapter *adap = &dev->adapter;
+	struct device_node *ms_node;
+	int ret;
+
+	ret = i2c_dwc_init_slave(dev);
+	if (ret)
+		return ret;
+
+	snprintf(adap->name, sizeof(adap->name), "Synopsys DWC I2C Slave adapter");
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
+EXPORT_SYMBOL_GPL(i2c_dw_probe_slave);
+
+MODULE_AUTHOR("Sankarshan shukla <sashukla@synopsys.com>");
+MODULE_DESCRIPTION("Synopsys DWC I2C bus slave adapter");
+MODULE_LICENSE("GPL");
-- 
2.43.0

