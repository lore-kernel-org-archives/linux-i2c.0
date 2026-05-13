Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8493A7837
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657787; cv=none; b=eOG/uTJ57uQn8RyJg8EdLulvzDvp0C7umHuRwVPUB4C5LKW05ln/hzoKD6/C9w47RCZ/TibxwfZlh3V0YjuV8UJOdVqmGnyAmRKzkwVGE0tptxE+aoKxoL4UPZRcelBrgeU9+Qs6e+JarLXrSBUKuwAPud0yZVmz2JtHFW4m+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657787; c=relaxed/simple;
	bh=96ytaBIvoVox2cv7ds6H6bYbxRBwuO8y2v9kZvcQ6Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC3Z6Oqn7BUCbNpc1bpA+S894wIEwwRQ56ioTeKQFGZKXh8HkuU92ORGBHL2R2ZOzQ06uuJ7MOwND1g7EFkJjGPFWeFzkLDjFuQeGFwbpkEsjX6lPvtqu+pM7Lp0JLiX+ughik0W9snzPyBDOnIiHNW6H8c/VvVmeLjkPbIsiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbi/KOBR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbi/KOBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A55C2BCFB
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778657787;
	bh=96ytaBIvoVox2cv7ds6H6bYbxRBwuO8y2v9kZvcQ6Ro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hbi/KOBRswqmxPSU22NITm/BbpELvqomCzCSF9vW4bRlNrm+yVq2YcR5iIar/w8py
	 I86xuObfMj1u3Ebjl/p235lWYqlcU6+Q0IbmwtTkc1sSohH68/FbH50uHhvGUqqmoZ
	 d8Kt0bj/j/AvcqqLxIwOINYljkhJ0hLzFm9KxTDpvevJmclCgrIWlwhLaotjwBQvoc
	 cm1nylTpEsKvTkeR8IF6Ra3J1F+XDMYs9qfTykVR/vId3prH+Rjn7f2h3fv581p1Zy
	 dxJ3vTqXfuhiVl6sUe7GbB/Q5GAmljlVtogyejGuUpgD6IeD7utiyy3bGpWwf+N0GZ
	 yIk14Uj/Eu6ug==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so4519653e87.3
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 00:36:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/zSS3DpcUINOjSn/8ZnQuyrwAMu1bk4tCBi+uEOwwSA0pvQthaqqIZ/Z6uQU7tmyLGqZRO+/IfkKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WV+5SHaxmY6b2D7io3L4CFbjy9KbSxh4IQdjpop3YnpPpvAG
	q7Xq4107t+enegFwYSSuL6/HeW5/2qneuuOI4sVuHevrBSaitvwd5ZOn/d+JneXIeKsfRhkwUgk
	jahWzTbT/qPNQZODRGb3uZZ7Vg1CR95s=
X-Received: by 2002:ac2:4e10:0:b0:5a4:6f5:6c4e with SMTP id
 2adb3069b0e04-5a8f39c5f4bmr554701e87.19.1778657786283; Wed, 13 May 2026
 00:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513061338.9348-1-hardikprakash.official@gmail.com> <20260513061338.9348-2-hardikprakash.official@gmail.com>
In-Reply-To: <20260513061338.9348-2-hardikprakash.official@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 13 May 2026 09:36:14 +0200
X-Gmail-Original-Message-ID: <CAD++jL=vG4fO_30jLF1GrwDsfYVH=odMQV0xD4OX2cuqSmb+Bw@mail.gmail.com>
X-Gm-Features: AVHnY4JVEsXYloe7nVkhuKP3kiNaHShoTMM0NI9LbGDzes7tcrop1eWqa0XxReU
Message-ID: <CAD++jL=vG4fO_30jLF1GrwDsfYVH=odMQV0xD4OX2cuqSmb+Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl-amd: enable IRQ for WACF2200 touchscreen on
 Lenovo Yoga 7 14AGP11
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linus.walleij@linaro.org, wsa@kernel.org, andriy.shevchenko@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 8:14=E2=80=AFAM Hardik Prakash
<hardikprakash.official@gmail.com> wrote:

> On Lenovo Yoga 7 14AGP11 (83TD), the WACF2200 touchscreen controller
> is wired via I2C2 (AMDI0010:02) with its interrupt on GPIO pin 157
> (confirmed via ACPI _CRS GpioInt decode). After amd_gpio_irq_init()
> clears all GPIO interrupts at boot, pin 157 is never re-enabled,
> preventing the touchscreen from signalling the driver.
>
> Windows keeps GPIO 157 INTERRUPT_ENABLE (bit 11) and INTERRUPT_MASK
> (bit 12) set after initialisation. Add a DMI quirk to restore these
> bits after amd_gpio_irq_init() on this hardware.
>
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> Assisted-by: Claude:claude-sonnet-4-6
> Assisted-by: GPT-Codex:gpt-5.2-codex

You forgot to carry over Andy's ACK!

I see that the only real change was the addition of the two AI tags so I
just added these to the commit already in my tree.

Yours,
Linus Walleij
