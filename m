Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D04C2273;
	Mon, 12 Oct 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826643; cv=fail; b=MdT7sTp244f3DYfNz61Mt4c0zHkRbSLfvVWLNZnQvufXRexzhE2QEGGFDy29YCuBGhfDLwO+TMjBEJmYu6/qjmVHAotlMlALbamCeu9UqEHIWOILRwmf7GJYq8W31eZANLEmPaFyyX7g5fatIdQGmlguVUTp+UDkR/2AHgB51Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826643; c=relaxed/simple;
	bh=8f5ClEN/wP1dSvafkSkElT6ZheLlh+CYuRT87njOaFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pr23r0ujET3VSZ00EVGMtfkhezrBktsD/ZUErtMlXW++DOgPQzWFczYwIwSoW78pk14234k48ZrLBI4rb7zIniRV0TzNt2OwZNWoQ3Vq+cX1n/uxh/89Yor5TV5hGIL2heJRFDLw3ha5gvf3FcQbSCnDR3u3x3hRVuLjJu0RmfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XiXrxUah; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XiXrxUah"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzvXFVizpmbxht5CVXN+a2cBCTYGUsK9wxzECWeXIqydxYckgIYjix05/m52rY46cM8ETDhQcoWZjt2r/xcDHBaGaiCFzE3lyceOu6BlFPplqtl3e4z/VGFeylRGunI2SdQN4WB1lwSrvfTW+MbRSqaPUnRTKPzDqhn2XpVDXQW6b/l9ordJ36vxHBpGdEHmiZrV4gCTAJOg2kJfF3vdFFbxp05IDdSV/aRBCr8x/y7oPFE1ClRB+G2QWjMfcPBcgMWJ/E6IbRrIuG1IFEqLWhTmRwJLRIA0mglcBeo/IKwOAH6L4NeyMe9ZCwTYAxZBcntMaFqex618EbNS7+sXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uomCNYBnMW/T1DNiVJTfEaSz9qHCyZyKn95EZ8fPWvs=;
 b=Y5Be7tXI7Nes1P8UMFkDmKtgpg7q9tPNzUMR2hl/lv7mJgzW5XdOH7AbJAJwpVMHSzEWxSVqRLQYWJ7Dwyft/XBW3xUD+LTOe+4Wi/AYwCzUvQ2UAMwsJUR+KvQfnoJ4X2v5WbOPLhLREOu1zin5Uh/UH0SzLiUBl449irUhsXpidMM9w3r6F/IauI4f9kN7W0ecHj257Yohm8pvbEsWFYsYUhQbaotWZR43ZrnYSHiZx5MhgPSnVaZWFvAQEP5PXS6wMx99j0VFQz1vTfnOcPc5xMHU9/K7otBMRFvecoTyHmugUekiTEb9Aj/TPjQQrvy16ALdoflNWZ/UYCDwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uomCNYBnMW/T1DNiVJTfEaSz9qHCyZyKn95EZ8fPWvs=;
 b=XiXrxUah5nmQHRKgIRTmZBG9pPFqPJKvPZwzVXb9XYzxBU6pLgwm2rnfmE2/R6hnzO4iTZHjvAJMvhVwPqGIyCeiYJh+ZHwsia5YjlWDr3gv8h+5RIwYyqfTlP2fEFy9sfaAAzHUREXEzuKV52RVp3c/ZZUgfSurOz4TPEcst/6xDnFLMGV6SOLvMUvzoFhoOsG7VH0dRXit0cFUDMLNQxx7mvGG/qsC8HUQme0yWzVdRDTX/84VB90vCTMC6UL43qUJNGzPphiF6gyXfOFk2kKvPPVDibBVPNjPq8l7xBFRcnZ3ojO0CAO05XUS2plK8hhNoVgpbvlJfv+o7aCGbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 17:37:12 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 17:37:12 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Donald Shannon <donalds@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/11] i2c: Add NVIDIA LSTP I2C driver
Date: Mon, 12 Oct 2026 20:36:06 +0300
Message-ID: <20261012-lstp-usb-adapter-v1-8-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::20) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: dfecc769-c05d-4b8c-3a64-08df288772a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|261009220027099003|261009221227099003|261009223327099003|261009223027099003|261009221727099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	l4vtRMViNl2sbxuWq4w3EW2XxWCBZSJB3ZThmIT/OfmihXEV+Dw3GTcZIvlGkKVIL58QKxFCO+Zw+auFaMCl5O2zvJ6HPI8h1InjF6o4fhL1ZK0VfU2y+wONI2NkchtaiKkO7YY92GTTjNHZGxHANFGn9fyPqZs8ZfMcYznnW4Z4NOGjaNIT6YIwqlWf8mNlo+OtxlHaPKOiTrRmbiQJvCBXaScBrdoPtynU3AQ34GmUgydrD8G2C7QahibHDLasWadISN5vbtijzO8GDF3MQaZBCWzFIbKyC5zaqq3RKQj8Z3o4okJITtNXXPJrQHOZZhCxD8b8VOyZmUKZP24a8supJWX3jFGqOXra1oZzJWzjjTsxySvBHVWSTtxHQVvfbeThXPdAGwNFMZa+XL66Oe6EcIi83mdDHEQgngFZkFAiGWO7DjwXim80nm25dgWIBFNkMLh0hIP76CwHh9JmAuYhSJy7q+3CUAqL3Ra1f7J+TIeHJbbIH5Y4heNL8GCbAtfYmoJFHqwDPWuSVVONIuQAC0gQC73G0mdhK5lXBbFK0jJ2+aQxOebTVb+HyS4TEunmkhE4nxaykDVdtGSdxsHZ1SNKHEuqHu2Z9smVJzKYL/PLRxYUgdESEBISKkNCPVZZjtu6OkQnuP1vDSw0JUJ2OHrf0tschW0Rt71vwXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009221727099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L6qsidvhY+WwwAfRifiWQfy+aJc8geIC7EGcURm/LaEtzxAVFEGzgtU+xQJD?=
 =?us-ascii?Q?NS7OS/+vzlfHVQNEhrIL1k474Sq79vP4J5gbIxNmJrpB5yc1sz+4d6yAB0Gu?=
 =?us-ascii?Q?WYFsaSw7mGdIoF7XVvY5noDurUNjajKPdLZfu2oOlJGAzKEjBCF161pYZsRc?=
 =?us-ascii?Q?iAAjEGEmV4BZUhT0r6K8/RB7kJra3SWC5628HkW6ewwqB+dVqwU3u6WdTd5R?=
 =?us-ascii?Q?7F5lEKcAUlDDErSB8AUDVa7xPpyNPs1SYsrAyL0q90dG9Z+3nLUtsbqPs7mg?=
 =?us-ascii?Q?G/BYvgnWq6V15yEIJgNKMHU0NHz9Hl7GJysKYCD/OzeYtQMT2m5eP34nfqsu?=
 =?us-ascii?Q?VxvTIgS0a6axko2pbnZovQUglcqgZ4kWbexMu2rVRQOK7QYhV3BWocal8RM5?=
 =?us-ascii?Q?xOPJQX9VD1rwy598k8tQheasxY4kkM6Eo46/sQOk+msMXoMPW068TpdfEDuV?=
 =?us-ascii?Q?5RG/30G92yvl2P39UABU4appQOSa/d0nDA6j7zqEITpzez6dpN+Opa3/Ug28?=
 =?us-ascii?Q?KOJzh+V0OLVRraE6RhZjKIdI30SCi9sXFxHk7XhwB2KthAbAF+im1qHctax3?=
 =?us-ascii?Q?c2otMyrVUhdRicngxXCYB+n9gBq3r4MKMrUY1h3K1XvgVoXPdG82DpHFChM9?=
 =?us-ascii?Q?Y7FWvgygVLKAMGw8Dva5UGm+A1DGy695KGNNh9j+74TY94rJJmGhjVX6VTld?=
 =?us-ascii?Q?juKUYgFyGDFx3se7f/hthR/617Y7BFWABy7BD1kzQ0EJaOU7AvsPT8hWSOhb?=
 =?us-ascii?Q?ORsUMU9PDJXIpgbYBAv1kJyRUM4LZq9egcUS7tbeNNgGrkLbUpelS5qmShPc?=
 =?us-ascii?Q?32VJrdtrVpuUw9hsHzJ02SrTBu7jJH+mHaytjk8sL76ucu6F2E3JmFr6tgq4?=
 =?us-ascii?Q?imlvsp/hBnLcP72Ax2+KPP86XbpkL8OVEodrvySQWKp438ID+bzpe7tzK+3P?=
 =?us-ascii?Q?N2nanDwv7bv6gy/gHYnIiWUdgEohb7gFKRuoMgfh5CflgEg0Eq8S2uxYV+yj?=
 =?us-ascii?Q?fLmaz4vJLWbjFFjHfYsHXzdRe1M05SIGc7SgXJpfx8GZsWIlZ67Q5d/qxhUh?=
 =?us-ascii?Q?A7TtNme2KuwjRFHAVVf44fa11J4CDm3Acj5/wMCT1u+5WvBgPn0WDcfSM3MQ?=
 =?us-ascii?Q?3Zf2n3mgSK1XJiWOn3CtPvA4jbxFTL2kJimCHRRKcefxSlCPPjay5c3JSbmW?=
 =?us-ascii?Q?aFbnubB/T0TVFfW8SygausxV7cJAQgP+cllR6nFZdHVnRPbKT+uCQmSPjkpV?=
 =?us-ascii?Q?CRZHihtAWiOIpMui1z5jqI4oOniesiTXlTJZct+0vY9AXa5h46d2z1+waXEH?=
 =?us-ascii?Q?3R3wYD1o8pY60DzobIAcqpgKNeD7Zn/Je9J+XY38U3SxdlD8tdbk/G2PAU4+?=
 =?us-ascii?Q?rqbqTkXQcI4ARbuNHvUYIAQBVOcydTAjFrQCq8F0dGtKjiq+E4VIDCyOEIoa?=
 =?us-ascii?Q?PGQKRNd+5+ysu7UNGCp8eByuErl6wyJ+1I2B775OgNXjbCCeQeTUtw4mpiMV?=
 =?us-ascii?Q?987zKvJEwcnIE504EINdVjloeLGu/bkQE8OQIrqkByttjDoI0iB7JLAW0C9B?=
 =?us-ascii?Q?WtVRb3KzaYTc0XL27SMD7Aq8c/4DW2Uu5Jk5nQdEN4gCHEjch25BWkLJRfTk?=
 =?us-ascii?Q?KdWnIr4lhokaJ3UmdrBB+BAcMRdnvuGzDGrc5V4Q6kW1NfOuYzro/eRkDIiX?=
 =?us-ascii?Q?ETZILCkusi+yVuzHqE4iINu5dzhG+p6LkqGn60FxyE2jpE2xty1o1eXA4H6k?=
 =?us-ascii?Q?jE0W2PPHXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfecc769-c05d-4b8c-3a64-08df288772a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:37:12.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLhzMux0eewcwWRtBUpzuU6kG9/ErYxCxaKEgbffc8UkFHmma4ggorUZV5M+1sJN7j855Dd1dd9aY9IfN5L/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

Add a driver for the I2C controller channels of NVIDIA LSTP USB
adapters. Each channel is registered as an I2C adapter; devices behind
it can be described by device tree or ACPI, or instantiated from
userspace. The device sets the bus speed. A transfer that fails on
arbitration loss or a busy bus is re-issued up to nvidia,retries times
(default 3), unless the device reports that it retries itself.

Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 MAINTAINERS                   |   1 +
 drivers/i2c/busses/Kconfig    |  13 +
 drivers/i2c/busses/Makefile   |   1 +
 drivers/i2c/busses/i2c-lstp.c | 573 ++++++++++++++++++++++++++++++++++
 4 files changed, 588 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-lstp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c8ed59cd4b11..082c4b3a0eb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19578,6 +19578,7 @@ F:	Documentation/devicetree/bindings/usb/nvidia,lstp.yaml
 F:	Documentation/driver-api/usb/lstp.rst
 F:	Documentation/firmware-guide/acpi/lstp.rst
 F:	drivers/gpio/gpio-lstp.c
+F:	drivers/i2c/busses/i2c-lstp.c
 F:	drivers/leds/leds-lstp.c
 F:	drivers/usb/misc/lstp.c
 F:	include/linux/usb/lstp.h
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d7b89508311f..9e3b21f18159 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1387,6 +1387,19 @@ config I2C_USBIO
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c_usbio.
 
+config I2C_LSTP
+	tristate "NVIDIA LSTP I2C support"
+	depends on USB_LSTP
+	default USB_LSTP
+	help
+	  Say Y or M here to support the I2C channels of NVIDIA LSTP USB
+	  adapters. Each channel is registered as an I2C adapter, and the
+	  devices behind it can be described by device tree, ACPI or
+	  instantiated from userspace.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-lstp.
+
 config I2C_CP2615
 	tristate "Silicon Labs CP2615 USB sound card and I2C adapter"
 	depends on USB
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 3755c54b3d82..5970b0bb1926 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -138,6 +138,7 @@ obj-$(CONFIG_I2C_DLN2)		+= i2c-dln2.o
 obj-$(CONFIG_I2C_LJCA)		+= i2c-ljca.o
 obj-$(CONFIG_I2C_NCT6694)	+= i2c-nct6694.o
 obj-$(CONFIG_I2C_USBIO)		+= i2c-usbio.o
+obj-$(CONFIG_I2C_LSTP)		+= i2c-lstp.o
 obj-$(CONFIG_I2C_CP2615) += i2c-cp2615.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PCI1XXXX)	+= i2c-mchp-pci1xxxx.o
diff --git a/drivers/i2c/busses/i2c-lstp.c b/drivers/i2c/busses/i2c-lstp.c
new file mode 100644
index 000000000000..f1af36a709dd
--- /dev/null
+++ b/drivers/i2c/busses/i2c-lstp.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * I2C driver for LSTP USB interface.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
+#include <linux/string.h>
+#include <linux/uio.h>
+
+#include <linux/usb/lstp.h>
+
+enum lstp_i2c_cmd {
+	LSTP_I2C_CMD_BUS_RECOVERY = 0x00,
+	LSTP_I2C_CMD_READ = 0x01,
+	LSTP_I2C_CMD_WRITE = 0x02,
+	LSTP_I2C_CMD_WRITE_READ = 0x04,
+	LSTP_I2C_CMD_SMBUS_BLOCK_READ = 0x05
+} __packed;
+
+enum lstp_i2c_cmd_flags { LSTP_I2C_CMD_FLAG_NO_STOP = 0x40 };
+
+enum lstp_i2c_smbus_block_read_flags {
+	LSTP_I2C_SMBUS_BLOCK_READ_FLAG_PEC = BIT(0),
+} __packed;
+
+struct lstp_i2c_read_req {
+	u8 addr;
+	__le16 rd_len;
+} __packed;
+
+struct lstp_i2c_write_req {
+	u8 addr;
+	u8 wr_data[];
+} __packed;
+
+struct lstp_i2c_wr_rd_req {
+	u8 addr;
+	__le16 rd_len;
+	u8 wr_data[]; /* Write length inferred from length in header */
+} __packed;
+
+struct lstp_i2c_smbus_block_read_req {
+	u8 addr;
+	__le16 flags; /* lstp_i2c_smbus_block_read_flags */
+	u8 wr_data[]; /* Write length inferred from length in header */
+} __packed;
+
+/* Largest block-read write phase: SMBus command byte, block count, maximum-size block. */
+#define LSTP_I2C_SMBUS_BLOCK_READ_WR_MAX (2 + I2C_SMBUS_BLOCK_MAX)
+
+enum lstp_i2c_speed {
+	LSTP_I2C_SPEED_100KHZ = 0x00,
+	LSTP_I2C_SPEED_400KHZ = 0x01,
+	LSTP_I2C_SPEED_1000KHZ = 0x02,
+	LSTP_I2C_SPEED_3400KHZ = 0x03,
+};
+
+struct lstp_i2c_config {
+	u8 speed;
+	__le16 output_drive_strength; /* in mA */
+	__le16 slew_rate; /* in 100 ps (0.1 ns) increments */
+	__le16 input_debounce_time; /* in us */
+	__le16 glitch_filter_width; /* in ns */
+	u8 bus_low_timeout; /* in ms */
+	u8 bus_arbitration_retries;
+} __packed;
+
+/* Wire offsets: inserting or resizing a field silently shifts every field after it. */
+static_assert(sizeof(struct lstp_i2c_config) == 11,
+	      "I2C channel config must match the LSTP specification");
+
+/* Shortest blob the channel accepts; every field after speed is optional. */
+#define LSTP_I2C_CONFIG_MIN_LEN offsetofend(struct lstp_i2c_config, speed)
+
+static bool lstp_i2c_can_retry(int lstp_status)
+{
+	return lstp_status == LSTP_BUSY || lstp_status == LSTP_ARB_LOST;
+}
+
+static bool lstp_i2c_suppress_error_logs(int ret, int lstp_status)
+{
+	return ret == -ENODEV || lstp_status == LSTP_NACK || lstp_i2c_can_retry(lstp_status);
+}
+
+/* i2c_bus_recovery_info.recover_bus: ask the device to run its own bus recovery. */
+static int lstp_i2c_bus_recovery(struct i2c_adapter *adap)
+{
+	struct lstp_channel *ch = adap->algo_data;
+	int lstp_status = LSTP_NO_RESPONSE_STATUS;
+
+	int ret = lstp_request(ch, LSTP_I2C_CMD_BUS_RECOVERY, NULL, 0, NULL, 0, NULL, &lstp_status);
+
+	if (ret && !lstp_i2c_suppress_error_logs(ret, lstp_status))
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: Bus recovery failed (%pe)\n", __func__,
+				    ch->ch_id, ERR_PTR(ret));
+	if (ret && lstp_i2c_can_retry(lstp_status))
+		return -EAGAIN;
+	return ret;
+}
+
+static int lstp_i2c_validate_msg(struct i2c_msg *msg)
+{
+	if (!msg->buf && msg->len > 0)
+		return -EINVAL;
+
+	if (msg->flags & I2C_M_TEN)
+		return -EAFNOSUPPORT; /* 10-bit address not supported */
+
+	if (msg->addr > 0x7F)
+		return -EINVAL; /* Only 7-bit address supported */
+
+	if ((msg->flags & I2C_M_RECV_LEN) && (!(msg->flags & I2C_M_RD) || msg->len < 1))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* One READ transaction; @no_stop omits STOP so a further message can follow. */
+static int lstp_i2c_read(struct i2c_adapter *adap, struct i2c_msg *msg, bool no_stop)
+{
+	u8 cmd = LSTP_I2C_CMD_READ;
+	struct lstp_channel *ch = adap->algo_data;
+	struct lstp_i2c_read_req req = {
+		.addr = msg->addr,
+		.rd_len = cpu_to_le16(msg->len),
+	};
+	int lstp_status = LSTP_NO_RESPONSE_STATUS;
+
+	int ret = lstp_i2c_validate_msg(msg);
+
+	if (ret) {
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: Invalid message to addr=0x%02x (%pe)\n",
+				    __func__, ch->ch_id, msg->addr, ERR_PTR(ret));
+		return ret;
+	}
+
+	if (msg->len > ch->max_rx_payload) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Read request message to addr=0x%02x too long (%u bytes, max %zu)\n",
+				    __func__, ch->ch_id, msg->addr, msg->len, ch->max_rx_payload);
+		return -EINVAL;
+	}
+
+	dev_dbg(ch->dev, "%s: ch_%d: addr=0x%02x, len=%d\n", __func__, ch->ch_id, msg->addr,
+		msg->len);
+
+	if (no_stop)
+		cmd |= LSTP_I2C_CMD_FLAG_NO_STOP;
+
+	ret = lstp_request(ch, cmd, &req, sizeof(req), msg->buf, msg->len, NULL, &lstp_status);
+	if (ret && !lstp_i2c_suppress_error_logs(ret, lstp_status))
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: READ to addr=0x%02x failed (%pe)\n",
+				    __func__, ch->ch_id, msg->addr, ERR_PTR(ret));
+	if (ret && lstp_i2c_can_retry(lstp_status))
+		return -EAGAIN;
+	return ret;
+}
+
+/* One WRITE transaction; @no_stop omits STOP so a further message can follow. */
+static int lstp_i2c_write(struct i2c_adapter *adap, struct i2c_msg *msg, bool no_stop)
+{
+	u8 cmd = LSTP_I2C_CMD_WRITE;
+	struct lstp_channel *ch = adap->algo_data;
+	struct lstp_i2c_write_req req_head = { .addr = msg->addr };
+	struct kvec vecs[2] = {
+		{ .iov_base = &req_head, .iov_len = sizeof(req_head) },
+		{ .iov_base = msg->buf, .iov_len = msg->len },
+	};
+	int lstp_status = LSTP_NO_RESPONSE_STATUS;
+
+	int ret = lstp_i2c_validate_msg(msg);
+
+	if (ret) {
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: Invalid message to addr=0x%02x (%pe)\n",
+				    __func__, ch->ch_id, msg->addr, ERR_PTR(ret));
+		return ret;
+	}
+
+	if (sizeof(req_head) + msg->len > ch->max_tx_payload) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Write message to addr=0x%02x too long (%u bytes, max %zu)\n",
+				    __func__, ch->ch_id, msg->addr, msg->len,
+				    ch->max_tx_payload - sizeof(req_head));
+		return -EINVAL;
+	}
+
+	if (msg->len > 0)
+		dev_dbg(ch->dev, "%s: ch_%d: addr=0x%02x, len=%d, data=0x%*ph\n", __func__,
+			ch->ch_id, msg->addr, msg->len, msg->len, msg->buf);
+	else
+		dev_dbg(ch->dev, "%s: ch_%d: addr=0x%02x, len=%d\n", __func__, ch->ch_id, msg->addr,
+			msg->len);
+
+	if (no_stop)
+		cmd |= LSTP_I2C_CMD_FLAG_NO_STOP;
+
+	ret = lstp_requestv(ch, cmd, vecs, ARRAY_SIZE(vecs), NULL, 0, NULL, &lstp_status);
+	if (ret && !lstp_i2c_suppress_error_logs(ret, lstp_status))
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: WRITE to addr=0x%02x failed (%pe)\n",
+				    __func__, ch->ch_id, msg->addr, ERR_PTR(ret));
+	if (ret && lstp_i2c_can_retry(lstp_status))
+		return -EAGAIN;
+	return ret;
+}
+
+/* Write then read at one address, separated by a repeated START, as a single request. */
+static int lstp_i2c_write_read(struct i2c_adapter *adap, struct i2c_msg *wr_msg,
+			       struct i2c_msg *rd_msg, bool no_stop)
+{
+	u8 cmd = LSTP_I2C_CMD_WRITE_READ;
+	struct lstp_channel *ch = adap->algo_data;
+	struct lstp_i2c_wr_rd_req req_head = {
+		.addr = wr_msg->addr,
+		.rd_len = cpu_to_le16(rd_msg->len),
+	};
+	struct kvec vecs[2] = {
+		{ .iov_base = &req_head, .iov_len = sizeof(req_head) },
+		{ .iov_base = wr_msg->buf, .iov_len = wr_msg->len },
+	};
+	int lstp_status = LSTP_NO_RESPONSE_STATUS;
+
+	int ret = lstp_i2c_validate_msg(wr_msg);
+
+	if (ret) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Invalid write message to addr=0x%02x (%pe)\n",
+				    __func__, ch->ch_id, wr_msg->addr, ERR_PTR(ret));
+		return ret;
+	}
+
+	if (sizeof(req_head) + wr_msg->len > ch->max_tx_payload) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Write message to addr=0x%02x too long (%u bytes, max %zu)\n",
+				    __func__, ch->ch_id, wr_msg->addr, wr_msg->len,
+				    ch->max_tx_payload - sizeof(req_head));
+		return -EINVAL;
+	}
+
+	ret = lstp_i2c_validate_msg(rd_msg);
+	if (ret) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Invalid read message to addr=0x%02x (%pe)\n",
+				    __func__, ch->ch_id, rd_msg->addr, ERR_PTR(ret));
+		return ret;
+	}
+
+	if (rd_msg->len > ch->max_rx_payload) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Read message to addr=0x%02x too long (%u bytes, max %zu)\n",
+				    __func__, ch->ch_id, rd_msg->addr, rd_msg->len,
+				    ch->max_rx_payload);
+		return -EINVAL;
+	}
+
+	if (wr_msg->addr != rd_msg->addr) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Write/read addr mismatch (wr=0x%02x, rd=0x%02x)\n",
+				    __func__, ch->ch_id, wr_msg->addr, rd_msg->addr);
+		return -EINVAL;
+	}
+
+	if (no_stop)
+		cmd |= LSTP_I2C_CMD_FLAG_NO_STOP;
+
+	ret = lstp_requestv(ch, cmd, vecs, ARRAY_SIZE(vecs), rd_msg->buf, rd_msg->len, NULL,
+			    &lstp_status);
+	if (ret && !lstp_i2c_suppress_error_logs(ret, lstp_status))
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: WRITE_READ to addr=0x%02x failed (%pe)\n",
+				    __func__, ch->ch_id, wr_msg->addr, ERR_PTR(ret));
+	if (ret && lstp_i2c_can_retry(lstp_status))
+		return -EAGAIN;
+	return ret;
+}
+
+/*
+ * SMBus block read with an optional write phase, which must address the same target.
+ * @rd_msg->len is updated to the bytes received.
+ */
+static int lstp_i2c_smbus_block_read(struct i2c_adapter *adap, struct i2c_msg *wr_msg,
+				     struct i2c_msg *rd_msg, bool no_stop)
+{
+	u8 cmd = LSTP_I2C_CMD_SMBUS_BLOCK_READ;
+	struct lstp_channel *ch = adap->algo_data;
+	DEFINE_RAW_FLEX(struct lstp_i2c_smbus_block_read_req, req, wr_data,
+			LSTP_I2C_SMBUS_BLOCK_READ_WR_MAX);
+	u16 wr_len = wr_msg ? wr_msg->len : 0;
+	u8 *wr_buf = wr_msg ? wr_msg->buf : NULL;
+	bool pec = rd_msg->flags & I2C_CLIENT_PEC;
+	/* The target frames the block with a count byte, plus a trailing PEC byte if asked for. */
+	u8 framing = pec ? 2 : 1;
+	u16 rx_buf_len = I2C_SMBUS_BLOCK_MAX + framing;
+	size_t pkt_len = 0;
+	int lstp_status = LSTP_NO_RESPONSE_STATUS;
+
+	/* Probe enforces bulk_tx_size >= LSTP_USB_EP_MIN_SIZE; anchor the largest write phase. */
+	BUILD_BUG_ON(sizeof(struct lstp_header) +
+			     struct_size(req, wr_data, LSTP_I2C_SMBUS_BLOCK_READ_WR_MAX) >
+		     LSTP_USB_EP_MIN_SIZE);
+
+	int ret = lstp_i2c_validate_msg(rd_msg);
+
+	if (ret) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Invalid read message to addr=0x%02x (%pe)\n",
+				    __func__, ch->ch_id, rd_msg->addr, ERR_PTR(ret));
+		return ret;
+	}
+
+	/*
+	 * An I2C_M_RECV_LEN read reserves rd_msg->len bytes on top of I2C_SMBUS_BLOCK_MAX, so the
+	 * framing has to fit in there for a maximum-size block to still land inside the buffer.
+	 */
+	if (rd_msg->len < framing) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Read from addr=0x%02x reserves %u bytes, needs %u for framing\n",
+				    __func__, ch->ch_id, rd_msg->addr, rd_msg->len, framing);
+		return -EINVAL;
+	}
+
+	if (wr_msg) {
+		ret = lstp_i2c_validate_msg(wr_msg);
+		if (ret) {
+			dev_err_ratelimited(ch->dev,
+					    "%s: ch_%d: Invalid write message to addr=0x%02x (%pe)\n",
+					    __func__, ch->ch_id, wr_msg->addr, ERR_PTR(ret));
+			return ret;
+		}
+
+		if (wr_msg->addr != rd_msg->addr) {
+			dev_err_ratelimited(ch->dev,
+					    "%s: ch_%d: Write/read addr mismatch (wr=0x%02x, rd=0x%02x)\n",
+					    __func__, ch->ch_id, wr_msg->addr, rd_msg->addr);
+			return -EINVAL;
+		}
+	}
+
+	if (wr_len > LSTP_I2C_SMBUS_BLOCK_READ_WR_MAX) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: SMBus write phase to addr=0x%02x too long (%u bytes, max %u)\n",
+				    __func__, ch->ch_id, rd_msg->addr, wr_len,
+				    LSTP_I2C_SMBUS_BLOCK_READ_WR_MAX);
+		return -EINVAL;
+	}
+
+	if (rx_buf_len > ch->max_rx_payload) {
+		dev_err_ratelimited(ch->dev,
+				    "%s: ch_%d: Read message to addr=0x%02x too long (%u bytes, max %zu)\n",
+				    __func__, ch->ch_id, rd_msg->addr, rx_buf_len,
+				    ch->max_rx_payload);
+		return -EINVAL;
+	}
+
+	*req = (struct lstp_i2c_smbus_block_read_req){
+		.addr = rd_msg->addr,
+		.flags = cpu_to_le16(pec ? LSTP_I2C_SMBUS_BLOCK_READ_FLAG_PEC : 0),
+	};
+	if (wr_len)
+		memcpy(req->wr_data, wr_buf, wr_len);
+
+	if (no_stop)
+		cmd |= LSTP_I2C_CMD_FLAG_NO_STOP;
+
+	ret = lstp_request(ch, cmd, req, struct_size(req, wr_data, wr_len), rd_msg->buf, rx_buf_len,
+			   &pkt_len, &lstp_status);
+	if (ret) {
+		if (!lstp_i2c_suppress_error_logs(ret, lstp_status))
+			dev_err_ratelimited(ch->dev,
+					    "%s: ch_%d: SMBUS_BLOCK_READ to addr=0x%02x failed (%pe)\n",
+					    __func__, ch->ch_id, rd_msg->addr, ERR_PTR(ret));
+		if (lstp_i2c_can_retry(lstp_status))
+			return -EAGAIN;
+		return ret;
+	}
+
+	if (pkt_len == 0) {
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: Empty response packet\n", __func__,
+				    ch->ch_id);
+		return -EIO;
+	}
+
+	u8 block_len = rd_msg->buf[0];
+
+	if (block_len > I2C_SMBUS_BLOCK_MAX) {
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: Invalid block length %u\n", __func__,
+				    ch->ch_id, block_len);
+		return -EPROTO;
+	}
+
+	u16 rx_len = block_len + framing;
+
+	if (pkt_len < rx_len) {
+		dev_err_ratelimited(ch->dev, "%s: ch_%d: Invalid response length (%zu)\n", __func__,
+				    ch->ch_id, pkt_len);
+		return -EIO;
+	}
+
+	rd_msg->len = rx_len;
+	return 0;
+}
+
+static bool lstp_i2c_is_combined_pair(const struct i2c_msg *wr_msg, const struct i2c_msg *rd_msg)
+{
+	return !(wr_msg->flags & I2C_M_RD) && (rd_msg->flags & I2C_M_RD) &&
+	       wr_msg->addr == rd_msg->addr;
+}
+
+/*
+ * i2c_algorithm.xfer: one device request per message, except a write/read pair to the same
+ * target, which folds into one combined request. Every request but the last omits STOP, so
+ * the whole message array stays a single bus transaction.
+ */
+static int lstp_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct lstp_channel *ch = adap->algo_data;
+
+	if (!msgs || num <= 0)
+		return -EINVAL;
+
+	dev_dbg(ch->dev, "%s: ch_%d: I2C transfer with %d message(s)\n", __func__, ch->ch_id, num);
+
+	for (int i = 0; i < num; i++) {
+		struct i2c_msg *wr_msg = NULL;
+		struct i2c_msg *msg = &msgs[i];
+
+		if (i + 1 < num && lstp_i2c_is_combined_pair(msg, &msgs[i + 1])) {
+			wr_msg = msg;
+			msg = &msgs[++i];
+		}
+
+		bool recv_len = msg->flags & I2C_M_RECV_LEN;
+		bool read = msg->flags & I2C_M_RD;
+		bool no_stop = i != num - 1;
+		int ret;
+
+		if (!read)
+			ret = lstp_i2c_write(adap, msg, no_stop);
+		else if (read && recv_len)
+			ret = lstp_i2c_smbus_block_read(adap, wr_msg, msg, no_stop);
+		else if (read && !recv_len && wr_msg)
+			ret = lstp_i2c_write_read(adap, wr_msg, msg, no_stop);
+		else
+			ret = lstp_i2c_read(adap, msg, no_stop);
+
+		if (ret)
+			return ret;
+	}
+
+	return num;
+}
+
+static u32 lstp_i2c_functionality(struct i2c_adapter *adap)
+{
+	/* TODO: This needs to be discoverable, also need separate commands for 10-bit address */
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL_ALL;
+}
+
+static struct i2c_bus_recovery_info lstp_i2c_recovery_info = {
+	.recover_bus = lstp_i2c_bus_recovery,
+};
+
+static const struct i2c_algorithm lstp_i2c_algorithm = {
+	.xfer = lstp_i2c_xfer,
+	.functionality = lstp_i2c_functionality,
+};
+
+#define LSTP_I2C_DEFAULT_RETRIES 3
+
+/*
+ * The I2C core re-issues only an -EAGAIN transfer and bounds the whole retry loop, not each
+ * attempt, by adap->timeout, so the timeout spans every attempt. A device reporting
+ * bus_arbitration_retries retries LSTP_BUSY and LSTP_ARB_LOST itself, so the host does not
+ * and ignores "nvidia,retries". @adap's firmware node must already be set.
+ */
+static void lstp_i2c_configure_retry_policy(struct lstp_channel *ch, struct i2c_adapter *adap,
+					    const struct lstp_i2c_config *cfg)
+{
+	u32 retries = LSTP_I2C_DEFAULT_RETRIES;
+	u32 configured_retries;
+	bool have_configured;
+
+	have_configured =
+		!device_property_read_u32(&adap->dev, "nvidia,retries", &configured_retries);
+
+	if (cfg->bus_arbitration_retries) {
+		if (have_configured && configured_retries)
+			dev_warn(ch->dev,
+				 "%s: ch_%d: Ignoring retries=%u; device retries the bus %u time(s) itself\n",
+				 __func__, ch->ch_id, configured_retries,
+				 cfg->bus_arbitration_retries);
+		retries = 0;
+	} else if (have_configured) {
+		if (configured_retries <= U8_MAX)
+			retries = configured_retries;
+		else
+			dev_warn(ch->dev, "%s: ch_%d: Ignoring retries value %u; maximum is %u\n",
+				 __func__, ch->ch_id, configured_retries, U8_MAX);
+	}
+
+	adap->retries = retries;
+	adap->timeout = msecs_to_jiffies((retries + 1) * LSTP_USB_RESPONSE_TIMEOUT_MS);
+}
+
+/* The I2C core takes the bus number from an "i2c" alias on adap->dev's firmware node. */
+static int lstp_i2c_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
+{
+	struct lstp_channel *ch = lstp_channel_from_auxdev(auxdev);
+	const struct lstp_channel_init_info *info = dev_get_platdata(&auxdev->dev);
+
+	if (!info)
+		return -ENODEV;
+
+	if (info->config_len < LSTP_I2C_CONFIG_MIN_LEN) {
+		dev_err(ch->dev, "%s: ch_%d: I2C config too short: %zu < %zu\n", __func__,
+			ch->ch_id, info->config_len, LSTP_I2C_CONFIG_MIN_LEN);
+		return -EINVAL;
+	}
+
+	/* Full-size copy, so field reads need no length checks: unreported fields read as zero. */
+	struct lstp_i2c_config cfg;
+
+	memcpy_and_pad(&cfg, sizeof(cfg), info->config, info->config_len, 0);
+
+	struct i2c_adapter *adap = devm_kzalloc(ch->dev, sizeof(*adap), GFP_KERNEL);
+
+	if (!adap)
+		return -ENOMEM;
+
+	adap->owner = THIS_MODULE;
+	adap->class = I2C_CLASS_HWMON;
+	adap->algo = &lstp_i2c_algorithm;
+	adap->algo_data = ch;
+	adap->dev.parent = ch->dev;
+	adap->bus_recovery_info = &lstp_i2c_recovery_info;
+	device_set_node(&adap->dev, ch->fwnode);
+	lstp_i2c_configure_retry_policy(ch, adap, &cfg);
+	strscpy(adap->name, ch->display_name, sizeof(adap->name));
+	/* TODO: save i2c speed from config */
+
+	int ret = devm_i2c_add_adapter(ch->dev, adap);
+
+	if (ret) {
+		dev_err(ch->dev, "%s: ch_%d: Could not register I2C adapter (%pe)\n", __func__,
+			ch->ch_id, ERR_PTR(ret));
+		return ret;
+	}
+
+	dev_info(ch->dev, "%s: ch_%d: Started as %s\n", __func__, ch->ch_id, adap->name);
+	return 0;
+}
+
+static const struct auxiliary_device_id lstp_i2c_id_table[] = { { .name = "lstp.i2c" }, {} };
+MODULE_DEVICE_TABLE(auxiliary, lstp_i2c_id_table);
+
+static struct lstp_auxiliary_driver lstp_i2c_drv = {
+	.adrv = {
+		.name = "i2c",
+		.probe = lstp_i2c_probe,
+		.id_table = lstp_i2c_id_table,
+	},
+};
+module_lstp_auxiliary_driver(lstp_i2c_drv);
+
+MODULE_IMPORT_NS("LSTP");
+MODULE_DESCRIPTION("LSTP I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

