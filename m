Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C33D1A86
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657630; cv=none; b=jHH1CLRXVIca/EZh9lTsRmm9zvZieKVhGSLaO9xReqedfQWOCIVKKzaM9FhYGCNK0vKQgGqtUOMhcDpmvDfICcNfsEgY2LsHr58Ox6yHin0XtPy0CAPDLWi907cdKOE8bh/7uZHdwr3NJJ9sujKelFjJxeMc0Vt7/++znvX4xWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657630; c=relaxed/simple;
	bh=Ijd/gSE0b2T0jw3EuQM4uYtgoWg2GppWrAZF8jwUcvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3iyOlETDJ/3zGglFIPHT8TFwMvxfsCeWzIZM/JDclIc06ZOqkImvkox8JVQJnPeP2AG1K5KP+8WQp0Uu6icTDAZX186nypGoD5EiG0zSff2PnsWnzEflFJBZeeW8FCfgKuyqJpkiR7+vXu5W++BPkfUrgWoBW1KXrBtvfUjAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5bkXS9+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5bkXS9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE885C2BCFC
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778657630;
	bh=Ijd/gSE0b2T0jw3EuQM4uYtgoWg2GppWrAZF8jwUcvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q5bkXS9+KMDF3rxNQeqLI0lcn9kK6zvj8bruGREtL9tK3VYPzLrxdJu6JUf0X+KCL
	 34oh0OIn37B/nacf0h/KapZbC7oFokvO5eZUUWC+wKHq/FkYie9Eqt/r4LFbjxT76D
	 y/QeHPJEZsCbl4OEOnIUVcj3A6Heb97gxr5p0sYz5bYHG62KBBJXRtryOfwqn0oSkC
	 HwnBQrXi/rJFiIte3Gr96Vj4+uR4ABQKW7zNmx8I0cfLjJkBOtxgY1chP7aBIciQ9i
	 e0PhQqd/yiu9Jv70vtdbJ63x2ybEEtUAtqq0MLFWJpGe50BppE9qxWrZdNd6roHJE3
	 yLqvOoghTLySA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8891f0c51so6064127e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 00:33:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+qtc61Xq1CSkJadinZz79r3S197PKjRICP6GC+eNjPWY3ZTyEJ8kPoHwTc7XIakSavn+YrSdJt8n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5k79Ea2tn+rpfBByb61XQynPmLYPbDM/LcClT59O3gtmXSvY
	BeEsdrnbn4cy9eunzFityOHZeXeKiXxj7C5REQGSjn/cu06KS2e9l3HRmf7XxC9NJwH8XIAthL6
	/FY8TY22oWKD/Q7JZ6S2ZBod7MfoZF/s=
X-Received: by 2002:a05:6512:1381:b0:5a4:1914:bae3 with SMTP id
 2adb3069b0e04-5a8f39c57f6mr505818e87.27.1778657628631; Wed, 13 May 2026
 00:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512073139.16343-1-hardikprakash.official@gmail.com> <20260512073139.16343-2-hardikprakash.official@gmail.com>
In-Reply-To: <20260512073139.16343-2-hardikprakash.official@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 13 May 2026 09:33:37 +0200
X-Gmail-Original-Message-ID: <CAD++jL=WHSkEEQ7Re-cUd1DyxiTcY5nWcgCZNoLXzCNR3a6__w@mail.gmail.com>
X-Gm-Features: AVHnY4I7enQ-ebICTz1gL9CcjQuVuy3DErs9Xji14SuYzx5B-COKVxCI9xul0vE
Message-ID: <CAD++jL=WHSkEEQ7Re-cUd1DyxiTcY5nWcgCZNoLXzCNR3a6__w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl-amd: enable IRQ for WACF2200 touchscreen on
 Lenovo Yoga 7 14AGP11
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linus.walleij@linaro.org, wsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 9:32=E2=80=AFAM Hardik Prakash
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

This patch 1/2 applied to the pinctrl fixes for v7.1.

Thanks Hardik & Andy!

Yours,
Linus Walleij
