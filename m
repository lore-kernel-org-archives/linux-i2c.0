Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E53B6BFD
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912618; cv=none; b=If4rTgk5bwjCGCQQte2VJQeDqwzHPJ4A7WzKSKLdC0fXxSA+RptL1znAEBc7M+ObJc2RxcSjLyHLzckj4Q9SjjsI9OZRhEFVe57otjF3/neHw/+6CLIBiHravbhnn5Z3ReRS7iYGDRCRrsQGoTgBPl5gIEuLSIj2YBdspxQLsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912618; c=relaxed/simple;
	bh=gLLA3yyHeohOG2GTebtGSeCoVbwDGh3LRV+lAp+ifus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vj1k4Yb7rNOhj03bO6ew5a9FFKt1zhcSj18q7OAP/nMjl19AYHjigxPzzzzMtpVGQVnuQFg8yS1LOhB9moiYImSkVplD7BpljsAnvL1GS5zpQfs7pVM3/hVJade4HK4/hBFdYvqk2J9EZIoT5AoEtGanPTOFjYF+3YndaOP+DOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=RAVHXciU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="RAVHXciU"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36abfe17c11so4023141a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1779912616; x=1780517416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMbCijtkQtm47ZP7cdCWnRygezzmp+zq/74mENw1x54=;
        b=RAVHXciUfUq/r/RAgBJdyhM7nrO+8tHloSJOAak+jn2SkVO8Z8knegn8iodVycpva+
         ADGXGjP965deWfdB8rknCZYtpSkGr5w9YQFyL+6F88pJjsVkjCAogu/WraeeW910GJLq
         QDrlmVvmvI6imIPdTFNL0ol+VP86BliOCYlNidQQ9NAi+ZDQlDcNCkxyZguIKMcweT+6
         CodtS0qIu8guZxo4MTHpPOx8MRUbMx45NHzCB0jrB3ctvcWGDKgUoHoBV3bOzxYp9Pw5
         0yi+cXVc6l3G5/yIFvtXhXS7P+33+L2jD25802nZa0szJ2O/6Oo4FKF1zAAheLrELayz
         4THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779912616; x=1780517416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GMbCijtkQtm47ZP7cdCWnRygezzmp+zq/74mENw1x54=;
        b=lBdu1NqAcm3pz3RuIDHGburJawRGhjyLBkOyMGzcVt9BgkaCRyxLa4FvqQu2X4YIat
         Nbx3RB3qou+WTyi4uHqJ4D1fisOGDg1vF+drGSZQWnfcNgpzMwIhRCjLXURUe8CVKAtg
         fQv8Nvq30AG/Z5fguRNSExEJ8X4Jbf5ZaMtXKL0VoG2mYA3MwYtHFFbwktY33BBbi/Vd
         0pMbpYfWthgkaimlZEnWTT8DzvmD6ePq660Zh8G6kHFQ3r52Er61aGkPmJBCvgJ/hDUn
         BDKnHvGmCcLrXM0mLpjvRic/nVcUInpIWXcs8wXXxBGu1Pg6txFGcay9G5z94lJngRmu
         ePAg==
X-Gm-Message-State: AOJu0Yw4jCRZe0EFL2H/GDIqUMcgY74alJis4KyLHZEm7zTvvx9oQ030
	lXe4Q3YS7HV/kO8DK1IUP7qK9Ek9+AbLl+o2KgMFfm9u+81AGrMklEs5IF651HCVZm8=
X-Gm-Gg: Acq92OFxnBcWdv2h1noYlvZz0dpSzZLnQEzYgWU2XxTqj7xE9ZEGsaWy0xpxlWfK0oX
	XW/NLvwiE8HXGq4VrT6ZQJ01hleUP1Z1TKRnGx0OHQaJ+C58NqL2TmE11Ruxwl5GKR4inMn5iC/
	UitclJrAoHcyrq7y9MtNL4JB2WTl9rm5GKuUYRfZr+XBbbu3vGuN4LTy7toDQyuF6aWm+hCkNvW
	OViNmlUJebUIuIQE2cR+DMEXME02Ap27g7icYCI41QNQBliJcdf7rqTkkvL+DYkq3o/7UKO8hMO
	46A3dlTBkHXV0jolEMbjNE4n+fxhaFeFg6ge7O3/icIYlKYRKocftA3MDIObvhSjwdtpuYhAPch
	Xr5M1D+ThU2h65eR/wZN5mr5M7qpyu+pkzZn+7Uny6+x71oGFvgDee0ROBOYVC8634k1BfD9uhi
	68fK72SiXciJAPz8iT3Hs2a/K9d0/p3EeLUzYSWyTXWQUH8Ve4ByQ7q/7k2V2ruCb5vguh3HaEs
	7y/t4vBjktBoOIvM5uAH+M=
X-Received: by 2002:a17:90a:c88d:b0:369:73a:326a with SMTP id 98e67ed59e1d1-36a6760034amr24042873a91.13.1779912616350;
        Wed, 27 May 2026 13:10:16 -0700 (PDT)
Received: from wakbuild.c.googlers.com (27.117.125.34.bc.googleusercontent.com. [34.125.117.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d9416csm21875253a91.3.2026.05.27.13.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:10:15 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Wed, 27 May 2026 20:09:52 +0000
Subject: [PATCH RESEND v5 4/4] i2c: designware: Handle active target
 cleanly
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-dw-i2c-v5-4-3483057f8d67@wkennington.com>
References: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
In-Reply-To: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
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
2.54.0.794.g4f17f83d09-goog

