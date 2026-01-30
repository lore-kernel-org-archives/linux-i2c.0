Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578C3446B3;
	Fri, 30 Jan 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788365; cv=none; b=dHcqjt94dCpQRETkSIJYGZr4K7ojHhYbMg/MLqDpcpS1jiNtULoVeJJ2TaUmDvf1/QzF1CwOcxSuaRQ9v2obbVwe79Lftm+vkp3Jk9CAxyG05CVpRuxQgbf50AYjUBOoOPN+XUyLDmnJ0KaG3ZuLpEnf6gzAE6R6M/Pn75DUi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788365; c=relaxed/simple;
	bh=KwNWowZX71q9zD/3NDCuLVTQ0pyHgr7T6t8lFk7Fb4U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aKsRu/y4HevFg7QEa/3whUCkpvClpaC0m9kB1SMHqVr/F3Q/2ZFbFJ6Oi63MYM4Em3Uqcbyj7ykuvy4wMj4Y6i6B8B35+jme6yBnYX563X1feF1kMgG0hEGMs2BZRd/I7yl2jOS4e+kYd5iU/kMluWdNbRHJZrywXSm0XSbMHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vCoaaIHD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vCoaaIHD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 42B924E42355;
	Fri, 30 Jan 2026 15:52:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D58D6075A;
	Fri, 30 Jan 2026 15:52:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25F0C119A885C;
	Fri, 30 Jan 2026 16:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769788359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kwJQO2x048sND1CuqmEehCo/evSBl9i8ehkPITSgcpg=;
	b=vCoaaIHDovck1QgJ9hkbfAR6jfgnuPXZIAUvFREoZEj3QEZoBvHsbeO7bJZIJnjYer6X9+
	Id+BVQD6WjPI6JENNtUy9fOiFX/tH/B+iMvNeBByYk1WGk1Sczer8mmHNzkweln3aQ8FxM
	wVRp7no5OOmfWYKsYi4pZ0tIj2Jz3BIvCMvMfLAVvTgNMZ2W7qOBVml8pupN5fOjMbNI1s
	PAPeREiF3h5E1XVaKG5+XjiaYr8zkaF18TJfI0fGFWXGrPDtcrKBM+shIvRSApvxQk2IHD
	sFaaMpOlFrJbQ1Z3oukS3dF8hLWjpGy0MaUXiyJxq70n4Qu2TqZUoCVvNuA5ZA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH v6 0/3] i2c: designware: Improve support of multi-messages
 transfer
Date: Fri, 30 Jan 2026 16:52:28 +0100
Message-Id: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALzTfGkC/2XNwU7EIBDG8VfZcBbDDAxQT76H8QADdUm0mHZTN
 Zu+u3ST1o09fhN+f65iymPJk3g6XcWY5zKVOrRhH06Cz2F4y7KktgUqJFBgZEGW6UumoIF6Rx4
 7K9rjzzH35fsWenlt+1ymSx1/bt0Z1uuWcFtiBqmki56iA3bBu+dY6+W9DI9cP8QamfEOatghN
 tgpA9Y70zOrI9R/EKDboW4wsomMATkGPkJzB9Hu0KxQWTLU+eyYjpA2aBWg2iE1qLI2yabOEP3
 7cVmWX2mezwCCAQAA
X-Change-ID: 20251014-i2c-dw-da315f758296
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

Add support for the I2C_M_STOP flag to the .xfer() function of
the designware driver. This allows grouping multiple accesses in a
single call and changing the target address after a STOP flag. This is
achieved by splitting i2c_dw_xfer_common() in two functions. The core
logic handling the transaction is now in __i2c_dw_xfer_one_part(),
while i2c_dw_xfer_common() loops over the messages to search for the
I2C_M_STOP flag and calls __i2c_dw_xfer_one_part().

Handle controllers that lack the ability to emit a RESTART when two
consecutive messages have the same address and direction by aborting
transfers that contain such a sequence of messages. For those controllers,
we also check that we do not get any unwanted STOP caused by a Tx FIFO
underrun, as they lack the ability to hold the clock during a transaction.
And we set the irq as non-threaded to prevent underrun on PREEMPT-RT
kernel when filling the FIFO.

The I2C controllers found in the EyeQ6Lplus and EyeQ7H SoCs from Mobileye
lack such capability, so a compatible string is added because this cannot
be detected at runtime. The corresponding DT bindings has already been
merged and is available in v6.19-rc2:

    d9b85d296f3a ("dt-bindings: i2c: dw: Add Mobileye I2C controllers")

This patch series also simplifies runtime PM handling in
i2c_dw_xfer_common() and amd_i2c_dw_xfer_quirk() with PM_RUNTIME_* macros.

To test I2C_M_STOP and other message modifier flags, I posted a patch
series for i2c-tools[1]. With it, i2cdetect shows the support of the
protocol mangling and repeated start skipping functionalities, and
i2ctransfer can set the modifier flags to the I2C messages.

The series is now based on i2c-host tree and only contains the last three
patches that have not been merged yet. The first and last patches are
functionally identical to the one posted in the previous revision. Only
the second patch contains modified code to use PM_RUNTIME_* macros
instead of ACQUIRE()/ACQUIRE_ERR(). Thus I let Mika's Acked-by on the
first and third patch, and dropped it from the second patch. I hope it
was the correct thing to do.

[1]: https://lore.kernel.org/all/20260127-msg-flags-v3-0-e7539945db2b@bootlin.com/

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Changes in v6:
- Rebased on i2c-host tree.
- Drop the first three cleanup patches of the series: already merged in
  i2c-host tree.
- Add/improve comments suggested by the last reviews.
- Use PM_RUNTIME_* macros instead of ACQUIRE()/ACQUIRE_ERR().
- Link to v5: https://lore.kernel.org/r/20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com

Changes in v5:
- Rebased on v6.19-rc6 and fully retested on EyeQ6Lplus.
- Drop dt-binding patch: already merged upstream in v6.19-rc2.
- From Andi Shyti's review:
  - __i2c_dw_xfer_one_part() now returns 0 on success instead
    of the number of messages transferred.
  - Drop inline keyword from i2c_dw_msg_is_valid() declaration.
- Link to v4: https://lore.kernel.org/r/20251126-i2c-dw-v4-0-b0654598e7c5@bootlin.com

Changes in v4:
- Use a boolean property instead of a flag for handling controllers
  IC_EMPTYFIFO_HOLD_MASTER_EN.
- Reorder the patches so goto and runtime PM auto-cleanup are not mixed
  in i2c_dw_xfer().
- Drop goto in __i2c_dw_xfer_one_part() and use return.
- Tidy up comments for i2c_dw_msg_is_valid() and irq_flags.
- Link to v3: https://lore.kernel.org/r/20251119-i2c-dw-v3-0-bc4bc2a2cbac@bootlin.com

Changes in v3:
- Add a compatible entry for Mobileye EyeQ7H i2c controllers.
- Use runtime PM macro for auto-cleanup in i2c_dw_xfer().
- Add a dedicated i2c_algorithm for AMD NAVI controllers.
- Rename __i2c_dw_xfer_unlocked() as it is not about locking at all.
- Rework the validity check of i2c_msg.
- Flag the irq as non-threaded for controllers that cannot hold the
  clock to avoid underrun.
- Link to v2: https://lore.kernel.org/r/20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com

Changes in v2:
- Add a single compatible for mobileye i2c controllers based in
  DesignWare IP.
- Handle the I2C_M_STOP flag instead of emitting a STOP on target address
  change.
- Abort transfer when it requires a RESTART on controller that cannot
  emit them.
- Detect FIFO underrun instead of disabling threaded interrupt on
  PREEMPT_RT kernel.
- Sort the compatible entries in a separate patch.
- Add a cleanup patch on flag reading in i2c_dw_read().
- Link to v1: https://lore.kernel.org/r/20251017-i2c-dw-v1-0-7b85b71c7a87@bootlin.com

---
Benoît Monin (3):
      i2c: designware: Implement I2C_M_STOP support
      i2c: designware: Use runtime PM macro for auto-cleanup
      i2c: designware: Support of controller with IC_EMPTYFIFO_HOLD_MASTER disabled

 drivers/i2c/busses/i2c-designware-common.c  |  20 ++++
 drivers/i2c/busses/i2c-designware-core.h    |   3 +
 drivers/i2c/busses/i2c-designware-master.c  | 162 ++++++++++++++++++++--------
 drivers/i2c/busses/i2c-designware-platdrv.c |   1 +
 4 files changed, 141 insertions(+), 45 deletions(-)
---
base-commit: 51e8ce3630878fa6083e1eec84f58f49ec85089b
change-id: 20251014-i2c-dw-da315f758296

Best regards,
-- 
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

