Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DF352008
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212644; cv=fail; b=nZ42UfaYA32CLqWgKyQ80cQx5GQ5rJnVytXPLnyycvht2IPSsxnyxCB9JvPFBi3bt7aSz/cJMCbwfWkqHjXDCA7fdokz8oGSRUvUhOeEPsaMRSkY4EzKTeYDieXihD0aGoelIqSLl6dS6vIseVHzNV4+9C9mgjam8Vq7W9B035o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212644; c=relaxed/simple;
	bh=aqq/iIQHZVkhqyZZLe7dwuSZBakcIFVdpP1OCNeIOi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YS7eLJXz1zUOw9NzvS0IkyzlA+mAH1xgUtYM4auwEkrD/z9z10aN01x0ysPx4eAgfSBK/W0beqrViYkGY8oLJlIa47aT4lS81vas6DolSocmo8eFT3mwg/MtNY/srB1Dpo49OXOXkdQ7RbXQwl+n/wdZ3u4d0Mcf3HVPgBMZD+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mvOUYzYP; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvOUYzYP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoDPrCnoLGBMA5a9GCJ3dxqq8rpR7Mi/lsm+pP7UyEqyX8yREmlc7yBpEWSeX1mMDAvaLsOCBKe0Z/qMqKrOsx6gC9qlBj7Va3xH0Qg3ucy4NOtlpXZHHDh8JPtqdQZ0uaykTjzbwPE4pnVuR3bL2pdeZcuctTRKeQ4e3UoCR6TXDna5HKnge76mjYsQ3kFO6n9KwDSsc5OSfBAvVBfJIYPISfHpVC1WGslgRO2jx8wAYK3GXBWEbLnnRtFbzVBoKibAlzJr03He8GW1nPdutei49F4M0XUp7HyvK95zcLQ0zTSQZi8538Km67KXDY18Vuc5rQ51rTEI7Cpu6LBlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvgUerGc+hn3fDC/B7WfEVypQQQn1i/6qR7Iiss2dDc=;
 b=k6DsVqVWh2KqpL3h2xyaav9g4I7i8PlU2vD9Izq3F2X6Kwz9bhqOfG8nhqi99HXbmH/2312H+Q7MOGoZusgMItKac5UuuuphPuc461wvp0/9ciC+SexBc0ACx9LsnBCNkjdjteZYmlQ0egBnlo4SLdw8LFN6HUe3xKSKpaAkVdjhjdiTtdvW84Z6tjMZZA7rR8lnGWxB+x8A2dWxkJIe9lNeVzgkzwPEIVIZws0DZFBPTPTKaTTAJGRgZeWCC8Pk0aXRyta9PrFdCxL9t3LBstUnW6yCCFTAtdumGVh6wUgoawJP35i/o8TqC7x20KN+YQ3ks22ddUMhehCxHiEetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lysator.liu.se smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvgUerGc+hn3fDC/B7WfEVypQQQn1i/6qR7Iiss2dDc=;
 b=mvOUYzYPiYbnc1JRce3OeHVXq8VdbLw0O7qlACqAzVDBqheRjt9mF/S4pYMZ6qxRcwImXsVYLJjs0IUCPgBPsVnHJOecQtu87jc4fhYxDOFMWAwXHSpFEi+FZossoKKLPepqZa9nJRybpabWKh3AoiZ4qdB8JqZ38t3e9b8KEwis5HeBChr3/YmInmyIkJZn2mgO4GAOs8FPT43gUYFZO8hj910RddhgxRb0bgTDtyXUhIxxpaDsAXgFbw7dw7WMPdxoaHQ58VAtvQV4azvq4ApMTh5h3/IQL5LeEyKGnkSXL6pZ4I+OyydnyPLlkeKhZ9OqbBNwUAiodwXg3jsh5g==
Received: from DS7PR05CA0045.namprd05.prod.outlook.com (2603:10b6:8:2f::7) by
 IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 19 May
 2026 17:43:53 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::6) by DS7PR05CA0045.outlook.office365.com
 (2603:10b6:8:2f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 17:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 17:43:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 10:43:32 -0700
Received: from r-build-bsp-06.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 10:43:30 -0700
From: Vadim Pasternak <vadimp@nvidia.com>
To: <peda@lysator.liu.se>
CC: <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, Vadim Pasternak
	<vadimp@nvidia.com>
Subject: [PATCH i2c-mux next 1/1] i2c: mux: Add register map based mux driver
Date: Tue, 19 May 2026 20:43:10 +0300
Message-ID: <20260519174310.1128423-1-vadimp@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8c88d3-edf0-4b8b-95a1-08deb5ce3116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|13003099007|5023799004|3023799007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	23u3ucbyZYMyYpsI1o6CmWlcFpA3YixupBypnUnUDQbv/27S/IXIoNV95wi6XlsadjHdnwJNLvOcMGWa2PgvTade+psRRl8N3sQLOUDozleHzfzqMUIFF6CUnas9cgeS81/GiYfC+OOH6doyZ1I4WHiELI0pSx8MYTEPK9GyC2k1XoUx3g7MwVNDtxRqLpImO2xqSjnyv9Mmc2j56zqxfRNmsVzWyATTITdzN26GtYg5EQDoMZw/FLKqqH9ScMXFyDaVGF8dS4xl/hKCPdOSqBXnpFGLldErIzjenk0Ui/AZoib4xPhHgo1y6YAgVt5bwmgVYCQP0tms5HEtnxUX2XH2bY0PV2S3SiD37GTxFk7lWA61dZ9iPAHO6mEwuo1X3xye8f4+yq2IDwVa+FxfgfYM6zdzhgQM+Xl+JWH0cDOcNrJgW+H5UXpygweuL9mYLZVwSAd0ktwE5CB9v06kbKTvVvQbzX8iFttsHMF70g2u8hVwPD7ng2jWpI92WO5VFZU7VZQwX9Kvk5h4M5uOQKN2A32CNaKrP2lculQVFh0z8jCJLxHSuY19oRnso6x2voa5KdyEQMoSuWB4GX2jJoNRd+ySSQKr73xz324AzolS8LKhUMvauLV/rn5vUReP+X7yWGRFQY6s2zhekW0FO4gGeBDaUpeJWjdQkBCobpWMHOz60gkbX5ms+1a5sHCV/KGLY46n3jXlhEr9EbK6a5GREdpmM7kFiw8IbUcifKs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(13003099007)(5023799004)(3023799007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GRXwiMu87ULnnJ7behxKXBId30ioKdcyQ8S1HqqVeETAimPvzlYMG8k7OREN7ol+hlshHpi+N+GG8eQuzZmrv9xFhHZZhIdDKgJnDsmJC7UcGeCO6nddUrnK5EzKNlEwYdQ/Wxujd73KSHIIylKjtM6QDH8H5PVglsW4qWB09iLtgpgJttoHtBlbf6XRxMbJHZWdwIZG2maACPe96lU/+sSYhS31WEy+fo9fXdkXEptjgCB4x7XVpvpwMPI5s+KwoTfVklxCl7in2/UFqrYoXM8IWLhNYj458Q/pOPFh0kVKqBeqkI4fjxEOhRMDXRp8TjlRhG7kTZ7g+txIEnS9NTL60SPXEacygt3D4WB9BydPhZultqCo608XjXegdxqbaLiQDprmzux2FYKNRDX8xkOr01Q+aoGJvvW8EEOl1ntW7Gp1C9pmIlu1pzn3HO+t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:43:52.3119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8c88d3-edf0-4b8b-95a1-08deb5ce3116
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

Add 'regmap' mux driver to allow virtual bus switching by setting a
single selector register.
The 'regmap' is supposed to be passed to driver within a platform data
by parent platform driver.

Unlike i2c-mux-reg, this driver relies on regmap abstraction
instead of direct MMIO access, allowing the mux selector register
to be accessed through arbitrary transport mechanisms supported
by regmap callbacks, including indirect PCIe-to-SPI and PCIe-to-LPC
transactions.

The register may reside on any bus type or mapped memory, supported by
'regmap' infrastructure.

Motivation is to support mux selector registers accessed indirectly
through transport-specific protocols.

For example, an FPGA connected through PCIe may expose SPI or LPC
bridges used to access downstream CPLDs or secondary FPGAs located on
another board. In such configurations the mux selector register is not
directly memory-mapped and access is performed through regmap
reg_read()/reg_write() callbacks implementing the required indirect
transaction protocol.

Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
---
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
index 000000000000..485f275baeb5
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
+	struct i2c_mux_regmap *mux;
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

