Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853252;
	b=3ZIOy8axAEwlyUU/XLI7fT94BmwnQohY4GCtawheZvRXeRPW0YDUlJHDFBrJzLbsjd19
	 u6WgPKPWAP6F4bbZwHcssYsmzzQhJidCiwoT9UXqoy+mG9yHuAE0bKohMxAaNs1srMD/P
	 pRmMPJw0KOynazKZwnH3cFurP0BOqb5FX+CVDo77tQF+0/uaorTGE5T8+VNfvStIfRAXY
	 L8lsOcgHYunYQmrEZ3S7rchkZmAGoH99qFndeTqBOwH8+bSCpaGpH+Hz/ccNfaFKevGtZ
	 GmrWFCJjcdWaBjvusubK15G5rmXs97AJIKqfgChmZdEGXpLdemrFQp/DldKv0Xq/XXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3MZjUptPvV0NGm+NQGrttciOr9poGpV6qt5fO1NBMdQ=;
	b=NGbPm9X9s+sTAHKyblvC96S8y2HAS4Bzbl/FCxl+OWxRoAb+Szqf5DBd2xjNfbRVwpaa
	 HevQqcEMl+NHj9wG6VC3kGjzkUHvvGdJV63qCSBz2zfB4fY6ZbBhJDQzMt1HZjDqpn0rZ
	 NXQMNZ27jgLxl4h75bz442rc9fCe+iMoAFu5SVQZrk/j8SeZczmAzwdmCDGJUTw2kL9sJ
	 Wdgg+hi9ezWGERzbDOJvG/KG7/YBhKzdCWpMgDJXOzjE6DPjlCrTxoElq+2nwC2JLvbhR
	 RPMqlMGr7OXKZ05W8mZLNbnG0EWTS8H4vMz3QgSkYpq2Iv+tIkwtqhmtIwr5+M1al9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VmbakR/S";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D0606A330
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 18:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 521D0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VmbakR/S
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ed1b9e8f43so17701615ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853251; x=1795458051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MZjUptPvV0NGm+NQGrttciOr9poGpV6qt5fO1NBMdQ=;
        b=VmbakR/SHyzoPhLhcM9UuvsRvLhgSwYKV9nnxC3HMUbGYMsGe3lwu49KkFJPI6m4OI
         Q2f5mszG4YBbwit0zb6a8n22fJG0a3oSHoSC00vmfjC7AxpwwxPwP8IhJ6aa/OCtdWrt
         54TmUzbO5YhwR61nAuV7IdKUSk5oaVSWES47giGWZRibmOXd0CXI+7zugGzHFEQbSIBL
         ZUJtMQrFraNl341kA0m1y1FWR2u2qM9asVfcKuYZxYwqhuL4Kpy6vnHD5HqwpFXtsdZN
         WMbNRLndJxzn3jk4yBWk9eyetaTnYJ8aSSogVkunriZCSTnAr7J308+r8z06Rc008hP5
         fiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853251; x=1795458051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3MZjUptPvV0NGm+NQGrttciOr9poGpV6qt5fO1NBMdQ=;
        b=2YsBf3pM/BOfRoLSi5RqQ2GI/cHzbJaSA+BcgXB+AQlpmOC565QIshPA7y0Gf7SEIc
         b32QvajLcuB26CArzkKL3dvcm7pIm3YQHmeF5rZGJxy0+WdYsnjuydu18Tms2cA3bXnW
         Z5UcZctfWLCUB6xm/PD31QLkWEEVQoDFyqZjf1u5hRQESBc2AdReh5uO6XBzDaz5eJfu
         /S4GBKKBYLuTrO0CujrshIfvpfPcv5cgFOZx7ToJlAAGrrNcfb7JR+uasFfVJLoOY7nL
         JALUGGpbFmv6WbFQt2/gvRC0Y0J/YoarhrN356l8qaF+2A1iEJdKkQAEtCNg27ecMffC
         +w+w==
X-Forwarded-Encrypted: i=1; AL+hErHzi1hY3+bj9elPL/hXAgcZgpukeVG9+L648ET6Gg1+m3/BP6mmhZLlMqoFHOIIEICrrGcYUg8oUbA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lrHitl3vvNCclykaPnlwwa9AjKc2Aq7OPEKfaaBfY6zNdV0t5
	n9KqZT5OWJXuMieDUbFB7UVewRNroeEEmyPWxttRxoFdlx8YMOd/dVcg
X-Gm-Gg: AZFdTZfIol5D9r2j8JT++znhVvPV93chpLIyIIDKFOrgN3EHVIkPzM3AhOldBBj3xab
	qsDKMG9e4GB4o3GMcJAgF18DAPfeFIrBWQSWB5FVpFdx/3U0zsq/HbSrDWONRfU0a7h/PL88hqH
	vczxe63JKX1StJbMpZgdzklfF/IW+d1wromm3fjqIP2Al3yCWquNs6MHxOoVaq04h5lkFOmDQ8u
	USRru2ZEtdIMYeplpnDfggLfbsj/7u/Xiqwtf1SyI6T8WBTbTIIIV/snrEpgQW+xwHtdZfTdpki
	T9yQu9+C7sKulniUlnftQKN2WzTxCaS77PFlVhYMJ/omQNvnT1Frk+CjqhVdONqBiKdaXgv70/2
	ZhrfL4v7Ny+z74BBKBqivxuxkLqOqgku6f6pB6Hxe22VP9QDFx8T//Fd/dKGjBL4u7n6RlE1EMX
	zvmpZ0wHhfFPrmf6x+qxjAS3yqxOnqSuTL/X3GoChDhhLWveBiLRIyLp6wcvBLD6kgrJAwUoeZa
	rNNkmoPFlfphIxt7sQVwta30lAuR2UkqekpOzEaAXk9x+MTklPa6ZE7TIA8IbrBjEV9yue4OC4Y
	nkRc9QW3EK4BU1Ej4ktwaqIMmDfTOylvIOunljbWngRZqwKDNZgD4ZtTYeqGSGE7oIC5to7WvfE
	IQgpe9MTa4kIPZTv0BSlVtSnGjr7UeJ4HuJ0x+SpZWisovU7q1uaHv1NzPg==
X-Received: by 2002:a17:903:3886:b0:2e9:9263:a6b with SMTP id d9443c01a7336-2ee0dfb0832mr95471945ad.40.1794853251181;
        Mon, 16 Nov 2026 10:20:51 -0800 (PST)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a5877bsm2871775ad.48.2026.11.16.10.20.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 10:20:50 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michal.simek@amd.com,
	richardcochran@gmail.com
Subject: [PATCH net-next v3 1/3] i2c: xiic: allow platforms to require 32-bit register accesses
Date: Mon, 16 Nov 2026 10:20:48 -0800
Message-ID: <20261116-wiwi-v3-87afa10a8-1-ahmadexp@gmail.com>
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

The LitePCIe bridge in the WiWi Time Card production image cannot safely
service subword MMIO accesses. Bringing up its AXI IIC controller with the
existing byte accessors caused a fatal machine check. Two crash dumps
placed the faulting access in ioread8(), called by xiic_clear_rx_fifo()
during xiic_reinit(). The affected register was the IIC status register.

Add a platform-data flag to use aligned 32-bit accesses for registers
carrying byte or halfword values. Keep the detected register endianness
and use a single transaction, not read-modify-write, for FIFO accesses.
Platforms that do not request this mode retain their existing accessors.
The WiWi ptp_ocp change later in this series is the first user: it sets
the flag in the platform data for the card's XIIC child.

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
index ab7916745..edb5e271c 100644
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
+static void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
 {
 	if (i2c->endianness == LITTLE)
-		iowrite8(value, i2c->base + reg);
+		iowrite32(value, i2c->base + reg);
 	else
-		iowrite8(value, i2c->base + reg + 3);
+		iowrite32be(value, i2c->base + reg);
 }
 
-static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
+static int xiic_getreg32(struct xiic_i2c *i2c, int reg)
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
+static void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
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
+static u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
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
+static void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
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
index 2e3683c23..afad9a49c 100644
--- a/include/linux/platform_data/i2c-xiic.h
+++ b/include/linux/platform_data/i2c-xiic.h
@@ -16,6 +16,8 @@
  * @num_devices:	Number of devices that shall be added when the driver
  *			is probed.
  * @devices:		The actuall devices to add.
+ * @force_32bit_access:	Use aligned 32-bit accesses even for byte and
+ *			halfword payloads on bridges without subword I/O.
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
