Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56130345CD3
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788368; cv=none; b=CHkdTpFFE0c/bvdZ9vQqWlaQdWhhoptid0w3PeF40PrxbUz5C4kQHWthZ3lR2nYRpAztNGBuC1T8olMUfr9NiofOouy3k1jKpmHBqOEXdnbfPxtQQY8q9Y0G8j8PVNG0hSEvr/3HJ2aJGG2mbbWKZWD6i4NcfdUg06jjGSsZ5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788368; c=relaxed/simple;
	bh=AakYswf0PURP85z0cKZMM2azCbtWXH9wUNMFsYSILi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMCmWylipTUYHka3fEkfqx8UhYNFsaEaGTyjhsRWmoeYTau3x1FeTTnhM88NOPeftPUuTKKjySjHxJOknkYfSZgR9JZ7iYEU9beUvDDGGy+hAiO0ZU4vFpSsObiEYzM2VugUnBDufXwDBJDzik7d/2Yr+s4y8x79tTL5MxP+rgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d6tdWlCU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d6tdWlCU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0521E4E42358;
	Fri, 30 Jan 2026 15:52:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D040E6075A;
	Fri, 30 Jan 2026 15:52:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4678119A888B;
	Fri, 30 Jan 2026 16:52:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769788364; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H6502f9v+m0yfsRyGf4npsshP4GW5USO0fLVkUBO4xU=;
	b=d6tdWlCUq0L+of1UgzhZus0rG611KWeyUxvBE45NDoc2fIBKPrbBmYZOtAghOxihZESxJe
	NWlHToqDuffPYOVDX/7uR9rJ/nuXFr6K8s1PKMw33u4mpHQuTK4BDfzySs2wfS3m6iWpxk
	XyKW2M2/GQn1EzpGlImDxAIdeeh2urRLGjK8g0tKehKQRv/of65/fNfMoGIshDZ9xMueBD
	SxmpUQIpC471/oxUz9B7taN8PAgA9+rO9iqUEsL0xDhdBQ44P9BLDf56BfkBHH0nxcejEa
	LiZWlT12SujzD8dehI2RZLZNjlCwg+FjbVn2BjKw/9lPlKMSFC5GwZU51B6jMw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 30 Jan 2026 16:52:31 +0100
Subject: [PATCH v6 3/3] i2c: designware: Support of controller with
 IC_EMPTYFIFO_HOLD_MASTER disabled
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260130-i2c-dw-v6-3-08ca1e9ece07@bootlin.com>
References: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>
In-Reply-To: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

If IC_EMPTYFIFO_HOLD_MASTER_EN parameter is 0, "Stop" and "Repeated Start"
bits in command register do not exist, thus it is impossible to send
several consecutive write messages in a single hardware batch. The
existing implementation worked with such configuration incorrectly:
all consecutive write messages are joined into a single message without
any Start/Stop or Repeated Start conditions. For example, the following
command:

    i2ctransfer -y 0 w1@0x55 0x00 w1@0x55 0x01

does the same as

    i2ctransfer -y 0 w2@0x55 0x00 0x01

In i2c_dw_msg_is_valid(), we ensure that we do not have such sequence
of messages requiring a RESTART, aborting the transfer on controller
that cannot emit them explicitly.

This behavior is activated by compatible entries because the state of
the IC_EMPTYFIFO_HOLD_MASTER_EN parameter cannot be detected at runtime.
The new flag emptyfifo_hold_master reflects the state of the parameter,
it is set to true for all controllers except those found in Mobileye
SoCs. For now, the controllers in Mobileye SoCs are the only ones known
to need the workaround. The behavior of the driver is left unmodified
for other controllers.

There is another possible problem with this controller configuration:
When the CPU is putting commands to the FIFO, this process must not be
interrupted because if FIFO buffer gets empty, the controller finishes
the I2C transaction and generates STOP condition on the bus.

If we continue writing the remainder of the message to the FIFO, the
controller will start emitting a new transaction with those data. This
turns a single message into multiple I2C transactions. To protect against
FIFO underrun, two changes are done:

First we flag the interrupt with IRQF_NO_THREAD, to prevent it from
running in a thread on PREEMPT-RT kernel. This ensures that we are
not interrupted when filling the FIFO as it is very time-senstive. For
example, being preempted after writing a single byte in the FIFO with
a 1MHz bus gives us only 18µs before an underrun. DMA would allow us
to keep the interrupt threaded but it is not available on Mobileye SoC
for I2C.

Second in i2c_dw_process_transfer(), we abort if a STOP is detected
while a read or a write is in progress. This can occur when processing
a message larger than the FIFO. In that case the message is processed in
parts, and rely on the TX EMPTY interrupt to refill the FIFO when it gets
below a threshold. If servicing this interrupt is delayed for too long,
it can trigger a FIFO underrun, thus an unwanted STOP.

Originally-by: Dmitry Guzman <dmitry.guzman@mobileye.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-common.c  | 20 ++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h    |  3 +++
 drivers/i2c/busses/i2c-designware-master.c  | 18 ++++++++++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c |  1 +
 4 files changed, 42 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 64654dabbb21..4dc57fd56170 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -492,6 +492,12 @@ int i2c_dw_fw_parse_and_configure(struct dw_i2c_dev *dev)
 
 	dev->clk_freq_optimized = device_property_read_bool(device, "snps,clk-freq-optimized");
 
+	/* Mobileye controllers do not hold the clock on empty FIFO */
+	if (device_is_compatible(device, "mobileye,eyeq6lplus-i2c"))
+		dev->emptyfifo_hold_master = false;
+	else
+		dev->emptyfifo_hold_master = true;
+
 	i2c_dw_adjust_bus_speed(dev);
 
 	if (is_of_node(fwnode))
@@ -918,6 +924,20 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	else
 		irq_flags = IRQF_SHARED | IRQF_COND_SUSPEND;
 
+	/*
+	 * The first writing to TX FIFO buffer causes transmission start.
+	 * If IC_EMPTYFIFO_HOLD_MASTER_EN is not set, when TX FIFO gets
+	 * empty, I2C controller finishes the transaction. If writing to
+	 * FIFO is interrupted, FIFO can get empty and the transaction will
+	 * be finished prematurely. FIFO buffer is filled in IRQ handler,
+	 * but in PREEMPT_RT kernel IRQ handler by default is executed
+	 * in thread that can be preempted with another higher priority
+	 * thread or an interrupt. So, IRQF_NO_THREAD flag is required in
+	 * order to prevent any preemption when filling the FIFO.
+	 */
+	if (!dev->emptyfifo_hold_master)
+		irq_flags |= IRQF_NO_THREAD;
+
 	ret = i2c_dw_acquire_lock(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index a49263a36023..9d8d104cc391 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -260,6 +260,8 @@ struct reset_control;
  * @clk_freq_optimized: if this value is true, it means the hardware reduces
  *	its internal clock frequency by reducing the internal latency required
  *	to generate the high period and low period of SCL line.
+ * @emptyfifo_hold_master: true if the controller acting as master holds
+ *	the clock when the Tx FIFO is empty instead of emitting a stop.
  *
  * HCNT and LCNT parameters can be used if the platform knows more accurate
  * values than the one computed based only on the input clock frequency.
@@ -318,6 +320,7 @@ struct dw_i2c_dev {
 	struct i2c_bus_recovery_info rinfo;
 	u32			bus_capacitance_pF;
 	bool			clk_freq_optimized;
+	bool			emptyfifo_hold_master;
 };
 
 #define ACCESS_INTR_MASK			BIT(0)
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 73d9347a6a08..de929b91d5ea 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -652,6 +652,14 @@ static void i2c_dw_process_transfer(struct dw_i2c_dev *dev, unsigned int stat)
 	if (stat & DW_IC_INTR_TX_EMPTY)
 		i2c_dw_xfer_msg(dev);
 
+	/* Abort if we detect a STOP in the middle of a read or a write */
+	if ((stat & DW_IC_INTR_STOP_DET) &&
+	    (dev->status & (STATUS_READ_IN_PROGRESS | STATUS_WRITE_IN_PROGRESS))) {
+		dev_err(dev->dev, "spurious STOP detected\n");
+		dev->rx_outstanding = 0;
+		dev->msg_err = -EIO;
+	}
+
 	/*
 	 * No need to modify or disable the interrupt mask here.
 	 * i2c_dw_xfer_msg() will take care of it according to
@@ -834,6 +842,16 @@ i2c_dw_msg_is_valid(struct dw_i2c_dev *dev, const struct i2c_msg *msgs, size_t i
 		return false;
 	}
 
+	/*
+	 * Make sure we don't need explicit RESTART between two messages
+	 * in the same direction for controllers that cannot emit them.
+	 */
+	if (!dev->emptyfifo_hold_master &&
+	    (msgs[idx - 1].flags & I2C_M_RD) == (msgs[idx].flags & I2C_M_RD)) {
+		dev_err(dev->dev, "cannot emit RESTART\n");
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4e6fe3b55322..481a4eaaa28d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -267,6 +267,7 @@ static void dw_i2c_plat_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dw_i2c_of_match[] = {
+	{ .compatible = "mobileye,eyeq6lplus-i2c" },
 	{ .compatible = "mscc,ocelot-i2c" },
 	{ .compatible = "snps,designware-i2c" },
 	{}

-- 
2.52.0

