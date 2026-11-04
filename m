Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799468;
	b=Eow9NhhjfkLh+IKPi6RNRWG7FCVouRcrcWj0kHHxjMxZuvE8wy7TcoD/trenEMsiaoPp
	 YVaXDVWXaNkAL1RyOqWUqxgSCXHIcun+PkXRLKLgQRqBlpbT8zIbWDp/J8VeOX/799V5a
	 BQWOmvFWPlJXD/sCFNHk7+0NRJW3WBqTAXVJPbJkflh1SB2H558XV5gYI/9GR/HZidEOI
	 iwFk9/JQRq/Trdhj8/2EMIifYFEqT+PyiSugV5hWhEN8o1swmOEryywn435KzTzTQg6s4
	 dHcEWRcSULCQjIVKRTssGfZzuK2tFrTAmlYHOdh6/FrhiLI5z5F25bJxRfIbtOGzKKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=P1PygSaRvCgyL8o50ty9nbaKvT4LTLDGq0VswjqXP6A=;
	b=CCepnEjXWqS8XFBrWgQdp7eqKExw5v/ahYj7enxekJ8pLVgucNv9j0TKelsdBL5z51+8
	 cSmv1/wzfL5vBEkzHIx1nsluvuCbKQUGXkyM/a4VAExruGuDNsw/r9rFx1Ck4JN+mvFp7
	 fWzlSwuw44qCkiuJfgCNgCjPi2vcIHY7eCaw+zwQc806T58NfxvrMRkoXMtSp6ubxoV2Q
	 QrOLX/haWI6ZMJojUDhjfq8bfWIf8Ix+IBhgMLmk6WCAWVuMA3NkCp6XSPgA9h/1sTKUI
	 Divuj/J5ZnaWMEab3dwR+6Yx+xYY4fMMeCZGfZBBPOjL0uJoJ1ZrU8kz1zTD4NiBthg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--atifashhar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="I/3zDfAG";
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E88606A329
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 13:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13E88606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--atifashhar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I/3zDfAG
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89f9fdbabe1so1186283b3a.1
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 05:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793799467; x=1794404267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1PygSaRvCgyL8o50ty9nbaKvT4LTLDGq0VswjqXP6A=;
        b=I/3zDfAG/EXO1AQkOQsRwC8drHuk6OLeIRrkRg3mKKy3oLcMTooZPEb4EXPEqrOSry
         Hn9q9khZlOmoo3AGxA0fedXaFPZjBFiM2Ivyh+uCH/vG5TRuE4dAEVVP9jjxRgXOpawx
         N4/IBgJq9WaSSWZVktAy1VITFRr47zzMlMkiso4CT4BPZWY1nmz/f6rcOwGis+waetcs
         3himsTFSTkkoPlF1HKiHCYWBN4fnAYjNoOnDhR3oUjRUZmu1g/nbULKqNF6ijbLVRDw/
         4B6fktwLw0crD2SuSxdxcHAx4auGtKANVqOMpWltcetqeamukbtTx32FQiIRD/B4woB/
         bBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799467; x=1794404267;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1PygSaRvCgyL8o50ty9nbaKvT4LTLDGq0VswjqXP6A=;
        b=ldaovJ3vDrnhC4vh4AaZy3dhyYdHtC5hTsQs/43bjFnFr2xvYcsy/7bGvWAD+Dj2y9
         pIt90dDD4rJfMV76HgqK5l3kfS396T5mUJGzM99YyIo4FmZ8RzQHK1HRRs2yI6Aw+2PP
         loAxWIu7NLlaXP70oaA71LdBXnIPHyzw0XspHyy5HnevAt7Llg7Epe6QuL6N6QQCjucX
         YomtE6+CdOU9mHFXUmnA084tMBkHjyBhmntVRG/C53W0skYb7v4huLqa+T0Q/CPagSqx
         6HzA5TwkLepKMlXIYWgqH+on7TSoYlnAhSqsSEjcZLLCeiA5UIEI24L3S+vSibPG04HQ
         0n1A==
X-Forwarded-Encrypted: i=1; AKwUvBx+ar1rFOlakomOWGy22SWoYytATuddfttX5yMivYxBd/kbowTH9mZZ3tBMC/+XPM5DoHWuDIrOk/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wjvJ6DMQFXmH3JcgxDjux2nydcPGH+M44JqgyAH7/jsQGrjWr
	Io1E+mIw1JtMjlwFCXR82yWNvNZ/BLQbti32Z0o7ZN8EFv5zpzEHeKgJ7b/sYpOxbMXArwYXEWu
	WbuRKFi+LJT2V4IA4a/MiBw==
X-Received: from pfbmy5-n2.prod.google.com ([2002:a05:6a00:6d45:20b0:89e:bd5e:725d])
 (user=atifashhar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6b8c:b0:3e9:15c2:83b5 with SMTP id adf61e73a8af0-3e928add0bdmr14068373637.74.1793799467220;
 Wed, 04 Nov 2026 05:37:47 -0800 (PST)
Date: Wed,  4 Nov 2026 13:37:45 +0000
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261104133745.1432212-1-atifashhar@google.com>
Subject: [PATCH] i2c: designware: Release slave SCL hold in __i2c_dw_disable()
From: Atif Ashhar <atifashhar@google.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Atif Ashhar <atifashhar@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When an external I2C master initiates a read to the Synopsys DW_apb_i2c
adapter in slave mode during kexec teardown, runtime suspend, or driver
unbind, the slave hardware stretches SCL low (0V) waiting for TX data,
setting DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY.

In master mode, __i2c_dw_disable() issues DW_IC_ENABLE_ABORT to release
the bus. However, according to the Synopsys DW_apb_i2c Databook, the
ABORT bit applies only to master transfers and has no effect in slave
mode. Because the slave cannot disable while stretching SCL,
__i2c_dw_disable() times out, leaving DW_IC_ENABLE_STATUS[0] = 1 across
kexec or rebind. Subsequent writes to DW_IC_SAR are write-protected and
silently dropped by hardware, wedging the slave and blocking any other
devices sharing the physical bus.

Fix this by:

1. In __i2c_dw_disable(), if DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY is
   set while disabling, temporarily re-enable the controller so the APB
   interface accepts data commands without racing with the slave ISR,
   clear pending RD_REQ/TX_ABRT interrupts, write a dummy 0xFF byte to
   DW_IC_DATA_CMD to release the SCL stretch, and immediately request
   disable via __i2c_dw_disable_nowait(). Also drain the RX FIFO if RFNE
   is set during SLAVE_ACTIVITY.

2. In i2c_dw_reg_slave(), replace __i2c_dw_disable_nowait() with
   __i2c_dw_disable() to ensure the controller is fully disabled before
   calling i2c_dw_set_mode(), which programs DW_IC_SAR and DW_IC_CON.

Fixes: 9f3e065c54b0 ("i2c: designware: add SLAVE mode functions")
Cc: stable@vger.kernel.org
Signed-off-by: Atif Ashhar <atifashhar@google.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 46 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-slave.c  |  2 +-
 include/linux/designware_i2c.h             |  1 +
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a1eca6cd4b75..ae737928820c 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -619,6 +619,50 @@ static int i2c_dw_set_sda_hold(struct dw_i2c_dev *dev)
 	return ret;
 }
 
+/*
+ * DW_IC_ENABLE_ABORT only aborts master transfers. If the adapter is acting
+ * as a slave and holding SCL low waiting for TX data (SLAVE_HOLD_TX_FIFO_EMPTY),
+ * hardware refuses to disable (IC_ENABLE_STATUS[0] stays 1) until a byte is
+ * written to DW_IC_DATA_CMD.
+ *
+ * Mask interrupts and temporarily set DW_IC_ENABLE_ENABLE so the APB interface
+ * accepts writes to the TX/RX FIFOs without racing with the slave ISR, clear
+ * pending RD_REQ/TX_ABRT interrupts, feed a dummy 0xFF byte to release SCL
+ * (or drain any pending RX byte), and immediately request disable again via
+ * __i2c_dw_disable_nowait() so the controller initiates disable upon
+ * completing the current byte.
+ */
+static void i2c_dw_release_slave_hold(struct dw_i2c_dev *dev)
+{
+	unsigned int status, dummy;
+	bool tx_hold, rx_pending;
+
+	if (!IS_ENABLED(CONFIG_I2C_DESIGNWARE_SLAVE) || dev->mode != DW_IC_SLAVE)
+		return;
+
+	regmap_read(dev->map, DW_IC_STATUS, &status);
+
+	tx_hold = status & DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY;
+	rx_pending = (status & DW_IC_STATUS_SLAVE_ACTIVITY) &&
+		     (status & DW_IC_STATUS_RFNE);
+
+	if (!tx_hold && !rx_pending)
+		return;
+
+	regmap_write(dev->map, DW_IC_INTR_MASK, 0);
+	regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
+
+	if (tx_hold) {
+		regmap_read(dev->map, DW_IC_CLR_RD_REQ, &dummy);
+		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
+		regmap_write(dev->map, DW_IC_DATA_CMD, 0xFF);
+	}
+	if (rx_pending)
+		regmap_read(dev->map, DW_IC_DATA_CMD, &dummy);
+
+	__i2c_dw_disable_nowait(dev);
+}
+
 void __i2c_dw_disable(struct dw_i2c_dev *dev)
 {
 	struct i2c_timings *t = &dev->timings;
@@ -676,6 +720,8 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 		if (!(status & 1))
 			return;
 
+		i2c_dw_release_slave_hold(dev);
+
 		/*
 		 * Wait 10 times the signaling period of the highest I2C
 		 * transfer supported by the driver (for 400kHz this is
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 0abcc7757b23..e51a6b60292a 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -40,7 +40,7 @@ int i2c_dw_reg_slave(struct i2c_client *slave)
 		return ret;
 
 	pm_runtime_get_sync(dev->dev);
-	__i2c_dw_disable_nowait(dev);
+	__i2c_dw_disable(dev);
 	dev->slave = slave;
 	i2c_dw_set_mode(dev, DW_IC_SLAVE);
 
diff --git a/include/linux/designware_i2c.h b/include/linux/designware_i2c.h
index 53f37f18a722..113a9d84e34d 100644
--- a/include/linux/designware_i2c.h
+++ b/include/linux/designware_i2c.h
@@ -100,6 +100,7 @@
 #define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
 #define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
 #define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)
+#define DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY	BIT(9)
 
 /* DW_IC_SMBUS_INTR_* bits */
 #define DW_IC_SMBUS_INTR_ALERT			BIT(10)
-- 
2.56.0.317.g454f8302e1-goog

