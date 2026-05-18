Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69168409DF8
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107316; cv=none; b=BuRMSMPjL6Hjg6y6RcrKirNnqT0+jISah5cp8msqnb55OyFjelnLFGe47dquURIt7J4Gb/s6QbN9jsfzcc7f7XldGSWyne3hB7A9A4nku7obtmgmOld+EMmsvBd7zHrhHlR/6xHWR8cAY7eId0tc+SLxJc6n/OYJ+cewz1JPVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107316; c=relaxed/simple;
	bh=1ybKlwammGmDtK2LUbGag/NDL4ZS2QmVDl8lR6xNa+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KjCPU0Q5sXU1/t1lMCjDcwfnD5Rfjw6MvdoTlJq3EJL1Id3B4tRxpFEp6ObFqLe6MUmsp9f4vuOPuCZfl4BBu9bYxCQCdggkF3V34g19At6EekD2pQF5I5guTE4y+h8CfWCnvlNRjBy9lNfQ5A8kULnRhw6L+xhkc3gitB/Rmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avxt0YVb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avxt0YVb"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c7980c060cfso876243a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107314; x=1779712114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/qCgc+4mUjMLRI/598MkfZu+KxmtkC92/pg9a3hb/M=;
        b=avxt0YVblNa045y12DGDTHmLCjawAOWaPhTGyBPsmHdGuScq6uQIbjE54X5uqFQp7L
         RpSXvKSdJVTmutNfzf05KhXvdGBDisYclHHzoCzWrZrDJTA1SZBss93wZtBNCwvdF9gw
         dwwNh87SlVxRB/cD459Ncn+EgxVrtdzNVfWpRGZdJj6kWcpVWvcBwCrcP/PQ6pvoOkKg
         fI0uKZoH0gRrUBBehKLLObjMfEuSVTNeiZynvLx2+3XY5K+0wENWD6t584BS6/dictrY
         zJ43t0npIzNC3izD8m+GDoXSlenbkbdsKY5q1mZ4fivS9fqlIFLgILCmcyHcQWh3phB6
         NI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107314; x=1779712114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/qCgc+4mUjMLRI/598MkfZu+KxmtkC92/pg9a3hb/M=;
        b=PVKgPznyH4lyewwQfMJxA44/H7VcD+S0W7MWoNjgQhV5uYWJxBCZeI4l4trevssgsG
         vPe+1t38ke6d1ZSZyHIISJ57//u/kI/0kgVH9NLLob6Edf7YGlEWfK5PNnVBHMyDg2bk
         oh84vO2MDvF6JEszjbCXrOPbq4d5Ux+QeuT7vWRL6d0Xx7oG3tCjLonbkMnn1rEXUCNX
         5g2qjkQN7Gb6CKPSsRA3SgEUuhAdoa/FMT5qQlwWHEoLHPHYQQnEXb27Xw4vSa8xnn39
         Lo6hrOMq5a3L/2OeY05ynNrVa51mID0WDZSS90tSdqYJU+5LMk1APpzozkvodNa3o6wt
         Lmcg==
X-Gm-Message-State: AOJu0YyJJN0iUvokTfrt8ssbDOMAYOUaCXII9DuqndqR3CgEOq8SrQiY
	5RoCIVwosZbiojFmI+osPSugzGsot9hn3p/o+eJzyNNGOPYqdW9kXZiMHx4H79WH
X-Gm-Gg: Acq92OFej03dV+V2+8hRLnIGwquP47X5nTOSESkzXRhx+iSOOzXfwg+0q0SOIOeb4Jt
	7LcEoC4b5mjE5WOIXrGldGHZoJfqLUmc7Z/6JV60DjDaCGsWzue7hoJQudQCIMHOMEFL8PzbM3w
	ryA74C0vzwxayXJHKcRcsfXDufmDJeaape/hETL67QyNs53QKj7IXxmeg9Yyxi93IzkNO7U1pF0
	AtDj+SBxrbPsg9eEUgJHqvbia2AtctULZ2Ezkd7rdNNOXToS4gFgiiINwnyBK0FnmwUOOB8Zjvb
	mOsdL9fV4sB8f79xujjKRzd9jJmLPddi6vUN6Plyz48BFB3019XFVce7QHLfoFgQjhOv11QsQsQ
	e0wsqqZXS8m8dsCWHfp9HMzcmEqULNMngkX6cq6CaE4N2391W4c24KE7YHa2UsK1EZTuZsIa6n5
	iPaOZel6XApehV64oBXLyoLiIj4SNEp7i6B6f1fzOkYtlXLTVhc9RVBbjZzZrAfqRX1+UQZnyP5
	doCbcUZajqZHLB01vUvCf5GxI1Y/OmgxyRGxd8KrbLXp7qPbFz2vaXaAh1cp5rU
X-Received: by 2002:a05:6a20:430b:b0:398:9b42:69f7 with SMTP id adf61e73a8af0-3b22ec72085mr15778694637.39.1779107314447;
        Mon, 18 May 2026 05:28:34 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c65:166e:af67:d4b8:e4e0:1695])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664a59sm14650472b3a.1.2026.05.18.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:28:34 -0700 (PDT)
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
Subject: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7 14AGP11
Date: Mon, 18 May 2026 17:58:12 +0530
Message-ID: <20260518122814.8975-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch 1/2 (pinctrl-amd GPIO IRQ fix) is already in Linus Walleij's
tree. This series contains only the i2c-designware probe ordering fix,
based on top of that commit.

The root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd
completes, so GPIO 157 (WACF2200 GpioInt per ACPI _CRS) has its
interrupt bits cleared when the first I2C transaction is attempted,
causing lost arbitration errors.

A higher-level ACPI devlink approach was investigated in response to
Bartosz Golaszewski's suggestion. The DSDT has no _DEP object linking
AMDI0010:02 to AMDI0030:00, so fw_devlink has nothing to act on.
Setting this up at the ACPI layer would require either a firmware
change to add _DEP, or a DMI quirk in the ACPI scan path — equally
quirk-based as the current approach.

v5:
 - Add blank line before #include <linux/acpi.h> (Bartosz Golaszewski)
 - Use scoped_guard(device, gpio_dev) (Bartosz Golaszewski)

v4:
 - Rebase onto Linus Walleij's tree (patch 1 already there)
 - Use --base so series is correctly 1/1 (Andy Shevchenko)
 - Add subsys_initcall test results (Mario Limonciello)

v3:
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

 drivers/i2c/busses/i2c-designware-platdrv.c | 76 +++++++++++++++++++++
 1 file changed, 76 insertions(+)

base-commit: 3812a9e84265a5cdd90d29fe8d97a023e91fb945
