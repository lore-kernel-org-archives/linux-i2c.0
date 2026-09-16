Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1233F104A
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542051; cv=none; b=U6fvehvM1/w+EU1LKb5AFEZQgl5DqS7K6fCCnda9zX6NtPbL9WZ8WSm52bMjIQw6znAojougbgxt7isvCE6jUkXcWoeXX1pvqoGGMaN6l1WglIfBJ8UNiEtkc/+3gKfrSUiL8cNuEe4epG8i8rgcpCqhMBBaO33pwLtM9fGX1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542051; c=relaxed/simple;
	bh=15VHq37KK3EFFSPH4QUDPhWIFIBLKGpmssDFAnjz4yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbnEpB6cl/LOozohUyE5xhRF1skCu2uYPl1QFVUxh6PFz0LCkeVCLU4SLH3HzJ4xAka5wt5w5uExiYJ8DxNd0l8U1gpqvJ7Lcii0vLixuqkkEZ6lCSZo4+PtfCgFCvejjCEfs6u9Tz9RBeuuKpL7Tbb2VK5LPJjdXfgu3g+q6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9YNEfCc; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9YNEfCc"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so353165a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789542049; x=1790146849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6eIVfRHGn9lTWHWO+UqCxzeZX3yXWYyVss2vdTuNRc=;
        b=F9YNEfCcQfxAKESCOLrVhlsslPOhbKA6Adb5LODpD9sm9o3/PKKaxsuh1p8xfnPUXk
         5IJ6rkb9GvmWu0Y0OLDPQ3mKK5nAerPzZuSVELyJoBZG4QGx2ekd+oUTpBdbPEAP+bgy
         xn5VhaJYXgrwmJ7FpUJDzzMm0kInyzoGVB4SVAn9pa/BGtoTqCSezOb8GMI7V4FdEIfD
         5CqyGOeXaXcCCaJfw4zBOE5R+TPtX5yPD2JvifibmKxyAp4zHnbPne+u/73nINBV+0NR
         TwEBrts9ve8qnjW80J3IkyB+EzY99HaM3DyjyQXSSrWI+NzM3ib+wPR7dCd6+GD/DkGg
         V6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789542049; x=1790146849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f6eIVfRHGn9lTWHWO+UqCxzeZX3yXWYyVss2vdTuNRc=;
        b=dxPvKf9tJnPnWifN7tReukRd7+6SQ752z3/aLu94StQAQJmzvunwmw7zGPHzYmwMJf
         vaZGChOGm9Zc+/WsBARpfufBNmNMuip1Bp4h28jRkzoZTBtFZB7Bg4k2CEREBmnLUPEa
         jzxhswGymnU7geEOL8txj1Df7+k5texOQR9VkUPGMQZwdOV1lRmNxrmFLUo29ahl1/0j
         KOwIw52YotWsIBf38WPYDuZ1ZvcW8WbOB7w8TYm1K/1HxFKCV60mjusMlJD95Oq3OBXS
         Rl+mDnEOqiBtvy7skl8wBi6R85vw9+SVKEQPD4a2kbHt/PDdDrpfyyLNJicriNENlxv1
         R0vw==
X-Forwarded-Encrypted: i=1; AKwUvBy1VIUz4JjPSNgGzuoWOZ1VFoNMolRO9CNQR0p5hDbP8Rc1X0pvM28B6i3NlTKfavG7UhNIldGJuow=@vger.kernel.org
X-Gm-Message-State: AFuF++lytYQyv6Sg1bQe2pCa1XCZKqk68dEHkFr7rHAyks/6m1NdsQ4y
	pmUuVvKzYpW3OjUvQiOOi/cDxjRYm9UvBXZrR5iUCp/DKLUJwbBt0xmE
X-Gm-Gg: AYBFou0dzwRSTE9YV3VgADa+TfklRibh2BN0Hh61GPLpmwU/is8ugvRWC2ock6q5mzH
	lF8fFcbuJMQ9j/FFFi+Vrcei4Y8vZzCGyeTsis0DOvxGy07pCazq1xWOx+XIwhdh/GrnvWt62QV
	lcqJmlDsstJnNdSxP3Rt+V+T86SuOzj7wI97wXIzvCg9fVQC1OQyvSXEBBEaR655na4v3vLy3Lj
	PDtpduVo9+3OADd0vWFaXs0QDtYVtIeNpObfLLqWnRWaiml3aJ7wgqjasYur5xZn3M14fw37iMC
	0EFQ5TcrjmHymGADlG5pUzq8ZTIVPMlGdBza5dIPE1J4fHDqSrYiycUlk7z/7tWQZW5uyVoE5h4
	spkCK9FoV2MBV+RmF4i8EZBQDxhJ2HaQKp2ohnaD16g37TaizrWxgK0n6w7ubUfNtTeWKJ9cvF9
	0Z0rY1XuSfxZuERLMWPwaoV2ev5iVSoHeS8thj4dNUe6RgoPSDX8E5TUYX1DaW01hQ26sshJn2p
	i/o68XWFay4WjZ4djwmJwW8JD2ujwKi69i8rmCguM4Rq1COhorwor5VaU3uIhqwK40=
X-Received: by 2002:a05:6a20:cf88:b0:3db:3d0b:31fd with SMTP id adf61e73a8af0-3dd5f3f86fdmr3920854637.1.1789542049031;
        Wed, 16 Sep 2026 00:00:49 -0700 (PDT)
Received: from gwaihir ([50.125.254.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab50d67sm1040887a12.6.2026.09.16.00.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:00:48 -0700 (PDT)
From: Strider Jones <stridera@gmail.com>
To: mail@dennisfoster.us
Cc: benjamin.tissoires@gmail.com,
	jikos@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	Strider Jones <stridera@gmail.com>
Subject: Re: i2c_hid_acpi: ELAN2514 touchscreen causes IRQ flood on HP Omnibook X 14 (Lunar Lake)
Date: Wed, 16 Sep 2026 00:00:45 -0700
Message-ID: <20260916070045.52663-1-stridera@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <19e3858758e.779469783489550.85756750264043334@dennisfoster.us>
References: <19e3858758e.779469783489550.85756750264043334@dennisfoster.us>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a second machine with the same failure, in case it helps get this
looked at. Happy to test patches or collect more data.

Hardware
  HP OmniBook 7 Flip Laptop 16-au0xxx (SKU B88B1UA#ABA), board 8DA0
  Intel Core Ultra 7 258V (Lunar Lake), Insyde BIOS F.10 (2025-10-22),
  latest available on LVFS as of 2026-09-15
  Touchscreen: ELAN2514:00, 04F3:43F0 (yours is 43F4)
  ACPI path \_SB.PC00.I2C4.TPL1 on I2C #4, PCI 00:19.0
  (8086 Core Ultra 200V I2C #4), i2c_designware.2, IRQ 20
  Ubuntu 26.10 development branch, kernels 7.0.0-30 and 7.2.0-5 both
  affected; first seen 2026-08-09.

Symptoms match your report exactly. At probe:

  i2c_hid_acpi i2c-ELAN2514:00: i2c_hid_get_input: IRQ triggered but there's no data

and then IRQ 20 (the i2c-designware controller line, IR-IO-APIC level)
never stops. Measured today by binding the driver by hand with my udev
workaround disabled:

  - ~49,500 interrupts on IRQ 20 within 2 s of the bind
  - steady state ~21,500/s, all on one CPU
  - the irq/108-ELAN2514:00 thread sits in D state; on an earlier
    occurrence (2026-09-03) its kernel stack was inside i2c_dw_xfer and
    the log had repeated
      i2c_hid_get_input: incomplete report (67/65280)
    i.e. reads returning 0xff filler.
  - echo i2c-ELAN2514:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind
    drops IRQ 20 to 0/s immediately.

The device's own interrupt is IRQ 108 (IR-IO-APIC, level). The touchpad
(SYNA3503:00 on I2C #5 / i2c_designware.3) on the same platform is fine.

DSDT details, consistent with your Interrupt()-vs-GpioInt() finding:
TPL1 carries two resource buffers; SBFI is an Extended Interrupt
descriptor with flags 0x05 (level, active-low, exclusive) and its vector
is patched at _INI with INT2 = INUM(GPLI). _CRS returns the GpioInt()
variant (G_IN(GPLI,...)) only when TPLM == 0; this firmware has
TPLM != 0, so we get the APIC path. _HID is rewritten to "ELAN2514" at
_INI when TPLT == 7.

Storm frequency is intermittent on my box rather than every boot: some
boots ran for days without it, others hit it at probe. When it happens
it takes the desktop down (compositor waits on the stuck I2C bus), so
I'm running the same unbind-at-probe udev rule you described:

  ACTION=="add|bind", SUBSYSTEM=="i2c", KERNEL=="i2c-ELAN2514:00", \
    RUN+="/bin/sh -c 'echo i2c-ELAN2514:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind'"

Interesting aside: when hid-multitouch binds it registers the usual
touchscreen/stylus nodes plus five "UNKNOWN" input nodes and a
"Keyboard" node, same odd set you saw. When it probed via hid-generic on
one boot the primary node was reported as "I2C HID v1.00 Keyboard".

I can provide the decompiled DSDT, an acpidump, dmesg with
i2c-designware/i2c-hid dynamic debug, or test a quirk against 04F3:43F0
on request.

Strider Jones
