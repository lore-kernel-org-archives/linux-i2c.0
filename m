Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370755;
	b=KrqrI3Bu5ErMpjnVvf/qHYHSVA8XTSj6rPwi5VmeVKweZDeeAuy3JvTj+VNLSFl2ywQ5
	 2zG2Jt0qOxeRjQVbm2DkVSl0fG9yXXqFAbUZXDyDRTTBNB2LkDG2girmwT6L5Okwp8r7q
	 pthrtcAtnEFR9CWd46wtgn/nOYisv5r6fvpZhLIW6nnQq/2MWrmXGVmjwcPt6kbS8oqdM
	 46AjysRHOgyTPiyiJXHOvjVPeqnvauQoih4tF9voJWzREyGAVfrTAFj3tSeAbyY+PusC1
	 u3jkxUtepb5YIcCDfOYF4Qm+0eeic48GzX9x35ES9u/5ousL+Cr+o6tBWtnoe0JHMSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tioxKfo0r6ymDmT2sdreesWQ9Kk6NZ3UAliEfKE+GeE=;
	b=sD/CmzOpMG9jdjCmISgmAhh1QToobvrnb5kDEeuv4T5uD7MruhSGM1NGrvZG579CZvKL
	 6uBaBIj36MYD5y/9QlyrvJpOEZ7iK28sObScUzeeKSWBF+7fuPYCMM3pe500bBIpzRUyV
	 m6W5sXzQ8VxjljSen9E5j12mrr0xY1rk7LlSiop/uQCdgDKIdS3KlbmOBHbt4ipO5dLOy
	 DNvbcgciFGMontgj6b0MZXK5D8IIjKUEr3/WA4L31GuxNGGRERaoRupjGE59bvbqVF3F0
	 R4SyLGoKK/5YgVqyzbd68tFO/iMpljEqay5Sr/Z5Ehlsk1kz4T7f5ZcWfT0PncC/lOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxdSpsSH;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD0606A32D
	for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 04:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCD0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxdSpsSH
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36e795af1d4so2333799eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 20:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370755; x=1794975555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tioxKfo0r6ymDmT2sdreesWQ9Kk6NZ3UAliEfKE+GeE=;
        b=mxdSpsSH6+mr7crxIK8lbMW88P9Aekvjbv2subpODZ62WB5uVpeytOGowg6t5QATYR
         M24Mdfg3i8/ukpLW/FuLj3DaVfbtV7PbkDrOQppUMi3xxOmqRSDTKBYvaSGLBh7gAphS
         lJGwuOBLRhutjzOsq2KMfk3tBFn4pf+k2Bz+FjxqrECQ8j39QULw8qduwL6lofdLjxxd
         IfhIMSrkYPFZPOXqx0fudF8/PuVZzIW6SCjroA1mXtUz/pUZMDukHwgQtBoHJ3dUeukW
         ATrk5LPOtw7f0P535hNwihOg3WYw4AWabKjwElzpBB6n/QRUbS0hTT5v/rzKm4tlsyOw
         4mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370755; x=1794975555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tioxKfo0r6ymDmT2sdreesWQ9Kk6NZ3UAliEfKE+GeE=;
        b=aj11owjZSD2x9n2bBYSTs3c5VZ0i6vyo1XITaIgLbEnSpNg43Ry/9nrWmOGo+EBwn3
         Ks6wLuTlc/7/YF/ozS0XoIzHTkh0smfHEwvIxZuUm38/3gybIt1PDX21j/rN3xLBH7Sc
         sDUYv9XbBWsRApQQhAp9lR9WQ3FWqHickOp5Ts0dIGzadAlD4K/uxyq2TMM+cV1qX8r9
         WuO7mJAF00pvTjDb459F2WpjoPyZk5gJIt/8Ezt/MUQ/qazJvq5QY5+DMsbTLYFX8cy4
         CFBkUC3ceQlS6MXWKVWBVFMQzvIEC7NZBNUBL2DYgUeI3jw2RStAidk+06P7w3+/8SDy
         crTw==
X-Gm-Message-State: APuU4Z+wCG0YbNQUattfD310Gd/HE7jU5WCC0Y1EFQC7SEh3I8yDWZxR
	x0ueK9ShaEQXOYSbTPUz0Tqlo09PevIxTSg4aB0W4Eo2wYlVfwpTa7AKxj1VeniTbdc=
X-Gm-Gg: AYBFou3gzXE/jNWZ+qBSylJUJ9M0vLMwe42n3mpnqXuKg2upah/q6PRkMJDubgW9KCy
	MPvewBlzuI1jzmzx8gg8voqAhRfM7HboPOifvO7wt/oiwBFFbPbaDwYRniEPOVA1sesuKCxdweL
	yivdrgxdWEP6A8oRszDkcQAi1t/5xF+mPHz8OL+uhHAH5FjnCdulwwuX5CWZmP7FY9dIzSjOpxo
	HyLeGRjtt72fVdvoTEbDEHGchO+OLJCgTAFskCFuR2yldsur9k57Zyc5emEMqiuaMPSqQp8IVWN
	LpCbWl924jtDJ9DF7ltXwF6vQL8W59UfZxIbgty/BVE25eRM9Hp6kEiClogQHJf2dTbEfZO+GHE
	Vc366uqvG6r9r1MTvrR/TPvsmNunUvGvbmVLjehh5NGNg9ODi3y2jF7+X7uUAR1KcT5Tjd5sTlc
	i9gdEkFIMstANyhW0GR8WjR2M4vshN6ygnuFu/MM1pNulgae4K8ZzN1QQBnRBkO3HXiD2SJHZoM
	gvg9G/VtVFEwj6HyQ61FmQUJh1VZmXbf8s7BMbN4b4Pgu7aoI4Qyt+mI2q8XvkrxyfW1nP9bOrp
	X+dpwwwa0k8aJZvaXHMmUemP8I94ZvVnnUw6cUUSbccDx9ng6PickNdrEK/Pq41FTJll1DGpOkD
	MTJlUTyp5pXFYp2UBRE9VA1CvIgicuHKHSneiDFSOyIvLwBYsOhV6onks0avyToyNDnyqRVhF
X-Received: by 2002:a05:7301:488a:b0:36d:be15:2dd6 with SMTP id 5a478bee46e88-37686b42aabmr1877422eec.11.1794370754436;
        Tue, 10 Nov 2026 20:19:14 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11820704eec.15.2026.11.10.20.19.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 20:19:13 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] i2c: xiic: allow platforms to require 32-bit register accesses
Date: Tue, 10 Nov 2026 20:19:01 -0800
Message-ID: <20261111041904.48916-2-ahmadexp@gmail.com>
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

The LitePCIe bridge in the WiWi Time Card production image cannot safely
service subword MMIO accesses. Bringing up its AXI IIC controller with the
existing byte accessors caused a fatal machine check. Two crash dumps
placed the faulting access in ioread8(), called by xiic_clear_rx_fifo()
during xiic_reinit(). The affected register was the IIC status register.

Add a platform-data flag to use aligned 32-bit accesses for registers
carrying byte or halfword values. Keep the detected register endianness
and use a single transaction, not read-modify-write, for FIFO accesses.
Platforms that do not request this mode retain their existing accessors.

With these accessors on a WiWi card, the controller probed and at24
registered the board and MAC EEPROMs. Repeated EEPROM reads and I2C
interrupt delivery were tested separately on an earlier Ubuntu port.

Tool-origin disclosure, as required by generated-content.rst: Codex was
used to analyze the supplied crash evidence, implement the accessors,
prepare tests and draft this changelog. The request was to support the
WiWi card while retaining the existing behavior on other platforms.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/busses/i2c-xiic.c          | 56 +++++++++++++++++---------
 include/linux/platform_data/i2c-xiic.h |  3 ++
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ba560462d..d13cfb012 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -66,6 +66,7 @@ enum i2c_scl_freq {
  * @rx_msg: Current RX message
  * @rx_pos: Position within current RX message
  * @endianness: big/little-endian byte order
+ * @force_32bit_access: Bridge requires aligned 32-bit register accesses
  * @clk: Pointer to AXI4-lite input clock
  * @irq: Interrupt number
  * @state: See STATE_
@@ -95,6 +96,7 @@ struct xiic_i2c {
 	struct i2c_msg *rx_msg;
 	int rx_pos;
 	enum xiic_endian endianness;
+	bool force_32bit_access;
 	struct clk *clk;
 	int irq;
 	enum xilinx_i2c_state state;
@@ -282,52 +284,68 @@ static int xiic_i2c_runtime_resume(struct device *dev)
  * Only the least significant byte [doublet] of the register are ever
  * accessed. This requires an offset of 3 [2] from the base address for
  * big-endian systems.
+ * Some bridges only support aligned 32-bit accesses. For these, access the
+ * entire register in its detected byte order, without a read-modify-write:
+ * reading or writing a FIFO register must perform exactly one transaction.
  */
 
-static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
+static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
 {
 	if (i2c->endianness == LITTLE)
-		iowrite8(value, i2c->base + reg);
+		iowrite32(value, i2c->base + reg);
 	else
-		iowrite8(value, i2c->base + reg + 3);
+		iowrite32be(value, i2c->base + reg);
 }
 
-static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
+static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
 {
-	u8 ret;
+	u32 ret;
 
 	if (i2c->endianness == LITTLE)
-		ret = ioread8(i2c->base + reg);
+		ret = ioread32(i2c->base + reg);
 	else
-		ret = ioread8(i2c->base + reg + 3);
+		ret = ioread32be(i2c->base + reg);
 	return ret;
 }
 
-static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
+static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
 {
+	if (i2c->force_32bit_access) {
+		xiic_setreg32(i2c, reg, value);
+		return;
+	}
+
 	if (i2c->endianness == LITTLE)
-		iowrite16(value, i2c->base + reg);
+		iowrite8(value, i2c->base + reg);
 	else
-		iowrite16be(value, i2c->base + reg + 2);
+		iowrite8(value, i2c->base + reg + 3);
 }
 
-static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
+static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
 {
+	u8 ret;
+
+	if (i2c->force_32bit_access)
+		return xiic_getreg32(i2c, reg);
+
 	if (i2c->endianness == LITTLE)
-		iowrite32(value, i2c->base + reg);
+		ret = ioread8(i2c->base + reg);
 	else
-		iowrite32be(value, i2c->base + reg);
+		ret = ioread8(i2c->base + reg + 3);
+	return ret;
 }
 
-static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
+static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
 {
-	u32 ret;
+	if (i2c->force_32bit_access) {
+		xiic_setreg32(i2c, reg, value);
+		return;
+	}
 
 	if (i2c->endianness == LITTLE)
-		ret = ioread32(i2c->base + reg);
+		iowrite16(value, i2c->base + reg);
 	else
-		ret = ioread32be(i2c->base + reg);
-	return ret;
+		iowrite16be(value, i2c->base + reg + 2);
 }
 
 static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
@@ -1480,6 +1498,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		return irq;
 
 	pdata = dev_get_platdata(dev);
+	if (pdata)
+		i2c->force_32bit_access = pdata->force_32bit_access;
 
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
diff --git a/include/linux/platform_data/i2c-xiic.h b/include/linux/platform_data/i2c-xiic.h
index 2e3683c23..df1aeb42c 100644
--- a/include/linux/platform_data/i2c-xiic.h
+++ b/include/linux/platform_data/i2c-xiic.h
@@ -16,6 +16,8 @@
  * @num_devices:	Number of devices that shall be added when the driver
  *			is probed.
  * @devices:		The actuall devices to add.
+ * @force_32bit_access:	Use aligned 32-bit accesses for all registers, including
+ *			byte and halfword payloads, on bridges without subword I/O.
  *
  * This purpose of this platform data struct is to be able to provide a number
  * of devices that should be added to the I2C bus. The reason is that sometimes
@@ -26,6 +28,7 @@
 struct xiic_i2c_platform_data {
 	u8				num_devices;
 	struct i2c_board_info const	*devices;
+	bool				force_32bit_access;
 };
 
 #endif /* _LINUX_I2C_XIIC_H */
