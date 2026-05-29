Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6106348C64
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049342; cv=none; b=AyM1ewiOxzQ1j5sPjOpRbQCpRoIkrVdG/Jl1OCaddDd4kYsENm3dGb7ZJdfB0N7mC7MfS+G/j/dRX+gv3qB2EjqMyaJpAfHb6q2q8Dvxm6sJNrr7MG7SwgtCYUg98JC45ohGHULLLY+yya6AounZLnOfoFNvnPwkwgF3H5ebBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049342; c=relaxed/simple;
	bh=Yz4wKUO7mRoNaZIugtu9UsGT2PX6SXaZekLqVb3l5ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YaNyr69umTHLkh+cRtDFWX6K2DyfOh1rh0mf+27GQQoNeRs2ygrWKkHO7GnGl4WRxflOwOn/7CXGvZETgHKJx+BedBSsnXTYJNEDRXpfaaPXaDm6ek2PI7cRS9f1UXiL/nub5ENL2nQ+ZoxFWTukF3TfNTous1lLXJZz1FAA+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4calMsD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4calMsD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so143045945ad.3
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049341; x=1780654141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8hXh27TAg8GvayKzSm4qP6Yj601eapfE8Ty44/peic=;
        b=W4calMsDFc7B+ziecRpLGRxJHvowzifbv+xIemf4X+TyFCJZi/MXTXs1HJwfRm465A
         QXKEc4AZCygkXppVPv4ArC9Gqs9asnKCpxLzIh7kARf0c9vZEhrzB59Fbb6ZYPusaX5d
         4Ln5LZ5icHuvyWsEH/O4YXR7dOsf7Ya++WM9r88ZhpfvdUfFWTdCseH/37kF7ZAyR46K
         DPq1Mj5+BcBuG5V5UE1k2uw92KFX+HJvxHJgnTzyBVcMItizmrFvQx5EUOe0ZXJZ9fM3
         hak/Qq0+10jpSgo+lGNhCk1e42XU0ZyNTdhhJfgi37FiWdkxpaSY58sBebLpbq0nYjDZ
         X7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049341; x=1780654141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8hXh27TAg8GvayKzSm4qP6Yj601eapfE8Ty44/peic=;
        b=fvhnP0HL7f8gTRxL1mQNsRdfZevQ8WIC8kcttsF3eOUCRHPelzY3bq53i6hIZWq85f
         3BlZpE0rVoMR+5IyU1Hcci+WHtwxkOVT+eghwTKcqunhw1/zCJFzGOldXavgxA8zLhTU
         MSIxPK68ikzasl8fQl6HiU6P510Lhm6tP+Cz9wgaNuzfJK9pmpnJT/0/aASuvKE3+je9
         WSip6aPyN1Kb6nJIY2Y+jOTqSoYJdXxbSgDgGKDsb32rhFOm5wkt5jg0mKz0pW1dni24
         KSsmZ/ByPCrajC1fknPtvy013q9ij2GLIjgvHGEkhtnrJJZ3HSu2Af4afeLEyEn38usX
         GTYA==
X-Gm-Message-State: AOJu0Yym3NwSZ3ycSsaKgLzxSRNiOKZuSqCn1k3W2AeHR3vIXe9L9m9/
	5CINsL8ZR1nCwPHmmAvtpiv7Fmg7Z4AG1ehpLAGRCWDq+pSAbNoAgwmVIFdXkp5c
X-Gm-Gg: Acq92OFVX61BApNDrLgCaYVl2EGUoVtk8nXYAkoawrYuwwzXJoN0vARK8nGabEnU0UC
	TCvpxyroqLbiT+V2wy4o92C0oYAmNA9491EExILowmcpgyDUGzMHUj5DLo6N3dZucuQ9wLqQz3G
	8jdwwPrXHap41cVt8k0tuYGiveky4njs9gtnkVdR6E7VebBLT3qRfybY1YvUafgIPYIAaitgZQ6
	T9pZGgQvQfKdxeq0vX7khnciiCr43CXfJ6Bc5TRiy0/b9lEvI3b7Y059cIGgNAlIhvPtrqvQkfv
	xeBZ+yg5GWodHqxdaGL/0/aUplB6aISoJ2D9Kh6KdJ7IX4GaJMS18xK345ePQ4suEf2LG6jiVNt
	rnYsGf2Nz26S3ZTru+cAkx5Ef9BgJw7eQPvr2zR5FO9cHH1tKW26a5gbhxML0VUIA0uhFe/w06h
	W2eap+1V6YaRRjQ5n5MjAZA1HcK626qCCgdANBwfgy1hLjREtxJ2yqxb9KF43L7IhbCBCLnMFS9
	UC0X4ezBgnRPRRPcl0036K+GVRitwmY3nxv+4o4G6y/6IOTOi8j+lVVfAX/aJGwK5YrsrZXp5nR
	Tx75kmGfq3nxywCmKMPKRuo=
X-Received: by 2002:a17:902:ce87:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2bf281f1c27mr12163095ad.24.1780049340822;
        Fri, 29 May 2026 03:09:00 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c22:2195:3f68:8568:1e68:2087])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b0122asm16051225ad.46.2026.05.29.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:09:00 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	mario.limonciello@amd.com,
	brgl@bgdev.pl,
	basavaraj.natikar@amd.com,
	linusw@kernel.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH v8 0/2] i2c: designware: fix WACF2200 touchscreen probe ordering
Date: Fri, 29 May 2026 15:38:35 +0530
Message-ID: <20260529100838.8896-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes the non-functional WACF2200 touchscreen on Lenovo
Yoga 7 14AGP11 by:

1. Reverting the earlier DMI-specific GPIO IRQ quirk (patch 1 of the
   original series, already in Torvalds' tree) which is no longer
   needed.

2. Adding a generic probe deferral in i2c-designware that walks ACPI
   child devices, finds GpioInt resources, and defers probe until the
   referenced GPIO controllers are fully bound.

Testing confirms patch 2 alone is sufficient — the existing
amd_gpio_irq_enable() flow works correctly once probe ordering is
fixed, making the manual IRQ restoration in the reverted patch
unnecessary.

The probe ordering race was confirmed via dynamic debug tracing:

  0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
  0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
  0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
  2.348157  lost arbitration

Tested on Lenovo Yoga 7 14AGP11 (83TD), Fedora 44, kernel 7.1.0-rc5+.

v8:
 - Add revert of now-unnecessary patch 1 (Mario Limonciello)
 - Collect Acked-by (Bartosz Golaszewski) and Reviewed-by (Mario Limonciello)

v7:
 - Fix unused 'ret' variable in check_child_gpioint() (kernel test robot)
 - Replace BugLink: with Link: (Bartosz Golaszewski)
 - Add Reported-by and Closes tags for kernel test robot warning

v6:
 - Replace DMI-specific deferral with generic GpioInt dependency check
   walking ACPI child devices (suggested by Mario Limonciello)

v5:
 - Add blank line before #include <linux/acpi.h> (Bartosz Golaszewski)
 - Use scoped_guard(device, gpio_dev) (Bartosz Golaszewski)

v4:
 - Rebase onto Linus Walleij's tree
 - Use --base so series is correctly 1/1 (Andy Shevchenko)

v3:
 - Fix variable declaration style (Andy Shevchenko)
 - Add BugLink tag (Andy Shevchenko)
 - CC AMD engineers (Andy Shevchenko)

v2:
 - Replace custom HID/UID lookup with acpi_dev_get_first_match_dev()
 - Use device_is_bound() under device_lock() with explanatory comments
 - Add Assisted-by tags per coding-assistants.rst

Kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221494
Related: https://bugzilla.kernel.org/show_bug.cgi?id=221454

Hardik Prakash (2):
  Revert "pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo
    Yoga 7 14AGP11"
  i2c: designware: defer probe if child GpioInt controllers are not
    bound

 drivers/i2c/busses/i2c-designware-platdrv.c | 156 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-amd.c               |  35 -----
 2 files changed, 156 insertions(+), 35 deletions(-)

base-commit: 8fde5d1d47f6
