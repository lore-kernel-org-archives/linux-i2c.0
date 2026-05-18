Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589813CF682
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088747; cv=none; b=Z7Rki4JIC1HJYTMckY/5lHUz74M7SEXdh7sn55NM7MGkhBVfUd5Mty19v2vyAcVpOtMif74KV3VmoE7Qhxh3Yt8BB0hgWoVH/SXWGnKzMjZYI1IWhDrfIdaFMuxTZe/Ziy7LuVYKbKcJcg5zwUlImX476DiMRYlroWoPTu+mvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088747; c=relaxed/simple;
	bh=3zgbl+Vnys9G91p4kZihIoo0LDe81gK1wYRdxc8lXZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qlet0SwXEino8zhO1+tclVYDk6KB2jIDpwfcpw98oHDGWDZ74ZGnlFftbthS/yAt96c8OLET4KC8ZX0fmvoFa8qxbG9lUPXBmUsJr4iAJxaeoo9j1Iq38SF9vwrfXYRldy7uQdWTmKKh6nKW11GbelUVEl+LqclUHtfZa6x82uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO4QrE21; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO4QrE21"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c801912c903so702528a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 00:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779088745; x=1779693545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNGdCGqRn/4V78cFmjLpgCf2Ei+cJeExb1kfSHeZ4PQ=;
        b=YO4QrE21KyCyn8xQFpCXauJD1KutqJGdUXUx/3hzjt1Y7sd8YZeCPj3NVpRCMuY7IR
         Mq24CAhGIybKe4cp0OR9Cug6RwAGKdW0KvqeTX/PcUN6RCs0ZGvWwPFmVyHkGQpjJnPd
         2J9FufCbpW3Uv7LcAD9eGqkHiXylZA2vgry0NEPPc7KG72ooOnASDnJiPdoQ5pycOCli
         G3k8w2Snr5tamtk5FGAgTOac9ELYZtt7unGZsPhzvdWJHG2FHmyPHcIeGziQ+m36oARN
         +pQDjFCMEeADNcFOaL2IYOKyC+AJJ+sY3EQIGc2xjGZU+DN1nLVz/3lb3NZwriGfbWdp
         nvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779088745; x=1779693545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNGdCGqRn/4V78cFmjLpgCf2Ei+cJeExb1kfSHeZ4PQ=;
        b=rU1wf7EbbtODmPPAOA4syBk0M9AolB2XUVGpllsKfYLgOUymKUWwcgr9N2CCvwek/C
         FpEqkutv580Mtpqow312S0IXXoT5lrhj8dvDRl0NkTdl8vCQL5rJsQSc1CuTVyQz+LaI
         19Y50P1t+fFfRcaVX0OGLo9NnsYp7k2YynXw5gVp1msdb9fPhB2vxNqYooOF8VolK2oe
         j1OqpdSDksPaWwh17dyJrb8iOHpcGH1N4EFXbVxGgrey356GkMx5jpNvH0yeFKLolCnA
         DjrUHPf1fPITZ558D3lRwz8iQXoPzDYpw3yxpyOKj5O5Khns4+rPRwSDOtxwW08Qjta7
         P4XA==
X-Gm-Message-State: AOJu0YwCy77SJbQRHzUVAi+YWE4NBFp7DzbDpqzettDc+buiBMyRuMlh
	+s86klRaCCwUob7/dXCGjQwWraPrEvZ6CLCOH2B6E65NpyB22Hx2RY/GkWMxWLEo
X-Gm-Gg: Acq92OG4oVxfVwXMVHvtbVkAnMHfJZJmU+67HP5MVKJQtM4NAsDkH/abeKK4rZ4FaKQ
	ciZwcaF/Re94MvgUWj6t/g6T9hyObz/SAaq8ELJsncnhFDqelCkzVLKAmGw7WF7OPjwKlWvDESy
	J3rbu1khIX55RWBmOdExrqIM0dVmFl32b6eFSQEfoBdP0G5X3T983aZcLT0VgRC+9gAWU4u/U4T
	PWessZZAINMNJ7xtt2u4N3ga4U9stlsTEJnD22P6y8rwzoRNk0l4KDKUm4q5PPUbbPnEWKjF8jZ
	f7rYFjwGbn2Svm3rOWtoy8FOGnKAsfhfKYuNdu29L5chkUX5d4qLELSJQ4hHWu6B2qcWVxGwLQR
	NnGDRN1lQYY+m+jhlj2ADkNxQAAAX/hCI3l0y7dmbk5ORnqmvfCz4ZgkB2sEWNm9E7CsaIXAq0h
	lUnI4B13SP92avJVj/ZdFWWBDnwc9QgLHGmMTpZX08eUOcHoijRyutOkK1HFZqnK7YGvivVJOXy
	D/zl92LAjeZPJaWolG9HoLvv2jc0mjKpm7nce7pt922Z5nyH7ASBV5gz4SfuSgL
X-Received: by 2002:a17:903:1250:b0:2b9:ea53:4cfc with SMTP id d9443c01a7336-2bd7e886e11mr147452075ad.19.1779088745363;
        Mon, 18 May 2026 00:19:05 -0700 (PDT)
Received: from hardik-yoga ([2401:4900:1c65:166e:af67:d4b8:e4e0:1695])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bdc4c2cd64sm62276215ad.78.2026.05.18.00.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:19:04 -0700 (PDT)
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
Subject: [PATCH v4 0/1] i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7 14AGP11
Date: Mon, 18 May 2026 12:47:56 +0530
Message-ID: <20260518071816.26629-1-hardikprakash.official@gmail.com>
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

Mario Limonciello suggested promoting pinctrl-amd to subsys_initcall
to fix the ordering without a quirk. This was tested across four
combinations:

  subsys_initcall alone:         arbitration errors, WACF2200 does not probe
  subsys_initcall + patch 1:     arbitration errors persist
  patch 1 alone:                 arbitration errors persist
  patch 1 + this patch (v4):    clean boot, touchscreen fully functional

The subsys_initcall promotion does not resolve the race on this
hardware — i2c_designware still probes AMDI0010:02 before pinctrl-amd
finishes regardless of the earlier initcall level. The explicit
device_is_bound() deferral is necessary.

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

 drivers/i2c/busses/i2c-designware-platdrv.c | 77 +++++++++++++++++++++
 1 file changed, 77 insertions(+)

base-commit: 3812a9e84265a5cdd90d29fe8d97a023e91fb945
