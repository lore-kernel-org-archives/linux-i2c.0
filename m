Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCC2DCF46
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868498; cv=none; b=RtL51oKNaAn9bW5otbncNH9b4kd46QixsJzfNxSq4WdFAEN8dERBVJlhMDNAxRigG4xuF9NodWZ7zM3NF12Zh2Md1sNxEpyHBOjWxoHaktXrcXi9XOIUchZrIixNFqHatSpuOXfwh0wxLnxECf+pVgQJrAUy2BMt9Vc3MCFHoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868498; c=relaxed/simple;
	bh=4NZvaMgEivH19ze0KrHa5URPQF+DJXe0KL1Iof4hU0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP2iI/ibi/ZQed/NvnyqnJ2XyfnXVxMOFVpu048YOWI0tCrtH0dSLnym2RIpaS0kiRlKIfG15BBlKp6N2uvdGlwr/gyMnlgXRQfLHN+C2/PoLKaxr9RMTimPtAMezdvRE+UAs21BUgBpydwK55hYUSzmE8XcBTD41deTg7Kyp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkZACa4M; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkZACa4M"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fde295992so222812f8f.0
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787868495; x=1788473295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12Czze317YjE4biaV1BLwood9eGVcYGSVELmZ2ehr0Q=;
        b=ZkZACa4MWqRVc/0lmyKUfN+BEO3QCsy1dGf0mBe8Zi3krYTf4Rpp+MGpPfDI1Soi0S
         NIcwitWJh0Gpu/PkYOwOgasQj39XuNdu6GscUn4RgcplqNI8pH3VROh2YLFUet9dqaji
         Gmnp2Otm5XQ31LaFJnPIBHPDIc/3GpHWyh3uD0wTnRqHPyIy6LT8U54IGllYfS3s7EUr
         aSVee/ptWVfB9mW5l+MML3d/hMCEbQ+DRW7b+y1gDk5kbbZN3fTCpSeUQrTfJqkfDZYA
         Mr9bTE1uxewFIYCM0GCdPVqQXLxV+tkeFaSE6SaGgwHLlNXG4c+B7pd201DbZVdViJPz
         iOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787868495; x=1788473295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=12Czze317YjE4biaV1BLwood9eGVcYGSVELmZ2ehr0Q=;
        b=gluUyDYCoUgALtbm4kC+Q5SlEqJ8ueW6A4BtZ05pDidDUi/BSenCmvH9WjuidZxvvI
         Cy0g2e9dPsBs3/sV6aG1A6THBlWiAO8MWo7KdV4NsUBwWHUtvAgJeImtPrx+UyVgqm+g
         pwrdB1VczpV8rgHd7T3WNTOq6OBjeTiHYLkhzOMylCxNyXC3HkTJBBOhq/yRH9J3Soup
         a1m41fFAMN4WFObZD4mMr0HQAfKrYd83JpKDpm8yF6+gffhy0YvOlgtPHo/uzDWQ/IlE
         N9NkKcEuuNEKOtGPpeIbA1eGpanJjLtQxJZvPBsxo29PhAdY5vKXBFXRdiZ0nHiIqFld
         COnw==
X-Forwarded-Encrypted: i=1; AHgh+Rol6LaujQCuEVNpgFS/lvQiVA5AQp2NwbnmegEYumhGltSr2Qk7Vdm57gpTYngBjCrRQ6nlxpNV3jk=@vger.kernel.org
X-Gm-Message-State: AFuF++mIiwhrOHXJL6L6ET0fEjq4nwEyIZsWjvm0D5v3N5TMnT7BieJ2
	B9lWsXspKB7Wwt2l3NYshRF5hpTAhnlRuVTmK8sEBx+b++sxI92/Q8n8
X-Gm-Gg: AR+sD126yQrwypIWo09MdmVrkxz7jVZJVXo7vhK7Jnup1ai6cxeo0xOYMNHoDz6JDEn
	00SLfqvUY8NUcEfbHcLrGy5ohDV21SroKrNZN7X7W7Ru6tG18A9dKGWhrMx2X/OB2TpJKgGj2Yj
	Ki/Tgcian28EvHtTF+MR/RIwVRdoDpJDJjn3/PsdpmGHsRlaihGoyALRsW8EU5UfBvLilK6bt3j
	xxJFbgVwHULPb1u8e/KGDpRMyPgwCICeWbDAhZYQNsSinOr6A0J7RD0Hur0XfNYHbNQXNzu/5KW
	tbI3/uesZtYsQSc8QGzlK51REWhw9MCTNffOOIt2VCxu3kUFAmc7zTVaOMATi5glAwQZ6LN0Wo8
	EkICFzZUNM7YIAhyozJ5GuXGnf4qNhIASW6wcP+yn3nR2igWpLtOX/Kk7U7kVivekb/UF5iwAwv
	agHxpFCiHWWNi9ygk4Ib/YK4x7a5aCAIMkKvpkfoY3wyFr9pHg9zl4cf6IjwI=
X-Received: by 2002:a5d:6f0d:0:b0:47f:71a0:c060 with SMTP id ffacd0b85a97d-482eab5ff3cmr11537622f8f.2.1787868494701;
        Thu, 27 Aug 2026 15:08:14 -0700 (PDT)
Received: from m2.. ([37.142.156.156])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-482e28e899dsm12023740f8f.28.2026.08.27.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:08:13 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: linusw@kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	brgl@kernel.org,
	germain.hebert@ca.abb.com,
	rio@r26.me,
	brunoceg1@gmail.com,
	contact@christina-quast.de,
	daniel.beer@igorinstitute.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	michael.zaidman@gmail.com,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] HID: ft260: uart: add modem pins control via ioctl
Date: Fri, 28 Aug 2026 01:08:05 +0300
Message-ID: <20260827220805.23112-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLnKXqbV0xB3wvTF9Ri7g1MuWV6csO0MGzCtv5LBwmSr4g@mail.gmail.com>
References: <CAD++jLnKXqbV0xB3wvTF9Ri7g1MuWV6csO0MGzCtv5LBwmSr4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 at 10:08 +0200, Linus Walleij wrote:
> I'm not the authortative expert on modem control using GPIO,
> but what I think you should do is to
>
> select GPIOLIB
> select SERIAL_MCTRL_GPIO
>
> On Kconfig, so that gpiolib is always available and you can use
> the generic modem control helpers for modem control over GPIO.

I looked into this, and it does not work for the FT260 without
changing serial_mctrl_gpio.c first. Three blockers:

- Every GPIO access on this chip is a USB transfer, so the
  gpiochip has can_sleep = true. mctrl_gpio_set() calls
  gpiod_set_array_value() and mctrl_gpio_get() calls
  gpiod_get_value(), and gpiolib does WARN_ON(can_sleep) in both,
  so every TIOCMGET/TIOCMSET would give a WARN backtrace.

- mctrl_gpio_init() takes a struct uart_port and its IRQ handler
  needs it: uart_port_lock_irqsave(), uart_handle_dcd_change(),
  port->icount, delta_msr_wait. This UART is a plain tty_driver
  with a tty_port, so only mctrl_gpio_init_noauto() is left - and
  the FT260 GPIO lines have no interrupts anyway.

- mctrl_gpio_init_noauto() only picks up lines that exist as
  firmware properties: device_property_present(dev, "cts-gpios")
  and friends. A gpiod_add_lookup_table() table is the machine
  lookup path, so every line would be skipped, all descriptors
  would stay NULL and both helpers would silently do nothing.
  Software nodes could satisfy that check, but there is no
  PROPERTY_ENTRY_GPIO in the tree to build them with.

serial_mctrl_gpio.h is also private to drivers/tty/serial - all
eleven users are serial_core drivers in that directory.

Registering a uart_port instead was tried for this device and
turned down. Daniel Beer's 2022 FT260 UART patch was built on
serial_core and called uart_add_one_port(); Greg asked for
usb-serial, and Johan Hovold answered that "neither USB-serial or
serial (core) is a good fit for such a HID device", pointing at
Christina Quast's tty driver as the right approach - which patch
1 of this series is a port of.

  https://lore.kernel.org/lkml/638c51a2.170a0220.3af16.18f8@mx.google.com/
  https://lore.kernel.org/lkml/Y6WNl6+ySy8zcSyg@hovoldconsulting.com/

That patch left set_mctrl empty and get_mctrl returning a
constant, which is this same constraint seen from the other side:
uart_ops.set_mctrl and .get_mctrl must not sleep, while every
FT260 line access is a HID feature report over USB.

> This can be a bit delicate in this case since the gpiochip that you
> use for mctrl is also registered in this driver, so you need to
> register the gpiochip *first*, then add a look-up table for the
> GPIOs, then register this modem control.
>
> Then look in e.g. drivers/mfd/sm501.c which is an
> MFD device that register a gpiochip and then consume
> GPIOs from itself.

Agreed on the ordering, and thanks for the reference. The UART
probe currently registers the tty port before the gpiochip, so
that would have to be inverted, and the gpiochip label is built
from the HID device name, so the table would have to be built at
probe rather than being static. Both are workable; they are not
what blocks this. sm501 does not hit the sleeping problem because
its gpiochip is memory mapped.

> The core idea is that the serial modem control should look
> up the GPIOs from its own gpiochip and use the MCTRL
> library helpers, then this should result in very little and
> compact code that is easy to read.

No argument with the goal - I would rather have that than my own
TIOCM handling. But making it usable here means work inside the
serial helpers: cansleep set/get, a path that does not require a
uart_port, a lookup that works without firmware properties, and
the header moved to include/linux. That is a serial subsystem
series to agree with Greg and Jiri Slaby, so I propose keeping
the ioctl implementation in this series and doing the conversion
as a follow-up.

Even then only the set/get helpers would apply: with no GPIO
interrupts, modem status changes come from the FT260's own
interrupt status input report (0xB1), so that part stays in the
driver either way.

Thanks,
Michael
