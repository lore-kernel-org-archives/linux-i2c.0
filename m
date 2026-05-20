Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39323DB301
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278234; cv=fail; b=PM6JIQRkKKnE68TZfoGa3e6IitJ0tjrnBsNEUqx6wRopdEOB2ml7UC//4DlM45uYwveGVi03dUqrW9/RXMofoQQetnz2lTAdZRxsH3nFi05sgRLTvO2mBaCRsmpkZ4hiOc+GzdQ6tmJlGKy7sHOuBa8/zSWbszihl+2EY8WeUKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278234; c=relaxed/simple;
	bh=55EJjFbk4FSlqHZdJxIsHVmC0mp/YPDZRxknIJpNUi4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=baoZjjwhVckr53SnTp+W4fPRik6AJVSjU9Z6pJqWKwgKvSsLPLm+on6s30NQz+g3klcYTtJqOzqEXxcW3c7AVHRcSl3uLSVDynfPf5qPI/+BjAiyqGmlwWePN9iO2V3wgINHby32WemmsMkgHoGbJlJF6/NPq9Gh4n6S3O+UXv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGQ3mJJm; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGQ3mJJm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc3nyBsWMG3S3Dza1doSdJGKCgUKojF2KCEzoieopp5+flhhMkTx7Vi4mZAVZesXTzKMwokVmQsd8BxFlyeKmNXkKXW09UoI6r0/5Mr1ZWIhCzRHQ+P5rdSk7iIQCPdZKukLbf2H6scVtLeQ5U+janIvCMpoRYnAMdweW3Ay/rBPrUI0IRyyk3ygdmjqPzfU7sTHo+FGfUk7eRBRwYx8LHP7f5bKDZf/sT3T0Syql4OGKMoIUIzpEXx7bQ4c4zeiXkLqPshtCoQ5bhzykxLb+vKlYhvix+mzzjnl/vE3ueRe9hxCINVwt+Z1EFY/xCEZ9Pwe8dCJxwQfiNzixsGLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TMg/IgJynGfaSW4Ig3OYubG/2GtPiDKUEJeVNw48tM=;
 b=AmICGz/3YVqayAZzZd6N46wbPJm5jM3XGSnWTZU4Y2L0J5p8nvg1T4sXExICwzMxSA4q21uiR3hvCWUYu+RsyNz9m/d5AJVEmsJOn8d84NCUiIo372JN3beedK3BNNo/Q5ghyy58KcP9jAtlOT2CVr/yeCbEnzgLie2Ly0dn+QKlzct/R33osorKZSXpakJ3EpX4FLd8EkB0J2neFmk/IJdtCjJSX60C2k2zpXE/p2HGXL7oRH2iamz2JqjYgZG7GaAU1Ryod6OFcWnG4RbdkDWhlJJSFPgryT7SWhZPCrQnEKPFopsB8KeXZU/AS+bU29N4FSHUSJ9kl2+SGzsYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lysator.liu.se smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TMg/IgJynGfaSW4Ig3OYubG/2GtPiDKUEJeVNw48tM=;
 b=uGQ3mJJm5OhctJ6bTdjw8OfIUPEgu7hgjudFhpmTONNK7xljY4GOZoKEd3wGWgOJr8MLbju1pWoTrB0AQx87B0xaq2itMn1OpNAPS7+6IaMga/9ovEQZR716XhVqpXb5nr0988uWBFmXER0o5n4nQzUrV7emBfmbxwVpo5FQ5p19KOSP2FmBj/JHt2qlBGEsnboGDrn7BPkEWJhB4foEPoSn8MPkmBfPFlMhD8nlMK2YST8fm66mGPUN8N+RLy8r5OqzxhH3eYt+RvFNMspAPy90cQTxRhq0GXG4GvYFCgBodzYF+0Vz+maF63GDXYR1SvtJPogdHCplqRAmxEMwfw==
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 11:57:04 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::14) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 20
 May 2026 11:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 11:57:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 04:56:40 -0700
Received: from r-build-bsp-06.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 04:56:38 -0700
From: Vadim Pasternak <vadimp@nvidia.com>
To: <peda@lysator.liu.se>
CC: <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, Vadim Pasternak
	<vadimp@nvidia.com>
Subject: [PATCH i2c-mux next v2 1/1] i2c: mux: Add register map based mux driver
Date: Wed, 20 May 2026 14:56:22 +0300
Message-ID: <20260520115622.2540593-1-vadimp@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba25899-b297-4fac-f997-08deb666e84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|13003099007|3023799007|5023799004|56012099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	QMKaSQ+Mlm8J6r4n9udASvEP+5q9K1MsYQSF1mxDxSqUNZ+rVLJw8UvFjNVGfL6U53yUFUh/bSFub87MzdfQX+6kHXFfQLoyMTSWdJ5vByqdMOPRTRJntWhGj2P7hVtDLEntGo6kA36GuGP6Gu4oBVZjR0fC+Q4P8u4lIATgEew291MkyN+HsZfKaMMC+pmlpLxQFawHb+CygqvPOVnMcRwyfgS4HMwvz1Q9uweJSs3LP/Xnkxb9sM7LtLaEsZzzNoSB9AAdIQ0qFqwUroVvbEXt+9oPURQbLnHy0axHdkRRP6OAZdmqd/s+0dWkXu3aDMmhHEP50RbsXiH6yuVbkawf3ET1/anTOFpUkIkYsxZAGjHfOv6b+C58LtLFvn/1hDxGuWPZWrZJVCC72qthlBN50miQU/XLMoPRUZiGEW+QiMReX7Rocbo/mfIJVvv7fgeCkvE4/r5qzxMIObHWrJRSfdW+Fv3N1puQOI8Tjfhf/F7yhpzl4WOgt8as6rGGdDZK2OFHBtNZO4gNtRTacArzw7XgwUWWidYE3nW8k4OGD0BB3xDJy7Ep/q+8ZDnUOXFiQFEavUAVKvcLPswNqp5WCEi9qtIFw+ZRO8NknDZBL1xe2Frplf7SJcnITomEFfpGmmqDHIJxwq28bGg+xgfBy/TlpU74dMfVJQGVzPjysySy+SLFhvAfjz1+UC3GYIRcykcZNFzEtlCqXcaSU8vNtgw9X/cuxbI8ijgF8x0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(3023799007)(5023799004)(56012099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0uQNquUKfbhE1+UqqkdbvO5PEP4lbVzsauZ/GpgQWZIAz+d+vdJg6gf9ftk7WYl4Ghg+G977nHHyQ/XelvHzwIxQ+9llK9B6J0AL2M8bEqmQImETl8IyWgiYImLkxdi9KjJE+HF42iRhGBwxKXzVJ6Sar9Yyf0aRSWUALtO633M6J7y7rkx+6NngtQ3HdqcrOFAId67a27uvR/K42lA/GXluM27G9aMUx4ILi1K0VelexbiQGaylMtRGfYgk721Elr+Wm+N/8fva2eU9QtGwFDK3wFJN4DHdd9V3/PYc+2n7A92jENTLtQrt/4kDaKeo0DJc5sALhVzoWHolmY+hrk+WNOovxFaijpHNoRkyilt1n0ugkwxYrKw5jEQIQpglaSETtCyV6eqLdyUstD10PTRTU87A8OjjoeHNb24fVtLmxhyYRiMJUZImjaYYrRIR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 11:57:03.3220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba25899-b297-4fac-f997-08deb666e84e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960

Add 'regmap' mux driver to allow virtual bus switching by setting a
single selector register.
The 'regmap' is supposed to be passed to driver within a platform data
by parent platform driver.

Unlike i2c-mux-reg, this driver relies on regmap abstraction
instead of direct MMIO access, allowing the mux selector register
to be accessed through arbitrary transport mechanisms supported
by regmap callbacks, including indirect PCIe-to-SPI and PCIe-to-LPC
transactions.

The regmap instance is expected to be provided through platform data
by the parent platform driver.

Motivation is to support mux selector registers accessed indirectly
through transport-specific protocols.

For example, an FPGA connected through PCIe may expose SPI or LPC
bridges used to access downstream CPLDs or secondary FPGAs located on
another board. In such configurations the mux selector register is not
directly memory-mapped and access is performed through regmap
reg_read()/reg_write() callbacks implementing the required indirect
transaction protocol.

Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605201604.3O39wIat-lkp@intel.com/
---
v2:
- Initialize mux to NULL to avoid uninitialized warning reported by
  kernel test robot.

Note:
Originally proposed in 2023:
https://patchwork.ozlabs.org/project/linux-i2c/patch/20230823155332.48648-2-vadimp@nvidia.com/
Reworked against current upstream.
---
 drivers/i2c/muxes/Kconfig                    |  12 ++
 drivers/i2c/muxes/Makefile                   |   1 +
 drivers/i2c/muxes/i2c-mux-regmap.c           | 150 +++++++++++++++++++
 include/linux/platform_data/i2c-mux-regmap.h |  37 +++++
 4 files changed, 200 insertions(+)
 create mode 100644 drivers/i2c/muxes/i2c-mux-regmap.c
 create mode 100644 include/linux/platform_data/i2c-mux-regmap.h

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 6d2f66810cdc..9b5e5258917a 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -99,6 +99,18 @@ config I2C_MUX_REG
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-reg.
 
+config I2C_MUX_REGMAP
+	tristate "Register map based I2C multiplexer"
+	depends on REGMAP
+	help
+	  If you say yes to this option, support will be included for a
+	  register map based I2C multiplexer. This driver provides access to
+	  I2C busses connected through a MUX, which is controlled
+	  by a single register through the regmap.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-mux-regmap.
+
 config I2C_DEMUX_PINCTRL
 	tristate "pinctrl-based I2C demultiplexer"
 	depends on PINCTRL && OF
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 4b24f49515a7..edecfc593df7 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -15,5 +15,6 @@ obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
 obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
 obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
+obj-$(CONFIG_I2C_MUX_REGMAP)	+= i2c-mux-regmap.o
 
 ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
diff --git a/drivers/i2c/muxes/i2c-mux-regmap.c b/drivers/i2c/muxes/i2c-mux-regmap.c
new file mode 100644
index 000000000000..cbb198e44c2b
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-mux-regmap.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Regmap i2c mux driver
+ *
+ * Copyright (C) 2026 Nvidia Technologies Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_data/i2c-mux-regmap.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/* i2c_mux_regmap - mux control structure:
+ * @last_val - last selected register value or -1 if mux deselected;
+ * @pdata: platform data;
+ */
+struct i2c_mux_regmap {
+	int last_val;
+	struct i2c_mux_regmap_platform_data pdata;
+};
+
+static int i2c_mux_regmap_select_chan(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct i2c_mux_regmap *mux = i2c_mux_priv(muxc);
+	int err = 0;
+
+	/* Only select the channel if its different from the last channel */
+	if (mux->last_val != chan) {
+		err = regmap_write(mux->pdata.regmap, mux->pdata.sel_reg_addr, chan);
+		mux->last_val = err < 0 ? -1 : chan;
+	}
+
+	return err;
+}
+
+static int i2c_mux_regmap_deselect(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct i2c_mux_regmap *mux = i2c_mux_priv(muxc);
+
+	/* Deselect active channel */
+	mux->last_val = -1;
+
+	return regmap_write(mux->pdata.regmap, mux->pdata.sel_reg_addr, 0);
+}
+
+static void i2c_mux_regmap_notify_probe_abandon(struct platform_device *pdev,
+						struct i2c_mux_regmap *mux,
+						struct i2c_mux_core *muxc,
+						struct i2c_adapter *parent,
+						int err, bool user_notify_called)
+{
+	const struct i2c_mux_regmap_platform_data *pd;
+
+	if (user_notify_called || err == -EPROBE_DEFER)
+		return;
+	pd = mux ? &mux->pdata : dev_get_platdata(&pdev->dev);
+	if (!pd || !pd->completion_notify || !pd->handle)
+		return;
+	pd->completion_notify(pd->handle, muxc ? muxc->parent : parent, NULL);
+}
+
+/* Probe/remove functions */
+static int i2c_mux_regmap_probe(struct platform_device *pdev)
+{
+	struct i2c_mux_regmap_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct i2c_mux_regmap *mux = NULL;
+	struct i2c_adapter *parent;
+	struct i2c_mux_core *muxc = NULL;
+	bool user_notify_called = false;
+	int num, ret;
+
+	if (!pdata)
+		return -EINVAL;
+
+	parent = i2c_get_adapter(pdata->parent);
+	if (!parent)
+		return -EPROBE_DEFER;
+
+	muxc = i2c_mux_alloc(parent, &pdev->dev, pdata->num_adaps, sizeof(*mux), 0,
+			     i2c_mux_regmap_select_chan, i2c_mux_regmap_deselect);
+	if (!muxc) {
+		ret = -ENOMEM;
+		goto err_put_parent;
+	}
+
+	mux = i2c_mux_priv(muxc);
+	memcpy(&mux->pdata, pdata, sizeof(*pdata));
+	platform_set_drvdata(pdev, muxc);
+	mux->last_val = -1; /* force the first selection */
+
+	/* Create an adapter for each channel. */
+	for (num = 0; num < pdata->num_adaps; num++) {
+		ret = i2c_mux_add_adapter(muxc, 0, pdata->chan_ids[num]);
+		if (ret)
+			goto err_i2c_mux_add_adapter;
+	}
+
+	/* Notify caller when all channels' adapters are created. */
+	if (pdata->completion_notify) {
+		ret = pdata->completion_notify(pdata->handle, muxc->parent,
+					       muxc->adapter);
+		user_notify_called = true;
+		if (ret)
+			goto err_i2c_mux_add_adapter;
+	}
+
+	return 0;
+
+err_i2c_mux_add_adapter:
+	i2c_mux_regmap_notify_probe_abandon(pdev, mux, muxc, parent, ret,
+					    user_notify_called);
+	i2c_mux_del_adapters(muxc);
+	goto put_parent;
+err_put_parent:
+	i2c_mux_regmap_notify_probe_abandon(pdev, mux, muxc, parent, ret,
+					    user_notify_called);
+put_parent:
+	i2c_put_adapter(parent);
+
+	return ret;
+}
+
+static void i2c_mux_regmap_remove(struct platform_device *pdev)
+{
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+
+	i2c_mux_del_adapters(muxc);
+	i2c_put_adapter(muxc->parent);
+}
+
+static struct platform_driver i2c_mux_regmap_driver = {
+	.driver = {
+		.name = "i2c-mux-regmap",
+	},
+	.probe = i2c_mux_regmap_probe,
+	.remove = i2c_mux_regmap_remove,
+};
+
+module_platform_driver(i2c_mux_regmap_driver);
+
+MODULE_AUTHOR("Vadim Pasternak (vadimp@nvidia.com)");
+MODULE_DESCRIPTION("Regmap I2C multiplexer driver");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:i2c-mux-regmap");
diff --git a/include/linux/platform_data/i2c-mux-regmap.h b/include/linux/platform_data/i2c-mux-regmap.h
new file mode 100644
index 000000000000..0015d5a905d9
--- /dev/null
+++ b/include/linux/platform_data/i2c-mux-regmap.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Regmap i2c mux driver
+ *
+ * Copyright (C) 2026 Nvidia Technologies Ltd.
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_I2C_MUX_REGMAP_H
+#define __LINUX_PLATFORM_DATA_I2C_MUX_REGMAP_H
+
+/**
+ * struct i2c_mux_regmap_platform_data - Platform-dependent data for i2c-mux-regmap
+ * @regmap: register map of parent device;
+ * @parent: Parent I2C bus adapter number
+ * @chan_ids: channels array
+ * @num_adaps: number of adapters
+ * @sel_reg_addr: mux select register offset in CPLD/FPGA space
+ * @handle: handle to be passed by callback
+ * @completion_notify: callback invoked after all child adapters are
+ *	created. May also be invoked once with @adapters set to NULL if
+ *	probe fails after parent adapter acquisition, so waiters can
+ *	unblock.
+ *	The adapters array is owned by mux core, remains valid until mux
+ *	removal, and contains @num_adaps entries.
+ */
+struct i2c_mux_regmap_platform_data {
+	struct regmap *regmap;
+	int parent;
+	const unsigned int *chan_ids;
+	int num_adaps;
+	int sel_reg_addr;
+	void *handle;
+	int (*completion_notify)(void *handle, struct i2c_adapter *parent,
+				 struct i2c_adapter *adapters[]);
+};
+
+#endif	/* __LINUX_PLATFORM_DATA_I2C_MUX_REGMAP_H */
-- 
2.34.1

