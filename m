Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAC285041
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671612; cv=none; b=h6UsA3IIgB+8LiBG3c9rP2nlrsceWpQaOFZjg9TG+wkkHifgnhDP3B4u5TrcDA0FiAn5W591s78RIb5PGlhxhtHVB/grvbLzlXxFfOvoxhtHWnKtkfWEAQYeqlu5a9DE+5o+FKAyAORWomQ0Reu9OLJM9dR33wOZrfx+dwF8AN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671612; c=relaxed/simple;
	bh=ovFl0FRA/Y50902pWqD3zOFTf5Y8L0LkM20eP95/xVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQ3SLPAuhZ76cPG+mfbBudBvRPozPaJSfrxdE0TyTWDX8pxTG9t3w9yU3bPC/M8gNa/LfdH8tlbw7XeuRPljcDPbbt5IKcdQasusDAzJ/9tlwemWNBgj4s8fENerqsWlu4JoINDRi26UNwqd0iyl97/RT0/c8OkUfXBRgXB6yRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtkVn6h6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtkVn6h6"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b6d9c981so3346952f8f.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773671609; x=1774276409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovFl0FRA/Y50902pWqD3zOFTf5Y8L0LkM20eP95/xVw=;
        b=KtkVn6h6JqJikItyIXK6w6Evu8ALKW2c3vDiRRMAF3DKvXKfSfx9tJP2VlZNI+om3U
         tCxG8uf0VLhsV2ungGj3G8VrPibRs8d90seIi9UJo3CiSyphmubwmGDxcKZ8p+0/Qsf0
         wYPdnhC/1doIFu4ZOr5c1VYYJjH6FNMPUz5KVhiIiKl/fXhmuiZzyU+sgYqX3h46TI3n
         d9AaKFXjVdwhd3H4UtNOyRjBLgJCiGr9YVb9xkVxBNZTSTCBbK6Yf8caiXxiv2tBfgwV
         szBYQf2ZW8FAoi4Flz8PzZD8J7jlyPeEbd9+YvB3UHqkty3LxBR4A1CEhOZUsY/q4JSJ
         lc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773671609; x=1774276409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ovFl0FRA/Y50902pWqD3zOFTf5Y8L0LkM20eP95/xVw=;
        b=gQhm860z/weSpHJ9wAzB2dkXVltubH22u2F6pAy+5BknOyxUxPLZBIYYj6U/LRkb6v
         5Ib40zDEOZ3CdwomBarIUjpO3SkrNmAddytL0OjWiuxtxiVABT4BzJoX3pxm3dClCBNP
         FxVGzlIedBljZ960U47j5yVpKWOphkzHynJ2VYOSn9DpyS56jqe8e55b5pSzgR9ShKq7
         q/L2K3B4oxW6HrEKVPl40hHmml7k1ecymQbrBu21a8uVcwmZAkEq41D7HOStmggrYLZW
         w11HDCI4oCC50ZI1cz2FfZaUK3VbCrQoXMSB0PdEd+uVzxtK3LBwW+STy+Y8B8awk5R3
         t59Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYF4E+TGiBCZlcxd8QeXlk7vKWiZ6yFS8Eyb3M1X/WNIZntvwjGwv/vHXmXo3ARVU3kBC2LXUFohM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJ/89+qU6AHaH3G4NHb5VTxZg4uSBC03CVHnvdguTH6RlXwmK
	GnpBvCtuSV9oDK2h1L/qt9wwyKefi5jxMm7YugZpa7/SXjoZOOD5ncWm
X-Gm-Gg: ATEYQzxyRTo82FogcQh6I9bca8MiIC689AP1TIgQAUAAPTKYIre2/nfKfi5LMHAthJN
	HbUA5EM9GnBlDIgnDV15dDPzSxV2yPW6OG0+33iXRuUYHcujkLRS4MRiAe8z0hlhVEcFzZ0iZDe
	8TA6IkRRtnR+At33pqJMIvlg5suhCOTwkzq+JIG98BZReV+z8+9Tl39HYWWHOjt6EHaiGBW/XSL
	JVCRRIUW20Qrxohox7EnjFTVikTAddaDkYW+OOLldt+bdMD+K3YIEZLd/rjoBiW600Cj2f3vcDy
	VT/flCevhNkCopgYffqI3iEN2DrlhgQtNRBiy/FnG7Li189aqAo/i1B7W/u4ebfnXDg4aTgn7Jf
	LvqHrMi0hJZJxi/0k6dV77sZgXnlIUB7wxGeub+4NUm0WukqoiFPrqSoERlJ08hHSuL1fa7ven5
	SJCn4CsXZUhmFv42kKLzinaLLFpbPzj2fnP75Bo/7OJyLXjrDlAhz0vHkhsjulNmjELXebEHvRL
	8UzO+Mafk0etQ5Pm3M227W3omCsqgBN1/vsDpvjRbHWL66PsZcvJOLVyfZ36tl5VDBgni2+vpIq
	TODYKxDKEKI=
X-Received: by 2002:adf:e984:0:b0:43b:3c32:d901 with SMTP id ffacd0b85a97d-43b3c32dbd9mr10069381f8f.11.1773671608811;
        Mon, 16 Mar 2026 07:33:28 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b468cf785sm4877457f8f.12.2026.03.16.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:33:28 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: skip generic I2C device when vendor-specific sibling exists
Date: Mon, 16 Mar 2026 14:32:42 +0000
Message-ID: <20260316143242.24248-1-edward.blair@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316131219.GD2275908@black.igk.intel.com>
References: <20260316131219.GD2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Mar 2026 at 13:12, Mika Westerberg wrote:
> Are they both 'present'? I mean their _STA() returns 0xF for both?

MSFT8000:00 has no _STA method at all. The sysfs status attribute is
absent, which only happens when acpi_has_method(handle, "_STA")
returns false (device_sysfs.c line 591). So it defaults to present per
the ACPI spec. ITE8853:00 has _STA returning 0xF.

As Heikki pointed out, MSFT8000 is the RhProxy device, not UCSI. My
mistake in the commit message.

> We have a quirk table already in drivers/acpi/x86/utils.c that I
> think could be used to mark the other one being not present.

That would work. acpi_device_override_status() runs before _STA
evaluation so it can force status=0 even without a _STA method.

My concern is scope. MSFT8000 is a Windows-only Resource Hub Proxy
(RhProxy) device with no Linux driver, no module binding, and no
in-kernel consumer. It's a static ACPI node with no _STA, so the
BIOS exports it unconditionally. Skipping it during I2C client
enumeration would have zero functional impact on Linux while avoiding
a quirk table entry that needs duplicating per board.

Thanks,
Edward
