Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14533FBB45
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861759; cv=none; b=XFZvlBZGNzPMKEGqcG5TX7fKlQNMQgP0qCi25KUMkIXHe5LV+SivWaX3PpiFrxaGM3+xB7Iwr/DsoS6dlonJNm18wSIEhziWYV3O8P41vE8cxyd3rJHghy/xRHxwH+xpprLYkBY5UoZ3hh2Aa1Gu2hfdS8c/Uq4r48crDGCbEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861759; c=relaxed/simple;
	bh=qSZuFzawdmmgI0kkp8axChRwnn8vKGfKmospa+AK43U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jba/pLhfvfQB3Cs2KcF9s+NQ9XCDD60SYIhGG8gP/CepIPjey0ofn23Q6+28oUMCG7HNFwVyCRGLKf1nta/bjV6lhOCAz8pMd2WGDeMSGOCcvoj/y6SM5Nq8Q5M6Gh05qZ3zsHmqmFN+ayQC3ng2znYLt9DD5QMfBT1GKcN5x74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fin0sNQn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fin0sNQn"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c80170db7d6so3859018a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861757; x=1779466557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQRqiVHWya/5y61dQcIpX563d/hPABwmTEr+JCzBtB8=;
        b=Fin0sNQnp4YoQvUENVyHSmRHWKX0+dsd08QGUzTEeNySl2QQYISkCFSrMn2VV9jY29
         Ytr2t2mV8qsZ5mBXf00IgN9XXsHlbC+AVJnYkPXvl7MinPhB42z18OF7XOXG92eQghqE
         fJNY9HI477Mou1enAe+52ZKO7JXn2LG0jksUEo6sdDNlAkVH2+XSn7byXibtqr33Ug3D
         Oon9bEohS2U2t9IRKrXf11QSDJffp5NY6YssyWwILau6uT2oWO+D2T9xWZu3hNY9bIXo
         Weoy+qPiTWiVL3XV5+1+UtqbG3DFmfhGcc/rlThM2oOeYE/rpTgR98dkI82hmn85O5g9
         tlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861757; x=1779466557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQRqiVHWya/5y61dQcIpX563d/hPABwmTEr+JCzBtB8=;
        b=MWttmGRtzbPzeXm7bfi/ZnoFsngcNUXRDcUiCnLVjY1yuFc4ZEq4yhAM2TeOSUwp7K
         W6pSv8YFYYBKCSYDEIafGmLm4IsDSvGvUsyLRA6QJBYimqmS2iAqdtZOiz0lxh9BNU0o
         tiXM9c9zA9O6NRthps2t2YMJQM+jzPf3kdq4WuEei+dWh3fF+CFDR7vCwVxeRAgLD8Hq
         5O7Y1GIlIgJYIdXVGgOGLm7CZCGjBQw14/8NvQKOmqeGwoctt78O8uu8VS55ioYsvmdU
         Fj3SV/alRGLiFEjl3lmkO6cNPTNtXy85gq3U7VVl9vgcsIgKARNsjIHkYbqKhsC3wUz6
         yX4A==
X-Gm-Message-State: AOJu0YyPFjlTVRDRfCdz5Lmth8O65jWur9VFqZSj1Lverh0Qs9QVafLq
	21dbn4JV0Pj63YD2XIj4NLgMWrF8hcNCdESqLq90sgWzYa3xBwd9CL2RolT57RAu
X-Gm-Gg: Acq92OFlQjiXGERFpNVfimcGrAXnuCsGpx/4DhzEHnQzdxiF96/lasqR+DC444wi/4a
	05IngW5nFgKMyLTlJ/Ze22nb5KUR+SlAaG3+b35nbIVWe3SOTLb15IVaPKBVFCMKnXv1x3FaO8T
	8Cywo4eV/tiNCtxPsKHIz/3hX0NwToJkcVexr8aS+nlTBX/Xt23WfBydx2aZhDou6SiH+GY4M++
	6p7qN+pC1WuVCUu/SeLV40xA34rjwEVX7MFhMHE6xrx8Kosfd97fBv4bvyPjvmOve5ZB3PKhEcq
	68UisnOLgr54QmSamAd/vkaevapspYs0KmdqcUa+B303dykrBhPwB8FbxOu7QbFZza1ZMCufqLL
	L4bOCNeu6FUJqDDwcKw1l4myDoQheRhV4Uszfh/c8MaLXw25lbNJHgUEMdU1t7T+HL3yGUKqGc9
	T6zLmAA50Tz1wZ3te+vYl2lb/d+0evX4b0ihiz2slqwp7U8AYRhY6aUpHMQxktVKydeIlaxE5p8
	PdI8DYM2IcLF8Nb+ZC5wTk5Tic/BjyP7nlMdjnr9dlgW8mKkVM+dMBrlqEWUEBY
X-Received: by 2002:a05:6a20:7fa0:b0:398:9e47:f5ff with SMTP id adf61e73a8af0-3b22e67bbb4mr5826867637.2.1778861756709;
        Fri, 15 May 2026 09:15:56 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c64:ff18:3fa8:7855:804e:9f49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062a2bsm7699036a12.7.2026.05.15.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:15:56 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	mario.limonciello@amd.com,
	brgl@bgdev.pl,
	basavaraj.natikar@amd.com,
	linus.walleij@linaro.org,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH v3 0/1] i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7 14AGP11
Date: Fri, 15 May 2026 21:45:15 +0530
Message-ID: <20260515161516.10474-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Wacom WACF2200 touchscreen on the Lenovo Yoga 7 14AGP11 (83TD) is
non-functional on Linux due to two bugs. Patch 1 (pinctrl-amd GPIO IRQ
fix) has already been taken into Linus Walleij's tree. This v3 resend
covers patch 2 only, addressing Andy Shevchenko's formatting feedback.

Root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd's
probe completes, so GPIO 157 (WACF2200 GpioInt per ACPI _CRS) has its
interrupt bits cleared when the first I2C transaction is attempted,
causing lost arbitration errors. The udev rebind workaround (which
works because pinctrl-amd has finished by userspace time) confirms
probe ordering as the root cause.

Note: the dual-master hypothesis raised by Mario Limonciello was
investigated. TPNL's _DSM (UUID 3cdff6f7-4267-4555-ad05-b30a3d8938de)
is a pure query method returning a constant HID descriptor address with
no side effects, making firmware acting as secondary I2C master unlikely
on this hardware. Awaiting Mario and Bart's technical verdict before
any further approach changes.

v3:
 - Patch 2 only (patch 1 already in Linus Walleij's tree)
 - Fix variable declaration style in dw_i2c_needs_amd_gpio_dep (Andy Shevchenko)
 - Add BugLink tag (Andy Shevchenko)
 - Add -v3 subject versioning (Andy Shevchenko)
 - CC AMD engineers (Andy Shevchenko)

v2:
 - Replace custom HID/UID lookup with acpi_dev_get_first_match_dev() (Andy Shevchenko)
 - Use acpi_get_first_physical_node() for platform device lookup
 - Use device_is_bound() under device_lock() with explanatory comments
 - Fix dev_warn to use dev_name() instead of hardcoded suffix
 - Fix commit message (removed incorrect "existing" reference)
 - Add Assisted-by tags per coding-assistants.rst

Kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221494
Related: https://bugzilla.kernel.org/show_bug.cgi?id=221454

Hardik Prakash (1):
  i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7
    14AGP11

 drivers/i2c/busses/i2c-designware-platdrv.c | 77 +++++++++++++++++++++
 1 file changed, 77 insertions(+)
