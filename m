Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0D4BE430
	for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602332; cv=none; b=VBe08ndhS5hxOo72rXPWrxpGKTNCQYfvV2lvdVmgLGQTnU3EfLXYh9DDGQx5SmhzuDPtyd3AnBy8zdKQBJ3ky36U3c0nuh2R2vQ4Y3O0Mkng80eNtLdGOW9cZOQNabiNS3i2LKoSM0wDU92x1Bt+78lhRbkWIG2xCHuyVDy79Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602332; c=relaxed/simple;
	bh=YDQ1oKThlXJP5YLS4/Qr6Maq4inJ4re2Xsw4QAyMW4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwIU6dEUKb1KB0o8bzWGDp7sHB3iXv6CFy8VrCDqllkyWc7D6+3K+khrx4kWobDFuH9iKDn7XOVqF/hqTJIIRZyee7r15RKFXf82p4xLH7exvmjYqlj1FdtOK0JXtqNJ4SwFll2NtxNDlp4udiYr1HnDERqh/iynOWz555vKAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.b=OUttkZNM; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.b="OUttkZNM"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202609281331572d09050eec000207bc
        for <linux-i2c@vger.kernel.org>;
        Mon, 28 Sep 2026 15:31:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pVGjlSdumnOarPPD1C+LzCuWsnMBFB1lMShsgy4vu78=;
 b=OUttkZNMYwF3mSo2WVreE/B+P/wf2hbGvspmwSywL9ugH5zFeDw/seRe0nYbvsfZVDWBUx
 4V3eNiO+fSr4QORI+v1pDNKLPZxhKevxP497yfOpwVrrkLUJKbHrPOBZHCZIj+4ALVMLXmBr
 6kiOQwm4XrzaBiBpIJqOtor05K2VSwP2eDB3WVO7IQMAKB+C0SXJa1eOhh04Lfoze5fK/zn7
 xM6Q7w+5DJhdqI00hv21OtnayT/gcu7bmdnJ73uvPNFsIqj5JA/qLlAmo2M/Xivdfz6aI0uN
 XOuKCJzeaL5tAHIGA/KHyuAWiIVeyGuP+QKserfJrDwamSUJlrWrOU0w==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: andi.shyti@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: baocheng.su@siemens.com,
	tobias.schaffner@siemens.com,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 1/2] i2c: i2c-nct6126: add support for NCT6126D Super I/O
Date: Mon, 28 Sep 2026 15:31:55 +0200
Message-ID: <20260928133156.817479-2-benedikt.niedermayr@siemens.com>
In-Reply-To: <20260928133156.817479-1-benedikt.niedermayr@siemens.com>
References: <20260928133156.817479-1-benedikt.niedermayr@siemens.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer

This adds support for an i2c master driver for the NCT6126D Super I/O
chips SMBUs controller. The NCT6126D exposes an SMBus master controller
inside Logical Device B (the Hardware Monitor / SB-TSI block).

The I/O base address is discovered dynamically and is expected to be
programmed by the BIOS into LD B CR62h (MSB) and CR63h (LSB).

The SMBus master controller shares the same CR30h register with the
Hardware Monitor (logical device B), which is currently used by the
nct6775 driver. The nct6775 driver force overrides the CR30h register
to 0x01, if not already set by the bios.
This driver in turn is more defensive and will not probe the chip if the
CR30h register is not set to 0x01.

Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
---
 MAINTAINERS                      |   5 +
 drivers/i2c/busses/Kconfig       |  11 +
 drivers/i2c/busses/Makefile      |   1 +
 drivers/i2c/busses/i2c-nct6126.c | 441 +++++++++++++++++++++++++++++++
 4 files changed, 458 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-nct6126.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 70a11f2ff61d..ca51c0a4a4ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19785,6 +19785,11 @@ F:	drivers/nubus/
 F:	include/linux/nubus.h
 F:	include/uapi/linux/nubus.h
 
+NUVOTON NCT6126D I2C/SMBUS DRIVER
+M:	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
+S:	Maintained
+F:	drivers/i2c/busses/i2c-nct6126.c
+
 NUVOTON NCT6694 MFD DRIVER
 M:	Ming Yu <tmyu0@nuvoton.com>
 S:	Supported
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d7b89508311f..8630cc230f36 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -258,6 +258,17 @@ config I2C_NFORCE2
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-nforce2.
 
+config I2C_NCT6126
+	tristate "Nuvoton NCT6126D SMBus master"
+	depends on X86 && HAS_IOPORT
+	help
+	  If you say yes to this option, support will be included for the
+	  SMBus master controller embedded in the Nuvoton NCT6126D Super-I/O
+	  chip (Logical Device B).
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-nct6126.
+
 config I2C_NVIDIA_GPU
 	tristate "NVIDIA GPU I2C controller"
 	depends on PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 3755c54b3d82..69042afb1f04 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_ISCH)		+= i2c-isch.o
 obj-$(CONFIG_I2C_ISMT)		+= i2c-ismt.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
+obj-$(CONFIG_I2C_NCT6126)	+= i2c-nct6126.o
 obj-$(CONFIG_I2C_NVIDIA_GPU)	+= i2c-nvidia-gpu.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
diff --git a/drivers/i2c/busses/i2c-nct6126.c b/drivers/i2c/busses/i2c-nct6126.c
new file mode 100644
index 000000000000..287659be160d
--- /dev/null
+++ b/drivers/i2c/busses/i2c-nct6126.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * i2c-nct6126 - i2c adapter driver for the Nuvoton NCT6126D Super-I/O chip.
+ *
+ * The NCT6126D exposes an SMBus master controller inside Logical Device B
+ * (the Hardware Monitor / SB-TSI block). Its I/O base address is programmed
+ * by BIOS into LD B CR62h (MSB) and CR63h (LSB).
+ *
+ * Inspired by nct6775-platform.c and gpio-f7188x.c.
+ *
+ * Copyright (c) Siemens AG, 2026
+ *
+ * Author: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
+ */
+
+#define DRVNAME "i2c-nct6126"
+#define pr_fmt(fmt) DRVNAME ": " fmt
+
+#include <linux/align.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+/*
+ * Super-I/O configuration space
+ */
+#define SIO_LDSEL		0x07	/* Logical Device Select */
+#define SIO_DEVID		0x20	/* CR20/CR21: 16-bit chip ID */
+#define SIO_UNLOCK_KEY		0x87	/* Enter extended function mode */
+#define SIO_LOCK_KEY		0xAA	/* Exit extended function mode */
+
+/* Accepted chip IDs */
+#define SIO_NCT6126D_A_ID	0xD283	/* NCT6126D, A version */
+#define SIO_NCT6126D_B_ID	0xD284	/* NCT6126D, B version */
+
+/* Logical Device B: Hardware Monitor + SB-TSI / SMBus master */
+#define SIO_LD_HM_SMBUS		0x0B
+#define SIO_LDB_ENABLE		0x30	/* bit0: block active (CR30) */
+#define SIO_LDB_ENABLE_HM_SBTSI	BIT(0)	/* Hardware Monitor & SB-TSI active */
+#define SIO_LDB_SMBUS_BASE	0x62	/* CR62 = MSB, CR63 = LSB */
+
+/* SMBus base address constraints */
+#define SMBUS_BASE_MIN		0x100
+#define SMBUS_BASE_MAX		0xFFE
+
+/*
+ * SMBus controller register offsets (base + offset)
+ * All registers are accessed directly at smbus_base + offset.
+ */
+#define NCT6126D_SMWRSIZE	0x01
+#define NCT6126D_SMCMD		0x02
+#define NCT6126D_SMIDX		0x03
+#define NCT6126D_SMCTL		0x04
+#define NCT6126D_SMADDR		0x05
+#define NCT6126D_ERROR_STS	0x09
+#define NCT6126D_SMCTL3		0x0e
+#define NCT6126D_SMBUS_REGION_SIZE	SZ_32
+
+/* Bit definitions */
+#define NCT6126D_FIFO_NULL		BIT(0)
+#define NCT6126D_FIFO_FULL		BIT(1)
+#define NCT6126D_ERR_NACK		BIT(1)
+#define NCT6126D_ERR_BER		BIT(2)
+#define NCT6126D_ERR_TIMEOUT		BIT(4)
+#define NCT6126D_ERR_ADNACK		BIT(5)
+#define NCT6126D_RST			BIT(6)
+#define NCT6126D_MANUAL_MODE		BIT(7)
+#define NCT6126D_ACTIVE_MANUAL_MODE	BIT(2)
+
+/* SMBus command codes */
+#define NCT6126_CMD_READ_BYTE	0
+#define NCT6126_CMD_WRITE_BYTE	8
+
+/* Timing / retry limits */
+#define SMBUS_RW_LOOP_MAX	5
+#define SMBUS_FIFO_WAIT_US	100
+#define SMBUS_FIFO_MAX_CLEAR_TIME	0xff
+
+/*
+ * Super-I/O functions.
+ */
+static inline int nct_superio_inb(int base, int reg)
+{
+	outb(reg, base);
+	return inb(base + 1);
+}
+
+static int nct_superio_inw(int base, int reg)
+{
+	int val;
+
+	outb(reg++, base);
+	val = inb(base + 1) << 8;
+	outb(reg, base);
+	val |= inb(base + 1);
+
+	return val;
+}
+
+static inline int nct_superio_enter(int base)
+{
+	if (!request_muxed_region(base, 2, DRVNAME)) {
+		pr_err("SIO config port %#x already in use\n", base);
+		return -EBUSY;
+	}
+
+	/* Datasheet 7.1.1: key must be written twice */
+	outb(SIO_UNLOCK_KEY, base);
+	outb(SIO_UNLOCK_KEY, base);
+
+	return 0;
+}
+
+static inline void nct_superio_select(int base, int ld)
+{
+	outb(SIO_LDSEL, base);
+	outb(ld, base + 1);
+}
+
+static inline void nct_superio_exit(int base)
+{
+	outb(SIO_LOCK_KEY, base);
+	release_region(base, 2);
+}
+
+struct nct6126_sio {
+	int addr; /* SIO config port */
+	unsigned long smbus_base; /* from LD B CR62/CR63 */
+};
+
+struct nct6126_smbus {
+	unsigned long port_addr;
+	struct i2c_adapter adap;
+};
+
+static int __init nct6126_find(int addr, struct nct6126_sio *sio)
+{
+	unsigned long base;
+	u8 enable, msb, lsb;
+	u16 devid;
+	int err;
+
+	err = nct_superio_enter(addr);
+	if (err)
+		return err;
+
+	/* Verify chip identity */
+	devid = nct_superio_inw(addr, SIO_DEVID);
+	if (devid != SIO_NCT6126D_A_ID && devid != SIO_NCT6126D_B_ID) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	/* Select Logical Device B (HM + SB-TSI/SMBus master) */
+	nct_superio_select(addr, SIO_LD_HM_SMBUS);
+
+	/*
+	 * Check CR30 bit 0: if clear, the block is not decoding its I/O
+	 * range on the LPC bus.  Every inb() at the SMBus window would
+	 * return 0xFF.  We do NOT write this bit: nct6775 owns CR30 and
+	 * maintains it across suspend/resume.
+	 */
+	enable = nct_superio_inb(addr, SIO_LDB_ENABLE);
+	if (!(enable & SIO_LDB_ENABLE_HM_SBTSI)) {
+		pr_info("LD B inactive (CR30 bit0=0): BIOS has not enabled the HM/SMBus block\n");
+		err = -ENODEV;
+		goto out;
+	}
+
+	/*
+	 * Read the SMBus master base address programmed by BIOS.
+	 * Datasheet 19.7.1, 23.11: LD B CR62h (MSB) / CR63h (LSB).
+	 * BIOS must program this.
+	 */
+	msb = nct_superio_inb(addr, SIO_LDB_SMBUS_BASE);
+	lsb = nct_superio_inb(addr, SIO_LDB_SMBUS_BASE + 1);
+	base = ((unsigned long)msb << 8) | lsb;
+
+	if (base < SMBUS_BASE_MIN || base > SMBUS_BASE_MAX || !IS_ALIGNED(base, 2)) {
+		pr_err("invalid SMBus base %#lx in LD B CR62/63\n", base);
+		err = -ENXIO;
+		goto out;
+	}
+
+	sio->addr = addr;
+	sio->smbus_base = base;
+	err = 0;
+
+out:
+	nct_superio_exit(addr);
+	return err;
+}
+
+/*
+ * SMBus
+ */
+static int nct_smbus_err_check(u8 err_code)
+{
+	if (err_code & NCT6126D_ERR_ADNACK)
+		return -ENXIO;
+	if (err_code & NCT6126D_ERR_TIMEOUT)
+		return -ETIMEDOUT;
+	if (err_code & (NCT6126D_ERR_BER | NCT6126D_ERR_NACK))
+		return -EXDEV;
+	return 0;
+}
+
+static void nct6126_smbus_init_config(struct nct6126_smbus *priv,
+				      u8 slave_addr, u8 slave_reg)
+{
+	u8 val;
+
+	/* Reset SMBus controller */
+	val = inb(priv->port_addr + NCT6126D_SMCTL);
+	val |= NCT6126D_RST;
+	outb(val, priv->port_addr + NCT6126D_SMCTL);
+	outb(0,   priv->port_addr + NCT6126D_SMCTL);
+
+	/* 7-bit slave address; hardware expects it left-shifted by 1 */
+	outb(slave_addr << 1, priv->port_addr + NCT6126D_SMADDR);
+	outb(slave_reg,       priv->port_addr + NCT6126D_SMIDX);
+}
+
+static int nct6126_smbus_enable_manual_mode(struct nct6126_smbus *priv)
+{
+	u8 val;
+
+	val = inb(priv->port_addr + NCT6126D_SMCTL);
+	val |= NCT6126D_MANUAL_MODE;
+	outb(val, priv->port_addr + NCT6126D_SMCTL);
+
+	val = inb(priv->port_addr + NCT6126D_SMCTL3);
+	val |= NCT6126D_ACTIVE_MANUAL_MODE;
+	outb(val, priv->port_addr + NCT6126D_SMCTL3);
+
+	/*
+	 * Wait ~200 us for the slave to respond, then read the error
+	 * status.  Per Nuvoton FAE: error must be checked after manual
+	 * mode is activated due to the one-shot enable behaviour.
+	 */
+	usleep_range(200, 300);
+	val = inb(priv->port_addr + NCT6126D_ERROR_STS);
+
+	return nct_smbus_err_check(val);
+}
+
+static int nct6126_smbus_write8(struct nct6126_smbus *priv,
+				u8 slave_addr, u8 slave_reg, u8 *data)
+{
+	int err;
+	u8 val;
+
+	if (!request_muxed_region(priv->port_addr,
+				  NCT6126D_SMBUS_REGION_SIZE, DRVNAME))
+		return -EBUSY;
+
+	nct6126_smbus_init_config(priv, slave_addr, slave_reg);
+
+	outb(1, priv->port_addr + NCT6126D_SMWRSIZE);
+	outb(NCT6126_CMD_WRITE_BYTE, priv->port_addr + NCT6126D_SMCMD);
+
+	err = read_poll_timeout(inb, val, !(val & NCT6126D_FIFO_FULL),
+				SMBUS_FIFO_WAIT_US,
+				SMBUS_FIFO_WAIT_US * SMBUS_RW_LOOP_MAX,
+				false, priv->port_addr + NCT6126D_SMCTL3);
+	if (err)
+		goto out;
+
+	outb(*data, priv->port_addr);
+	err = nct6126_smbus_enable_manual_mode(priv);
+
+out:
+	release_region(priv->port_addr, NCT6126D_SMBUS_REGION_SIZE);
+	return err;
+}
+
+static int nct6126_smbus_read8(struct nct6126_smbus *priv,
+			       u8 slave_addr, u8 slave_reg, u8 *data)
+{
+	int loop_cnt;
+	int err;
+	u8 val;
+
+	if (!request_muxed_region(priv->port_addr,
+				  NCT6126D_SMBUS_REGION_SIZE, DRVNAME))
+		return -EBUSY;
+
+	nct6126_smbus_init_config(priv, slave_addr, slave_reg);
+
+	outb(0, priv->port_addr + NCT6126D_SMWRSIZE);
+	outb(NCT6126_CMD_READ_BYTE, priv->port_addr + NCT6126D_SMCMD);
+
+	err = nct6126_smbus_enable_manual_mode(priv);
+	if (err)
+		goto out;
+
+	err = read_poll_timeout(inb, val, !(val & NCT6126D_FIFO_NULL),
+				SMBUS_FIFO_WAIT_US,
+				SMBUS_FIFO_WAIT_US * SMBUS_RW_LOOP_MAX,
+				false, priv->port_addr + NCT6126D_SMCTL3);
+	if (err)
+		goto out;
+
+	*data = inb(priv->port_addr);
+
+	/* Drain any residual FIFO entries */
+	loop_cnt = SMBUS_FIFO_MAX_CLEAR_TIME;
+	while (!(inb(priv->port_addr + NCT6126D_SMCTL3) & NCT6126D_FIFO_NULL) &&
+	       --loop_cnt)
+		inb(priv->port_addr);
+
+	err = (loop_cnt == 0) ? -ETIMEDOUT : 0;
+
+out:
+	release_region(priv->port_addr, NCT6126D_SMBUS_REGION_SIZE);
+	return err;
+}
+
+/*
+ * i2c_algorithm
+ */
+static int nct6126_smbus_xfer(struct i2c_adapter *adap, u16 addr, u16 flags,
+			      char read_write, u8 cmd, int size,
+			      union i2c_smbus_data *data)
+{
+	struct nct6126_smbus *priv = i2c_get_adapdata(adap);
+
+	if (!priv)
+		return -ENODEV;
+
+	if (read_write == I2C_SMBUS_READ)
+		return nct6126_smbus_read8(priv, addr, cmd, &data->byte);
+	else
+		return nct6126_smbus_write8(priv, addr, cmd, &data->byte);
+}
+
+static u32 nct6126_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA;
+}
+
+static const struct i2c_algorithm nct6126_algo = {
+	.smbus_xfer    = nct6126_smbus_xfer,
+	.functionality = nct6126_functionality,
+};
+
+static int nct6126_smbus_probe(struct platform_device *pdev)
+{
+	struct nct6126_sio *sio = dev_get_platdata(&pdev->dev);
+	struct nct6126_smbus *priv;
+	struct i2c_adapter *adap;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->port_addr = sio->smbus_base;
+
+	adap              = &priv->adap;
+	adap->owner       = THIS_MODULE;
+	adap->class       = I2C_CLASS_HWMON;
+	adap->algo        = &nct6126_algo;
+	adap->dev.parent  = &pdev->dev;
+	adap->nr          = -1;
+	strscpy(adap->name, DRVNAME, sizeof(adap->name));
+	i2c_set_adapdata(adap, priv);
+
+	err = i2c_add_adapter(adap);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add i2c adapter: %d\n", err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+}
+
+static void nct6126_smbus_remove(struct platform_device *pdev)
+{
+	struct nct6126_smbus *priv = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&priv->adap);
+}
+
+static struct platform_driver nct6126_smbus_driver = {
+	.driver = {
+		.name = DRVNAME,
+	},
+	.probe = nct6126_smbus_probe,
+	.remove = nct6126_smbus_remove,
+};
+
+static struct platform_device *nct6126_pdev;
+
+static int __init nct6126_smbus_init(void)
+{
+	struct nct6126_sio sio;
+	int err;
+
+	if (nct6126_find(0x2e, &sio) && nct6126_find(0x4e, &sio))
+		return -ENODEV;
+
+	err = platform_driver_register(&nct6126_smbus_driver);
+	if (err)
+		return err;
+
+	nct6126_pdev = platform_device_register_data(NULL, DRVNAME, 0, &sio, sizeof(sio));
+	if (IS_ERR(nct6126_pdev)) {
+		err = PTR_ERR(nct6126_pdev);
+		goto err_unreg_driver;
+	}
+
+	return 0;
+
+err_unreg_driver:
+	platform_driver_unregister(&nct6126_smbus_driver);
+	return err;
+}
+
+static void __exit nct6126_smbus_exit(void)
+{
+	platform_device_unregister(nct6126_pdev);
+	platform_driver_unregister(&nct6126_smbus_driver);
+}
+
+module_init(nct6126_smbus_init);
+module_exit(nct6126_smbus_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Benedikt Niedermayr <benedikt.niedermayr@siemens.com>");
+MODULE_DESCRIPTION("SMBus master driver for Nuvoton NCT6126D Super-I/O");
-- 
2.43.0

