Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853262;
	b=QuirbpZsj/Ro8YaMsvi0SyjSKr2P+C8bzJ50r7vrn0SB2OYwkZ/fM3atzlybbWN7hCSE
	 yJGh2eB8gDs7EEMzxSP1ABLqHfd6lS1saFd4yavzvNM+0hJ4CCLFgDWiifbhXFdyPOyww
	 zsKULCjdNhnBYBBLu0PB8Jow15Ts7pJgkjxp+uA5t14bFQX7iv90nNwicBn3P3upE2/Kb
	 jGoLUTjjH4uQuR6lHmYB/u2TRa39BG+xAIdSMf0WyggWw3rmbT7Q+SOnHtKyG6c7/Ut/H
	 w1fUZYpFyulhTZgqvmnQ30Q1Hz/vngZzqgMKT+nBkO2HRDQ5qC3ntmOrGMt3YlNba+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y8vKeC4ApgPKvtb5f83QUWlYjNGKfo0MCQ1lCHmqkXo=;
	b=EUw/vbhYfSazbdLUShN/5WB8CXxl4qbmVwnM9pZFoTm8aSYOoWcIdFeUm/lryPbEVeC6
	 CEbA4IHwWIHbxv/V7cfo92Ck3N6+WTyiGxHFldLcP33nEh5vTByBRHN1v5qUY26y4TV54
	 5RP3pe6al6QG6GJkwzTJ+2e/kUptYa76VHl3zJ5D1io9lGsr219zLItpUBAJJItPFkLjj
	 CBqCH/fyrlWbHbdnurAmVctTktpwrUsfZFK/ns4BgQYw9wTPgZ+PF8Gkvk4aK0EFey9OO
	 j7k7lifWJXIz/iW35QTZFjK6pcLcHlu4DqwPEAaWStaP6nZlMGENHcnXp9NC5C8UCeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8fzeRKe;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173AD606A329
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 18:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 173AD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8fzeRKe
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso2003635a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853261; x=1795458061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8vKeC4ApgPKvtb5f83QUWlYjNGKfo0MCQ1lCHmqkXo=;
        b=V8fzeRKe0oGo4rCimiTi77vYt3tRjLJfLRD0yqtNjjKqHb46isoCWjVaN3hPDdRBdK
         uX+tem2ioLtwU3pS59aB9cBxZMFG9p6O0HTDNvRVUBVKVOq4SvyyS/UnFO5cETI1PBg5
         WrB1DUYRCTuDzXUPW9NtfKoMcxFZcTwzjcyonec4i1lV9mQ7mUoLkqku3UBkhBzQEBtu
         km1VkK6tN+UnVPsNwGsb4xpREqD8hXCk8+qMs32/4Xmu/30CzcSwOd1e7kN3WN7r0kbs
         xwgxR7P090HtmF5hr1Pw1b+zCu+I8sbmVzld0EPIM4Wz5VbFghXxGaHDHMi6eUFgW2Zi
         IWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853261; x=1795458061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8vKeC4ApgPKvtb5f83QUWlYjNGKfo0MCQ1lCHmqkXo=;
        b=zoQz/9bCwLMsiDsvZAcTYSQGETISLHYibksZmgLaBTEHvCiad4lGuknGQt2w3dIwxe
         y9L/JaoezwjpFpAMVQb4KBFtnX+wmJvBn+xo4Mxv1X0AtJUfzV3D2CrwXboRugmFKQyY
         JPa+L0g+WwJre1eGI0Xj5jHAdtmIS8X4ylkKZlU4g0t0OBiiuvNNjrpksn5GczK5bBbV
         VSh1trqFM/Fc4M263CCl79MqyCv4Q26xLECT1t1Lx/fv3al9DUgu4FmqkhL1hIpdaOw6
         1PyB9mqtPf23Mcgwzo3VGcA8jmnoLKQPKT5J5ddKL1h3O4k3muaQ10PoC/HJqOmISrzz
         3kSg==
X-Forwarded-Encrypted: i=1; AL+hErEehRbb6pXeCha5GJgyDHbqXocsXDl8TUOY9KsD60cwpyrPyNgw84Bm2MmL0KKrf443EiGyHDPiDaw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s3Q4Uy9nXkGmsnhZlY/T5PWWvNfP0h6ZPwtqpgektMYB727bb
	jLxbp4giw3eNF2kOBdOFTY6lcQK7z9KD/6Kdwu1ljFznpjPPGjR7w8Ff
X-Gm-Gg: AZFdTZd4+mSe4oBETYNi9+cjJQ4c1dDDDpS/XIGv1uAF+z5UIJCf4ikQ82thtc2hpPn
	F/Pn3b7TuzrCm6MIahiLs1ld7T/vYovAPjJizHv6gaq9LIdUIyqt4T5aMi7kD50LQb9fd3Gr1L1
	I8RGqUkdPyI0YFxYc+p9dk3v2cb1bdNkyI61IzdDAo5dGEY5vei5JZsl2IJrS74UPAlTVQX7aNT
	Dryw/TGH27FGqvrB4kRz9EjL1eMrw6GbQzf/RngMys8UiuT/J0oU+KgbAbQ1rUCBMmaR9r2K4Ip
	w9QO+glqGsyPiSm/55ROwyTbicngdjVf83U1gObp8yXYi2R0w9hXZoSMYpLLgDy3k6gByL8Fe6C
	Z0yrLMbMkKlDxiyC52GUru32uz3BePd7fbmhnVOd3bLndWanSswIvuohb8Ksa2a2LQAwFWf19VE
	hT5f5mFURTEVY3pKb/Dwcc5HhdsR5TtTw4g+fmFul2VGu3AlDUvf12L3kY4djkYFOW2RdWdasCO
	Ffp2wZwRSS8OMqSzLB0v1Nc0S30qlnqy8USOCsppsvgbjd4MiMjbzFogZQvjxHIiw1igwwsX3e+
	7ZS2DJXVJgh56N398en+6Cj6hVHDFD0u0TwILT3lSRzsdg8h3i+YORWWYz5tVUsbCjWMwk8OQcW
	3sbLPAdoL9FfalVPo7+1ObqUTqruqkcHOITakwv/1HUw0QutaE56ZmAwMnzc=
X-Received: by 2002:a17:90b:548d:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3b1b0b836femr11432251a91.41.1794853261056;
        Mon, 16 Nov 2026 10:21:01 -0800 (PST)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm10002360a91.0.2026.11.16.10.20.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 10:20:58 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v3 3/3] ptp: ocp: support the WiWi revision 02 Time Card
Date: Mon, 16 Nov 2026 10:20:55 -0800
Message-ID: <20261116-wiwi-v3-87afa10a8-3-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116-wiwi-v3-87afa10a8-0-ahmadexp@gmail.com>
References: <20261116-wiwi-v3-87afa10a8-0-ahmadexp@gmail.com>
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

Match WiWi 2163:1008, subsystem 10ee:0007, without a class filter.
Resolve WiWi devices against the static PCI table so a dynamic ID
cannot substitute an unrelated resource layout. NetTimeLogic uses the PCI
Revision ID for incompatible interface changes. Revision 02 identifies
the LitePCIe/MSI-X interface; the Xilinx subsystem ID and FPGA build
number do not identify the register interface. Reject unknown revisions
and check BAR0 and the MSI-X layout before accessing FPGA registers.
Do not probe a CoreList or require exact versions of individual cores.

Report the full 32-bit image ID as the running firmware build. Derive
signal and frequency capabilities from the supported revision, not the
legacy FB build-number thresholds. This ID does not identify the boot
slot. Retain legacy version reporting on other cards.

WiWi shares the peripheral resource table used by the existing Celestica
entry (18d4:1008), not its PCI addressing and interrupt scheme.
For WiWi only, translate peripheral offsets by 0x02000000 and interrupt
inputs by 32. Use aligned 32-bit UART I/O and typed XIIC platform
data, sharing the EEPROM list but not casting another controller's data.
Do not expose an unvalidated second GNSS UART or PPS output source.
Keep the external SMA PPS2 input. The PCI revision identifies the host
interface, not optional board wiring. Use hardware selector values for
WiWi DPLL routing; preserve the existing behavior on other boards.

Enable the three UART and XIIC inputs during probe. Reject attempts to
arm a timestamper or generator with -EAGAIN until the timing gate write
has been flushed. This avoids relying on FPGA replay of a pulse caused
by a userspace request made while the gate was closed.

Do not register the WiWi SPI flash controller or enable its interrupt.
This prevents the driver from exposing raw MTD access to the golden
image. Reject devlink flash as well. The update format and controller
support are not validated; read access via MTD is intentionally lost.

Thomas Schaub of NetTimeLogic described the production register layout
and interrupt gate on 10 November 2026 and the PCI revision convention
on 11 November.

An earlier driver on revision 02, build 0x0000800f, registered 64 MSI-X
vectors, the PHC and three UARTs; both at24 devices bound and the PHC
advanced. That run did not test this revision's flash policy, GNSS2
routing policy or interrupt-readiness guard. No PPS lock, UTC accuracy
or replay of masked events is claimed.

Tool-origin disclosure: Codex assisted with the driver changes, tests
and changelog using the hardware evidence, revision rule and netdev review.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 Documentation/networking/devlink/ptp_ocp.rst |  47 +++-
 drivers/ptp/ptp_ocp.c                        | 242 +++++++++++++++++--
 2 files changed, 270 insertions(+), 19 deletions(-)

diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
index f94b759d9..f7e228570 100644
--- a/Documentation/networking/devlink/ptp_ocp.rst
+++ b/Documentation/networking/devlink/ptp_ocp.rst
@@ -20,8 +20,10 @@ The ``ptp_ocp`` driver reports the following versions
      - Description
    * - ``fw``
      - running
-     - Version of the firmware running on the card.  Reported as ``loader``
-       instead when the card is running the firmware loader.
+     - Version of the firmware running on the card. Where the driver can
+       distinguish a firmware loader, it reports ``loader`` instead.
+       WiWi reports the raw build ID as ``fw``; it does not identify the
+       boot slot or distinguish a fallback boot.
    * - ``board.id``
      - fixed
      - Board identifier, read from the on-card EEPROM.
@@ -54,7 +56,8 @@ selected with the component name.
      - Description
    * - (none)
      - The card's own flash, written through the SPI controller the driver
-       exposes.  The card runs the new image after its next reset.
+       exposes. Not supported on WiWi. The card runs the new image after
+       its next reset.
    * - ``fw.cpld``
      - The configuration flash of the TAP CPLD on ADVA TimeCard X1 boards,
        programmed over I2C with the MachXO3 in-system programming commands
@@ -73,3 +76,41 @@ with the standard devlink status notifications.
 Example::
 
     $ devlink dev flash pci/0000:02:00.0 file adva-cpld.bin component fw.cpld
+
+WiWi production firmware
+========================
+
+WiWi Time Cards with PCI ID ``2163:1008`` and subsystem ID ``10ee:0007``
+use the PCI Revision ID to identify the register interface. The driver
+supports revision ``02`` (LitePCIe/MSI-X) and rejects unknown revisions
+before accessing FPGA registers. Incompatible interface changes require
+a new revision. The driver also checks the BAR and MSI-X layout before
+initializing the card.
+
+The image ID at BAR0 offset ``0x02020000`` identifies a firmware build,
+not the register interface. The running ``fw`` version in devlink reports
+the full image ID, for example ``0x0000800f``. Compatible builds need not
+have the same image ID or individual core versions. PCIe access to the
+CoreList is not required.
+
+WiWi reuses the peripheral layout described by the driver's shared
+resource table. Its PCI interface is distinct from that of the existing
+Celestica entry (``18d4:1008``). Only the WiWi match adds ``0x02000000``
+to peripheral offsets and requires aligned 32-bit MMIO. Interrupt input
+``n`` uses MSI-X vector ``n + 32``. The per-input enable mask is at BAR0
+offset ``0x1800``. Until the timing gate is open, attempts to arm a
+timestamp, PPS or signal generator return ``-EAGAIN`` and can be retried.
+The driver exposes neither a second GNSS serial port nor a GNSS2 SMA
+output source on this board. Neither is a supported capability inferred
+from revision 02. This does not disable the external SMA PPS2 input.
+The separate EEPROM and RGB I2C inputs (17 and 18) have no handlers in
+this driver and stay masked; these are distinct from its I2C input 7.
+
+The driver does not register the WiWi SPI flash controller, so there is
+no raw MTD device for this flash, even for reads. Its IRQ remains masked.
+WiWi firmware updates through ``devlink dev flash`` are also rejected.
+The WiWi image has a different flash header from the Celestica image.
+The golden image at flash offset zero boots the update image via MultiBoot
+with watchdog fallback. The vendor's programming path requires a modified
+``spi-xilinx`` driver. Successful clock registration does not establish
+GNSS synchronization or valid UTC.
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index decc56892..df40dac98 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -35,6 +35,22 @@
 #define PCI_VENDOR_ID_CELESTICA			0x18d4
 #define PCI_DEVICE_ID_CELESTICA_TIMECARD	0x1008
 
+#define PCI_VENDOR_ID_WIWI			0x2163
+#define PCI_DEVICE_ID_WIWI_TIMECARD		0x1008
+
+/* WiWi rev 02 translates shared peripheral offsets and interrupt inputs. */
+#define OCP_WIWI_MMIO_OFFSET			0x02000000
+#define OCP_WIWI_IRQ_OFFSET			32
+#define OCP_WIWI_MSI_ENABLE			0x1800
+/* Upper 32 bits: the three UARTs and XIIC can interrupt during probe. */
+#define OCP_WIWI_PERIPHERAL_IRQS	(BIT(3) | BIT(5) | BIT(7) | BIT(10))
+/* PPS/TS0/TS1, TS2, GEN1-4 and TS3/TS4. */
+#define OCP_WIWI_TIMING_IRQS			(GENMASK(2, 0) | BIT(6) | \
+						 GENMASK(16, 11))
+/* Do not unmask unused inputs, including the flash controller (9). */
+#define OCP_WIWI_IRQS				(OCP_WIWI_PERIPHERAL_IRQS | \
+						 OCP_WIWI_TIMING_IRQS)
+
 #define PCI_VENDOR_ID_OROLIA			0x1ad7
 #define PCI_DEVICE_ID_OROLIA_ARTCARD		0xa000
 
@@ -405,6 +421,10 @@ struct ptp_ocp {
 	struct delayed_work	sync_work;
 	int			id;
 	int			n_irqs;
+	bool			wiwi;
+	bool			wiwi_timing_ready;
+	u32			wiwi_image_id;
+	void __iomem		*wiwi_msi;
 	struct ptp_ocp_serial_port	port[__PORT_COUNT];
 	bool			fw_loader;
 	u8			fw_tag;
@@ -578,6 +598,22 @@ static struct ptp_ocp_eeprom_map art_eeprom_map[] = {
  * 15: Orolia TS4
  */
 
+static struct i2c_board_info ocp_fb_i2c_devices[] = {
+	{ I2C_BOARD_INFO("24c02", 0x50) },
+	{ I2C_BOARD_INFO("24mac402", 0x58), .platform_data = "mac" },
+};
+
+static struct ptp_ocp_i2c_info ocp_wiwi_i2c = {
+	.name = "xiic-i2c",
+	.fixed_rate = 50000000,
+	.data_size = sizeof(struct xiic_i2c_platform_data),
+	.data = &(struct xiic_i2c_platform_data) {
+		.num_devices = ARRAY_SIZE(ocp_fb_i2c_devices),
+		.devices = ocp_fb_i2c_devices,
+		.force_32bit_access = true,
+	},
+};
+
 static struct ocp_resource ocp_fb_resource[] = {
 	{
 		OCP_MEM_RESOURCE(reg),
@@ -730,12 +766,8 @@ static struct ocp_resource ocp_fb_resource[] = {
 			.fixed_rate = 50000000,
 			.data_size = sizeof(struct xiic_i2c_platform_data),
 			.data = &(struct xiic_i2c_platform_data) {
-				.num_devices = 2,
-				.devices = (struct i2c_board_info[]) {
-					{ I2C_BOARD_INFO("24c02", 0x50) },
-					{ I2C_BOARD_INFO("24mac402", 0x58),
-					  .platform_data = "mac" },
-				},
+				.num_devices = ARRAY_SIZE(ocp_fb_i2c_devices),
+				.devices = ocp_fb_i2c_devices,
 			},
 		},
 	},
@@ -1322,6 +1354,11 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
 static const struct pci_device_id ptp_ocp_pcidev_id[] = {
 	{ PCI_DEVICE_DATA(META, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_WIWI, PCI_DEVICE_ID_WIWI_TIMECARD,
+			       PCI_VENDOR_ID_XILINX, 0x0007),
+		.driver_data = (kernel_ulong_t)ocp_fb_resource,
+	},
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
 	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
 	{ PCI_DEVICE_DATA(ADVA, TIMECARD_X1, &ocp_adva_x1_resource) },
@@ -1384,6 +1421,23 @@ static const struct ocp_selector ptp_ocp_sma_out[] = {
 	{ }
 };
 
+/* No validated second receiver on the supported WiWi board. */
+static const struct ocp_selector ptp_ocp_wiwi_sma_out[] = {
+	{ .name = "10Mhz", .value = 0x0000, .frequency = 10000000 },
+	{ .name = "PHC",   .value = 0x0001, .frequency = 1 },
+	{ .name = "MAC",   .value = 0x0002, .frequency = 1 },
+	{ .name = "GNSS1", .value = 0x0004, .frequency = 1 },
+	{ .name = "IRIG",  .value = 0x0010, .frequency = 10000 },
+	{ .name = "DCF",   .value = 0x0020, .frequency = 77000 },
+	{ .name = "GEN1",  .value = 0x0040 },
+	{ .name = "GEN2",  .value = 0x0080 },
+	{ .name = "GEN3",  .value = 0x0100 },
+	{ .name = "GEN4",  .value = 0x0200 },
+	{ .name = "GND",   .value = 0x2000 },
+	{ .name = "VCC",   .value = 0x4000 },
+	{ }
+};
+
 static const struct ocp_selector ptp_ocp_art_sma_in[] = {
 	{ .name = "PPS1",	.value = 0x0001,  .frequency = 1 },
 	{ .name = "10Mhz",	.value = 0x0008,  .frequency = 1000000 },
@@ -2174,6 +2228,12 @@ ptp_ocp_devlink_flash_update(struct devlink *devlink,
 	const char *msg;
 	int err;
 
+	if (bp->wiwi) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "WiWi flash updates are not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (params->component) {
 		if (!bp->has_cpld ||
 		    strcmp(params->component, ADVA_CPLD_COMPONENT)) {
@@ -2220,7 +2280,10 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	u32 id;
 
 	fw_image = bp->fw_loader ? "loader" : "fw";
-	sprintf(buf, "%d.%d", bp->fw_tag, bp->fw_version);
+	if (bp->wiwi)
+		snprintf(buf, sizeof(buf), "0x%08x", bp->wiwi_image_id);
+	else
+		sprintf(buf, "%d.%d", bp->fw_tag, bp->fw_version);
 	err = devlink_info_version_running_put(req, fw_image, buf);
 	if (err)
 		return err;
@@ -2470,6 +2533,12 @@ ptp_ocp_signal_from_perout(struct ptp_ocp *bp, int gen,
 	return ptp_ocp_signal_set(bp, gen, &s);
 }
 
+static bool ptp_ocp_timing_ready(struct ptp_ocp *bp)
+{
+	/* Pair with probe's publication after the gate readback. */
+	return !bp->wiwi || smp_load_acquire(&bp->wiwi_timing_ready);
+}
+
 static int
 ptp_ocp_signal_enable(void *priv, u32 req, bool enable)
 {
@@ -2479,6 +2548,9 @@ ptp_ocp_signal_enable(void *priv, u32 req, bool enable)
 	struct timespec64 ts;
 	int gen;
 
+	if (enable && !ptp_ocp_timing_ready(bp))
+		return -EAGAIN;
+
 	gen = ext->info->index - 1;
 
 	iowrite32(0, &reg->intr_mask);
@@ -2552,6 +2624,9 @@ ptp_ocp_ts_enable(void *priv, u32 req, bool enable)
 	struct ts_reg __iomem *reg = ext->mem;
 	struct ptp_ocp *bp = ext->bp;
 
+	if (enable && !ptp_ocp_timing_ready(bp))
+		return -EAGAIN;
+
 	if (ext == bp->pps) {
 		u32 old_map = bp->pps_req_map;
 
@@ -2641,7 +2716,7 @@ ptp_ocp_serial_line(struct ptp_ocp *bp, struct ocp_resource *r)
 	 */
 	memset(&uart, 0, sizeof(uart));
 	uart.port.dev = &pdev->dev;
-	uart.port.iotype = UPIO_MEM;
+	uart.port.iotype = bp->wiwi ? UPIO_MEM32 : UPIO_MEM;
 	uart.port.regshift = 2;
 	uart.port.mapbase = pci_resource_start(pdev, 0) + r->offset;
 	uart.port.irq = pci_irq_vector(pdev, r->irq_vec);
@@ -2944,6 +3019,14 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
 	.set_output	= ptp_ocp_sma_fb_set_output,
 };
 
+static const struct ocp_sma_op ocp_wiwi_sma_op = {
+	.tbl		= { ptp_ocp_sma_in, ptp_ocp_wiwi_sma_out },
+	.init		= ptp_ocp_sma_fb_init,
+	.get		= ptp_ocp_sma_fb_get,
+	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
+	.set_output	= ptp_ocp_sma_fb_set_output,
+};
+
 static int
 ptp_ocp_sma_adva_set_output(struct ptp_ocp *bp, int sma_nr, u32 val)
 {
@@ -3037,6 +3120,13 @@ ptp_ocp_fb_set_version(struct ptp_ocp *bp)
 
 	version = ioread32(&bp->image->version);
 
+	if (bp->wiwi) {
+		/* Revision 02 defines capabilities; report the build ID. */
+		bp->wiwi_image_id = version;
+		bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
+		return;
+	}
+
 	/* if lower 16 bits are empty, this is the fw loader. */
 	if ((version & 0xffff) == 0) {
 		version = version >> 16;
@@ -3069,8 +3159,7 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 
 	bp->flash_start = 1024 * 4096;
 	bp->eeprom_map = fb_eeprom_map;
-	bp->fw_version = ioread32(&bp->image->version);
-	bp->sma_op = &ocp_fb_sma_op;
+	bp->sma_op = bp->wiwi ? &ocp_wiwi_sma_op : &ocp_fb_sma_op;
 	bp->signals_nr = 4;
 	bp->freq_in_nr = 4;
 
@@ -3110,7 +3199,30 @@ ptp_ocp_register_resources(struct ptp_ocp *bp, kernel_ulong_t driver_data)
 	int err = 0;
 
 	table = (struct ocp_resource *)driver_data;
-	for (r = table; r->setup; r++) {
+	for (; table->setup; table++) {
+		struct ocp_resource translated = *table;
+
+		r = table;
+		if (bp->wiwi) {
+			/* Do not expose the flash through raw MTD, either. */
+			if (r->setup == ptp_ocp_register_spi)
+				continue;
+			/* The supported board has no validated GNSS2 port. */
+			if (r->setup == ptp_ocp_register_serial &&
+			    r->bp_offset == offsetof(struct ptp_ocp,
+						    port[PORT_GNSS2]))
+				continue;
+			/* Leave the shared resource table unchanged. */
+			if (translated.offset)
+				translated.offset += OCP_WIWI_MMIO_OFFSET;
+			if (r->setup == ptp_ocp_register_i2c)
+				translated.extra = &ocp_wiwi_i2c;
+			if (r->setup == ptp_ocp_register_ext ||
+			    r->setup == ptp_ocp_register_serial ||
+			    r->setup == ptp_ocp_register_i2c)
+				translated.irq_vec += OCP_WIWI_IRQ_OFFSET;
+			r = &translated;
+		}
 		if (!ptp_ocp_allow_irq(bp, r))
 			continue;
 		err = r->setup(bp, r);
@@ -3394,6 +3506,8 @@ ptp_ocp_sma_show(struct ptp_ocp *bp, int sma_nr, char *buf,
 		return ptp_ocp_show_inputs(tbl[0], val, buf, default_in_val);
 	}
 
+	if (bp->wiwi && !ptp_ocp_select_name_from_val(tbl[1], val))
+		return sysfs_emit(buf, "OUT: unavailable\n");
 	return ptp_ocp_show_output(tbl[1], val, buf, default_out_val);
 }
 
@@ -5455,7 +5569,7 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 	}
 	seq_printf(s, "MAC PPS1 src: %s\n", mac_src);
 
-	gpio_input_map(buf, bp, sma_val, 1, "GNSS2");
+	gpio_input_map(buf, bp, sma_val, 1, bp->wiwi ? NULL : "GNSS2");
 	seq_printf(s, "MAC PPS2 src: %s\n", buf);
 
 	/* assumes automatic switchover/selection */
@@ -5787,6 +5901,12 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	platform_device_unregister(bp->i2c_ctrl);
 	if (bp->i2c_clk)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
+	/* Keep child interrupts available until the children are gone. */
+	if (bp->wiwi_msi) {
+		iowrite32(0, bp->wiwi_msi);
+		iowrite32(0, bp->wiwi_msi + 4);
+		ioread32(bp->wiwi_msi);
+	}
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
 	mutex_destroy(&bp->cpld_lock);
@@ -5881,9 +6001,14 @@ static int ptp_ocp_dpll_frequency_set(const struct dpll_pin *pin,
 		return -EOPNOTSUPP;
 
 	tbl = bp->sma_op->tbl[sma->mode];
-	for (i = 0; tbl[i].name; i++)
-		if (tbl[i].frequency == frequency)
-			return ptp_ocp_sma_store_val(bp, i, sma->mode, sma_nr + 1);
+	for (i = 0; tbl[i].name; i++) {
+		if (tbl[i].frequency == frequency) {
+			int val = bp->wiwi ? tbl[i].value : i;
+
+			return ptp_ocp_sma_store_val(bp, val, sma->mode,
+						     sma_nr + 1);
+		}
+	}
 	return -EINVAL;
 }
 
@@ -5901,6 +6026,8 @@ static int ptp_ocp_dpll_frequency_get(const struct dpll_pin *pin,
 	int i;
 
 	val = bp->sma_op->get(bp, sma_nr + 1);
+	if (bp->wiwi)
+		val &= SMA_SELECT_MASK;
 	tbl = bp->sma_op->tbl[sma->mode];
 	for (i = 0; tbl[i].name; i++)
 		if (val == tbl[i].value) {
@@ -5952,6 +6079,49 @@ ptp_ocp_sync_work(struct work_struct *work)
 	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
 }
 
+/* The PCI revision identifies the register interface, not the FPGA build. */
+static int ptp_ocp_wiwi_validate(struct pci_dev *pdev)
+{
+	u32 table, pba;
+	int cap;
+
+	if (pdev->revision != 0x02)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Unsupported WiWi PCI revision 0x%02x\n",
+				     pdev->revision);
+
+	cap = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
+	    pci_resource_len(pdev, 0) != 0x04000000 || !cap ||
+	    pci_msix_vec_count(pdev) != 64 ||
+	    pci_read_config_dword(pdev, cap + PCI_MSIX_TABLE, &table) ||
+	    pci_read_config_dword(pdev, cap + PCI_MSIX_PBA, &pba) ||
+	    table != 0x2000 || pba != 0x1808)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Unsupported WiWi PCI layout\n");
+
+	return 0;
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
@@ -5960,6 +6130,13 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int err, i;
 	u64 clkid;
 
+	/* Dynamic IDs must not override the WiWi board's resource table. */
+	if (pdev->vendor == PCI_VENDOR_ID_WIWI) {
+		id = pci_match_id(ptp_ocp_pcidev_id, pdev);
+		if (!id)
+			return -ENODEV;
+	}
+
 	devlink = devlink_alloc(&ptp_ocp_devlink_ops, sizeof(*bp), &pdev->dev);
 	if (!devlink) {
 		dev_err(&pdev->dev, "devlink_alloc failed\n");
@@ -5973,6 +6150,13 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	bp = devlink_priv(devlink);
+	bp->wiwi = id->vendor == PCI_VENDOR_ID_WIWI;
+	if (bp->wiwi) {
+		/* Validate before IRQ setup, bus mastering or FPGA writes. */
+		err = ptp_ocp_wiwi_validate(pdev);
+		if (err)
+			goto out_disable;
+	}
 	err = ptp_ocp_device_init(bp, pdev);
 	if (err)
 		goto out_disable;
@@ -5988,18 +6172,33 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
+	/* Only the UART and XIIC inputs may interrupt during probe. */
+	if (bp->wiwi_msi) {
+		iowrite32(OCP_WIWI_PERIPHERAL_IRQS, bp->wiwi_msi);
+		ioread32(bp->wiwi_msi);
+	}
 
 	err = ptp_ocp_register_resources(bp, id->driver_data);
 	if (err)
@@ -6048,6 +6247,17 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			goto out_dpll;
 		}
 	}
+	/* All handlers and the PHC are ready for timestamp interrupts. */
+	if (bp->wiwi_msi) {
+		iowrite32(OCP_WIWI_IRQS, bp->wiwi_msi);
+		if (ioread32(bp->wiwi_msi) != OCP_WIWI_IRQS) {
+			err = dev_err_probe(&pdev->dev, -EIO,
+					    "WiWi interrupt gate did not open\n");
+			goto out_dpll;
+		}
+		/* Publish readiness to the timestamp and generator enablers. */
+		smp_store_release(&bp->wiwi_timing_ready, true);
+	}
 	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
 
 	return 0;
