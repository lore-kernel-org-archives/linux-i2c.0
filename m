Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77F33F588
	for <linux-i2c@vger.kernel.org>; Sat, 23 May 2026 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558317; cv=none; b=W6dfrVEeKP0UEEn/mY5P8XQFlHx7W9zVtMq2K/Vk05ndJvkAqaAFQ10v5WodSpSiaPX021e6IyBQzL/VVGGbNQDN/czroiQA9iLl376LaszC786j6h/d3FaP2MrPSKm7Ilq8adlbdy3Rke98ege/OurtQGDOT75lTDjDoyJhu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558317; c=relaxed/simple;
	bh=3uCSAZaEKJhqIoMxLF0gKtRAOr7hPsxZqRHiu+Vplzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMdnjAXsmQRHd2r5qKbyvNoPzAGOcanWZ4jDln3sY9v6DrPGQPGuGTbQFLovFdE1OUwNDQIAQ3FiyeFZRmpa9dyjiY+ULRNILcAaaVe2TK1KP+kSBOgyCk0s3Wei1zTIXjzCIjKg3dxP3zF9TbCWUQYQbtDj+9PW8fThZLWzzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE4U5fiI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE4U5fiI"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso5961246a91.1
        for <linux-i2c@vger.kernel.org>; Sat, 23 May 2026 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779558314; x=1780163114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KB9h+7r26Q66tvDFJQbtSLggffDcPzif2omnbHE6cS8=;
        b=YE4U5fiIIMM9oO1ubVPDNs2mbmMrfbUrOyeKVJN6bcE2bYQxBjfqT0pFaH07+cd1Na
         98sctN2Fly+0mR0PbychWOI7jVV3SJmIBVL3l46wdisTxy52v9qY5G3yYVOtFHZuvvyf
         7Yy96pyXj5/BaJeCMtuKRFVzBxfB13ikdFLCTP+z+/vmufkhzebSNF8IPhil0Yky+VPE
         xE/37qbWBGs8EITj8mWpVFASZIvbpxfNsqltU7R0ACe8Qn57NFEA4KldwGYvtYSmhSwq
         18iuayi77sAcWc+75wBSOMD2ixXPPAmw8AzLXVPhXXEX0gsKHRFgX1CrT1cttgyU4tTb
         hjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779558314; x=1780163114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB9h+7r26Q66tvDFJQbtSLggffDcPzif2omnbHE6cS8=;
        b=TsYgkexrpkgturgzYVoB3yCHWNwe5lFd+RW1olQzQbcIVdmWkBhR95XGEcWHv/qTJE
         b6C+hWXY6jFRiOqGKU7A4p8BabgQC0wNw95OTKqFK/Ow8IqsK0cehMkrcYD9IW7yT4Hp
         y0quWoE1x5ujsMIkEMPhrVIZzQI7AI4z5VMYqcKz7kA685NFrQED2WbUDE4YlqkU8Cm9
         c0VEhl4xgKxQS9ZEBnPDPuljANM7+jXe2+wME+/MquFL+Ov6E39pekUGYpcqjm/fNgwi
         wBpGCD9xz0aCtAQ/+1GcgidcrPEggXhLGJ7q5yX2izVkGIdtWCOYrEDQXxSjI3k8TYsI
         TvQA==
X-Gm-Message-State: AOJu0YzdHj2k1e7skOJI9xSGKZEBx7zgKCs8kycn8Niogs/PDsXUyuLZ
	rzj08Fjahf20/MlniS+DcZTRvrrI0qDVkIB0tCUPxyQgMhlQtZh4xAMKDqo36jO1
X-Gm-Gg: Acq92OGjL9dLs+3zFu9lgQaTcv616+Xri1iRfaG0B7eDKqWGzFIDDNe/HghL9NpcNWt
	1+N1ggdkErl2kR0eUzgB1NfNrrR2Zk8/yYAU+Ta6Yx2iy+HZQ/FF77YWdW6msF8nMCNx+hys17t
	A34wEy6G4R9FFUsSwgJawWAtmCTRdW8KMnTNMSba4dCKAxpd2aPvWJENlwnkb8sWeFtnOVWyOgd
	iMnTAF6YzImENzeaUzhS8GPQprYK4ZojApjM5zpM2wAn27h/zpjz8fU9MCuwiv/IjDpfq3UMFjL
	u8hnJo05D8UksDH+vhHjGniZZ5wdsNFpjAV5mwu3LVYjrvqd5by2A9IeZbugPPVDe8RQczonZUD
	PJlAj202kvobHERTNZUJnNYwONmBTT6uWj5UMimBdl3FkgHDgcavPMPK9NDV8/6gFDePcXFYru/
	op0E1VlbYAlzQACGs6bgW5LBCI+01dlFQY/SlM6nwLfRWDnv3tczOc/I/WZ6YuP0i7YKo+ZFnZN
	yx/WoR4OlVF4cgl53P4CjgMySvvSwIF+B7loXD8e9whxDAS/ADcKVP1nNEfunyMAPv5njv2VElB
	UXJ0avf6zw2H
X-Received: by 2002:a17:90b:35c9:b0:369:74b3:a103 with SMTP id 98e67ed59e1d1-36a476ec35amr9987666a91.8.1779558313595;
        Sat, 23 May 2026 10:45:13 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c23:1260:c040:19f4:9706:1050])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71dbc38fsm5127139a91.5.2026.05.23.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 10:45:13 -0700 (PDT)
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
Subject: [PATCH v6 0/1] i2c: designware: defer probe if child GpioInt controllers are not bound
Date: Sat, 23 May 2026 23:14:39 +0530
Message-ID: <20260523174440.9629-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1/2 (pinctrl-amd GPIO IRQ fix) is already in Linus Walleij's
tree. This replaces patch 2 with a generic solution suggested by
Mario Limonciello.

The root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd
completes. Dynamic debug tracing confirmed the race:

  0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
  0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
  0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
  2.348157  lost arbitration

Previous attempts to fix this via initcall promotion (subsys_initcall,
fs_initcall, arch_initcall) all failed because the race is not about
when the driver registers but about when probe completes. The GPIO chip
becomes visible to the system via gpiochip_add_data() before
amd_gpio_probe() finishes, and i2c-designware probes AMDI0010:02 in
that window.

This patch adds a generic check that walks ACPI child devices, finds
any GpioInt resources, and defers probe if the referenced GPIO
controllers are not yet fully bound. No DMI matching required.

v6:
 - Replace DMI-specific deferral with generic GpioInt dependency check
   walking ACPI child devices (suggested by Mario Limonciello)

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

 drivers/i2c/busses/i2c-designware-platdrv.c | 157 ++++++++++++++++++++
 1 file changed, 157 insertions(+)

base-commit: 3812a9e84265a5cdd90d29fe8d97a023e91fb945
