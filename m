Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0621A444
	for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701956; cv=none; b=MukIberwUljYSZW5R/NrC3jotOqjNXtDm5uZxisVXrWzIkEOxh2j2FamdyBN6cCd1L8P7WOTMDaImUgcOMnhsnnG44ueM4CGsdzdAqAHuIad33KROnsR0OFW5n2f4EPB+98wqF28ynTfG54rcfOwN+63lM2qI2kzYmseS0OQSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701956; c=relaxed/simple;
	bh=s0iYucdNe1Uu1TX9fXv1CdteKAWo8P2bkcFUCr7n9Ks=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MIqzXrScNEj05hwIzAdMFnRLTIZfNSNhm4DNNiG7Dgpg2eAnSAo9Rt8+gW1kprwBr4RMIP3/M0EdlpgcHz+raPG6gW925kONedGdqRYNlcHUlCcyUkQtJ66gkqy/uT1L5sQNl782oXZ1XLQFOsIywnLvWMlU+YB7RRJ3Msie/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XQ1EOsUH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XQ1EOsUH"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59de66fda55so1302564e87.3
        for <linux-i2c@vger.kernel.org>; Thu, 29 Jan 2026 07:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769701952; x=1770306752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIUwQDA4iBfignRU1cxH6zkNHGRlAJ1DFqJyeuGlQwY=;
        b=XQ1EOsUHTvX9EBVuecfEn/RT7R8Eq3hrAUGOTvOKoPLtMjdny0INbOR9L91fBCUILL
         Gc8NobyO9v8nBLNkYDhuxO8sq463nD4gUqHVc+xUwivlMkiPyOs/SJ0t34uJ6AMhTX1R
         AD9KWEwGZCcIx1FBuO0XIUyJDNyc+TDgLhgC+wCnpzmz/rw7v0ciDHL7C/okcplnfgx0
         8RzzbeT00Qgi0lAdilAUdxmsHj9k8c07rBqlH45gWyFXQ4gYlQUi29kszV92Etwh6c3J
         6BOv5phfJwpdGeLx/m5TOLi0xD1QFXZr0wb/nVxDPNQUWAy1duPtInMuaPChU+hxlWzZ
         a4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769701952; x=1770306752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIUwQDA4iBfignRU1cxH6zkNHGRlAJ1DFqJyeuGlQwY=;
        b=ExvkJmibsdujVnV7HA2PjRaxkhxgNvgYAjzAdRMa1sS5+r+meDg4iGAPks7Uf3g3Ou
         /n0QeIdFt0kpkxiW17bQOZqiVHqx3dTUW93RPgU+bpyWe2IZ3QHwDsqxEAz91uWOEw5K
         XJLzPmb7jqYsugZo1tqybNinKNY3kqDLYGrIStJA38cctGef0iODBsR3X1QXDhI4PJ/N
         22hLkQ2ThBp/ZwYSYc68+OKgTKhUx1WBiYtagYL7Z2pmuJVNVo2qOw8fIdlZmnulH57R
         dnfIg75hdEW6wk+pSE0nHeuzk3NEfI7fcK+BchSwWPcOwJABTZad6amyRFnpY40OhKLj
         ROdA==
X-Forwarded-Encrypted: i=1; AJvYcCVLfzbnNb053Bfra6hHzxvv5lTRKhO81g4sBEmB3E6ljtJuhzkLbKp5EV9T9s2abxMpzkUvRMmNLAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpcsFo2Al6VvGImXlpOxSnAzqYgPgNZJOM0vDV/TJZSgxng1Vq
	ifSK4guNDfHtyHWf/JfTt0BuREu5N9yR3apz4xIdnumj8JCHu5luZ4GFKwgZX9afZJIzjOedJwI
	Wtfhasjw=
X-Gm-Gg: AZuq6aIFtjSZjWuwF2IQwu05sKG+vzuWajgAAt3OkEN7n+qT1+VmVq68T1u4doDNfMo
	yVPhSUQk0U1FkR4qk2ztqKnuREWZ6QsfXekBD8zUY6uVnaDplGwygtG6d4B/XeHXHOGn00RYhJD
	jGuhM3JSm7aJGMoHe4+fT9yxaGK/2Bx6XK+i1Y6KU5S2DB244s3kT8eznTv0HcI27Id8HmUyPqG
	TcTetBBqaOK5hS3QQfRaZ6In5YTVBzBG7kLgQVZ7gK26BuZsGl/hgJ5W6a85g1TswvZlooArbvL
	akfnQFViAudhfu4oMcsUv7V9OBQUPcpY44s8pw8qR956IPZo8vsnfndX243jDLlDEICn9dhus6h
	TA6MmpZfktM276rlsAUQ/mDwkQ7IoMqmoQvtc3Of5kpQXWtbNv+2AFj4=
X-Received: by 2002:a05:6512:110b:b0:598:f1a7:c70d with SMTP id 2adb3069b0e04-59e04028e70mr3885411e87.38.1769701951988;
        Thu, 29 Jan 2026 07:52:31 -0800 (PST)
Received: from localhost ([151.47.16.98])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b70c8sm1218114e87.75.2026.01.29.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:52:31 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH v3] i2c: Add FTDI FT4222H USB I2C adapter
Date: Thu, 29 Jan 2026 16:52:30 +0100
Message-Id: <20260129155230.3054708-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15974; i=flavra@baylibre.com; h=from:subject; bh=s0iYucdNe1Uu1TX9fXv1CdteKAWo8P2bkcFUCr7n9Ks=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpe4I0OkHojbrtqABbjtNOUCJPZY2JRW4PSkg7w 5Ah9USykfeJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXuCNAAKCRDt8TtzzpQ2 X/rzC/9BiAFqfq4hjg3DIvC6ukKJs3BIC+0Ru/Mi5WoYfDmBo2b+idY2qPRljPJana6KHXmz7L/ T513y53c8yCfX7aflZd50dijAukMs8/BkZmW+MFQYAtmLDPjI1PcQXvq4hnkRpOdV9JiJ0OyHH7 gDpyW618derjc7kLUwvCupWSPVJgLJIBQ2QteHbA+ePU1rP3c964OPhuEEL5oOubfSE9j9TRXI3 Yzmo6vuqNommadEdqz4uTiu/wTg0pjwcKhDYE5bMC5pQWPDDJW2V06qJcgb4MbB2AAa/LUoPlDT zp3BXNi0+ZVGAgmPy3c1nqcycL0qBp2qLvDT3iWPP+3ekxsOVq5MslOo58GhLd1X/F3xdsvl8Y0 mdZRHFaHuvbHJm3JrF+gTRp8/ys5yAKi8LZLzvmnUEeC1k9djnrEki9TRcEG4KQBFdEcELc1erw IzTdgS8jvmr1iVOSqXLwKX4nMdj/5ThEg4aOMm3gd2U5kEZZ/nT+aYE2/pGHY0akfX45M=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

FT4222H exports a USB interface to operate as I2C bus master when set up
(via the DCNF pins) in configuration mode 0 or 3.
The USB communication protocol implemented by the FT4222 chip is not
publicly documented, therefore the name assigned to the various defines
used in the USB communication code is a semi-educated guess after sniffing
USB traffic generated with the FTDI FT4222 userspace library.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
Changes from v2 [2]:
- added delay between retries and decreased maximum retries in
  ft4222_i2c_get_status()

Changes from v1 [1]:
- replaced magic numbers with symbolic constants
- changed enums to use capital letters
- decreased max retries in ft4222_i2c_get_status()
- removed not so useful dev_dbg() call
- removed handling of configuration modes 1 and 2
- miscellaneous stylistic changes

[1] https://lore.kernel.org/linux-i2c/20260106170807.3964886-1-flavra@baylibre.com/T/
[2] https://lore.kernel.org/linux-i2c/20260116101816.1200416-1-flavra@baylibre.com/T/

 .../ABI/testing/sysfs-bus-i2c-devices-ft4222  |   7 +
 drivers/i2c/busses/Kconfig                    |  11 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ft4222.c               | 454 ++++++++++++++++++
 4 files changed, 473 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-ft4222
 create mode 100644 drivers/i2c/busses/i2c-ft4222.c

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-ft4222 b/Documentation/ABI/testing/sysfs-bus-i2c-devices-ft4222
new file mode 100644
index 000000000000..fdd921f723bd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-ft4222
@@ -0,0 +1,7 @@
+What:		/sys/bus/i2c/devices/i2c-<bus-id>/i2c_freq
+Date:		January 2026
+KernelVersion:	6.20
+Contact:	Francesco Lavra <flavra@baylibre.com>
+Description:	(RW) I2C bus clock frequency, expressed in Hz.
+		Accepted values range from 100000 (standard mode) to 3400000
+		(high-speed mode).
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index bcbc6693dbe4..313613e07abe 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1462,6 +1462,17 @@ config I2C_TINY_USB
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-tiny-usb.
 
+config I2C_FT4222
+	tristate "FTDI FT4222 USB to I2C interface"
+	depends on USB
+	help
+	  Include support for interfacing with I2C devices via an FTDI
+	  FT4222H USB device that acts as I2C master.
+	  The I2C interface is available when the chip is set up (via the
+	  DCNF0 and DCNF1 pins) in configuration mode 0 or 3.
+
+	  If built as a module, this driver creates a module called i2c-ft4222.
+
 config I2C_VIPERBOARD
 	tristate "Viperboard I2C master support"
 	depends on MFD_VIPERBOARD && USB
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index e1a71830321c..bb708372ef3a 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -144,6 +144,7 @@ obj-$(CONFIG_I2C_PCI1XXXX)	+= i2c-mchp-pci1xxxx.o
 obj-$(CONFIG_I2C_ROBOTFUZZ_OSIF)	+= i2c-robotfuzz-osif.o
 obj-$(CONFIG_I2C_TAOS_EVM)	+= i2c-taos-evm.o
 obj-$(CONFIG_I2C_TINY_USB)	+= i2c-tiny-usb.o
+obj-$(CONFIG_I2C_FT4222)	+= i2c-ft4222.o
 obj-$(CONFIG_I2C_VIPERBOARD)	+= i2c-viperboard.o
 
 # Other I2C/SMBus bus drivers
diff --git a/drivers/i2c/busses/i2c-ft4222.c b/drivers/i2c/busses/i2c-ft4222.c
new file mode 100644
index 000000000000..22761c0be9a2
--- /dev/null
+++ b/drivers/i2c/busses/i2c-ft4222.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FTDI FT4222H USB-to-I2C bridge
+ */
+
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#define FT4222_CONF0	0x18
+#define FT4222_CONF3	0x17
+
+/* USB endpoints */
+#define FT4222_EP_CTRL	0
+#define FT4222_EP_RX	1
+#define FT4222_EP_TX	2
+
+/* USB request values */
+#define FT4222_REQ_CMD_GET	0x20
+#define FT4222_REQ_CMD_SET	0x21
+
+/* USB request types */
+#define FT4222_REQTYPE_CMD_GET	0xC0
+#define FT4222_REQTYPE_CMD_SET	0x40
+
+#define FT4222_REQIDX	0x0001
+
+#define FT4222_CMD_I2C_ENABLE	0x05
+#define FT4222_CMD_I2C_RESET	0x51
+#define FT4222_CMD_I2C_CLOCK	0x52
+
+#define FT4222_CMD_SYS_CLK	0x0004
+#define FT4222_CMD_I2C_STATUS	0xF5B4
+
+#define FT4222_I2C_CLK_M_LOW	8
+#define FT4222_I2C_CLK_M_HIGH	6
+#define FT4222_I2C_CLK_N_HIGH	0xC0
+
+/*
+ * Tx header:
+ * - I2C device address + R/W bit (1 byte)
+ * - flags (1 byte)
+ * - message length (2 bytes)
+ */
+#define FT4222_TX_HDRLEN	4
+
+#define FT4222_RX_HDRLEN	2
+
+#define FT4222_BULK_MAXLEN	512
+#define FT4222_IO_TIMEOUT	5000
+
+#define FT4222_FLAG_START	0x2
+#define FT4222_FLAG_RESTART	0x3
+#define FT4222_FLAG_STOP	0x4
+#define FT4222_FLAG_NONE	0x80
+
+/* Status flags */
+#define FT4222_I2C_CTRL_BUSY	(1 << 0)
+#define FT4222_I2C_ERROR	(1 << 1)
+#define FT4222_I2C_ADDR_NACK	(1 << 2)
+#define FT4222_I2C_DATA_NACK	(1 << 3)
+#define FT4222_I2C_ARB_LOST	(1 << 4)
+#define FT4222_I2C_CTRL_IDLE	(1 << 5)
+#define FT4222_I2C_BUS_BUSY	(1 << 6)
+
+enum ft4222_sys_clk {
+	FT4222_SYS_CLK_60 = 0,
+	FT4222_SYS_CLK_24,
+	FT4222_SYS_CLK_48,
+	FT4222_SYS_CLK_80,
+};
+
+struct ft4222_i2c {
+	struct i2c_adapter adapter;
+	struct usb_device *udev;
+	u8 ubuf[FT4222_BULK_MAXLEN];
+	unsigned int sys_clk;	/* system clock frequency */
+	unsigned int freq;	/* I2C bus frequency */
+};
+
+static int ft4222_cmd_set(struct ft4222_i2c *ftdi, u8 cmd, u8 val)
+{
+	struct usb_device *udev = ftdi->udev;
+
+	return usb_control_msg(udev, usb_sndctrlpipe(udev, FT4222_EP_CTRL),
+			       FT4222_REQ_CMD_SET, FT4222_REQTYPE_CMD_SET,
+			       cmd | (((u16)val) << 8), FT4222_REQIDX, NULL, 0,
+			       FT4222_IO_TIMEOUT);
+}
+
+static int ft4222_cmd_get(struct ft4222_i2c *ftdi, u16 cmd, u8 *val)
+{
+	struct usb_device *udev = ftdi->udev;
+	int ret;
+
+	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, FT4222_EP_CTRL),
+			      FT4222_REQ_CMD_GET, FT4222_REQTYPE_CMD_GET, cmd,
+			      FT4222_REQIDX, ftdi->ubuf, sizeof(*val),
+			      FT4222_IO_TIMEOUT);
+	if (ret == sizeof(*val))
+		*val = ftdi->ubuf[0];
+	else if (ret >= 0)	/* unexpected number of bytes transferred */
+		ret = -EIO;
+	return ret;
+}
+
+static int ft4222_i2c_reset(struct ft4222_i2c *ftdi)
+{
+	return ft4222_cmd_set(ftdi, FT4222_CMD_I2C_RESET, 1);
+}
+
+static int ft4222_i2c_get_status(struct ft4222_i2c *ftdi)
+{
+	/*
+	 * Multiple retries are needed mostly when retrieving the controller
+	 * status after doing a write with the I2C bus operating at a low speed.
+	 * Empirical tests conducted at 100 kHz showed that after a
+	 * maximum-sized (512-byte) write, up to 4 retries are needed before the
+	 * chip clears its CTRL_BUSY flag (on the condition that a delay is
+	 * inserted between retries).
+	 */
+	const int max_retries = 5;
+	int retry;
+	u8 status;
+
+	for (retry = 0; retry < max_retries; retry++) {
+		int ret = ft4222_cmd_get(ftdi, FT4222_CMD_I2C_STATUS, &status);
+
+		if (ret < 0)
+			return ret;
+		if (!(status & FT4222_I2C_CTRL_BUSY))
+			break;
+		msleep(10);
+	}
+	if (retry == max_retries) {
+		ft4222_i2c_reset(ftdi);
+		return -ETIMEDOUT;
+	}
+	if (!(status & FT4222_I2C_ERROR))
+		return 0;
+	if (status & FT4222_I2C_ADDR_NACK)
+		return -ENXIO;
+	else if (status & FT4222_I2C_DATA_NACK)
+		return -EIO;
+	else
+		return -EBUSY;
+}
+
+static int ft4222_i2c_write(struct ft4222_i2c *ftdi, u8 flags, u8 slave_addr,
+			    u8 *data, int len)
+{
+	struct usb_device *udev = ftdi->udev;
+	unsigned int pipe = usb_sndbulkpipe(udev, FT4222_EP_TX);
+	u8 *buf = ftdi->ubuf;
+	int written = 0;
+
+	dev_dbg(&ftdi->adapter.dev, "write to 0x%02x, flags 0x%02x, len %d",
+		slave_addr, flags, len);
+	buf[0] = slave_addr << 1;
+	buf[2] = buf[3] = 0;
+	do {
+		int pkt_len = min(FT4222_TX_HDRLEN + len - written,
+				  FT4222_BULK_MAXLEN);
+		bool first_pkt = (written == 0);
+		bool last_pkt = (written + pkt_len == FT4222_TX_HDRLEN + len);
+		int ret, actual_len;
+
+		buf[1] = 0;
+		if (first_pkt)
+			buf[1] |= flags & FT4222_FLAG_RESTART;
+		if (last_pkt)
+			buf[1] |= flags & FT4222_FLAG_STOP;
+		if (buf[1] == 0)
+			buf[1] = FT4222_FLAG_NONE;
+		memcpy(buf + FT4222_TX_HDRLEN, data + written,
+		       pkt_len - FT4222_TX_HDRLEN);
+		ret = usb_bulk_msg(udev, pipe, buf, pkt_len, &actual_len,
+				   FT4222_IO_TIMEOUT);
+		if (ret < 0)
+			return ret;
+		if (actual_len < pkt_len)
+			return -EIO;
+		ret = ft4222_i2c_get_status(ftdi);
+		if (ret < 0)
+			return ret;
+		written += pkt_len - FT4222_TX_HDRLEN;
+	} while (written < len);
+	return 0;
+}
+
+static int ft4222_i2c_read(struct ft4222_i2c *ftdi, u8 flags, u8 slave_addr,
+			   u8 *data, int len)
+{
+	struct usb_device *udev = ftdi->udev;
+	unsigned int pipe = usb_rcvbulkpipe(udev, FT4222_EP_RX);
+	u8 *buf = ftdi->ubuf;
+	int actual_len;
+	int read = 0;
+	int ret;
+
+	dev_dbg(&ftdi->adapter.dev, "read from 0x%02x, flags 0x%02x, len %d",
+		slave_addr, flags, len);
+	buf[0] = (slave_addr << 1) | 1;
+	buf[1] = flags;
+	buf[2] = len >> 8;
+	buf[3] = len;
+	ret = usb_bulk_msg(udev, usb_sndbulkpipe(udev, FT4222_EP_TX), buf,
+			   FT4222_TX_HDRLEN, &actual_len, FT4222_IO_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (actual_len != FT4222_TX_HDRLEN)
+		return -EIO;
+	do {
+		int pkt_len = min(FT4222_RX_HDRLEN + len - read,
+				  FT4222_BULK_MAXLEN);
+
+		ret = usb_bulk_msg(udev, pipe, buf, pkt_len, &actual_len,
+				   FT4222_IO_TIMEOUT);
+		if (ret < 0)
+			return ret;
+		if (actual_len < FT4222_RX_HDRLEN)
+			return -EIO;
+		actual_len -= FT4222_RX_HDRLEN;
+		memcpy(data + read, buf + FT4222_RX_HDRLEN, actual_len);
+		read += actual_len;
+	} while (read < len);
+	return ft4222_i2c_get_status(ftdi);
+}
+
+static int ft4222_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msg,
+			   int num)
+{
+	struct ft4222_i2c *ftdi = container_of(adapter, struct ft4222_i2c,
+					       adapter);
+	int ret;
+	int i;
+
+	dev_dbg(&adapter->dev, "transfer with %d message(s)", num);
+	for (i = 0; i < num; ++i) {
+		const u8 addr = msg[i].addr;
+		const u16 len = msg[i].len;
+		u8 *buf = msg[i].buf;
+		u8 flags;
+
+		flags = ((i == 0) ? FT4222_FLAG_START : FT4222_FLAG_RESTART);
+		if (i == num - 1)
+			flags |= FT4222_FLAG_STOP;
+		if (msg[i].flags & I2C_M_RD)
+			ret = ft4222_i2c_read(ftdi, flags, addr, buf, len);
+		else
+			ret = ft4222_i2c_write(ftdi, flags, addr, buf, len);
+		if (ret < 0)
+			goto err;
+	}
+	return num;
+err:
+	ft4222_i2c_reset(ftdi);
+	return ret;
+}
+
+static u32 ft4222_i2c_func(struct i2c_adapter *adapter)
+{
+	/*
+	 * The device seems to be unable to perform I2C transactions with 0 data
+	 * length, hence no support for SMBus quick command.
+	 */
+	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL_ALL & ~I2C_FUNC_SMBUS_QUICK);
+}
+
+static const struct i2c_algorithm ft4222_i2c_algo = {
+	.master_xfer = ft4222_i2c_xfer,
+	.functionality = ft4222_i2c_func,
+};
+
+static int ft4222_i2c_setup(struct ft4222_i2c *ftdi, unsigned int freq)
+{
+	bool hi_freq = (freq > I2C_MAX_FAST_MODE_FREQ);
+	const int m = hi_freq ? FT4222_I2C_CLK_M_HIGH : FT4222_I2C_CLK_M_LOW;
+	u8 n;
+	int ret;
+
+	if ((freq < I2C_MAX_STANDARD_MODE_FREQ) ||
+	    (freq > I2C_MAX_HIGH_SPEED_MODE_FREQ))
+		return -EINVAL;
+	n = DIV_ROUND_UP(ftdi->sys_clk, freq * m) - 1;
+	if (hi_freq)
+		n |= FT4222_I2C_CLK_N_HIGH;
+	ret = ft4222_cmd_set(ftdi, FT4222_CMD_I2C_CLOCK, n);
+	if (ret < 0)
+		return ret;
+	ret = ft4222_cmd_set(ftdi, FT4222_CMD_I2C_ENABLE, 1);
+	if (ret < 0)
+		return ret;
+	ftdi->freq = freq;
+	return 0;
+}
+
+static struct ft4222_i2c *ft4222_i2c_from_dev(struct device *dev)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(dev);
+
+	return container_of(adapter, struct ft4222_i2c, adapter);
+}
+
+static ssize_t i2c_freq_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct ft4222_i2c *ftdi = ft4222_i2c_from_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", ftdi->freq);
+}
+
+static ssize_t i2c_freq_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	unsigned int i2c_freq;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &i2c_freq);
+	if (!ret) {
+		struct ft4222_i2c *ftdi = ft4222_i2c_from_dev(dev);
+
+		ret = ft4222_i2c_setup(ftdi, i2c_freq);
+	}
+	return ret < 0 ? ret : count;
+}
+
+static DEVICE_ATTR_RW(i2c_freq);
+
+static struct attribute *ft4222_attrs[] = {
+	&dev_attr_i2c_freq.attr,
+	NULL
+};
+
+static const struct attribute_group ft4222_attr_group = {
+	.attrs = ft4222_attrs,
+};
+
+static const struct attribute_group *ft4222_attr_groups[] = {
+	&ft4222_attr_group,
+	NULL
+};
+
+static int ft4222_i2c_init(struct usb_interface *interface)
+{
+	struct device *dev = &interface->dev;
+	struct i2c_adapter *adapter;
+	struct ft4222_i2c *ftdi;
+	unsigned int sys_clk;
+	u8 sys_clk_enum;
+	int ret;
+
+	ftdi = devm_kmalloc(dev, sizeof(*ftdi), GFP_KERNEL);
+	if (!ftdi)
+		return -ENOMEM;
+	ftdi->udev = interface_to_usbdev(interface);
+
+	ret = ft4222_cmd_get(ftdi, FT4222_CMD_SYS_CLK, &sys_clk_enum);
+	if (ret < 0)
+		return ret;
+	switch (sys_clk_enum) {
+	case FT4222_SYS_CLK_60:
+		sys_clk = 60000000;
+		break;
+	case FT4222_SYS_CLK_24:
+		sys_clk = 24000000;
+		break;
+	case FT4222_SYS_CLK_48:
+		sys_clk = 48000000;
+		break;
+	case FT4222_SYS_CLK_80:
+		sys_clk = 80000000;
+		break;
+	default:
+		dev_err(dev, "unknown system clock setting %d", sys_clk_enum);
+		return -EOPNOTSUPP;
+	}
+	ftdi->sys_clk = sys_clk;
+
+	ret = ft4222_i2c_setup(ftdi, I2C_MAX_FAST_MODE_FREQ);
+	if (ret < 0)
+		return ret;
+	ret = ft4222_i2c_reset(ftdi);
+	if (ret < 0)
+		return ret;
+
+	adapter = &ftdi->adapter;
+	memset(adapter, 0, sizeof(*adapter));
+	adapter->owner = THIS_MODULE;
+	adapter->algo = &ft4222_i2c_algo;
+	adapter->dev.parent = dev;
+	adapter->dev.groups = ft4222_attr_groups;
+	snprintf(adapter->name, sizeof(adapter->name),
+		 "FT4222 USB-to-I2C %03d-%03d", ftdi->udev->bus->busnum,
+		 ftdi->udev->devnum);
+	ret = devm_i2c_add_adapter(dev, adapter);
+	if (ret < 0)
+		return ret;
+	dev_dbg(&adapter->dev, "system clock frequency %d Hz", sys_clk);
+	return 0;
+}
+
+static u8 ft4222_get_conf(struct usb_interface *interface)
+{
+	struct usb_device *udev = interface_to_usbdev(interface);
+	u16 dev_type = udev->descriptor.bcdDevice;
+
+	return dev_type >> 8;
+}
+
+static int ft4222_i2c_probe(struct usb_interface *interface,
+			    const struct usb_device_id *id)
+{
+	int intf = interface->cur_altsetting->desc.bInterfaceNumber;
+	u8 conf_mode;
+
+	/*
+	 * When FT4222H is set up (via the DCNF pins) in configuration mode 0 or
+	 * 3, its USB interface number 0 can be used to operate it as I2C bus
+	 * master.
+	 */
+	if (intf != 0)
+		return -ENODEV;
+	conf_mode = ft4222_get_conf(interface);
+	if ((conf_mode != FT4222_CONF0) && (conf_mode != FT4222_CONF3))
+		return -ENODEV;
+
+	return ft4222_i2c_init(interface);
+}
+
+static void ft4222_i2c_disconnect(struct usb_interface *interface)
+{
+}
+
+static const struct usb_device_id ft4222_id_table[] = {
+	{ USB_DEVICE(0x0403, 0x601C) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, ft4222_id_table);
+
+static struct usb_driver ft4222_i2c_usb_driver = {
+	.name = "i2c-ft4222",
+	.probe = ft4222_i2c_probe,
+	.disconnect = ft4222_i2c_disconnect,
+	.id_table = ft4222_id_table,
+};
+
+module_usb_driver(ft4222_i2c_usb_driver);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("FT4222H USB-to-I2C bridge");
-- 
2.39.5

