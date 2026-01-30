Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71717344033;
	Fri, 30 Jan 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788365; cv=none; b=eoPCiSfxTTNchvDydnR8t+RGrBuWVzWChJdjX/5Q3r4X2iZxoyFBciz24nWayPmF1SDw8ULZZoiyLk11TELYwlAXhcP8FpWO+85ARDUflGbOp1zZWV8zolidMeTtDRCyGhmE//gGFnU7NH69oXGlV7QRKMCsPrrVgFB8scAgEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788365; c=relaxed/simple;
	bh=39z6ELlhWfOS3WubUi8PSCLlP8oYRxCb+ySctWRbkS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtV6TyIVMW753DLEN95OhJpDEYe2bTXyzIlm/SuBDtzcmhlN7yHHWOS9mPTFJkmrh8EiXE6ox1/kPqSiLK7aehE+rPAoPwyvNz1nr619+REmMoreC88KcqZ10yl1RQyfSGbe57JKmgOLsTQ8iBC+9I76tecPLRQZCVrHzBQhSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vrrFGoVu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vrrFGoVu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1D62D4E42356;
	Fri, 30 Jan 2026 15:52:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6A1D6075A;
	Fri, 30 Jan 2026 15:52:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 754E8119A8886;
	Fri, 30 Jan 2026 16:52:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769788360; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ucNjf6o24tw8VIRv3UolSI4jtitkY7sdSeM8UkdM358=;
	b=vrrFGoVuO+4eYyvmujAQ6LwzBNWHQB0oSfonq/wMf6zqWp2dazPXauDvTplXqyJK7xhqNg
	hgV7lGkCngB9dFRyXqgl7vJpvrodH7ztWMlkHjPXYX9H3wcL2mYqqGffETss57c+2NciuJ
	pamzvzH5zJRtOeq1DyHLsiHjQJXSCiP5DhcT7uh0aSqQj4QIIv7l7bS5p5pnTgM6z3FHp4
	Zq1ymbiv56rHipu8oU6nDzmDkhuVfP3QTGeRu0vSBKZ/4uIax5OJoATHE5dX4fflibkPS+
	CBgB/EAcJ5t+nFLqDQW8qRweBCJ8DFJr+3I1EJXHs+FM43CqAFsV8+5rpCKqfQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 30 Jan 2026 16:52:29 +0100
Subject: [PATCH v6 1/3] i2c: designware: Implement I2C_M_STOP support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260130-i2c-dw-v6-1-08ca1e9ece07@bootlin.com>
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

Add the support of the I2C_M_STOP flag in i2c_msg by splitting
i2c_dw_xfer() in two: __i2c_dw_xfer_one_part() for the core transfer logic
and i2c_dw_xfer() for handling the high-level transaction management.

In detail __i2c_dw_xfer_one_part() starts a transaction and wait for its
completion, either with a STOP on the bus or an error. i2c_dw_xfer()
loops over the messages to search for the I2C_M_STOP flag and calls
__i2c_dw_xfer_one_part() for each part of the messages up to a STOP or
the end of the messages array.

i2c_dw_xfer() takes care of runtime PM and holds the hardware lock on
the bus while calling __i2c_dw_xfer_one_part(), this allows grouping
multiple accesses to device that support a STOP in a transaction when
done via i2c_dev I2C_RDWR ioctl.

Also, now that we have a lookup of the messages in i2c_dw_xfer() prior
to each transaction, we use it to make sure the messages are valid for
the transaction, via a new function i2c_dw_msg_is_valid(). We check
that the target address does not change before starting the transaction
instead of aborting the transfer while it is happening, as it was done
in i2c_dw_xfer_msg(). The target address can only be changed after an
I2C_M_STOP flag, i.e after a STOP on the i2c bus.

The I2C_FUNC_PROTOCOL_MANGLING flag is added to the list of
functionalities supported by the controller, except for the AMD NAVI
i2c controller which uses its own xfer() function and is left untouched.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 132 ++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 39 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 8ca254cbb2f8..a466511dadd4 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -377,7 +377,6 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	struct i2c_msg *msgs = dev->msgs;
 	u32 intr_mask;
 	int tx_limit, rx_limit;
-	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
 	u8 *buf = dev->tx_buf;
 	bool need_restart = false;
@@ -388,18 +387,6 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		u32 flags = msgs[dev->msg_write_idx].flags;
 
-		/*
-		 * If target address has changed, we need to
-		 * reprogram the target address in the I2C
-		 * adapter when we are done with this transfer.
-		 */
-		if (msgs[dev->msg_write_idx].addr != addr) {
-			dev_err(dev->dev,
-				"%s: invalid target address\n", __func__);
-			dev->msg_err = -EINVAL;
-			break;
-		}
-
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 			/* new i2c_msg */
 			buf = msgs[dev->msg_write_idx].buf;
@@ -746,17 +733,15 @@ static int i2c_dw_wait_transfer(struct dw_i2c_dev *dev)
 }
 
 /*
- * Prepare controller for a transaction and call i2c_dw_xfer_msg.
+ * Prepare controller for a transaction, start the transfer of the @msgs
+ * and wait for completion, either a STOP or a error.
+ * Return: 0 or a negative error code.
  */
 static int
-i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
+__i2c_dw_xfer_one_part(struct dw_i2c_dev *dev, struct i2c_msg *msgs, size_t num)
 {
 	int ret;
 
-	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
-
-	pm_runtime_get_sync(dev->dev);
-
 	reinit_completion(&dev->cmd_complete);
 	dev->msgs = msgs;
 	dev->msgs_num = num;
@@ -768,13 +753,9 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 	dev->abort_source = 0;
 	dev->rx_outstanding = 0;
 
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		goto done_nolock;
-
 	ret = i2c_dw_wait_bus_not_busy(dev);
 	if (ret < 0)
-		goto done;
+		return ret;
 
 	/* Start the transfers */
 	i2c_dw_xfer_init(dev);
@@ -786,7 +767,7 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 		/* i2c_dw_init() implicitly disables the adapter */
 		i2c_recover_bus(&dev->adapter);
 		i2c_dw_init(dev);
-		goto done;
+		return ret;
 	}
 
 	/*
@@ -809,28 +790,95 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 	 */
 	__i2c_dw_disable_nowait(dev);
 
-	if (dev->msg_err) {
-		ret = dev->msg_err;
-		goto done;
-	}
+	if (dev->msg_err)
+		return dev->msg_err;
 
 	/* No error */
-	if (likely(!dev->cmd_err && !dev->status)) {
-		ret = num;
-		goto done;
-	}
+	if (likely(!dev->cmd_err && !dev->status))
+		return 0;
 
 	/* We have an error */
-	if (dev->cmd_err == DW_IC_ERR_TX_ABRT) {
-		ret = i2c_dw_handle_tx_abort(dev);
-		goto done;
-	}
+	if (dev->cmd_err == DW_IC_ERR_TX_ABRT)
+		return i2c_dw_handle_tx_abort(dev);
 
 	if (dev->status)
 		dev_err(dev->dev,
 			"transfer terminated early - interrupt latency too high?\n");
 
-	ret = -EIO;
+	return -EIO;
+}
+
+/*
+ * Verify that the message at index @idx can be processed as part
+ * of a single transaction. The @msgs array contains the messages
+ * of the transaction. The message is checked against its predecessor
+ * to ensure that it respects the limitation of the controller.
+ * Return: true if the message can be processed, false otherwise.
+ */
+static bool
+i2c_dw_msg_is_valid(struct dw_i2c_dev *dev, const struct i2c_msg *msgs, size_t idx)
+{
+	/*
+	 * The first message of a transaction is valid,
+	 * no constraints from a previous message.
+	 */
+	if (!idx)
+		return true;
+
+	/*
+	 * We cannot change the target address during a transaction, so make
+	 * sure the address is identical to the one of the previous message.
+	 */
+	if (msgs[idx - 1].addr != msgs[idx].addr) {
+		dev_err(dev->dev, "invalid target address\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int
+i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
+{
+	struct i2c_msg *msgs_part;
+	size_t cnt;
+	int ret;
+
+	dev_dbg(dev->dev, "msgs: %d\n", num);
+
+	pm_runtime_get_sync(dev->dev);
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		goto done_nolock;
+
+	/*
+	 * If the I2C_M_STOP is present in some the messages,
+	 * we do one transaction for each part up to the STOP.
+	 */
+	for (msgs_part = msgs; msgs_part < msgs + num; msgs_part += cnt) {
+		/*
+		 * Count the messages in a transaction, up to a STOP or
+		 * the end of the msgs. The last if below guarantees that
+		 * we check all messages and that msg_parts and cnt are
+		 * in-bounds of msgs and num.
+		 */
+		for (cnt = 1; ; cnt++) {
+			if (!i2c_dw_msg_is_valid(dev, msgs_part, cnt - 1)) {
+				ret = -EINVAL;
+				goto done;
+			}
+
+			if ((msgs_part[cnt - 1].flags & I2C_M_STOP) ||
+			    (msgs_part + cnt == msgs + num))
+				break;
+		}
+
+		/* transfer one part up to a STOP */
+		ret = __i2c_dw_xfer_one_part(dev, msgs_part, cnt);
+		if (ret < 0)
+			break;
+	}
 
 done:
 	i2c_dw_set_mode(dev, DW_IC_SLAVE);
@@ -840,7 +888,9 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 done_nolock:
 	pm_runtime_put_autosuspend(dev->dev);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+	return num;
 }
 
 int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
@@ -859,6 +909,10 @@ void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 
 	dev->functionality |= I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
 
+	/* amd_i2c_dw_xfer_quirk() does not implement protocol mangling */
+	if ((dev->flags & MODEL_MASK) != MODEL_AMD_NAVI_GPU)
+		dev->functionality |= I2C_FUNC_PROTOCOL_MANGLING;
+
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
 

-- 
2.52.0

