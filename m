Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2530DEB0
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925709; cv=none; b=uIufCgF2OTtOtHDhos6/CW06mo/19TxGCJcwwtbmiRxv778MLhkMSfr4yoU01lCzE8etKX1amSlEUOBlNZPLXRMA9RDcpTi4CNs713mjWwJ7tBup+AmTe1FIme+t3YEo3DmDgsOZchzVVYxhUJkNzKbS99FZl6MT4v4p/HpBoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925709; c=relaxed/simple;
	bh=T0R/JRPSIi4l6iZ8HhDvk/mxhiX1g/sSVAs1BzrrMLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/UbzMyFnTuN64aEXNewjdJI5A7e9R1uxfOD3mGzwHimpFlNWCi55fQPSRm2FSIJquJNpMGHnoJfYmFxuGFTtyw7zrzsDC/wQAPFaQdAiyAdCZfWW+aI7bitIalHZ8pnK5QV/Yv2OMJCklLayQ+RRpEZOAJp4qsL6Um2Jm1fTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=CLITdPNy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="CLITdPNy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-356337f058aso2869422a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1777925707; x=1778530507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgxSZwGgCRa1NejRL1TMSL6Pe1HA8DjUPmozziT+PDM=;
        b=CLITdPNyDt/qDbNsAGSd55st+7asWryawkz3HawcWyyC3Wuyg3jEqGwTIGfkqvsQz+
         poaYwxwMqlQt0t2yA1X1VzrmXwkuwWc4ZxyuOOtbuYJjrHVDCMmkD5TFI+G5SUUW8eEO
         EwqIW4r0BxLph19cPHAfTStW9gaeQKp1wlyYg8wpBdTbIE0uQ85a6hnBlz8ZP8vrP5IA
         SuMBxqm9VuGDV3lkJzaW7fhOfMUoUyngTWdNkTrKEv24uQ6k1kGvuZvPv+paPD7zYCPv
         zyKkDLGK0AgyBztTpaUaVVetvB/lsqxVjE1tE3hDdJPqhkl+2lTV4LMrzcxAnI0Q7yMD
         8+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925707; x=1778530507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qgxSZwGgCRa1NejRL1TMSL6Pe1HA8DjUPmozziT+PDM=;
        b=goaV1l6HMBatnSpm4J9lF3CRB1s1pfCRuMNJGDnG/P4RaLdFGUwqnJPXfxFVtkQF6G
         sC924tYGTBVoAL5KyJyXHRDE9mLmMWGl9Q/SrTLO6eAD66/6JkPKsUWI28RD/sHIOoUP
         YsbLUrmLbvry1KBCRMGm109szAFRcfkKkZcU8/DnPs4s33Hg64BxuKoKiWw5xYVTMkjc
         So3ax0gRKe+9UWVUu3diWtXbe9wl3nZi7N+eIOq9aJI2IwX6r6liQgvnXX3n/Eo8qbVQ
         WjHRW0LIW3e6yrAoTZN7vaUA8lAq0pfA5AiS/gL+uqI/STgteX0tEXH4yPPoIMyR0SP1
         vfYg==
X-Gm-Message-State: AOJu0YyRqDihhMGGCG3Jy6RRvLzDYjUFJuCpyVHgTDfsWuYSefaRijbt
	hYFnAfGyvdpJ608N5k7QWmwUArcLesY5GcizNoMb77WWTS4yi5KEHFr74TCF0t9AH3k=
X-Gm-Gg: AeBDievU2ZMDW+yZ+MBJAUyvbZLua+1Le77PoRQrOuE2TLvT2SBSas/i3SkarFMtWa4
	fZOrIGnxI4oTALSwaJFtcrYprL2ScCeFIB1wGCcqxAhjcQmeWCg13BJdZeIqfQ1e9ir7ObtHgOi
	r8+iVr69Gpn0MtAxdS0Td6lpg1je++Pjc+ewQMzTgvE77TdzsA9AK+p6/K6Ca7HNIrssfjzkUGd
	ZKA6AT6KOCg13oU+H2CH/Lj3VPwe8TmcbEE/1o7uR+KRE1E//XyNCwErBzjlmgIpJHZ1pLO+14f
	dqy22BuW8Hy2I02HZtbBZUShiAYO0DgLVX3X/uTobhYi/zt5tmADWx/ckQlPzpzurMb96IfA3IN
	mImefDZd2cprZ44PcuoGbUruASrHF6ijvj+exKmIB0lSUHy4f9/bFyWxvzHCjsvAcr6KB4Gkkrl
	Akc4C0BwaHAVJikjbID59FCi4xO9en3i0o6S4SAVbDF61pO3ZYO/DNCe0ZC4SYXzCATg6f8wqdk
	c7YvmcwCrE7NoYlWGD3j5ye4A==
X-Received: by 2002:a17:90a:e7cd:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-3650cdb883dmr10970435a91.11.1777925707166;
        Mon, 04 May 2026 13:15:07 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2aa41sm20568593a91.4.2026.05.04.13.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:15:06 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Mon, 04 May 2026 20:15:05 +0000
Subject: [PATCH v3 4/4] i2c: designware: Handle active slave cleanly
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dw-i2c-v3-4-57e56135d602@wkennington.com>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
In-Reply-To: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

When the I2C master attempts a new transaction while the slave
controller is shutting down or restarting, it can lead to bus lockups
and system bootloops if the hardware enters an inconsistent state.

Address this by ensuring that the internal state machines are properly
cleared when disabling the controller if slave activity is detected.

If the controller remains active after disabling, perform a bus recovery
to reset it to a known good state.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-common.c |  8 ++++++++
 drivers/i2c/busses/i2c-designware-core.h   |  4 ++--
 drivers/i2c/busses/i2c-designware-master.c | 31 ++++++++++++++++++------------
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 0703fb29038c..31394d8fe612 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -633,6 +633,14 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 
 	abort_needed = (raw_intr_stats & DW_IC_INTR_MST_ON_HOLD) ||
 			(ic_stats & DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY);
+
+	/*
+	 * If we are in slave mode and there is activity, we should also
+	 * trigger an abort to clear the internal state machines.
+	 */
+	if (dev->mode == DW_IC_SLAVE && (ic_stats & DW_IC_STATUS_SLAVE_ACTIVITY))
+		abort_needed = true;
+
 	if (abort_needed) {
 		if (!(enable & DW_IC_ENABLE_ENABLE)) {
 			regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 8b422249acbd..259b7ce16d0c 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -129,8 +129,8 @@
 #define DW_IC_STATUS_ACTIVITY			BIT(0)
 #define DW_IC_STATUS_TFE			BIT(2)
 #define DW_IC_STATUS_RFNE			BIT(3)
-#define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
-#define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
+#define DW_IC_STATUS_MASTER_ACTIVITY	BIT(5)
+#define DW_IC_STATUS_SLAVE_ACTIVITY	BIT(6)
 #define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)
 
 #define DW_IC_SDA_HOLD_RX_SHIFT			16
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
2.54.0.545.g6539524ca2-goog

