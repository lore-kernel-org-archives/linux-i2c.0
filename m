Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370762;
	b=onbHMWpBMTWqrpuEH6WxKJw7kSCSfzsOJEBb4xcN4OWbwvr1joJ4bCPc8UXqHZnRA4Fi
	 adeg/i6IciC0b2vRHYCqAdDaTF7R0JI5APeaBIcSUrBd/pFB4RDa76rpXQvqt7aUqm61W
	 chtyUFF3quTp8hvVXIUpitb2Hm52/1sipFWLM1RMz9oSzKfAM60LwfIvops4Op7Vy7ziL
	 I4dBm5egeSrGQzigi6HXqsO/FQk7wFhouCrQOG1jd2VMfKU5VFA5A2nv40yeNUDbIhPBc
	 Ps/MS5znGRyr5NKycDQEeFya1Yyy67Iz/3tgrX17g9NorFA1G/l7XL6Fd3hs5nfNPGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RZzd/00KHA6UQmnnP7AIA0dfP5EP7jOE3/OxHm1kiZ0=;
	b=QSJHTLqgk6lVrW5KFdQXyOjU17Af4kZ16/puENoa30Zw0PVQMGNn+lMwaV/hqkl4tU3S
	 lmr/LvX5X0NkGl+qlBY0gY6FFzcVMsQNZsMzfvegbvjwSV4VFfWsk6kZc6iG92/bq2ByM
	 X0gLMjdfaHVGxWyLU/Or/PmGTLtAWtbPsjEcmJbMpWfJHkSElGV1g8Vd//JSC2wddRxAh
	 9dbuhDsfQpr+zTfBSuuQnThM3rTZlUZLCmdDBjONWCDkuV/s1yTzeGkAcqllnurj5z1b1
	 64xdUioBGuPWXdLU/KTTEpADnlzWo4ZZUQ1+8yDhTb5nIljggWQPq++0SY2jisec1Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RMaf3jlY;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C216606A338
	for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 04:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C216606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RMaf3jlY
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3712b6d9843so2637604eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 20:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370761; x=1794975561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZzd/00KHA6UQmnnP7AIA0dfP5EP7jOE3/OxHm1kiZ0=;
        b=RMaf3jlYLyZ/HLW/+KYXVbeUs7XPsT1EqYJa5ckIduBmXbWd9U+SwfXE/Wq/m8otmw
         2bIXkGWle81gjIwJlZ8cTHs4dQA/TvfVprmpXzIAqGx0h8r1ytzU2NWz48IzbK9Q9BOJ
         0PfaZz3e2Jn07Ez0LsxkD8jX9SwwZhIJ4a69Hbm4ak5uKX9oQ9wMxNtNVGWDYAHoeOyD
         99bHD0DhJeqUuX/vHEo+vLFoyDEDOfACpr9exr6r07h6bhQqFqqmRnQJFwylKPiQB0m6
         IsxvxHMJcDhNoWovdopSaNAVBThNikiZkvi1YepkqOqTyUl8zlc7O4Cvsi+E7k9i7KSC
         b2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370761; x=1794975561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZzd/00KHA6UQmnnP7AIA0dfP5EP7jOE3/OxHm1kiZ0=;
        b=0TSJDGOctZS6jG5GeZ/xIlMTX3fHPhA6b18DnyfhB7Y6KU8oSOEDw1GXh2v9oeNT64
         NzZzE5DmTI2pj4OobtAH0zCzWaL9XmWNdZ0PpEmSTUYeB8y3GygnVSxFh9YOTg2tF7r3
         dKP9RSNca/FGimAQQGcFF2uqTq1qUcRfzksk9ebcsdeKnNlfuhVAPesUBmiU6PqizNtq
         z1vXTML+8H9AZbr5svdBCAJPUd+qm7Y3kCUU/KI/4VlXx0EmSQ/xlJxWSGHXxiFwCYLh
         V/gqqSxu+nf+es412bzG5vLZRv7nFnfvAGyXPOiMJQMckstoNmcvin9GPR+Hw4+B6tAa
         TnwA==
X-Gm-Message-State: APuU4Z/fZR2tsovcDzVz5C7M9tgqlGELTpLo1cuKm9qiUzVCfWd1y67h
	2QhRKlIRORgzXbRcJL2MACz//agks9vF27Wv4HCmpfRWGG+FNYAA0s1G
X-Gm-Gg: AYBFou1tR6OGy7ecye0f88cbgSlVGXCGr26ToD6t2M4f+LYxNjaLoTQlhH3IBU6wvqW
	3DOu0VkxZq1RCGtl08TQwK1eOcBrCXlRuBTagPMIjDs1LuFyppd3oe3nDLsdCt4gkwLRHeL9CW3
	bwkaMfG7EPByAiHzoVjxtrPfglZcVSSq8+oedORbID7PPwB9Nqbg+iCotIM7xQ+t+EKnR0d7g3t
	UaJ1aHWAhd0VJWMTzzpVrhvPzRhLxPaGKermyzigje/ehP4+jfB5wl1fUU1ILfAxiAzxGwNBEH+
	UowBCAPdnGdo6Q+eR/XbbqsPF3AgxKmcqrlC3tuyJsmAIbULTzo/nFUQHX5RzHndFxuCDVdu9GQ
	oCdRoQ6y+SW0J64p+KehkQT/zhS4ZIMkWQgq7d6cyAAwHgkBpTKe5TOUp0plvxj515RPBGoKmfw
	A5fl2Jc8aiSKKmSs8ZU00169gt1L7SgH4U23MlJ5Yl6cSXOsH5rSo0s7a9uolbuR9V0GiXr91IO
	d1iL/871GgAZG09jJw4Hje9S6HJq2w+lrgCO7Sa2WOn2enPiTPBYS3HZPj/wffrTrb/IOG6Llxr
	VTLpjieXmU5XPctlErnUALCz5E6c82n9aFefNQANTDxzfpa8CbPU9v59BzIyTUFPFhpKKWCxtiU
	k8czvhjhnaZriyrhxPFGqvZgptXzXjLvoJ4ZrPqj7m5vpbeb5xp68RfM6Xh4QhCJomJgzpkw1
X-Received: by 2002:a05:7301:b0f:b0:375:c862:31c with SMTP id 5a478bee46e88-3768730b2c7mr1832550eec.40.1794370761338;
        Tue, 10 Nov 2026 20:19:21 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11820704eec.15.2026.11.10.20.19.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 20:19:20 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] ptp: ocp: add WiWi Time Card production image support
Date: Tue, 10 Nov 2026 20:19:03 -0800
Message-ID: <20261111041904.48916-4-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111041904.48916-1-ahmadexp@gmail.com>
References: <20261111041904.48916-1-ahmadexp@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match WiWi 2163:1008, subsystem 10ee:0007, revision 2. The Xilinx
default subsystem ID is not a firmware-layout identifier. On the
verified 0x800f production image the register interface matches the
Celestica LitePCIe production image; the VID and flash header differ.

Translate a copy of each peripheral resource by 0x02000000 and its
interrupt input by 32. Use aligned 32-bit UART and XIIC register I/O.
Do not register the second GNSS UART: it exists but has no pin routing.
Leave non-WiWi resource tables and access modes unchanged.

CoreList is available via the configuration UART, not PCIe. Check the
PCI layout and the image ID at BAR0 + 0x02020000 before accessing the
remaining core signatures or initializing any peripherals. Keep exact
matches until a compatibility convention for later images is agreed.

The LitePCIe per-input gate at BAR0 + 0x1800 must enable SPI before
child probing: SPI NOR identification can wait for an interrupt. Open
only the UART, I2C and SPI inputs first. Enable timing inputs after
registering the PHC and its consumers. Skip unwired GNSS2, HWICAP and
the separate EEPROM/RGB I2C inputs 17/18: this series does not register
consumers for them. The highest owned vector is 48, not 50. Keep child
interrupts available through removal, then mask the gate before freeing
the vectors.

Reject WiWi devlink flash updates before looking up or modifying an MTD
device. The WiWi image uses a different flash header and the vendor's
programming path requires a modified spi-xilinx. A recognized JEDEC ID
does not establish a supported update path. Leave existing boards' flash
operations intact.

Source: Thomas Schaub, NetTimeLogic, 10 November 2026, email cited with
permission. He tested the Time Card repository driver at 1d49e31 with
the WiWi ID on a production card. His separate fix opens the gate before
child probe on that driver. This implementation uses a selective mask;
his test was not a test of this net-next series.

On a WiWi production card, the driver bound, allocated 64 MSI-X
vectors and registered the PHC, PPS device and three UARTs. The SPI
NOR and both at24 devices bound. The PHC advanced by 3.000429460 s
across three one-second sleeps, within the host monotonic brackets.
The clock reported UNSYNCED at probe; neither PPS lock nor UTC
accuracy was established.

Tool-origin disclosure: Codex helped analyze supplied hardware evidence,
implement and test the adaptation, and draft the changelog and docs.
The revision reconciles Thomas's findings with the tested layout and
does not treat a proposed image-ID convention as a vendor guarantee.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 Documentation/networking/devlink/ptp_ocp.rst |  35 +++-
 drivers/ptp/ptp_ocp.c                        | 198 ++++++++++++++++++-
 2 files changed, 226 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
index f94b759d9..a81dc1136 100644
--- a/Documentation/networking/devlink/ptp_ocp.rst
+++ b/Documentation/networking/devlink/ptp_ocp.rst
@@ -54,7 +54,8 @@ selected with the component name.
      - Description
    * - (none)
      - The card's own flash, written through the SPI controller the driver
-       exposes.  The card runs the new image after its next reset.
+       exposes. Not supported on WiWi. The card runs the new image after
+       its next reset.
    * - ``fw.cpld``
      - The configuration flash of the TAP CPLD on ADVA TimeCard X1 boards,
        programmed over I2C with the MachXO3 in-system programming commands
@@ -73,3 +74,35 @@ with the standard devlink status notifications.
 Example::
 
     $ devlink dev flash pci/0000:02:00.0 file adva-cpld.bin component fw.cpld
+
+WiWi production firmware
+========================
+
+WiWi Time Cards with PCI ID ``2163:1008`` and subsystem ID ``10ee:0007``
+use the Celestica register layout behind a LitePCIe bridge. The driver
+currently supports revision 2 with production image ID ``0x0000800f``
+(reported as firmware version ``1.15``). It verifies the PCI layout and
+the image/core versions before initializing the card. Other firmware
+layouts are rejected, even if they use the same PCI ID.
+
+CoreList is readable over the configuration UART, not over PCIe. The
+driver reads the image ID at BAR0 offset ``0x02020000`` before reading the
+known core version registers. Neither a higher image ID nor the Xilinx
+default subsystem ID guarantees a compatible layout.
+
+The image uses the Celestica LitePCIe production map: add ``0x02000000``
+to the peripheral offsets and use aligned 32-bit MMIO. Interrupt input
+``n`` uses MSI-X vector ``n + 32``. The per-input enable mask is at BAR0
+offset ``0x1800``. The driver enables the SPI interrupt before probing
+the flash and defers timing interrupts until the PHC is ready. GNSS2 is
+instantiated but not wired to pins, so no second GNSS port is registered.
+The separate EEPROM and RGB I2C inputs (17 and 18) have no handlers in
+this driver and stay masked; these are distinct from its I2C input 7.
+
+WiWi firmware updates through ``devlink dev flash`` are not supported.
+The WiWi image has a different flash header from the Celestica image.
+The golden image at flash offset zero boots the update image via MultiBoot
+with watchdog fallback. The vendor's programming path requires a modified
+``spi-xilinx`` driver. Recognizing the SPI NOR does not validate that path
+or the image header. Successful clock registration does not establish
+GNSS synchronization or valid UTC.
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 625a85b2d..ee2242389 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -34,6 +34,23 @@
 #define PCI_VENDOR_ID_CELESTICA			0x18d4
 #define PCI_DEVICE_ID_CELESTICA_TIMECARD	0x1008
 
+#define PCI_VENDOR_ID_WIWI			0x2163
+#define PCI_DEVICE_ID_WIWI_TIMECARD		0x1008
+
+/* WiWi production firmware uses the Celestica map behind LitePCIe. */
+#define OCP_WIWI_MMIO_OFFSET			0x02000000
+#define OCP_WIWI_IRQ_OFFSET			32
+#define OCP_WIWI_MSI_ENABLE			0x1800
+/* Upper 32 bits: UARTs, I2C and SPI can interrupt during probe. */
+#define OCP_WIWI_PERIPHERAL_IRQS			(BIT(3) | BIT(5) | BIT(7) | \
+						 BIT(9) | BIT(10))
+/* PPS/TS0/TS1, TS2, GEN1-4 and TS3/TS4. */
+#define OCP_WIWI_TIMING_IRQS			(GENMASK(2, 0) | BIT(6) | \
+						 GENMASK(16, 11))
+/* Leave unwired GNSS2 (4), HWICAP (8) and EEPROM/RGB I2C (17/18) masked. */
+#define OCP_WIWI_IRQS				(OCP_WIWI_PERIPHERAL_IRQS | \
+						 OCP_WIWI_TIMING_IRQS)
+
 #define PCI_VENDOR_ID_OROLIA			0x1ad7
 #define PCI_DEVICE_ID_OROLIA_ARTCARD		0xa000
 
@@ -404,6 +421,8 @@ struct ptp_ocp {
 	struct delayed_work	sync_work;
 	int			id;
 	int			n_irqs;
+	bool			wiwi;
+	void __iomem		*wiwi_msi;
 	struct ptp_ocp_serial_port	port[__PORT_COUNT];
 	bool			fw_loader;
 	u8			fw_tag;
@@ -1321,6 +1340,13 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
 static const struct pci_device_id ptp_ocp_pcidev_id[] = {
 	{ PCI_DEVICE_DATA(META, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_WIWI, PCI_DEVICE_ID_WIWI_TIMECARD,
+			       PCI_VENDOR_ID_XILINX, 0x0007),
+		.class = PCI_CLASS_MEMORY_OTHER << 8,
+		.class_mask = 0xffffff,
+		.driver_data = (kernel_ulong_t)ocp_fb_resource,
+	},
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
 	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
 	{ PCI_DEVICE_DATA(ADVA, TIMECARD_X1, &ocp_adva_x1_resource) },
@@ -2173,6 +2199,11 @@ ptp_ocp_devlink_flash_update(struct devlink *devlink,
 	const char *msg;
 	int err;
 
+	if (bp->wiwi) {
+		NL_SET_ERR_MSG_MOD(extack, "WiWi flash updates are not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (params->component) {
 		if (!bp->has_cpld ||
 		    strcmp(params->component, ADVA_CPLD_COMPONENT)) {
@@ -2331,20 +2362,29 @@ ptp_ocp_register_spi(struct ptp_ocp *bp, struct ocp_resource *r)
 }
 
 static struct platform_device *
-ptp_ocp_i2c_bus(struct pci_dev *pdev, struct ocp_resource *r, int id)
+ptp_ocp_i2c_bus(struct ptp_ocp *bp, struct ocp_resource *r, int id)
 {
+	struct xiic_i2c_platform_data wiwi_data;
+	struct pci_dev *pdev = bp->pdev;
 	struct ptp_ocp_i2c_info *info;
 	struct resource res[2];
 	resource_size_t start;
+	const void *data;
 
 	info = r->extra;
+	data = info->data;
+	if (bp->wiwi) {
+		wiwi_data = *(struct xiic_i2c_platform_data *)info->data;
+		wiwi_data.force_32bit_access = true;
+		data = &wiwi_data;
+	}
 	start = pci_resource_start(pdev, 0) + r->offset;
 	res[0] = DEFINE_RES_MEM(start, r->size);
 	res[1] = DEFINE_RES_IRQ(pci_irq_vector(pdev, r->irq_vec));
 
 	return platform_device_register_resndata(&pdev->dev, info->name,
 						 id, res, ARRAY_SIZE(res),
-						 info->data, info->data_size);
+						 data, info->data_size);
 }
 
 static int
@@ -2369,7 +2409,7 @@ ptp_ocp_register_i2c(struct ptp_ocp *bp, struct ocp_resource *r)
 
 	sprintf(buf, "%s.%d", info->name, id);
 	devm_clk_hw_register_clkdev(&pdev->dev, clk, NULL, buf);
-	p = ptp_ocp_i2c_bus(bp->pdev, r, id);
+	p = ptp_ocp_i2c_bus(bp, r, id);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
@@ -2640,7 +2680,7 @@ ptp_ocp_serial_line(struct ptp_ocp *bp, struct ocp_resource *r)
 	 */
 	memset(&uart, 0, sizeof(uart));
 	uart.port.dev = &pdev->dev;
-	uart.port.iotype = UPIO_MEM;
+	uart.port.iotype = bp->wiwi ? UPIO_MEM32 : UPIO_MEM;
 	uart.port.regshift = 2;
 	uart.port.mapbase = pci_resource_start(pdev, 0) + r->offset;
 	uart.port.irq = pci_irq_vector(pdev, r->irq_vec);
@@ -3109,7 +3149,26 @@ ptp_ocp_register_resources(struct ptp_ocp *bp, kernel_ulong_t driver_data)
 	int err = 0;
 
 	table = (struct ocp_resource *)driver_data;
-	for (r = table; r->setup; r++) {
+	for (; table->setup; table++) {
+		struct ocp_resource translated = *table;
+
+		r = table;
+		if (bp->wiwi) {
+			/* GNSS2 is instantiated but not routed to FPGA pins. */
+			if (r->setup == ptp_ocp_register_serial &&
+			    r->bp_offset == offsetof(struct ptp_ocp,
+						    port[PORT_GNSS2]))
+				continue;
+			/* Never modify the resource table shared with other cards. */
+			if (translated.offset)
+				translated.offset += OCP_WIWI_MMIO_OFFSET;
+			if (r->setup == ptp_ocp_register_ext ||
+			    r->setup == ptp_ocp_register_serial ||
+			    r->setup == ptp_ocp_register_i2c ||
+			    r->setup == ptp_ocp_register_spi)
+				translated.irq_vec += OCP_WIWI_IRQ_OFFSET;
+			r = &translated;
+		}
 		if (!ptp_ocp_allow_irq(bp, r))
 			continue;
 		err = r->setup(bp, r);
@@ -5786,6 +5845,12 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	platform_device_unregister(bp->i2c_ctrl);
 	if (bp->i2c_clk)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
+	/* Child removal can need interrupts, notably SPI NOR reset. */
+	if (bp->wiwi_msi) {
+		iowrite32(0, bp->wiwi_msi);
+		iowrite32(0, bp->wiwi_msi + 4);
+		ioread32(bp->wiwi_msi);
+	}
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
 	mutex_destroy(&bp->cpld_lock);
@@ -5951,6 +6016,99 @@ ptp_ocp_sync_work(struct work_struct *work)
 	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
 }
 
+/*
+ * CoreList is accessible via the configuration UART, not via PCIe.
+ * Check the image ID first: an unknown image need not provide any of
+ * the subsequent registers. Only the verified fixed layout is supported.
+ */
+static int ptp_ocp_wiwi_validate(struct pci_dev *pdev)
+{
+	static const struct {
+		u32 offset;
+		u32 version;
+	} versions[] = {
+		{ 0x02020000, 0x0000800f }, /* image */
+		{ 0x0300000c, 0x01040000 }, /* clock */
+		{ 0x0301000c, 0x01030001 }, /* timestamp 0 */
+		{ 0x0302000c, 0x01030001 }, /* timestamp 1 */
+		{ 0x0306000c, 0x01030001 }, /* timestamp 2 */
+		{ 0x0311000c, 0x01030001 }, /* timestamp 3 */
+		{ 0x0312000c, 0x01030001 }, /* timestamp 4 */
+		{ 0x030c000c, 0x01030001 }, /* PPS timestamp */
+		{ 0x030d000c, 0x01030001 }, /* signal 1 */
+		{ 0x030e000c, 0x01030001 }, /* signal 2 */
+		{ 0x030f000c, 0x01030001 }, /* signal 3 */
+		{ 0x0310000c, 0x01030001 }, /* signal 4 */
+		{ 0x0303000c, 0x01030001 }, /* PPS generator */
+		{ 0x0304000c, 0x01030002 }, /* PPS input */
+		{ 0x0305000c, 0x02030002 }, /* ToD */
+		{ 0x0307000c, 0x02000002 }, /* IRIG input */
+		{ 0x0308000c, 0x02000001 }, /* IRIG output */
+		{ 0x0309000c, 0x00010002 }, /* DCF input */
+		{ 0x030a000c, 0x00010000 }, /* DCF output */
+		{ 0x030b000c, 0x02000002 }, /* NMEA output */
+	};
+	u32 table, pba, value;
+	void __iomem *base;
+	unsigned int i;
+	int cap, err;
+
+	cap = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
+	if (pdev->revision != 2 ||
+	    !(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
+	    pci_resource_len(pdev, 0) != 0x04000000 || !cap ||
+	    pci_msix_vec_count(pdev) != 64 ||
+	    pci_read_config_dword(pdev, cap + PCI_MSIX_TABLE, &table) ||
+	    pci_read_config_dword(pdev, cap + PCI_MSIX_PBA, &pba) ||
+	    table != 0x2000 || pba != 0x1808)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Unsupported WiWi PCI layout\n");
+
+	err = pci_request_region(pdev, 0, KBUILD_MODNAME);
+	if (err)
+		return err;
+
+	base = pci_iomap(pdev, 0, 0);
+	if (!base) {
+		err = -ENOMEM;
+		goto out_release;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(versions); i++) {
+		value = ioread32(base + versions[i].offset);
+		if (value != versions[i].version) {
+			dev_err(&pdev->dev,
+				"Unsupported WiWi register version %#x at %#x\n",
+				value, versions[i].offset);
+			err = -ENODEV;
+			break;
+		}
+	}
+	pci_iounmap(pdev, base);
+out_release:
+	pci_release_region(pdev, 0);
+	return err;
+}
+
+static int ptp_ocp_wiwi_irq_init(struct ptp_ocp *bp)
+{
+	void __iomem *msi;
+
+	msi = __ptp_ocp_get_mem(bp, pci_resource_start(bp->pdev, 0) +
+			      OCP_WIWI_MSI_ENABLE, 8);
+	if (IS_ERR(msi))
+		return PTR_ERR(msi);
+	bp->wiwi_msi = msi;
+
+	/* LiteX stores bits 63:32 before bits 31:0, as little-endian words. */
+	iowrite32(0, msi);
+	iowrite32(0, msi + 4);
+	if (ioread32(msi) || ioread32(msi + 4))
+		return -EIO;
+
+	return 0;
+}
+
 static int
 ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -5972,6 +6130,14 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	bp = devlink_priv(devlink);
+	bp->wiwi = pdev->vendor == PCI_VENDOR_ID_WIWI &&
+		   pdev->device == PCI_DEVICE_ID_WIWI_TIMECARD;
+	if (bp->wiwi) {
+		/* No IRQ allocation, bus mastering or FPGA writes before this. */
+		err = ptp_ocp_wiwi_validate(pdev);
+		if (err)
+			goto out_disable;
+	}
 	err = ptp_ocp_device_init(bp, pdev);
 	if (err)
 		goto out_disable;
@@ -5987,18 +6153,33 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	INIT_DELAYED_WORK(&bp->sync_work, ptp_ocp_sync_work);
 
+	if (bp->wiwi) {
+		err = ptp_ocp_wiwi_irq_init(bp);
+		if (err)
+			goto out;
+	}
+
 	/* compat mode.
 	 * Older FPGA firmware only returns 2 irq's.
 	 * allow this - if not all of the IRQ's are returned, skip the
 	 * extra devices and just register the clock.
 	 */
-	err = pci_alloc_irq_vectors(pdev, 1, 17, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (bp->wiwi)
+		err = pci_alloc_irq_vectors(pdev, 49, 64, PCI_IRQ_MSIX);
+	else
+		err = pci_alloc_irq_vectors(pdev, 1, 17,
+					    PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (err < 0) {
 		dev_err(&pdev->dev, "alloc_irq_vectors err: %d\n", err);
 		goto out;
 	}
 	bp->n_irqs = err;
 	pci_set_master(pdev);
+	/* SPI NOR probe needs interrupts, but timestamp consumers are not ready. */
+	if (bp->wiwi_msi) {
+		iowrite32(OCP_WIWI_PERIPHERAL_IRQS, bp->wiwi_msi);
+		ioread32(bp->wiwi_msi);
+	}
 
 	err = ptp_ocp_register_resources(bp, id->driver_data);
 	if (err)
@@ -6047,6 +6228,11 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			goto out_dpll;
 		}
 	}
+	/* All handlers and the PHC are ready for timestamp interrupts. */
+	if (bp->wiwi_msi) {
+		iowrite32(OCP_WIWI_IRQS, bp->wiwi_msi);
+		ioread32(bp->wiwi_msi);
+	}
 	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
 
 	return 0;
