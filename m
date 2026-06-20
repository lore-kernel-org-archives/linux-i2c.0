Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EA3624DE
	for <linux-i2c@vger.kernel.org>; Sat, 20 Jun 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781966516; cv=none; b=Ia+ddhtrUQPxgr9FX/LvvrnKYy9CK0wvr3oB1jdZY2OmonNIFq/bM/sky0UtWicOY3y9d4rYHcedDEMO6kWDpI4F8vjEHzW1Kd+tY/LtgfA8dPhl4WNhMHny02+TZNehsHwO8T0XGZOKf0ghzO4lWTdLl8nMVAd0OUweJxk6DFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781966516; c=relaxed/simple;
	bh=JdBjzW6JY5wegYllrP2QalBUCpTOp+liiIDVNbheGLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKZBMqMyvXSKes0CA1CE5d0xA2RcFZv4YMhYLWhQ6BsUBW8dXtEeFxCSwxZDrBDmYf7TwO585SFGRM/spGDbFssQqlaDHVdyBv5UVzpj+627MbXJWfn97q7GxCqyixSYVsvofdBp9LT7vWHnCtNPgeqX6tH2moLCbHkLjH/3ksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuJDqSm2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuJDqSm2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-460662fcb4eso2045756f8f.0
        for <linux-i2c@vger.kernel.org>; Sat, 20 Jun 2026 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781966511; x=1782571311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W39Um6Xj6L/Lz8gQywTLJV7rPzc1so/dHQ30ZfGY7es=;
        b=LuJDqSm2R87eoly1B9LAiNxsSxaf/Fv8W2cUZmDCPXVJsIc0ZlySX/A4NfWU/gdu0I
         9PD7lHU56JmTNKkamKgjGmVL46JMxhkfOONqDwZr23QlKl3Ug/zBquewWS61MHDhs1xX
         NUqXpW8LkWOwbN9X7aPs4ZlD/kwwxZ4Aq3k8fBLEKxJ7gdn4qmYSP7wRNSTmX6toaaYl
         7QtMN8YFhMQpgFyuD+q+mNez2WlRjg9pnch0ys3zMA6Fb/+zVk2wIrb1N/N5QOZHw2t9
         NbkB7j5i80u5upOikFNQrwrT/BfsBOBmftfrvG0Dw0K6KcYUP3H5iYO7eMwZPXIQ9LZ2
         mKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781966511; x=1782571311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W39Um6Xj6L/Lz8gQywTLJV7rPzc1so/dHQ30ZfGY7es=;
        b=nnTnnjeHcDAxLYvtM1It5KbZj8Td9orWEUTgrmRO7R8LmWpD+wQCMJo2kZPOxAEQKh
         zk+1S8ArLR349/ptTKtEbOR8R2m1jT/aQWOAABTZBoUbfftxRBHGLZxWeNrhUl02RKNS
         ec41S/V+KzQGccVO4641BJcX0Z7lT2BK1Khhh+Qm0Re4fKspbQcwO5dW5KZIvIwH7VdC
         OYOzM0ty4cmb+VfMl46QPFl2kb4FZaDMEvZhYY5ELxVK7QXJ8ekKemNWWg8fpofn9lGq
         J4nJSWmndJhS8u/8qaPI4WKBJEYDKRqwwwQ1S/AEVNM0e3oTgcyJLFzEovxEyxc+8V5a
         sKbw==
X-Gm-Message-State: AOJu0YyWOTDcrJWBwP6Ay9Xz5AAPuDhpZ2vVcoxatu1TYT6dCAt+dvna
	px2Q4FvhUgxdBKWo6TjhwMsyq6rrCIkjDEHrWl4K+CG6VcxnVdWHFFrhxSPd1FFYBnp+Dw==
X-Gm-Gg: AfdE7cm4MssQG5vDp2hbgYcb4kMEcXi+RGJ/Wmn+vm6bZNcgWfHTuPHGcoMa/pVxsqI
	SbFPOouHwn15/mANy9AjPYsRRVyssuPOYtGhXvr4hQsdmk1RYhollGneLanfGz/h0Ayeb7i98wM
	wjAXYxLAqwqzkUTlncxjAvrVXdJlqYqygQpDHFX5beJlozZ/vfgGWdxrztvf+5llCRDSZSUhhdz
	LSkjZylxNqAC2MSNOOoD6ooNi1voWmReqrVZ6zwBRuoPKlUGAhdzBYpgQUsHIuU8VUtdp7oYzFe
	7HGIh+ROTfWjGEfvu82A/C2NMYiFUUcVWCM9qlHJHrs7g8Cb6kcYxqzg8lSn4ccVPADXfvRtp2Q
	mOv3zRx46HMIBE+rCkjYmKjQm0Ev8HTX8ULl8/hnyvWQMlnHnXMZoxi1HyI0tHhfMvkV67tOFBr
	SI5Ai3LAPPq3IuSGqii/9xYZtnkqm59djRvcK/Al61A/jVEk8gk/henu9hah37VcHnRWqKMziEO
	Jp8FJCkNrY=
X-Received: by 2002:a5d:5246:0:b0:460:e4d:bd46 with SMTP id ffacd0b85a97d-465097867f3mr10671133f8f.21.1781966511333;
        Sat, 20 Jun 2026 07:41:51 -0700 (PDT)
Received: from ws1-mint.. (host125-33-78-130.dimensionesrl.eu. [130.78.33.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c579dfsm8964357f8f.31.2026.06.20.07.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 07:41:51 -0700 (PDT)
From: Simone Chifari <simone.chifari@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: wsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Simone Chifari <simone.chifari@gmail.com>
Subject: [PATCH v2 1/1] i2c: imc-x299: add driver for Intel X299/Skylake-X iMC SMBus engine
Date: Sat, 20 Jun 2026 16:41:29 +0200
Message-ID: <20260620144131.415559-2-simone.chifari@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620144131.415559-1-simone.chifari@gmail.com>
References: <20260620144131.415559-1-simone.chifari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The integrated memory controller (iMC) on Intel Skylake-X / Cascade
Lake-X (X299, PCU function 8086:2085) exposes an SMBus engine that
reaches the DDR4 DIMM SPD EEPROMs and thermal sensors. Present it as two
standard I2C adapters (one per hardware SMBus channel) so that i2c-tools
and lm-sensors can use it.

The engine is driven through the PCI configuration space of the PCU
function. On this platform System Management Mode traps CF8/CFC
port-based config writes to this function, so pci_write_config_dword()
never completes. The MMCONFIG (ECAM) window is not trapped, so the
driver ioremap()s the ECAM page of the function and drives the registers
by MMIO, locating the MMCONFIG base via a manual walk of the ACPI MCFG
table (the pci_mmcfg_* helpers are not exported to modules).

Relation to prior iMC SMBus work: two earlier attempts to upstream an
iMC SMBus driver exist. Lutomirski (2013-2016, Sandy Bridge-EP
8086:3ca8) used CF8/CFC pci_{read,write}_config_dword, which is correct
on that platform because SMM does not trap those ports there; it was not
merged, largely over missing BMC/CLTT bus arbitration and a required
allow_unsafe_access flag. schaecsn (2020, Broadwell-E 8086:6fa8) added
TSOD arbitration but saw no reviewer response. This device is a
different ID (0x2085), with a different register layout (DATA/STATUS/CTRL
at 0x9C-0xB8 vs 0x180-0x188) and a fundamentally different access method
(ECAM MMIO), so a separate file is cleaner than a per-generation hw_data
table with mutually incompatible access paths. The X299 HEDT platform
has no BMC and no CLTT firmware polling, so the arbitration concern does
not apply and no allow_unsafe_access flag is needed.

Only SMBus BYTE_DATA transfers are implemented; the devices on this bus
need nothing more.

Tested on ASUS TUF X299 Mark 1 (i9-10900X, 4x Kingston FURY DDR4): both
channels enumerate, SPD EEPROMs are readable, udev autoloads the module,
and 20 rmmod/modprobe cycles run clean with no oops or leaks.

Signed-off-by: Simone Chifari <simone.chifari@gmail.com>
---
 MAINTAINERS                       |   6 +
 drivers/i2c/busses/Kconfig        |  19 ++
 drivers/i2c/busses/Makefile       |   1 +
 drivers/i2c/busses/i2c-imc-x299.c | 435 ++++++++++++++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-imc-x299.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d4b913f..bb4b06b5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13374,6 +13374,12 @@ L:	netdev@vger.kernel.org
 S:	Orphan
 F:	drivers/net/wwan/iosm/
 
+INTEL X299 iMC SMBUS DRIVER
+M:	Simone Chifari <simone.chifari@gmail.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-imc-x299.c
+
 INTEL(R) FLEXIBLE RETURN AND EVENT DELIVERY
 M:	Xin Li <xin@zytor.com>
 M:	"H. Peter Anvin" <hpa@zytor.com>
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867..12732b8ff 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -180,6 +180,25 @@ config I2C_I801_MUX
 	  Optional support for multiplexed SMBUS on certain systems with
 	  more than 8 memory slots.
 
+config I2C_IMC_X299
+	tristate "Intel X299 / Skylake-X iMC SMBus adapter"
+	depends on PCI && ACPI && X86
+	help
+	  Say Y here if you want kernel support for the integrated memory
+	  controller (iMC) SMBus engine found in Intel Skylake-X / Cascade
+	  Lake-X processors (socket LGA 2066, platform X299, PCU function
+	  8086:2085).
+
+	  The engine is exposed through the PCI configuration space of the
+	  PCU function and is driven via ECAM MMIO (not CF8/CFC port I/O,
+	  which is trapped by System Management Mode on this platform).
+	  Two I2C adapters are registered, one per hardware SMBus channel,
+	  allowing access to DDR4 DIMM SPD EEPROMs (0x50-0x57) and thermal
+	  sensors from userspace via standard i2c-tools and lm-sensors.
+
+	  If unsure, say N.  This driver is only useful on Intel X299 desktop
+	  / HEDT systems with the Skylake-X or Cascade Lake-X CPU.
+
 config I2C_ISCH
 	tristate "Intel SCH SMBus 1.0"
 	depends on PCI && HAS_IOPORT
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 547123ab3..8c7cb83fd 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_CHT_WC)	+= i2c-cht-wc.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
+obj-$(CONFIG_I2C_IMC_X299)	+= i2c-imc-x299.o
 obj-$(CONFIG_I2C_ISCH)		+= i2c-isch.o
 obj-$(CONFIG_I2C_ISMT)		+= i2c-ismt.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
diff --git a/drivers/i2c/busses/i2c-imc-x299.c b/drivers/i2c/busses/i2c-imc-x299.c
new file mode 100644
index 000000000..28f2575a4
--- /dev/null
+++ b/drivers/i2c/busses/i2c-imc-x299.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel X299 / Skylake-X iMC SMBus I2C adapter.
+ *
+ * The integrated memory controller (iMC) on Intel Skylake-X / Cascade Lake-X
+ * (X299) exposes an SMBus engine used to reach the SPD EEPROMs and thermal
+ * sensors on DDR4 DIMMs.  The engine is driven through the PCI configuration
+ * space of the Sky Lake-E PCU function (0000:16:1e.5, 8086:2085).  This driver
+ * presents that engine as two standard Linux I2C adapters - one per hardware
+ * SMBus channel - so that i2c-tools and lm-sensors can use it without bespoke
+ * sysfs hacks.
+ *
+ * Why ECAM MMIO instead of the usual CF8/CFC config accessors:
+ *   On this platform System Management Mode (SMM) traps and mangles port-based
+ *   (CF8/CFC) writes to the first 256 config bytes of this function, so the SMBus
+ *   command never completes.  The boot log reports "PCI: Using configuration
+ *   type 1 (probe)" confirming the default path is port-based; the MMCONFIG
+ *   (ECAM) window is not trapped.  Windows' NTIOLib reaches the registers via
+ *   ECAM, which is how we confirmed the register layout on hardware.  We map the
+ *   ECAM page of the target function and drive the registers by MMIO, exactly as
+ *   the firmware does.
+ *
+ *   ECAM phys(off) = mmcfg_base + (bus<<20) + (dev<<15) + (fn<<12) + off
+ *   mmcfg_base is read from the ACPI MCFG table at probe time (not hardcoded).
+ *
+ * Per-channel register triple within the config page:
+ *                  ch0     ch1
+ *     CTRL (data)  0xB4    0xB8   write: data byte in bits[23:16]; read: low byte
+ *     DATA (cmd)   0x9C    0xA0   FRAME | (cmd << 8) | reg ; bit19 = GO
+ *     STATUS       0xA8    0xAC   busy while bit0 set; done when clear,
+ *                                 bit1 (0x02) set on completion = device NACKed
+ *   SMBus command byte (DATA bits[15:8]) = (rw << 7) | addr7: the 7-bit slave
+ *   address with bit7 = direction (1 write / 0 read).  The register/offset goes
+ *   in DATA[7:0].  So 0x50 reads SPD EEPROM 0x50.  This was decoded and
+ *   confirmed on hardware.
+ *
+ * The two channels are independent SMBus buses (DIMMs 1,2 on ch0; DIMMs 3,4 on
+ * ch1), hence two i2c_adapter instances exposed as separate /dev/i2c-* nodes.
+ * Each channel carries the DIMM SPD EEPROMs (0x50-0x57) and thermal sensors -
+ * all reachable by 7-bit address.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+
+/* expected PCI id of the Sky Lake-E PCU SMBus function */
+#define PCU_DEVICE	0x2085
+#define PCU_ID		((PCU_DEVICE << 16) | PCI_VENDOR_ID_INTEL)
+
+#define CFG_SIZE	0x1000UL
+
+/* per-channel register offsets within the config page */
+#define CH0_CTRL	0xB4
+#define CH0_DATA	0x9C
+#define CH0_STAT	0xA8
+#define CH1_CTRL	0xB8
+#define CH1_DATA	0xA0
+#define CH1_STAT	0xAC
+
+/*
+ * Command word written to the DATA register:
+ *   bits[31:16] = FRAME (engine config + GO bit19), constant
+ *   bits[15:8]  = SMBus command byte = (rw << 7) | addr7
+ *                   rw bit (0x80): 1 = write, 0 = read
+ *                   addr7        : 7-bit SMBus slave address
+ *   bits[7:0]   = register/offset within the addressed device
+ * For a write the data byte is latched into CTRL[23:16] beforehand.  This
+ * encoding was confirmed on hardware: command 0x50 reads SPD EEPROM 0x50
+ * (DDR4 signature).
+ */
+#define FRAME		0x20080000U	/* engine config + GO bit19, constant */
+#define RW_WRITE	0x80		/* OR into the command byte for a write */
+#define GO_BIT		BIT(19)
+#define STAT_BUSY	BIT(0)		/* low bit set while transaction in flight */
+#define STAT_NACK	BIT(1)		/* set on completion if the device NACKed */
+
+struct imc_chan {
+	u32 ctrl, data, stat;
+};
+
+static const struct imc_chan imc_chans[2] = {
+	{ CH0_CTRL, CH0_DATA, CH0_STAT },
+	{ CH1_CTRL, CH1_DATA, CH1_STAT },
+};
+
+/* one driver state object, shared by both per-channel adapters */
+struct imc_smbus {
+	struct device *dev;		/* &pdev->dev, for dev_*() logging */
+	void __iomem *cfg;		/* ioremapped ECAM page of the function */
+	struct mutex lock;		/* serialises all SMBus transactions */
+	struct i2c_adapter adap[2];	/* one per hardware channel */
+};
+
+/*
+ * ECAM base discovery from ACPI MCFG.  acpi_table_parse() is not exported to
+ * modules, so map the MCFG table with acpi_get_table() (exported) and walk the
+ * allocation entries by hand.  Uses pdev's PCI segment and bus number so no
+ * module parameter override is needed.
+ */
+#ifdef CONFIG_ACPI
+static u64 imc_detect_mmcfg_base(struct pci_dev *pdev)
+{
+	unsigned int seg = pci_domain_nr(pdev->bus);
+	unsigned int bus = pdev->bus->number;
+	struct acpi_table_header *hdr;
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *e;
+	unsigned long n, i;
+	u64 base = 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MCFG, 0, &hdr)))
+		return 0;
+
+	mcfg = (struct acpi_table_mcfg *)hdr;
+	if (hdr->length < sizeof(*mcfg)) {
+		acpi_put_table(hdr);
+		return 0;
+	}
+	e = (struct acpi_mcfg_allocation *)(mcfg + 1);
+	n = (hdr->length - sizeof(*mcfg)) / sizeof(*e);
+	for (i = 0; i < n; i++) {
+		if (e[i].pci_segment == seg &&
+		    bus >= e[i].start_bus_number &&
+		    bus <= e[i].end_bus_number) {
+			base = e[i].address;
+			break;
+		}
+	}
+	acpi_put_table(hdr);
+	return base;
+}
+#else
+static u64 imc_detect_mmcfg_base(struct pci_dev *pdev)
+{
+	return 0;
+}
+#endif
+
+/*
+ * Wait until GO clears (transaction issued), then until the busy bit drops.
+ * Returns 0 on completion, -ETIMEDOUT if the engine never went idle.  On
+ * success *status (if non-NULL) gets the final status word.  Process context
+ * only - it sleeps between polls.
+ */
+static int imc_wait(struct imc_smbus *s, const struct imc_chan *c, u32 *status)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout(s->cfg + c->data, val, !(val & GO_BIT), 10, 200000);
+	if (ret)
+		return ret;
+
+	ret = readl_poll_timeout(s->cfg + c->stat, val, !(val & STAT_BUSY), 10, 50000);
+	if (ret)
+		return ret;
+
+	if (status)
+		*status = val;
+
+	return 0;
+}
+
+/*
+ * Poll the busy bit clear only (no GO check).  The firmware polls STATUS after
+ * the CTRL (data-latch) write too, before issuing the DATA/GO word.
+ */
+static int imc_wait_status(struct imc_smbus *s, const struct imc_chan *c)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout(s->cfg + c->stat, val, !(val & STAT_BUSY), 10, 50000);
+	if (ret) {
+		dev_dbg(s->dev, "pre-command poll timed out, engine still busy\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/* translate a completed transaction's status into an errno (0 = ACK) */
+static int imc_check_status(struct imc_smbus *s, u32 status, u8 addr, u8 reg)
+{
+	if (status & STAT_NACK) {
+		/* no device at this address, or it refused the access */
+		dev_dbg(s->dev, "addr 0x%02x reg 0x%02x NACK (stat 0x%08x)\n",
+			addr, reg, status);
+		return -ENXIO;
+	}
+	return 0;
+}
+
+/* SMBus write-byte to addr: latch the data byte, then issue the command. */
+static int imc_write_byte(struct imc_smbus *s, const struct imc_chan *c,
+			  u8 addr, u8 reg, u8 val)
+{
+	u32 status = 0;
+	int ret;
+
+	writel((u32)val << 16, s->cfg + c->ctrl);
+	ret = imc_wait_status(s, c);
+	if (ret)
+		return ret;
+	writel(FRAME | ((u32)(addr | RW_WRITE) << 8) | reg, s->cfg + c->data);
+	ret = imc_wait(s, c, &status);
+	if (ret) {
+		dev_warn_ratelimited(s->dev,
+				     "write addr 0x%02x reg 0x%02x timed out\n",
+				     addr, reg);
+		return ret;
+	}
+	ret = imc_check_status(s, status, addr, reg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* SMBus read-byte from addr: issue the command, return the low data byte. */
+static int imc_read_byte(struct imc_smbus *s, const struct imc_chan *c,
+			 u8 addr, u8 reg, u8 *val)
+{
+	u32 status = 0;
+	int ret;
+
+	ret = imc_wait_status(s, c);
+	if (ret)
+		return ret;
+	writel(FRAME | ((u32)addr << 8) | reg, s->cfg + c->data);
+	ret = imc_wait(s, c, &status);
+	if (ret) {
+		dev_warn_ratelimited(s->dev,
+				     "read addr 0x%02x reg 0x%02x timed out\n",
+				     addr, reg);
+		return ret;
+	}
+	ret = imc_check_status(s, status, addr, reg);
+	if (ret)
+		return ret;
+	*val = readl(s->cfg + c->ctrl) & 0xFF;
+	return 0;
+}
+
+/*
+ * Standard SMBus transfer callback.  The per-channel imc_chan is stashed in the
+ * adapter's algo_data.  The command word carries the 7-bit address, so
+ * SPD EEPROMs (0x50-0x57) are reachable on each channel.  Only BYTE_DATA
+ * is supported (see imc_func()); larger transfers would need the
+ * engine's block primitives, which are not used by the devices on this bus.
+ */
+static s32 imc_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+			  unsigned short flags, char read_write, u8 command,
+			  int size, union i2c_smbus_data *data)
+{
+	struct imc_smbus *s = i2c_get_adapdata(adap);
+	const struct imc_chan *c = adap->algo_data;
+	u8 reg, val = 0;
+	int ret;
+
+	if (addr > 0x7f)
+		return -EINVAL;
+
+	if (size != I2C_SMBUS_BYTE_DATA)
+		return -EOPNOTSUPP;
+
+	reg = command;
+
+	mutex_lock(&s->lock);
+	if (read_write == I2C_SMBUS_WRITE) {
+		val = data->byte;
+		dev_dbg(s->dev, "ch%d W addr=%02x reg=%02x val=%02x\n",
+			(int)(c - imc_chans), addr, reg, val);
+		ret = imc_write_byte(s, c, addr, reg, val);
+	} else {
+		ret = imc_read_byte(s, c, addr, reg, &val);
+		if (!ret)
+			data->byte = val;
+		dev_dbg(s->dev, "ch%d R addr=%02x reg=%02x -> %02x (ret %d)\n",
+			(int)(c - imc_chans), addr, reg, val, ret);
+	}
+	mutex_unlock(&s->lock);
+
+	return ret;
+}
+
+static u32 imc_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_BYTE_DATA;
+}
+
+static const struct i2c_algorithm imc_algo = {
+	.smbus_xfer	= imc_smbus_xfer,
+	.functionality	= imc_func,
+};
+
+static void imc_mutex_destroy(void *data)
+{
+	struct mutex *lock = data;
+
+	mutex_destroy(lock);
+}
+
+static int imc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	resource_size_t phys;
+	struct imc_smbus *s;
+	u8 imc_bus_hw;
+	u64 base;
+	u32 cfg0, cc;
+	int ret, i;
+
+	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable PCI device: %d\n", ret);
+		return ret;
+	}
+
+	s->dev = &pdev->dev;
+	mutex_init(&s->lock);
+	ret = devm_add_action_or_reset(&pdev->dev, imc_mutex_destroy, &s->lock);
+	if (ret)
+		return ret;
+
+	base = imc_detect_mmcfg_base(pdev);
+	if (!base) {
+		dev_err(&pdev->dev, "cannot resolve MMCONFIG base\n");
+		return -ENODEV;
+	}
+
+	phys = base +
+	       ((resource_size_t)pdev->bus->number   << 20) +
+	       ((resource_size_t)PCI_SLOT(pdev->devfn) << 15) +
+	       ((resource_size_t)PCI_FUNC(pdev->devfn) << 12);
+
+	/*
+	 * Deliberately no request_mem_region(): the MMCONFIG window is already
+	 * claimed as a firmware/PCI resource, so a reservation would fail with
+	 * -EBUSY.  The pci_driver binding keeps the function alive; the registers
+	 * we drive are side-band controls the kernel does not otherwise touch.
+	 */
+	s->cfg = devm_ioremap(&pdev->dev, phys, CFG_SIZE);
+	if (!s->cfg) {
+		dev_err(&pdev->dev, "ioremap(%pa) failed\n", &phys);
+		return -ENOMEM;
+	}
+
+	cfg0 = readl(s->cfg + 0);
+	if (cfg0 != PCU_ID) {
+		dev_err(&pdev->dev, "wrong device at ECAM %pa (cfg[0]=0x%08x)\n",
+			&phys, cfg0);
+		return -ENODEV;
+	}
+
+	/*
+	 * Cross-check the iMC bus number against the configuration register
+	 * value: cfg[0xCC] bits[15:8] = the iMC SMBus bus number as seen by
+	 * the PCU.  On all known X299 boards this matches the probed bus number.
+	 * A mismatch means the ECAM walk landed on the wrong slot — warn but
+	 * continue; the binding is already locked to 8086:2085.
+	 */
+	cc = readl(s->cfg + 0xCC);
+	imc_bus_hw = (cc >> 8) & 0xFF;
+
+	if (imc_bus_hw && imc_bus_hw != (u8)pdev->bus->number)
+		dev_warn(&pdev->dev,
+			 "cfg[0xCC] reports iMC bus 0x%02x but probed bus=0x%02x\n",
+			 imc_bus_hw, (u8)pdev->bus->number);
+	else
+		dev_dbg(&pdev->dev,
+			"cfg[0xCC]=0x%08x iMC bus 0x%02x confirmed\n",
+			cc, imc_bus_hw);
+
+	dev_info(&pdev->dev, "ECAM %pa (mmcfg_base=0x%llx)\n", &phys, base);
+
+	for (i = 0; i < 2; i++) {
+		struct i2c_adapter *a = &s->adap[i];
+
+		a->owner     = THIS_MODULE;
+		a->algo      = &imc_algo;
+		a->algo_data = (void *)&imc_chans[i];
+		a->dev.parent = &pdev->dev;
+		i2c_set_adapdata(a, s);
+		snprintf(a->name, sizeof(a->name),
+			 "iMC SMBus X299 channel %d", i);
+
+		ret = devm_i2c_add_adapter(&pdev->dev, a);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"i2c_add_adapter ch%d failed: %d\n", i, ret);
+			return ret;
+		}
+	}
+
+	dev_info(&pdev->dev, "registered 2 SMBus channels (use i2cdetect -l)\n");
+	return 0;
+}
+
+static const struct pci_device_id imc_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCU_DEVICE) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, imc_pci_ids);
+
+/*
+ * All resources (ioremap, i2c adapters, mutex) are devm-managed and are
+ * released automatically after probe returns or during device unbinding, so
+ * no .remove callback is needed.  The register state is deliberately left
+ * as-is on unbind: the engine carries no driver-private latched state that
+ * needs teardown, and the SMBus controls we drive are side-band registers the
+ * rest of the kernel does not touch.
+ */
+static struct pci_driver imc_driver = {
+	.name     = "i2c-imc-x299",
+	.id_table = imc_pci_ids,
+	.probe    = imc_pci_probe,
+};
+module_pci_driver(imc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Simone Chifari");
+MODULE_DESCRIPTION("Intel X299/Skylake-X iMC SMBus I2C adapter (ECAM MMIO)");
-- 
2.43.0

