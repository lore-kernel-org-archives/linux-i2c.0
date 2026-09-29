Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12448519DF5;
	Tue, 29 Sep 2026 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684041; cv=none; b=XoaGr5DOWXogPm1Uav2r0E97H6Nj9dnTXwPK96TjScNDIxHHHRS37eOZGHhQBCCcgMpZQR/tOz0Bydg+wazJsjL84IK7jHG4XIFYW8pzQRqjs10TkOM6BoOIW5iKhyj2on7YvcZjwRmEdwQ1ANvPw62oSYmgID53aefZcEZO2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684041; c=relaxed/simple;
	bh=tzRq1nQqVKgeTjL+BXtutkXKsbTpUe1v+8HDD2W8fhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5XROK6YqZhf9pD3lZnKsR3enGPUYmev8Yd0IVO0QMPoznf/FoJnOHzhPBQN04SAiNkgz/aWFaz5tlRba8e8IriD9TSI52i1JmiEa23DeVVinr/Xx/RsEItGM5r0/1xZPlRI4rCGrheejX6JkmbhP2vUIT5RCUuV3PTm57bt1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ly55CIHQ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ly55CIHQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Qf1wifVMGQ5Xxq6Y+9fvB4ciUzALM7HnducbSW/kuhk=;
	b=ly55CIHQUFUz9Gbak4geFzPgWujO81YXMpbEnqI3uyAH6jR/5EhLhjIZW20wt0ewXiuvF8HQt
	T1CueG+fRQCMLOW9/bEaXarWOz034c+pmMF6BeUGBMIGZP79Oe+CCCOaMoejpBAYrLFULZonlrN
	SVgOcZhX7K3bTaOklcvglLI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hvGxK4RT0zpSvD;
	Tue, 29 Sep 2026 20:01:41 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 7819640561;
	Tue, 29 Sep 2026 20:13:50 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 20:13:49 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <linuxarm@huawei.com>, <liudingyuan@h-partners.com>,
	<andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>, <acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>
CC: <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <yubowen8@huawei.com>,
	<ouyiyong1@huawei.com>
Subject: [PATCH v5 2/2] i2c: hisi: Add I2C bus recovery support
Date: Tue, 29 Sep 2026 20:13:48 +0800
Message-ID: <20260929121348.109556-3-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260929121348.109556-1-yubowen8@huawei.com>
References: <20260929121348.109556-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100017.china.huawei.com (7.202.195.215)

When the I2C bus is stuck due to a slave device holding SDA low
(e.g. during an incomplete transfer), the master has no way to recover
the bus through normal operation. Add bus recovery support using the
subctrl register to manually toggle SCL and generate clock pulses to
release the bus.

The recovery is performed via a second register resource (sctrl_base)
that provides direct control over SCL/SDA lines through mux and
output-enable bits. After recovery, the I2C controller is reset through
the ACPI _RST method and reconfigured.

Recovery is only registered when the subctrl resource is provided in
the firmware description, keeping backward compatibility with existing
platforms.

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 drivers/i2c/busses/i2c-hisi.c | 142 ++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/i2c/busses/i2c-hisi.c b/drivers/i2c/busses/i2c-hisi.c
index ba5c9579ae19..5b4e92d23032 100644
--- a/drivers/i2c/busses/i2c-hisi.c
+++ b/drivers/i2c/busses/i2c-hisi.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021 HiSilicon Technologies Co., Ltd.
  */
 
+#include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
@@ -62,6 +63,8 @@
 #define HISI_I2C_INT_CLR		0x0048
 #define HISI_I2C_INT_MASK		0x004C
 #define HISI_I2C_TRANS_STATE		0x0050
+#define   HISI_I2C_TRANS_STATE_SDA_LEVEL	BIT(5)
+#define   HISI_I2C_TRANS_STATE_SCL_LEVEL	BIT(6)
 #define HISI_I2C_TRANS_ERR		0x0054
 #define HISI_I2C_VERSION		0x0058
 
@@ -86,9 +89,26 @@
 #define NSEC_TO_CYCLES(ns, clk_rate_khz) \
 	DIV_ROUND_UP_ULL((clk_rate_khz) * (ns), NSEC_PER_MSEC)
 
+/*
+ * SUBCTRL SC_I2C_CTRL register
+ * Set HISI_I2C_CTRL_DAT_CFG_EN and HISI_I2C_CTRL_SCL_CFG_EN to control
+ * I2C pin behavior by subctrl controller; use HISI_I2C_CTRL_DAT_OE and
+ * HISI_I2C_CTRL_CLK_OE to control input or output; use HISI_I2C_CTRL_SDA_OUT
+ * and HISI_I2C_CTRL_SCL_OUT to control output value.
+ */
+#define HISI_I2C_CTRL_DAT_CFG_EN BIT(5)
+#define HISI_I2C_CTRL_SCL_CFG_EN BIT(4)
+#define HISI_I2C_CTRL_DAT_OE BIT(3)
+#define HISI_I2C_CTRL_CLK_OE BIT(2)
+#define HISI_I2C_CTRL_SDA_OUT BIT(1)
+#define HISI_I2C_CTRL_SCL_OUT BIT(0)
+
+#define HISI_I2C_RECOVERY_REG_SIZE 4
+
 struct hisi_i2c_controller {
 	struct i2c_adapter adapter;
 	void __iomem *iobase;
+	void __iomem *sctrl_addr;
 	struct device *dev;
 	struct clk *clk;
 	int irq;
@@ -108,8 +128,14 @@ struct hisi_i2c_controller {
 	struct i2c_timings t;
 	u32 clk_rate_khz;
 	u32 spk_len;
+
+	/* Bus recovery */
+	struct i2c_bus_recovery_info rinfo;
+	acpi_handle acpi_handle;
 };
 
+static void hisi_i2c_configure_bus(struct hisi_i2c_controller *ctlr);
+
 static void hisi_i2c_enable_int(struct hisi_i2c_controller *ctlr, u32 mask)
 {
 	writel_relaxed(mask, ctlr->iobase + HISI_I2C_INT_MASK);
@@ -151,6 +177,118 @@ static void hisi_i2c_handle_errors(struct hisi_i2c_controller *ctlr)
 	}
 }
 
+static int hisi_i2c_recovery_get_scl(struct i2c_adapter *adap)
+{
+	struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
+	u32 reg = readl(ctlr->iobase + HISI_I2C_TRANS_STATE);
+
+	return !!(reg & HISI_I2C_TRANS_STATE_SCL_LEVEL);
+}
+
+static int hisi_i2c_recovery_get_sda(struct i2c_adapter *adap)
+{
+	struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
+	u32 reg = readl(ctlr->iobase + HISI_I2C_TRANS_STATE);
+
+	return !!(reg & HISI_I2C_TRANS_STATE_SDA_LEVEL);
+}
+
+static void hisi_i2c_recovery_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
+	u32 reg;
+
+	reg = readl(ctlr->sctrl_addr);
+	if (val)
+		reg |= HISI_I2C_CTRL_SCL_OUT;
+	else
+		reg &= ~HISI_I2C_CTRL_SCL_OUT;
+	writel(reg, ctlr->sctrl_addr);
+}
+
+static void hisi_i2c_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
+	u32 reg;
+
+	reg = readl(ctlr->sctrl_addr);
+	reg |= HISI_I2C_CTRL_SCL_CFG_EN | HISI_I2C_CTRL_DAT_CFG_EN |
+		   HISI_I2C_CTRL_CLK_OE | HISI_I2C_CTRL_SCL_OUT;
+	reg &= ~HISI_I2C_CTRL_DAT_OE;
+	writel(reg, ctlr->sctrl_addr);
+}
+
+static void hisi_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct hisi_i2c_controller *ctlr = i2c_get_adapdata(adap);
+	u32 reg;
+
+	reg = readl(ctlr->sctrl_addr);
+	reg &= ~(HISI_I2C_CTRL_SCL_CFG_EN | HISI_I2C_CTRL_DAT_CFG_EN);
+	writel(reg, ctlr->sctrl_addr);
+
+	/*
+	 * Invokes the specific ACPI method "_RST" to trigger a soft reset
+	 * of the I2C controller to help the I2C controller recover from
+	 * the abnormal state after the bus recovery process.
+	 */
+	if (ctlr->acpi_handle && acpi_has_method(ctlr->acpi_handle, "_RST")) {
+		acpi_status status;
+
+		status = acpi_evaluate_object(ctlr->acpi_handle, "_RST", NULL, NULL);
+		if (ACPI_FAILURE(status))
+			dev_err(ctlr->dev, "_RST method failed: %s\n",
+				acpi_format_exception(status));
+	}
+	hisi_i2c_configure_bus(ctlr);
+}
+
+static int hisi_i2c_get_bus_recovery_res(struct hisi_i2c_controller *ctlr,
+					 struct platform_device *pdev)
+{
+	struct resource *res0;
+
+	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+
+	if (!res0 || resource_size(res0) != HISI_I2C_RECOVERY_REG_SIZE)
+		return -ENODEV;
+
+	ctlr->sctrl_addr = devm_ioremap_resource(&pdev->dev, res0);
+	if (IS_ERR(ctlr->sctrl_addr)) {
+		ctlr->sctrl_addr = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int hisi_i2c_recovery_init(struct hisi_i2c_controller *ctlr)
+{
+	struct platform_device *pdev = to_platform_device(ctlr->dev);
+	struct i2c_adapter *adapter = &ctlr->adapter;
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	ret = hisi_i2c_get_bus_recovery_res(ctlr, pdev);
+	if (ret)
+		return ret;
+
+	ctlr->rinfo = (struct i2c_bus_recovery_info) {
+		.get_scl = hisi_i2c_recovery_get_scl,
+		.get_sda = hisi_i2c_recovery_get_sda,
+		.set_scl = hisi_i2c_recovery_set_scl,
+		.prepare_recovery = hisi_i2c_prepare_recovery,
+		.unprepare_recovery = hisi_i2c_unprepare_recovery,
+		.recover_bus = i2c_generic_scl_recovery,
+	};
+	adapter->bus_recovery_info = &ctlr->rinfo;
+	ctlr->acpi_handle = ACPI_HANDLE(ctlr->dev);
+
+	return 0;
+}
+
 static int hisi_i2c_start_xfer(struct hisi_i2c_controller *ctlr)
 {
 	struct i2c_msg *msg = ctlr->msgs;
@@ -496,6 +634,10 @@ static int hisi_i2c_probe(struct platform_device *pdev)
 
 	hisi_i2c_configure_bus(ctlr);
 
+	ret = hisi_i2c_recovery_init(ctlr);
+	if (ret)
+		dev_info(ctlr->dev, "I2C bus recovery not available\n");
+
 	adapter = &ctlr->adapter;
 	snprintf(adapter->name, sizeof(adapter->name),
 		 "HiSilicon I2C Controller %s", dev_name(dev));
-- 
2.33.0

