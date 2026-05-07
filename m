Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4AC364E84
	for <linux-i2c@vger.kernel.org>; Thu,  7 May 2026 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184328; cv=none; b=nzM9GK+5C3dDOhBZck5y3M5beoAFeDpUb5O4VivwtiPcpqRtEPhRArhZCpH9qko2uxB929w92NxTl7zI4Li0epH6pFNKBV9dM11i7aaPiNaZzfr/ZUt7nW/MwNmL96pHZXHGwQh5gaeM6+kyaJ3a98J9/t0i3nTKgXMf0OGObVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184328; c=relaxed/simple;
	bh=dWw2eeSEN5euvjVJ3wXeI34saYGcPcQNp2hNwJvzVPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=toIPxge/KqAeAen8hYp6YEIBRbgp+whqkWgbm4W8BDmBQIC9NaffLeguEJCy2gxsWLGpQTH4OCnbkp1V14G/9AuN1choLMFS6AARaaH7SHs0A2tMdp3YpK2L9rwRh/rDKcozTC+/V3N1fKhUC802yit+4mMvO7ENTSOuOpOdSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=KUiE9X5C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="KUiE9X5C"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8367df48711so568479b3a.1
        for <linux-i2c@vger.kernel.org>; Thu, 07 May 2026 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778184326; x=1778789126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oC1FmSZRpBHqB8kjyzbhzh5I8FZEHW+KmWxwvZd/drI=;
        b=KUiE9X5C+Jsx1BuO3PudTjxQ+N7CuINFeFaZ+jBIj9A4Uz6gTWDQ+sdmDxoks7LXW8
         fv8e6oZWEg+n5V9xsTyDuyVcuVlf3QaImRLRhv3uoi7VShE98MKNnZX2y8HblsUzXm4+
         /AcHAvu2nl93+8gf8KwXdnh6tVegD3qSOAPftaWulUeAZBFhyOua9mzkTqe7nnAp8iyI
         p9gh3iLttdJi59IxztlQCoEpXj7V0trALNFk4c+8+2P+W+Dqg8t0PihjhPTFkIqYY0mm
         684cv+IEnIYcu93G2akwtk7ddBjemL+vGQs0RuVOOYaPJsjcqANBI05JegBK4OCPXQw7
         DdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184326; x=1778789126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oC1FmSZRpBHqB8kjyzbhzh5I8FZEHW+KmWxwvZd/drI=;
        b=mcaOUSEt9+vPbfpP93LG/AgkQVPvuFnN48zFOsvR+KE/vJBdPMiC/v6j1mpgNNsSfJ
         iK49aQfEAagZ4kn3q59pz/ekk7rWYCQZGzrrU6sv37BGGtXoIpbCbbeRab95T3QfIsJb
         JBJ5DFyXugjJRoqYMxRTu4f51eUrqWVErcS3EdoHacwP7WeOmfbZyus9btjagzmG477n
         WXTHCAOJj79Sl4oY48RzFZOvkeYiEBUyTQHyGPKbMwMnmjLc7902iXRCWoOKB6hgb321
         FH7zbpxonfsNGrrP0CmskJUi0G53ZmP7VM4gC43dQrKQEiQ7UYv2dF4lkC/GkAs43mxZ
         7nHQ==
X-Gm-Message-State: AOJu0YyBZxRagmT7kBG9/8NyJbL/QONWQMtZFwfHnVQM9OQ60vB11kMe
	kXlYt+qdYos2DU8LckKFklGhMkXSatiXl2QEs2598UdsqFyfwPlSWpl3HoifRV8q8YY=
X-Gm-Gg: AeBDieuDkoDYVYOSoBm1jCApuRwFoZBx8vbDCtMmZmWjyFZWnXEZn3BrH8A1uJHxZiF
	tpJFj/iH1BlwQnOoN7GsMmzsJ0vEeKw9aDsOtmti6d7kU6J+QFSe7Ri0jNvyqSYQwflUrvG+NZJ
	Pn4hOQs7eh4elQsf0jCaf4vSnGKG0wqimTfcsO5g7zr7HcXLLyphQkzAugFEH4ezTTTj1Jg6goU
	TCIZMRTfe233OlDgILcOgEcvMdNbYHAt4FdC34WpguXBCdtEMmso/WQ9mXbXsXJ5zCbMYftKkAH
	wA+tcHHat/hJ2ncLRBPUDGdd78B9m87WRTEgljPozad+90WRucoVZi0r8N0Bqeol4iVm/LaNOMg
	2dnBwDoa5E1Q12v0B5IjEn3+uVnAIX51Wna6BrHjk9AOAc903h37m95wzygOpYHF4UC/vJRlkAu
	5WA96ADtpFlQQ8g0zdQu9bNxYg5A7ldTRgwDYYF91YamFKN9LaP2uaeiy0nZBgAmgsaxbauERWS
	O4QyvOfrtdTOIE=
X-Received: by 2002:a05:6a21:99a9:b0:39b:e321:67ea with SMTP id adf61e73a8af0-3aa5ab855bemr9904536637.45.1778184326443;
        Thu, 07 May 2026 13:05:26 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8263ff29c2sm443200a12.12.2026.05.07.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:05:26 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Thu, 07 May 2026 20:05:18 +0000
Subject: [PATCH v4 4/4] i2c: designware: Handle active target cleanly
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-dw-i2c-v4-4-9a447b23bfdf@wkennington.com>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
In-Reply-To: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
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
---
 drivers/i2c/busses/i2c-designware-common.c |  8 ++++++++
 drivers/i2c/busses/i2c-designware-master.c | 31 ++++++++++++++++++------------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 886f4dad166a..cf5feed269bd 100644
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

