Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159A3FD133
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806247; cv=none; b=apslKs9bkTvhx493KV2pyil9kp534Kt1iToqecUO74ai7Ccc4FPDZklV2P2xm1LejdeM03kHiI5VSwtM0brM82zhsP0vn+za+HwUbsGXHNeS5KU5qfXULTDMUh5awzKDFyXIeGOaKWssU+JkZ5FrN033TXnAiD4aCqU3XRAkLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806247; c=relaxed/simple;
	bh=9DguFz/w39N1oZZZDKp+yyOgXvl1xRpIiiz4lRCQx6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=czM4Ru5+Fs8Dg5nlowzFSLJrCoUScKF8hXcyrOnl8f+W8SNwBuvAsjbv7XZ4eLK6JiA7iyY3aHbzQYoujj6QeheksDADSSbBAezOaYpw7rGU4xnp0ieAl2XzSM/43iL9cYhjNEzuDA73ORjLkOVpwdlajsluY9QzA4HSSj9lrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGHSWhR3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGHSWhR3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49048e043e5so31318625e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779806245; x=1780411045; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IR7wPi+xk7Q/JeKG+D+3ANr2AQD/gij5HhxCcP8ssCM=;
        b=cGHSWhR31fpp2tn5oN9sp0RxzFyZR+dvwQHdSn5eLWuIlG8XPwf+TEntaGvDPUD53D
         SdJMaWiKw85lXBMIl8PKIFoSYcz3pF+Bdis7jOIzLMois13AcH+vP4AjMpaqC/4+7YIi
         V0Y+PAnH5WPH9T9ZlUTIegF2xyz9w8wnGq9rkSmYdDf5ipD/lhOjtsa5WnQmqjhkaDTv
         qyEgYEXCAmedXOY5aSu/0PckLAnMrrifA3Sru2gaWtemw/zWUiU94ORc1rBEk7mnQFOm
         4Rn6kwnAMwWwDCTc+2B1E4WTQCJxcKdv4YDi5eYHKBj/l2b8ot1NEkOQaLUSVO0HMYfD
         JgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806245; x=1780411045;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR7wPi+xk7Q/JeKG+D+3ANr2AQD/gij5HhxCcP8ssCM=;
        b=sp7xE9HB37W16UDz6Abe0YiH9DMqbYAqM7OYpzu9CjdAYf4+GybPmXDCiEwy1MQXZ6
         ITR9sZkXajbJmKJFsMAHRXPTiYmKcD1xEecdxgRLCOYppY7d2DTaBW9HhkhuyS6o6iMT
         /vkyZEV0v6cBmOOv+pkS+mxG33Bfyysvq8jvuS/8mN+H+Jvch/Rb8ASxtGNItXYAwn28
         ac0rKR0BcTs7QblaYjQZJ7v0U+VDxRruRtFxYbUqtTQpm+J96Lr2hlHzXL6xdSOuiEdI
         1HnLCc1fye8mqcueBEAgIgrTlMrnumDTytzxFnzexZm7JWfvs3tNzz/6rmCsrGhFrThY
         PRYQ==
X-Gm-Message-State: AOJu0Yw39hKh9DDMBtMHIzB5WQLW3Ti1uXJPqz9x7c4xhufRT0KIW2pj
	Kdevq8qJVf5XeAe5KBSApJ4vgzjAC6ulpSkT6lfSDhcTjVdsc72R5JnYu6p1hw==
X-Gm-Gg: Acq92OF+VyLJU/vzBfvyGtLHQtoa4WTvowl39Ix+1o61BYO1qmDpr+TJAYZqmMlbVuy
	4bKJ2qy/Q5x+KLEni6435o0BGpEDesymgiy2VC8LbXm4qL3YhMSxulJBLPsKK62do95pBwV+2pr
	B4OhQvxtSEcwBlmOmIvCGBNamEPDXLrbOsrI+k8LM3wAv5j4DXrptEDrtXxUvGamKFh2U5aP/1U
	6oB+pxBFxWYQNk2A2Ab66r21E8V/Jx2LrNexqma0BZiG1+2n1yW1tAxJoC3sQKceRrc6Aa7GC65
	P6+97pcddCTgs6hqnVgUDkZBTzgCBFtoEGsxLy4BAFMf4Ntd51FdkuitFX7PNoyr3dQbPz0Y0vu
	Pb3yUc926gxF9OOUh7gNBrwgiMIEqRD6cIRAKmVC7knAUXqClhlJEqagJt1zezF0/hCNAUOQ4BZ
	/qS8+vRsRs6Z8td/tR5IfuDvohrmeDiqkN9lsh90P46owv5/A3q3BlmWCi+cL1nxc3+IkhHecqw
	MM=
X-Received: by 2002:a05:600c:45ce:b0:490:59cc:999f with SMTP id 5b1f17b1804b1-49059cc9aa2mr183824375e9.4.1779806244414;
        Tue, 26 May 2026 07:37:24 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042ce8722sm111424575e9.34.2026.05.26.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:37:24 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 26 May 2026 16:36:57 +0200
Subject: [PATCH] i2c: busses: make K1 driver default for SpacemiT platforms
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-orangepi-sd-card-i2c-v1-1-b92268bfd467@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W5hFh/Mr4kG6TntR6UAE8e9Oj
 wkkN2QxlQxDdYPJqVn3rUBTV8DrvC2CGgsDOfKuI4+7ffZQzBF5tohKjMm13AduKIQeSnqYJL3
 +7Tg9zwtwn+NDZgAAAA==
X-Change-ID: 20260526-orangepi-sd-card-i2c-f04c89c12998
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3

Enable I2C_K1 by default when ARCH_SPACEMIT is configured to ensure SD
card functionality works out-of-the-box.

SpacemiT K1 boards use I2C-controlled PMICs (like the P1 chip) to
provide SD card power supplies. Without the I2C_K1 driver enabled,
regulators cannot be controlled and SD card detection/operation fails.

Suggested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
Suggested-by: Yixun Lan <dlan@kernel.org>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
This patch addresses a user experience issue where SD card support fails
on SpacemiT K1 boards due to missing I2C driver dependency.

Background:
SpacemiT K1 boards use I2C-controlled PMICs (such as the P1 chip) to
provide SD card power supplies. When CONFIG_MMC_SDHCI_OF_K1 is enabled
but CONFIG_I2C_K1 is disabled, SD card detection and operation fails
because the regulator subsystem cannot communicate with the PMIC over
I2C.

Solution:
Following discussion in the community, this patch implements Yixun Lan's
suggested approach of making CONFIG_I2C_K1 default to enabled when
ARCH_SPACEMIT is configured, rather than adding hard dependencies
between unrelated subsystems.

This ensures SD card functionality works out-of-the-box while
maintaining proper subsystem separation and supporting theoretical
future boards that might use different PMIC interfaces.

Link: https://lore.kernel.org/all/CABdCQ=NFuW-XBK2zrw2TUFrEg0Q1Wf3_qS28zT3v-Hfud8mkew@mail.gmail.com/
---
 drivers/i2c/busses/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867a37..bfe191e50b49 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -794,6 +794,7 @@ config I2C_K1
 	tristate "SpacemiT K1 I2C adapter"
 	depends on ARCH_SPACEMIT || COMPILE_TEST
 	depends on OF
+	default ARCH_SPACEMIT
 	help
 	  This option enables support for the I2C interface on the SpacemiT K1
 	  platform.

---
base-commit: 6edd9a0d32e1ef81133b8cb5b3bb3157a44da4d1
change-id: 20260526-orangepi-sd-card-i2c-f04c89c12998

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

