Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB237F73D
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529993; cv=none; b=sWsGnOpdTmaw8atKPLnKLOU/o4ypt5DTBUjY3XoySKZRBurI4FJkz4esqGqFHIUou3iNhcnd7Yz9Dsd3B6ABOL+njooHbLg6IOgTHq3BZ2KMYI3NNYdJxYT2zbcNSkpcRadpE/cLsWH3DbhGgO/y7ehW+UUcKc1Je3pyIV/AeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529993; c=relaxed/simple;
	bh=maWy64YLlRB732kUgHTdJdy5XYo42YyqBugNE3vRYd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gae3/blQZHvsEpNXaNuXqsK3B3NDUK54sjMLqNLYmheTt822QGZtUbyHdYIQTs9gUzqIJxAuku61wzSWJ7yrSRF1VxntWUl2KDrjVLNKlj1Jy0KuZMJHKJhtzw7e1uFDy93eNOGdWyKZBA93wUhBKH5b5hMfFH7XAbPFag+oV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=eQcOOMaq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="eQcOOMaq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3488226eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778529991; x=1779134791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qe1WFsOyIztipU9mcAPjFDXZdMGa3f5fAzVGnu1+Kw=;
        b=eQcOOMaqRPAcXVsAAVA3H5HFp02arz2zmUt6wIS0ndRmC5TzyZlu0fQ2TesXy5GJ0R
         AFO/G5sQ++8ef5oTmlOJMndvzFTx8xXPj6O69UQ7o5uFQtT8OuKBB+uS/VjlyC1OhQ5E
         P2rImKKfLOlNHgVWvQXVAx5FalT9ArMHcdvimSpKq3l0vujaPgn+CRYH2RElMRJA48VN
         BlaexD4V/nopc5cdKWfAUb0SS/gE9eLeT2WcXCAEYPp6kolNE0pC7OPMltUp7/A5Z9xG
         kkbFEVxp/BxrU5FK5YXGs5sbe0kasHFZEtaZjqHUvTSDuorShCaYKI677OCw5CLhgUrt
         +1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529991; x=1779134791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5qe1WFsOyIztipU9mcAPjFDXZdMGa3f5fAzVGnu1+Kw=;
        b=nCO3nI2lZ0lfMYCdQOp+l6UBiHwX3FDcmTZyzsvlpXP74REuVRg2mhcNcg375PTKf0
         L1UcUA5Q7zX9lK1dUp4CTwN/6KQra1IN2xaW8ACou8U/ZsG//ktq5yvfveno5zFjJp84
         eP1NMQc5OnzGsrvA89gn/ge55sA41nah3Oxx3LfeIwTpZnuOdFoQMoysuYIyFgu1TQg1
         H2EP4HZKjqnhs2VR/5i5g/GzaJoFOkj4gKOoUtiBxyvGyDh8H11HR9rO0gTWp0gRdZJG
         I9VqGFfAP01SkLb/ur6w559H8XhtqNNUw1Vvbuct/JMG7pxHQC72fGF7CZXEuNfB79ad
         +wuA==
X-Gm-Message-State: AOJu0YxLAWTsHFJd2gApfOyZ2ERHeB06z7Lqm3tkSbaB6i58ef5mm1ks
	PwCHWpxYSnRROyagIWMPG0ShnOzF7cALVjiKyW4tUfeTe1KBKZxlm45ITHS8iROcReLKBrT+tFn
	qwpca/Ww=
X-Gm-Gg: Acq92OEyFR9spMnKz3t+ilGySYhcRF8UQZFTJ+eZ+AI594xCPauHOvpQHv6BKtXWLkr
	6/8N9jK4b8DqCk4nf4yj2avwdvvK2t7rL9CZLE+G6Ml8covLZq4sQhZS5aOgA9yPjp9kmFCalhx
	59QLfKA15tEjJzfDLopgmGu5RwkGZLSRIzJkC/BBiL+8L96z24Cgiqz6Aqz1Nq2vhmAlfw7Kx5U
	MKt1mxOFRN6dCJ+bXZzQWgZb+W/o/ifS4+JxtIeYmqbrfXP+0ck/LtHWyfg3R8IdcLdrDXs1t+6
	Zzcb7NgQVCXVUG9yd9L+OPi851xxmAXVHLzIqM33ZGL/nlvDLu6qr1YwZ0x7TBneDDON0ll1yi1
	oY+YFTbEeGtscXcx7SGAtvOh4hYmWJP1R4LJ0riKE1HghW8nSBXCCEGauElCpmuXLSl8UGjdt38
	dE6TZcMisHNTHb223+XF2ZIwrdkjcNY6A2a33eYu6UYp9RESvEjvfR4C/risFmlfGVsoFckll9S
	cDbi2M/MNwkP26NvTXhMt6C+Q==
X-Received: by 2002:a05:693c:839c:20b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2ff907f1630mr456690eec.0.1778529990860;
        Mon, 11 May 2026 13:06:30 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm15066942eec.24.2026.05.11.13.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:06:30 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Mon, 11 May 2026 20:06:29 +0000
Subject: [PATCH v5 4/4] i2c: designware: Handle active target cleanly
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-dw-i2c-v5-4-6c382e1b5de6@wkennington.com>
References: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
In-Reply-To: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

When the I2C controller attempts a new transaction while the target
controller is shutting down or restarting, it can lead to bus lockups
and system bootloops if the hardware enters an inconsistent state.

Address this by ensuring that the internal state machines are properly
cleared when disabling the controller if target activity is detected.

If the controller remains active after disabling, perform a bus recovery
to reset it to a known good state.

Signed-off-by: William A. Kennington III <william@wkennington.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c |  8 ++++++++
 drivers/i2c/busses/i2c-designware-master.c | 31 ++++++++++++++++++------------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index ef618d3e1ace..7d9c6a5148cd 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -633,6 +633,14 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 
 	abort_needed = (raw_intr_stats & DW_IC_INTR_MST_ON_HOLD) ||
 			(ic_stats & DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY);
+
+	/*
+	 * If we are in target mode and there is activity, we should also
+	 * trigger an abort to clear the internal state machines.
+	 */
+	if (dev->mode == DW_IC_SLAVE && (ic_stats & DW_IC_STATUS_SLAVE_ACTIVITY))
+		abort_needed = true;
+
 	if (abort_needed) {
 		if (!(enable & DW_IC_ENABLE_ENABLE)) {
 			regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index de929b91d5ea..7a301c8b604e 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -785,18 +785,25 @@ __i2c_dw_xfer_one_part(struct dw_i2c_dev *dev, struct i2c_msg *msgs, size_t num)
 	 * IC_RAW_INTR_STAT.MASTER_ON_HOLD holding SCL low. Check if
 	 * controller is still ACTIVE before disabling I2C.
 	 */
-	if (i2c_dw_is_controller_active(dev))
-		dev_err(dev->dev, "controller active\n");
-
-	/*
-	 * We must disable the adapter before returning and signaling the end
-	 * of the current transfer. Otherwise the hardware might continue
-	 * generating interrupts which in turn causes a race condition with
-	 * the following transfer. Needs some more investigation if the
-	 * additional interrupts are a hardware bug or this driver doesn't
-	 * handle them correctly yet.
-	 */
-	__i2c_dw_disable_nowait(dev);
+	if (i2c_dw_is_controller_active(dev)) {
+		/*
+		 * If the controller is still active after the timeout, attempt a
+		 * bus recovery to clear any potentially locked state.
+		 */
+		dev_err(dev->dev, "controller active after xfer, recovering\n");
+		i2c_recover_bus(&dev->adapter);
+		i2c_dw_init(dev);
+	} else {
+		/*
+		 * We must disable the adapter before returning and signaling the end
+		 * of the current transfer. Otherwise the hardware might continue
+		 * generating interrupts which in turn causes a race condition with
+		 * the following transfer. Needs some more investigation if the
+		 * additional interrupts are a hardware bug or this driver doesn't
+		 * handle them correctly yet.
+		 */
+		__i2c_dw_disable_nowait(dev);
+	}
 
 	if (dev->msg_err)
 		return dev->msg_err;

-- 
2.54.0.563.g4f69b47b94-goog

