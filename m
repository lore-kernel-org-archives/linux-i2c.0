Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD473148A7
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571149; cv=none; b=XS3kdN+UWonTHl0fYumhLGlz/rTDFYMmEFVtxjwWMmRn5zPdA8Rj2DazrIjrUpxGhkxTM+vRNPMp4B5qSmYlrzEhfbyccECV7e78EvE4olNfs0jIJ0vAmKtpt8AMFIs3VFoaIigVAlSah/AvcAhPfHSjog9zdtrC0vKV/o6XxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571149; c=relaxed/simple;
	bh=GTUlPVx0YMPbfLUzBxXLhjPR/mqY9lD53Qc8zk3/i4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhtikpmDulkgxFuOBvcW1n7YT3r26PXL2ejJT9eBaZsJUgwwxyQvkDXToKUnbMbRxrkBAQuMf/WLF0mXAQz0kU4QwNvfzsxZJpdUw/ReqkGtn6JGUlW3BU6yHMJUHzjMZKt5G9rY6d3UXCVv5Ke5Sem1W0qt4GoI2paLjoXGKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rf1gJy6j; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rf1gJy6j"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-366375c43c2so2954595a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571147; x=1779175947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9/d2mQMSHOXQXBgiHyinooMXc2bmST//VHdITCznnc=;
        b=rf1gJy6jEY2cxpt57+pHrqH7+cUSs2c5Bc9EP1Ce2aTUnq2T4CjIVEBwHIGZlf3Yko
         5sKXicnKqFueK7KOjSN5ULjq4wpO5Uu/IHG6wDtjMjx3HtZrrOY1IJ1+m8T7ShnbO8mQ
         d9VE5qeMCyILQp2b0Ju4Tmb8d4f95agN84vvme1q/y8znbNE+KLhyq3tY0dES+7Qo766
         7UNS7ph5aDnHE76M42HjFb1aYgwOcG+lhUVNPDlCXCX6gM8WAjxwJkcJZZ0F/hC3Jjit
         +FpXao7+L/kFMRnGEiNLgHyNkguVoaLH0n0o2xF03bj+iIEBJhnxHBdVuCErB1x45QTs
         P1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571147; x=1779175947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9/d2mQMSHOXQXBgiHyinooMXc2bmST//VHdITCznnc=;
        b=OiItij2XelYcCPsJnrT74kRcSMHRNOawycr/9VIw6Xzxdk8ZnnDvpoFCf2sahxaJKU
         OvmS0ZsSNu16LeFwZ2dEZmPV3XzDnE+JU5CtgFn/FfJZJwGCIfhPgCvWD0kA1ms1pnBo
         ZMTf2YE3lh7nEU3tsNytp4MhHF2gv3ZGEHCWj3mlU+SIeut8qZSKFsojuECwMiFST+LA
         p2fRyTRujRwamyex0HWjOYNmdvpk+s+Z6ixSB1EybHW8RGzScbAKi2hJJqkmm7fCld0/
         eHLx+ETOYs0m1MbsIV7BP8SkQJxDxWFv2DjmqJ/vlGWVJwhNqJLA495VIue7RGINiFJG
         Kwcw==
X-Forwarded-Encrypted: i=1; AFNElJ89zSHOtyLzcy+3m4+Omz2ywBhE1lzIIqb3G7CrAj3EXzy0twYdP9FLX4zOqaGikC3dv9rE5zoS8zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBWMXIYHbsGrkGeLaCGYtsBskYggOeg9LjAg7qhUZgqhMciiK
	ngKjD3YN6vDCbiijdVqWmf9jyKXoJ4OvEHIRfxBRCOhwSdKsjqNxNSPonIUcbIAOPd0=
X-Gm-Gg: Acq92OEC4noqJ1D7J4qSjS1M5Juoo6rOd5WxkvEDcODMSOcOEZXhnYQ+23JScFoCSWX
	w1dHU/HR+c53o+kS2mrfNWnbC4AFJMQm7avTbEzwhd33ljFV/Rj4cQMa7f9hu2otHd1Iii2BKjK
	MUyNvXthWfr84f+CvqkS1tR+7po2BXDH7wnXysYuJWUSX/QFEkwgBTs4+SzmHzLYOzwdWVVrtqn
	mPSrI04oCDFYKd7jQ5nanK3vGYsi4NdNhAAX24P6NQD8Zymp0jWeq9wMMw2a2c0njuFAujDTko0
	Dce2C9GOvELrXGPKMs6xeuTOSRwnDW2Yazn/OpJy0qLyKSRFSrzzokZVYmRyLvOkXI4r2SCE50x
	p8iQsLhYsjkYEMC4ARmfFcEebiHj7zT/dL2VXukOuGm9l6UUqvVWzJgef5M9ProG0FiOpB0WQKY
	+81hJUgbLhUjl22+rDkeN1CWKdZdCHySRJ4Kp3CgTwWqSKKCObQ/U3e7NSDCN8kz7Yg0OvZrGk6
	pepOAIxTobp9Hx965d1fonrZoF9mWgM1qWjfc44e1Pz4J5a4owD8zw8N0VxhY4=
X-Received: by 2002:a17:90a:2c86:b0:368:2289:42cc with SMTP id 98e67ed59e1d1-3682289a92dmr6128980a91.24.1778571147028;
        Tue, 12 May 2026 00:32:27 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c23:32d:3989:a15e:2491:59ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d63bad27sm12420410a91.10.2026.05.12.00.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:32:26 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linus.walleij@linaro.org,
	wsa@kernel.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH 0/2] Fix WACF2200 touchscreen on Lenovo Yoga 7 14AGP11
Date: Tue, 12 May 2026 13:01:37 +0530
Message-ID: <20260512073139.16343-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Wacom WACF2200 touchscreen on the Lenovo Yoga 7 14AGP11 (83TD) is
completely non-functional on Linux. The I2C bus (AMDI0010:02) fails with
repeated lost arbitration errors at boot before any driver can probe the
device. The touchscreen works correctly in UEFI and Windows.

Investigation using ACPI _CRS decode and Windows/Linux GPIO register
comparison identified two bugs:

1. GPIO 157 (WACF2200 GpioInt per ACPI _CRS) has INTERRUPT_ENABLE and
   INTERRUPT_MASK cleared by amd_gpio_irq_init() and never restored,
   preventing the device from signalling the driver. Windows keeps both
   bits set after initialisation.

2. i2c_designware probes AMDI0010:02 before pinctrl-amd's probe
   completes. The existing dw_i2c_amd_gpio_defer_dmi quirk for this
   hardware checks gpio_dev->driver which is set before probe finishes,
   so the deferral does not actually enforce ordering.

Patch 1 adds a DMI quirk in pinctrl-amd to restore GPIO 157 interrupt
bits after amd_gpio_irq_init().

Patch 2 fixes the existing broken deferral in i2c-designware-platdrv to
use device_is_bound() under device_lock(), which correctly waits for
pinctrl-amd probe to complete before AMDI0010:02 is probed.

Both patches tested on Lenovo Yoga 7 14AGP11 (83TD), Fedora 44, kernel
7.1.0-rc2+. Touch and stylus fully functional after applying both patches.

Kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221494
Related: https://bugzilla.kernel.org/show_bug.cgi?id=221454

Hardik Prakash (2):
  pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7
    14AGP11
  i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7
    14AGP11

 drivers/i2c/busses/i2c-designware-platdrv.c | 81 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-amd.c               | 35 +++++++++
 2 files changed, 116 insertions(+)

-- 
2.54.0
