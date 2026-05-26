Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843973DDDA0
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792759; cv=none; b=gW3nD3tMtrQ70l75bIlpoDa2r5hFCMJpC1BxE7AD8IE9L1mkZrmDdST2ubeWQ7u1Ba162fJ0qHJoXcej7qtIWy1Qjp3cwSxpMedz9lehidgoSDS7gJx/uDM3RiQDbwMuWTxNwqUIYf5zhag8usNmYnsc6hKeN+FCAZmfmuma6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792759; c=relaxed/simple;
	bh=O7YRMU/gIB39/PH7Oe5t1hwEMJjKDCiXGwnEh4pxdoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kam9rK+H8WdxinChBt8YdOrvq0FUBkQ+ZS3wSkfwoH78LRDOyTQaObZCHrqRAhM4qMi5czZJfPyId0oMq1TAbz6R36I8MwaSccEiugibrsTC2igxuR0XD4shgOadaFKtaf6CbKf/h0rtYVx4/Kg3HUzoyhq5hOAWjK2NWtMcxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf7NuEhl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf7NuEhl"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so4727569b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 03:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792758; x=1780397558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LywgSOMGFzG9gHBF5SWAjzmzCpEAv3XPtUpcuKzvSZg=;
        b=Yf7NuEhlI56tFH6eyzxacU50i0rapxOL2hXkL8I7gp/+OkQXJPhTppE7n4yQlrFsde
         mbCrmLZ7ZTKeWcoKRmFnKsQq0Tnv+V7FCRGVmXhosvnPhy1kkjvl6dODwGj3BCo94Z3J
         aobUzMIOtzezPFtT5433aE/IcgOwnjfMIhL6eXhFfgEe6thqXNI+pCUA+e7pIQiRSIvK
         NGXYGFAXldV0SnTYG0ooPM0W6eHxXkzhUtpKMaFMvGjmAS8pc1FIl7oJUAzUdF1S/sNv
         vCYc2wz4vowfDzYWTXVuyYrP8mJiv3tsvilyo3b9irMgXe6s5/YTKTiSC9ksKLLNqz6v
         K1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792758; x=1780397558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LywgSOMGFzG9gHBF5SWAjzmzCpEAv3XPtUpcuKzvSZg=;
        b=XZ15QOWdSa94JbpF7yHdVdm+Xf/4XOQxrt3Z5620JVXFftbGZkQoYSsCJCx7/4joiu
         Diul+Suzn7IC4OSPIa5x5WRNRjsx774LNbX9WY3Nx0MBvbujQ5E5RfP3VmccoiA+1LSG
         RFMneFx1MfKTYA/0lXMXXUVXjn6kZjHFAZLacpro4Pa7wdfzNK2eomdxEXCX3jFt6oxH
         CCz5yVGNYR/R9cCrM4JnD/34IibLY7DT+3lBE4JF6L0oz9NBg9EOiWr3O14LR6hEFFnr
         km0hLu4ZbPTnCcg3x9iCqKfse1eyaxviIH7XvW5GXYklgyPbuQmKVbsS7RPYvGwuQuVn
         DIqA==
X-Gm-Message-State: AOJu0YyIjGIzQaIDYZaSQWNzCCX4eVROTPhRtUZa45UgUi+KSJENFtVt
	39Yp9zMZNRllx0+YMKVnbiKNggnkOyXhr+A8ndh1KASW9qpgyPeT5kxFdG9MrABC
X-Gm-Gg: Acq92OFH2JGdMEos3N35LHxbSU4wRKv4vAvjhu6I2RJirWj/PVOLJ+cXbnKhrIjy7Cf
	XjyHASgg+ZS7XcCmppN2NFLwNuOdks70VTmFQV8tlSnRlrN6KLoZjSswcQPnhqQi0JkIbohcvWe
	snDNY5i7PC9foGOEjUM02PFvP4CSPSk/L16sss71Yk8CG3NO/PLMdQUD2CyRPjqJwQytGQKUA7o
	7swTPFEb13tJI0kwOcC0uYQ9+cTKg5HbKYLIgpGIjub/NEc9e5o4GYEUmsrxAyXZKZi6+DnkE0j
	ww7UxE4sX+m7Exevp0iGHfNq2zxC2U5Rsyy5pRjXFM5KA/Kn7VEGQS6Wp4jbZFp1pXSF7Lx3vHd
	x79Gy/oF2UFhsp588vRhmJq4UWdwIr8uJ3p9H7mZkhYUobc9GEWeWXjGKhH0uIVVa1JOXFaBekS
	Ig/pkHaRQ8+17cSHxG5J9PquzSMRVcaOTMujATe+RUjJ/Hx096jZpNmWe65xcPIyjU5otuD8cMW
	iM1wSsYvKz2V7HaPCPx85beFXKU9o8e1OnVVWyYfMswA+nj01SPJzvjSlAr4192RUbOza2kYB41
	dQB5zZ1TCRwQoyzcSrDFL70=
X-Received: by 2002:a05:6a00:a90c:b0:833:2398:cde2 with SMTP id d2e1a72fcca58-8415f3a3cd6mr16705784b3a.43.1779792757864;
        Tue, 26 May 2026 03:52:37 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c23:6e83:739b:c8ff:8cea:29c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fb3083sm12053271b3a.43.2026.05.26.03.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:52:37 -0700 (PDT)
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
Subject: [PATCH v7 0/1] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Tue, 26 May 2026 16:22:09 +0530
Message-ID: <20260526105213.85833-1-hardikprakash.official@gmail.com>
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
tree, but testing confirms it is not needed with this approach — v7
alone is sufficient. Linus Walleij may wish to drop patch 1.

The root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd
completes. Dynamic debug tracing confirmed the race:

  0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
  0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
  0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
  2.348157  lost arbitration

This patch adds a generic check that walks ACPI child devices, finds
any GpioInt resources, and defers probe if the referenced GPIO
controllers are not yet fully bound. No DMI matching required.

Tested on Lenovo Yoga 7 14AGP11 (83TD), Fedora 44, kernel 7.1.0-rc1+.
Touch and stylus fully functional with v7 alone (without patch 1).

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
 - Rebase onto Linus Walleij's tree (patch 1 already there)
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

Hardik Prakash (1):
  i2c: designware: defer probe if child GpioInt controllers are not
    bound

 drivers/i2c/busses/i2c-designware-platdrv.c | 156 ++++++++++++++++++++
 1 file changed, 156 insertions(+)

base-commit: 3812a9e84265a5cdd90d29fe8d97a023e91fb945
