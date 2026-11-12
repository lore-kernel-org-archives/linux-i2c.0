Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501229;
	b=aahMjwV0fY8sSJ14KepEr+VTtIzA2DznP/JRuc1KeTnaKKJ0JLXK/sQISmPkHGIua3YI
	 YJ/JV9diDcc3dtCMtPvyn4H32IlNLyDkqiJ0jDQ4+MmMXGRlwZQb08u0A4DwzJseP/iT7
	 1lmUD3IXUSSSDVUPWCb8bhiSIU+SqG1QN23gHg9vKdgOZtNGtdYl5Uz7iI3Co4HpWd9aq
	 M7xmOvt1q7YcI93+dUnNRhBLAcao5BpkbEGyCNmFjFztJ7SICyyvguUFESUYrycw1jBnh
	 Mm/hGKwq47+XCHIQYV56nMKGBwvXGXUZRZ/VV/pibeAjAmDfo606I+S0eBMyOvRq5FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gyJuNAeoXszdWFzMU5/1mECWPAANZRNlmYnCDitqtII=;
	b=0cJHygdIubaVbwmFhvzcm3rY+1idlsb+Mv7qOsv87PbjBTsw5QuZcgXC38KGeXvKvKwF
	 JlG6AS8DaU2AY0/YWSePhtFRoXyATgljfNXULymsGS1JDwZPi3f2lwejM+zBLX/HnAirG
	 58//kFoT2883cucO1fnmSlGzkAkYEX88oDlyKvwG71tDqqaJ8ga5qwyYfW3RrS9hnwlf3
	 HK0X7LRrqmi3D05F7m/BEVMRoLMEkJB35De0cmcsZWkkyBYTuikubVvjjDDQvr7vqYMY/
	 O8Rp06IdWB2xWoOyi+UsKiLiEttux9edCPpd0HUR2MwQ3Db6doGYS9brScmA1a0I16Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQ1O4O+C;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7654606AB3C
	for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 16:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7654606AB3C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQ1O4O+C
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a8cc11ac42so4482264c88.0
        for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501228; x=1795106028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gyJuNAeoXszdWFzMU5/1mECWPAANZRNlmYnCDitqtII=;
        b=AQ1O4O+CnBvsL9liNvWZ3q49mbpN4U96ovP7fMhFg5HLVFpZ63BOy4LXGh01oL3veU
         nT+KDclIHFCUos4TZhssNnxmT/sNB0I8nhrkVGCsrD+Dpp/YmM+EGOVYKgeJr3bqHr3n
         DJdXX+edd8qL9bd9BiVS1OoLecKMbXpFnNX6vGm50Sl/W2iOn0R4flS/T6U++BZuqaHi
         dtfzGR39P9l/FMyT3YVkFPchMJ4IFNnHANhze0vs7Zkqp1w5onvRATa/Lh3mllAXeoWh
         yM0wxFVjGk7MmTplwTLd9qSOAerRZM7vKpoh7kIK19kRHiwe1oZ32MyCjrsiucpNuY2A
         AOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501228; x=1795106028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gyJuNAeoXszdWFzMU5/1mECWPAANZRNlmYnCDitqtII=;
        b=qPbSvSgOARpWH9pV5TiNYw+W7jfOVkqDuFiybBElWEOCU3EfflX0UrcZlqLeeHkNpY
         jGzfcEcmHdxT8cYhljacp1rGhHw3aF1aF5CreVSFO8SROKvLdAM3NUSemuCLp0r9YVuA
         SMdXso7Y3wBoGfq2WleduVR2atfmMAs2s3X/UQEaEejnqarupqUtuUUB0V1kVuj2/DUB
         JgJTEqXYqO9vCdsPyaFeE1jQDZlFfJeHI0Mz5RBaytbp7PBQ/bWdKUC440MkJEne8guM
         HMdO/L9OnO0CQ053abErFeeLbWraqfhzWuePGr/P8Z9Ell6T3YFXpn5lXuUON80MScpn
         HElQ==
X-Gm-Message-State: APuU4Z+jcX/NaJ3Aj0t9hN83nK+dwR2oBDSkDJesGiJmJPX5rDbDkuaD
	6kmp6VAH+asCA5UPJJ6wV+V2bAkMC+xkejBYanCOp6j42eFJlrkDc67p
X-Gm-Gg: AYBFou2aMg8dy9tzLPMtFjqBYGrFqK4zmxVnyF5XxOKqV1jT0Y+XCDokm1r4KwSPtjx
	xJqjD7BQLrO4eeG0OIuyZKqTAAHodko32Cv5/olLFdDEBI+zsfeZuvQRvBtuuWptn/IUm3J4oes
	IP8gNCp7ayp6WRtrS2rMWHIayOpY0Qy6ABiYv7XITsmcxNWC2oAG2tU+mw54pSDZL5PQCDPP25s
	JNCihA7WKCtAC6Bm7c1uitBMiYpruv8+WYsF+FKOuh/e4OMemwmbYBYMAaCfWkSdnUeJSeBmxgo
	GtCDBw3Gep3rns/4k3rSQMoWmV9pv55Kp4hoX8o6j0Q01ERAS+psrZ8/Ph5qD5lTHeiJ9+HRgB5
	9hSSHPEG0L+yWzcDxJfmbvdpU/vSIPTiFcv1lPx5Ra0EeD4Y81b5+5dU7CgjIt5kiE8+kKXXuEy
	cKtYCaLTYX2Uh+mDnTYcKbPC25N39Me20F+OWTHCltRQbfmQ9vcIGcZS5QbFDcJPzNfmI1j3vs4
	Yc34UNI1C5sEmnDsYkT2mfWO/5ignBmAHOdQWK6UBDnQrXZnbFr79jZCtJSpY9TUUctQn/Bsev5
	j0pohb1JB2IOHOreCj/vOFvKp9G9gvHumI7bdrXfuKrNcwruN9FVs4WztcHyn91wjdLH7UY3XtW
	B8Z0JgBVmwQ2/6NGRrJ2Id2gw+5zm2EoS/ONncx5yRjGbSd45uzCwwckwieeTU0hkVV6XroUq
X-Received: by 2002:a05:7022:3a85:b0:185:fd0c:4585 with SMTP id a92af1059eb24-1b50312b3b0mr80585c88.33.1794501227470;
        Thu, 12 Nov 2026 08:33:47 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50300e5dcsm230248c88.0.2026.11.12.08.33.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 08:33:46 -0800 (PST)
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
Subject: [PATCH net-next v2 3/3] ptp: ocp: support the WiWi revision 02 Time Card
Date: Thu, 12 Nov 2026 08:33:32 -0800
Message-ID: <20261112163333.12523-4-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112163333.12523-1-ahmadexp@gmail.com>
References: <20261112163333.12523-1-ahmadexp@gmail.com>
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

Match WiWi 2163:1008, subsystem 10ee:0007. NetTimeLogic uses the PCI
Revision ID for incompatible interface changes. Revision 02 identifies
the LitePCIe/MSI-X interface; the Xilinx subsystem ID and FPGA build
number do not identify the register interface. Reject unknown revisions
and check BAR0 and the MSI-X layout before accessing FPGA registers.
Do not probe a CoreList or require exact versions of individual cores.

Report the full 32-bit image ID as the running firmware build. Derive
signal and frequency capabilities from the supported revision, not the
legacy FB build-number thresholds. Retain legacy version behavior on
other cards.

Translate a copy of each peripheral resource by 0x02000000 and its
interrupt input by 32. Use aligned 32-bit UART and XIIC register I/O.
Leave GNSS2 unregistered: it is not wired on the tested production
image. Do not change other cards' resource tables or access modes.

Open the UART, I2C and SPI inputs before probing children: SPI NOR
identification can wait for an interrupt. Enable timing inputs after
registering the PHC and its consumers. Keep unused inputs masked and
leave child interrupts available through removal.

Reject WiWi devlink flash updates before looking up or modifying MTD.
The flash header differs from Celestica and the vendor update path
requires a modified spi-xilinx. Device recognition is not validation
of an update path.

Thomas Schaub of NetTimeLogic described the production register layout
and interrupt gate on 10 November 2026 and the PCI revision convention
on 11 November.

On a revision 02 production card, devlink reported build 0x0000800f.
The driver allocated 64 MSI-X vectors, registered the PHC, PPS and
three UARTs, and exposed four generator and four frequency-counter
groups. SPI NOR and both at24 devices bound. The PHC advanced
3.000441080 s over three one-second sleeps, with each delta inside
the host monotonic bounds. PCIe AER counters did not change. The clock
reported UNSYNCED at probe; the test did not establish PPS lock or UTC.

Tool-origin disclosure: Codex assisted with the driver changes, tests
and changelog using the supplied hardware evidence and revision rule.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 Documentation/networking/devlink/ptp_ocp.rst |  36 +++-
 drivers/ptp/ptp_ocp.c                        | 163 ++++++++++++++++++-
 2 files changed, 190 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
index f94b759d9..2515dcccd 100644
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
@@ -73,3 +74,36 @@ with the standard devlink status notifications.
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
+The image uses the Celestica LitePCIe production map: add ``0x02000000``
+to the peripheral offsets and use aligned 32-bit MMIO. Interrupt input
+``n`` uses MSI-X vector ``n + 32``. The per-input enable mask is at BAR0
+offset ``0x1800``. The driver enables the SPI interrupt before probing
+the flash and defers timing interrupts until the PHC is ready. GNSS2 is
+not wired to pins on the tested image; no second GNSS port is registered.
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
index 625a85b2d..10ad2fbeb 100644
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
+#define OCP_WIWI_PERIPHERAL_IRQS	(BIT(3) | BIT(5) | BIT(7) | \
+					 BIT(9) | BIT(10))
+/* PPS/TS0/TS1, TS2, GEN1-4 and TS3/TS4. */
+#define OCP_WIWI_TIMING_IRQS			(GENMASK(2, 0) | BIT(6) | \
+						 GENMASK(16, 11))
+/* Leave unwired GNSS2 (4), HWICAP (8) and EEPROM/RGB I2C (17/18) masked. */
+#define OCP_WIWI_IRQS				(OCP_WIWI_PERIPHERAL_IRQS | \
+						 OCP_WIWI_TIMING_IRQS)
+
 #define PCI_VENDOR_ID_OROLIA			0x1ad7
 #define PCI_DEVICE_ID_OROLIA_ARTCARD		0xa000
 
@@ -404,6 +421,9 @@ struct ptp_ocp {
 	struct delayed_work	sync_work;
 	int			id;
 	int			n_irqs;
+	bool			wiwi;
+	u32			wiwi_image_id;
+	void __iomem		*wiwi_msi;
 	struct ptp_ocp_serial_port	port[__PORT_COUNT];
 	bool			fw_loader;
 	u8			fw_tag;
@@ -1321,6 +1341,13 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
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
@@ -2173,6 +2200,12 @@ ptp_ocp_devlink_flash_update(struct devlink *devlink,
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
@@ -2219,7 +2252,10 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
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
@@ -2331,20 +2367,29 @@ ptp_ocp_register_spi(struct ptp_ocp *bp, struct ocp_resource *r)
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
@@ -2369,7 +2414,7 @@ ptp_ocp_register_i2c(struct ptp_ocp *bp, struct ocp_resource *r)
 
 	sprintf(buf, "%s.%d", info->name, id);
 	devm_clk_hw_register_clkdev(&pdev->dev, clk, NULL, buf);
-	p = ptp_ocp_i2c_bus(bp->pdev, r, id);
+	p = ptp_ocp_i2c_bus(bp, r, id);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
@@ -2640,7 +2685,7 @@ ptp_ocp_serial_line(struct ptp_ocp *bp, struct ocp_resource *r)
 	 */
 	memset(&uart, 0, sizeof(uart));
 	uart.port.dev = &pdev->dev;
-	uart.port.iotype = UPIO_MEM;
+	uart.port.iotype = bp->wiwi ? UPIO_MEM32 : UPIO_MEM;
 	uart.port.regshift = 2;
 	uart.port.mapbase = pci_resource_start(pdev, 0) + r->offset;
 	uart.port.irq = pci_irq_vector(pdev, r->irq_vec);
@@ -3036,6 +3081,13 @@ ptp_ocp_fb_set_version(struct ptp_ocp *bp)
 
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
@@ -3068,7 +3120,6 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 
 	bp->flash_start = 1024 * 4096;
 	bp->eeprom_map = fb_eeprom_map;
-	bp->fw_version = ioread32(&bp->image->version);
 	bp->sma_op = &ocp_fb_sma_op;
 	bp->signals_nr = 4;
 	bp->freq_in_nr = 4;
@@ -3109,7 +3160,26 @@ ptp_ocp_register_resources(struct ptp_ocp *bp, kernel_ulong_t driver_data)
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
+			/* Leave the shared resource table unchanged. */
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
@@ -5786,6 +5856,12 @@ ptp_ocp_detach(struct ptp_ocp *bp)
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
@@ -5951,6 +6027,49 @@ ptp_ocp_sync_work(struct work_struct *work)
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
+				     "Unsupported WiWi PCI revision %#02x\n",
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
@@ -5972,6 +6091,14 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	bp = devlink_priv(devlink);
+	bp->wiwi = pdev->vendor == PCI_VENDOR_ID_WIWI &&
+		   pdev->device == PCI_DEVICE_ID_WIWI_TIMECARD;
+	if (bp->wiwi) {
+		/* Validate before IRQ setup, bus mastering or FPGA writes. */
+		err = ptp_ocp_wiwi_validate(pdev);
+		if (err)
+			goto out_disable;
+	}
 	err = ptp_ocp_device_init(bp, pdev);
 	if (err)
 		goto out_disable;
@@ -5987,18 +6114,33 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
+	/* SPI NOR needs IRQs now; timestamp consumers are not ready. */
+	if (bp->wiwi_msi) {
+		iowrite32(OCP_WIWI_PERIPHERAL_IRQS, bp->wiwi_msi);
+		ioread32(bp->wiwi_msi);
+	}
 
 	err = ptp_ocp_register_resources(bp, id->driver_data);
 	if (err)
@@ -6047,6 +6189,11 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
