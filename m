Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F10395AD5
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652855; cv=none; b=KxTP4bWfxEuQ8arYhO7Yr/IB2HDVwMa+DqIPveBMQmCU+XrpphnNF2vH29OvKO14KEgao3TXN83pKnF5JFMOoNwB83IYFhKtU7pysX4ZTg0OoVfuBiG+StIjKVmzOr4F/vG/TX3YTDP1PGMyDyPqOREEi/NdebYWDj+tiS2TO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652855; c=relaxed/simple;
	bh=V6msAI377L+ns0uHY7va0NdiO6T6hVzqRPjEuIEAZrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRm/7XghHYhE5/RoiYDBccz3tI2NVgpQutx0x4cHaOG9QCQIYfvZK4JjFoujCTQm08d72H3fKesjWohf0YWcEeTy9Ra/r6UxDwtIZ5obT+gfozBuYwuP4HVtSIUYhjjl8vJPozwUdPex3fusALGuXUViLD44FiFPK8OWG4QNmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMeNor2R; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMeNor2R"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c82a6278a4cso1014500a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778652852; x=1779257652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLABxC4pkckDVG0/IBLNPBDn3CA4Kl5z12bdryv+qA4=;
        b=BMeNor2RX4C9EPmX0QJ13DyyylQ8XGkgQgfDhtKTn5K2CIpjcEJgxb5jv8Abga+ItR
         KXwBEO9JSqFk0zHqqf4ChCoPqiKQ78KpMjroZeU/U0QLT0R5k5Rby7eKIzPuEKpVXFxK
         ALBEbr8VQTZ9/hRicjUipcm21a8hIrM1tkJKtwZuNHLt64Bug2JV90/O1Wt8RffO91+o
         KZHSXDcDmn1QDVYNrZ4m7khHMkemOZ+8dCCEYtUGxx3hY4HnShRY8AOrrCDhZ7iWgkUP
         9zqqDMRQkxU1UKhUMc4SskRjeuQ/zkHZpdA73cCczWxAL328g+T5ypp2qfWLbrhwzE6a
         URBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778652852; x=1779257652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLABxC4pkckDVG0/IBLNPBDn3CA4Kl5z12bdryv+qA4=;
        b=CcQD4zCAX3ZzylqPaJ6+DmHhthGO5ZYJ7dBANJVkGPMIAoikEGvP5WBFr/DRQwk8pC
         hCfOZ6vR++1SV0gQAbpUNlHLmtYghyFHAa535bwrrAk1W+trhF6m4WbFwl/T83R7JWYv
         jrcfTyu8ZrjceT3P89TQDNEdfoH0q2RNHbRV2Sx40NPI8LkVVfIb6229VrlTfmcRn+CX
         VQLwICfFmGhFfKbVEK8nGc2of5MVdPcPQObvszKCWQb/ZrvZrLwWDS8HTJgyIUDJvUFT
         5TepduKNvaAOpEYChjpNY7urixM7Axgng3x6QqpHsbQEVIXoVKd7V+9q1MyR+KE7p01S
         ZDMg==
X-Forwarded-Encrypted: i=1; AFNElJ8pLejKJMZCbzC/i6uRPLa6pPIZhiEduh35n3RLCnVu1CjlhDLAtI5uZ38kRei0bqkdf24NfBbFWGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUF6LZQlK+bMEDluPal/ACH7qFn6i2eWLkMnwzKUn+1UHgHYc
	AU43bE1ktGfzozalYByPKgkGdzJyjv8uJWTfu2VbB2Yj0wfkNEGKFfRi8KbUYEse
X-Gm-Gg: Acq92OGUaJe++QMK34Lm6bSY6X1dQnRidDZ3rKrTN7epVlDTGjHGuJYecK+kg989o2B
	a4Rajy/Y2ODAb3WyPDN3+98SSfW+2g5VxQidLEk/uKuQUq0B8K9Qf9J/q9Fauggsc0feVasSvlN
	NRWvwxOXotW6O0cWWKkIDxqjS8r0jnboaSB/aVLVS9LC+tYsVJSrVUurdSEU3b4mptJv6SHB9dO
	FnmQoaLGR+UoVVhVSBpYuxZhBsLSIwgNzJKZOczzV60LxaGtQK+yg2CC8vNBs76aR8oHd0a5OTM
	q/ctT/QwU5y5OcA6YZpWEHqVh5+jk8HU8VKKR/7XqIeTwaKl6gNPzRtjsiFzibw5CU5jX24QK34
	LhNezPvjLXYWrp8o1xLVm9QynsV/LZwGMqBfzLQokAl8o8Hf1t2qREiKL91D5Jwjp5+8hpWnPdL
	EmElU6PBlVTHpiwztoo1TUl4buAdMDr1JlCBqTTJF94ZAoxGt2B0vYwnvW12RAkk+ahJI/07Iau
	vViOnZ91AQGldXvAjJRjlxzG6K/wpeZLS06UeYvCgoqDxAo1G7WajTWmGvVOTtL
X-Received: by 2002:a05:6a21:6d94:b0:3af:53f3:6ddb with SMTP id adf61e73a8af0-3afb002b243mr1610431637.47.1778652852266;
        Tue, 12 May 2026 23:14:12 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c64:ff18:3fa8:7855:804e:9f49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771a8a1sm13470874a12.24.2026.05.12.23.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:14:11 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linus.walleij@linaro.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH v2 0/2] Fix WACF2200 touchscreen on Lenovo Yoga 7 14AGP11
Date: Wed, 13 May 2026 11:43:36 +0530
Message-ID: <20260513061338.9348-1-hardikprakash.official@gmail.com>
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
   completes. A DMI-matched deferral is added to correctly enforce
   ordering using device_is_bound() under device_lock().

Patch 1 adds a DMI quirk in pinctrl-amd to restore GPIO 157 interrupt
bits after amd_gpio_irq_init().

Patch 2 adds a probe deferral in i2c-designware-platdrv that correctly
waits for pinctrl-amd to fully complete before AMDI0010:02 is probed,
using acpi_dev_get_first_match_dev() and acpi_get_first_physical_node()
for robust device lookup.

Both patches tested on Lenovo Yoga 7 14AGP11 (83TD), Fedora 44, kernel
7.1.0-rc2+. Touch and stylus fully functional across 4 stable reboots.

v2:
 - Patch 2: replace custom HID/UID lookup helpers with
   acpi_dev_get_first_match_dev() (Andy Shevchenko)
 - Patch 2: use acpi_get_first_physical_node() to get the platform
   device for correct device_is_bound() check
 - Patch 2: use device_is_bound() under device_lock() with explanatory
   comments (Andy Shevchenko)
 - Patch 2: fix dev_warn to use dev_name() instead of hardcoded suffix
   (Andy Shevchenko)
 - Patch 2: fix commit message (removed incorrect "existing" reference)
 - Both patches: add Assisted-by tags per coding-assistants.rst
 - Patch 1: no functional changes (Acked-by: Andy Shevchenko)

Kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221494
Related: https://bugzilla.kernel.org/show_bug.cgi?id=221454


 drivers/i2c/busses/i2c-designware-platdrv.c | 75 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-amd.c               | 35 ++++++++++
 2 files changed, 110 insertions(+)

-- 
2.54.0

