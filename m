Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD8472F9D
	for <linux-i2c@vger.kernel.org>; Fri,  7 Aug 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102425; cv=none; b=FiNQnxKDnrwnsUla02CNQGIpGEdn0Q94GpZOfDqUN16+BCt1wphaoreVdNSHMHjnnQOFdmAnj7Su5gL7icGpr2ZK3ZWnGevkraU5uueQFZOJ1tLDIzddbB0VHrJF3ol2TtRALSe3OMxnDTCCOHq62f1ZdQCZDKv7+vP14scDABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102425; c=relaxed/simple;
	bh=KZfsGqLnGn6sYUgiUfxkHqW9jLn/Vo2fmE4mbUWm3fw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HOyxfV+klcQ9gBK9wvawiSHGLeirZc+up+OUb4DHzBhVd/bmcZd0VaosgT4eayYjX5d0a/I4akNQJgLdGNZl63Vh4umAjNm5RvCGDM09voytjijHh2ogwCDWk+r5B8YH2BaoybagWPF4oyv7X+KrR3rIGRBGqG5neDsLFGGu+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5+fmH1y; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5+fmH1y"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3450590a91.2
        for <linux-i2c@vger.kernel.org>; Fri, 07 Aug 2026 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786102423; x=1786707223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7PbxRsMzVb8kmct5SLmSMjVEgduDlXlOncSV33ZehU=;
        b=B5+fmH1y/JluPy84aqa3N4qZvrLSntubqxVdGZppAmq63WRnjDwpHluxzL7nrfLYxw
         lFHVuTDgtw6Yt8JrP6kMLEj3yEvHmWcfFeJpWpupEKgv3RGSUwU3wmDugxPayg4uq2n2
         zMCTikQxFXNm7YBvPHUGR9c5GF3bi9OZEMVAyxvemg5GY1nO4uug4qCD4GNyh/+IORRA
         ovuewT9T2gKksFwLAcg1NS65rw/SbValotsjrRhfIu+QEmDlwWL4eu1Przr2bdUWR8H7
         HT2Ymw99ltTrK2TEDPC0XnfIOOBWaTdcIwX4w/qdexWGpc6Po4jmPCyY6VVPyOkkVzbR
         i1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786102423; x=1786707223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7PbxRsMzVb8kmct5SLmSMjVEgduDlXlOncSV33ZehU=;
        b=C13McRwYm5jlCc+f9bWhZ8l/AxeltQPVy0zDHrKeTkiAKUoI5Vsavkb0Icxc/WDLaP
         Yj4XpJ7rTriWNrhyCDtW1wwM5KMkI/qLS4wFtQ0CV4UBVc6KXRDITZoO10UrMhlHrez4
         hPDmUsLo4C2f7Lrlvh2tE2bIsiY5DRWX0r8KHc3+dG1SzJHQ8YdSBRoTzGVfdhS8gAg1
         W4i7RJvfCvZUoXws2+NGzG/c7YeIW2q8joMrXeAh0QcEYuDmn+M8l+2gSIFIKV3T8rxQ
         LNhpx8U7uRH89UeWh+B3AgyAuHOzDc7Ad+B94k7MwMDODbtLDIUZf7XonYOKu/VI4Dpa
         ZgcA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8qPP/oSCIXzhrX1KMKixfBBHpBRqes2rR/vM9cdY5vYyO2VmEhFDTo/s99UzgRdiSY2aGQxTMqDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0Sc2R94XK5sIO8coYM1Lhk20y06zQrjdIXwwgMrMRMEivtLn
	pEK3DlyvyztbFAK/ffgpDJuLv1gTnbICch3yJCLpYqhg56YA598IBELn
X-Gm-Gg: AR+sD11N574VDnI8NhhL6KiXLvKbvR4EUaAHUvybMq41QMcF4askK81Gc6l3+CsjXxc
	Fg7Qo4sDwVJh3flbifBLswzIQPdQ4Jd/cXhPtlVte81r5M6YSmuWLy5GTVYfYC8D4QnxZEjD5Co
	xPdCcXQcIVIGFnZZsRdL4JRRucCStPza0SbvqwbGFdNXjMlX8C/Cz5kxGRedx33liVQuwcfzXlj
	iUV9mAA+r6kJdvJeN4Qiu4t74Bbsa0sK1CpvP+5EwhC3AFePcuKEIThpownnz0Pkh0P1QwcFUnc
	Aiwuuzeo4aJZX5m2tKuwr1D1XfhvyQXrr4YbKUvevUnPvvxQHSjimiDq4J5Oq3/MvHKPeF9HA+P
	VfRFTzHU2Tc+PpKSUAM93/1K4VXUYoq4SLOULBPJQoh0zj+MamYHGVWleSjEe4ptjHAeTXWdJe7
	9D2Yht8wJ7hB8fRkWYkc5v8IA3J0tKSaUXlfnwWfFA2ns85xZMb0mPeZ6VRHctJcL3kkz2B3HL/
	kM=
X-Received: by 2002:a17:90b:4e8d:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-3903c58ed40mr22433206a91.10.1786102422619;
        Fri, 07 Aug 2026 04:33:42 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f5e33fsm4641768a91.14.2026.08.07.04.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:33:42 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [RFC PATCH] i2c: designware: add atomic transfer support for IRQ-off contexts
Date: Fri,  7 Aug 2026 19:33:33 +0800
Message-Id: <20260807113333.1635449-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DesignWare I2C controller driver cannot perform transfers when
IRQs are disabled, e.g. during noirq system resume where an I2C
client (GPIO expander, PMIC) must be accessed before IRQs are
re-enabled: the interrupt-driven path calls wait_for_completion_timeout()
which deadlocks with IRQs off.

The i2c core already routes to master_xfer_atomic() when
i2c_in_atomic_xfer_mode() is true, but that gate requires
system_state > SYSTEM_RUNNING, which does not hold during resume_noirq
(system_state is already SYSTEM_RUNNING there).  So the framework
atomic path does not cover resume_noirq either, and designware does
not implement master_xfer_atomic at all.

Implement i2c_dw_xfer_atomic() and register it as ->xfer_atomic.
It reuses the existing i2c_dw_process_transfer() state machine (the
TX/RX/STOP/ABRT handling is identical to the interrupt path) but:

  - drives the clock directly via i2c_dw_prepare_clk() instead of
    pm_runtime (which may sleep),
  - sets ACCESS_POLLING for the duration of the transfer so register
    reads use IC_RAW_INTR_STAT and the hardware interrupt is masked,
  - polls with udelay() + a retry count instead of usleep_range() +
    jiffies, neither of which is safe with IRQs disabled (the tick is
    frozen so jiffies does not advance, and usleep_range() may sleep).

Also fall back to i2c_dw_xfer_atomic() from i2c_dw_xfer() when IRQs
are disabled, since i2c_in_atomic_xfer_mode() does not cover
resume_noirq.

This is an RFC: the resume_noirq coverage relies on the driver-side
irqs_disabled() fallback because the framework gate is closed there.
I'd like feedback on whether that fallback is acceptable or whether
the gate should be widened in the i2c core instead.

Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/i2c/busses/i2c-designware-common.c |   1 +
 drivers/i2c/busses/i2c-designware-core.h   |   1 +
 drivers/i2c/busses/i2c-designware-master.c | 109 +++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index e4dfa2ec58bb..561efcd39c7f 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -873,6 +873,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 
 static const struct i2c_algorithm i2c_dw_algo = {
 	.xfer = i2c_dw_xfer,
+	.xfer_atomic = i2c_dw_xfer_atomic,
 	.functionality = i2c_dw_func,
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	.reg_slave = i2c_dw_reg_slave,
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index c71aa2dd368d..4bc22b53d470 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -398,6 +398,7 @@ extern void i2c_dw_configure_master(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe_master(struct dw_i2c_dev *dev);
 
 int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
+int i2c_dw_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 extern void i2c_dw_configure_slave(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 7a301c8b604e..9a94abf86233 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -918,6 +918,104 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 	return num;
 }
 
+/* Poll up to ~1s in 10us steps; bounded fallback for the IRQ-off path. */
+#define I2C_DESIGNWARE_ATOMIC_POLL_RETRIES	100000
+
+/*
+ * Atomic-context variant of i2c_dw_wait_transfer().  The normal polling
+ * path (ACCESS_POLLING branch in i2c_dw_wait_transfer()) uses usleep_range()
+ * and a jiffies deadline, neither of which is safe when IRQs are disabled
+ * (noirq system resume, shutdown): the tick is frozen so jiffies does not
+ * advance, and usleep_range() may sleep.  Poll IC_RAW_INTR_STAT with
+ * udelay() and a retry count instead, while reusing the shared
+ * i2c_dw_process_transfer() state machine so TX/RX/STOP/ABRT handling is
+ * identical to the interrupt path.  Caller must have set ACCESS_POLLING.
+ */
+static int i2c_dw_wait_transfer_atomic(struct dw_i2c_dev *dev)
+{
+	unsigned int stat;
+	int retries = I2C_DESIGNWARE_ATOMIC_POLL_RETRIES;
+
+	do {
+		if (try_wait_for_completion(&dev->cmd_complete))
+			return 0;
+
+		stat = i2c_dw_read_clear_intrbits(dev);
+		if (stat)
+			i2c_dw_process_transfer(dev, stat);
+		else
+			udelay(10);
+	} while (--retries > 0);
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * i2c_dw_xfer_atomic - transfer messages in atomic context.
+ *
+ * Used when IRQs are disabled, e.g. during noirq system resume where an
+ * I2C client (GPIO expander, PMIC) must be accessed before IRQs are
+ * re-enabled.  pm_runtime and mutexes may sleep, so drive the clock
+ * directly via i2c_dw_prepare_clk(); ACCESS_POLLING makes register reads
+ * use IC_RAW_INTR_STAT and routes the wait through
+ * i2c_dw_wait_transfer_atomic().
+ */
+int
+i2c_dw_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+	unsigned int flags = dev->flags;
+	int ret;
+
+	dev->flags |= ACCESS_POLLING;
+
+	ret = i2c_dw_prepare_clk(dev, true);
+	if (ret)
+		goto out_flags;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		goto out_clk;
+
+	reinit_completion(&dev->cmd_complete);
+	dev->msgs = msgs;
+	dev->msgs_num = num;
+	dev->cmd_err = 0;
+	dev->msg_write_idx = 0;
+	dev->msg_read_idx = 0;
+	dev->msg_err = 0;
+	dev->status = 0;
+	dev->abort_source = 0;
+	dev->rx_outstanding = 0;
+
+	i2c_dw_xfer_init(dev);
+
+	ret = i2c_dw_wait_transfer_atomic(dev);
+
+	if (i2c_dw_is_controller_active(dev)) {
+		i2c_recover_bus(&dev->adapter);
+		i2c_dw_init(dev);
+	} else {
+		__i2c_dw_disable_nowait(dev);
+	}
+
+	if (!ret) {
+		if (likely(!dev->cmd_err && !dev->status))
+			ret = 0;
+		else if (dev->cmd_err == DW_IC_ERR_TX_ABRT)
+			ret = i2c_dw_handle_tx_abort(dev);
+		else
+			ret = -EIO;
+	}
+
+	i2c_dw_release_lock(dev);
+out_clk:
+	i2c_dw_prepare_clk(dev, false);
+out_flags:
+	dev->flags = flags;
+	return ret < 0 ? ret : num;
+}
+
 int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
@@ -925,6 +1023,17 @@ int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
 		return amd_i2c_dw_xfer_quirk(dev, msgs, num);
 
+	/*
+	 * Fall back to the atomic path when IRQs are disabled, e.g. during
+	 * noirq system resume where an I2C client (GPIO expander, PMIC)
+	 * must be accessed before IRQs are re-enabled.  The i2c core's
+	 * i2c_in_atomic_xfer_mode() gate does not cover resume_noirq
+	 * (system_state is already SYSTEM_RUNNING there), so the driver has
+	 * to route the transfer itself.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled())
+		return i2c_dw_xfer_atomic(adap, msgs, num);
+
 	return i2c_dw_xfer_common(dev, msgs, num);
 }
 
-- 
2.34.1

