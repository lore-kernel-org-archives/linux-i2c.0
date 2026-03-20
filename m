Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1053C0637
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015271; cv=none; b=rxw6Z1YWgdpeWbc915VdsZIdkIR13eRbgQ7tGjDJDyAgE7aE6wbaukHjHwR95v0RzIkp5vMFaC1JGHNksfKuzMYM3vDihYrRLfeh5vbXAr9mYl3PsTLM6XQiRCSqIwPk9pWrLQYsOSKVfNRTQiE7clG/xumlLAstNPG5w0Tbggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015271; c=relaxed/simple;
	bh=Nx8bQBs95SJZiGV9sxDUOjb6cqnHHMShwIEg031kToo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SR7QgqnOIvBgU+lV64K+Zy39IVsVnl7cL3cDaGV4K+HEnzrh6FdxaBAQl7JHC+F/iHp1B+BMcwqmVFYGLWhrFGPcURoDYKO46rvWjE4C8pwnf76EYmqCTibD6XHb9iBMY9JuUUQ+6u1+IW8Kihh55lG7TCYnXnvm3TTFDIPM5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-46726528f1cso1464812b6e.0
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 07:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015267; x=1774620067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txsLO2jkdNhN6oBkuArfXNgiBSygoSMNA3GUMB3p1q0=;
        b=S5i0YRjWUrrhBihkSYLAHvaWmKrRP97WLDyGWHWL8Xpm8lGr/r+zKxNzMG2vvfBSXM
         sbq2qTU8p97dCn9z3fyPvBRTmgG/LrdEIEYLviTbfU2oRV9xVcEf+Tn7GlhDuG3aBxD2
         q3fX9C7LjCP2GP/HsvypLu9vsDrVC9lPjjTS8DqrqbSV2baj2Id1MKPTnWuFWFrMqr9D
         Rfa1iZzHZgbO3O19jJ9iFwG24tu45qJFWwyynb8P0eUDwQXxBaqdEqAIi2KFPUN4mS8m
         NWFW3b6dngPi68Lzm65zccjANUlCljVNvjBIJseBTQD8MOOUJ9efRJHq8R2uFNz0v+co
         dmdw==
X-Forwarded-Encrypted: i=1; AJvYcCVqnwAIvLlf4epxPpJgZ44H7XtyXVlKQhoax848YOkMKHv4YzMHV/TaYQtX+1/aCRWRmgrLM6+dRDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNz21iMST5FylR8fd9NvtFxsQDFEf1GmCbE5KyS+3zh3fHBHL
	SCFbUnNEO0Y0a7pLJwI8VYS12Xj64rY6c6xVppHqaq44NS4OlFK5z6FEty90n+uZ
X-Gm-Gg: ATEYQzwhvVXQH6pKqG/UKYSQ5E6V/Em3RLWGumFIWaj60HQYGXz3vyM+F0Qvf7E7B+p
	MTcwaYRtnrkq9Jm2FyKHQAfvP1foh2ze+eW8vgFCG8h39Xdcq+xRDHh3qJ2cueRvqlqD9Sq25Jt
	sp95WobaVgPFC5vl3M7Kvuw8suE+knBj6xPr8lLYnMwoF0wFgENJWP7BIY6JmcM7ymTqdZDody1
	GMQ9CmvhGwRB994dlpNGIW6bLM3FekYQPEXauT1Bb5cUR7pBIMn8w1FvIEZOt5EVyiFDMHfKEfQ
	27lAGLIoMDjXaWYFVqwLKCXU7d/5Mek8a5El0yq+AxNqR2YSLdPe322ckUOBMTlOatwl7zZXsSy
	gTWJe7NRsPS+Vnw+52QEDpJ3OgtkekxPhta0zHvIoAR7TOZ5vQGVOAPbzW8JK2jWTapw593gCVf
	OCqXPp5pfhOZ3mjJusEdbQA9WpuF160oJxtedGfPPHXjX8CBvxPlNvU5152pG4zOx81f9j95M1Q
	lNQQ4UjjObylO8WWJmF1J59disUobSkYpsqouawHWlvbmGtehouu6lrHWGmiN5fdeUXv8Actg==
X-Received: by 2002:a05:6808:f94:b0:467:db7f:ab97 with SMTP id 5614622812f47-467e5dbf1efmr1677373b6e.22.1774015264791;
        Fri, 20 Mar 2026 07:01:04 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d1a68fsm1353903b6e.3.2026.03.20.07.01.03
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:01:03 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d7851e2cc4so1880859a34.3
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 07:01:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVL0iA7lVLeBdoPLwdg5vxsXGPXhho6T/zhKSI7MgIoKklkv7sy0DNpCS9MwGm6GRFT0FczlfbaKWk=@vger.kernel.org
X-Received: by 2002:a05:6830:67c5:b0:7d7:d15a:ce8e with SMTP id
 46e09a7af769-7d7eb04feffmr2015751a34.32.1774015263260; Fri, 20 Mar 2026
 07:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 20 Mar 2026 10:00:26 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9b1VujkHCVdXowQs+BXA0+DL=6sdoP0wuSYpau4T31XQ@mail.gmail.com>
X-Gm-Features: AaiRm53Q86Nf9dVOSTKn0cYEE4xmDvp3jUYoCfYFj-SX9hFNk_weUYFVfwHr6Ok
Message-ID: <CAEg-Je9b1VujkHCVdXowQs+BXA0+DL=6sdoP0wuSYpau4T31XQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Initial Apple silicon M3 device trees and dt-bindings
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:23=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> Hej,
>
> This series adds initial device trees for M3 Apple silicon devices. The
> device trees contain only a minimal set of hardware not going much
> beyond the minimum required for booting kernel and initramfs and
> verify via serial console that the hardware and drivers work.
> The hardware with the exception of the interrupt controller is
> compatible with the M1 and M2 SoCs and the existing drivers.
> Changes for the interrupt controller were sent separately in [1] and are
> picked up and in linux-next. The device trees pass make dtbs_check with
> the apple,aic2 dt-bindings change from that series.
>
> Link: https://lore.kernel.org/asahi/20260223-irq-apple-aic3-v3-0-2b732807=
6b8d@jannau.net/ [1]
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (9):
>       dt-bindings: arm: cpus: Add Apple M3 CPU core compatibles
>       dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible
>       dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
>       dt-bindings: watchdog: apple,wdt: Add t8122 compatible
>       dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
>       dt-bindings: i2c: apple,i2c: Add t8122 compatible
>       dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
>       dt-bindings: arm: apple: Add M3 based devices
>       arm64: dts: apple: Initial t8122 (M3) device trees
>
>  Documentation/devicetree/bindings/arm/apple.yaml   |   18 +
>  .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    4 +-
>  Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
>  .../devicetree/bindings/i2c/apple,i2c.yaml         |    4 +-
>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    4 +-
>  .../bindings/power/apple,pmgr-pwrstate.yaml        |    4 +-
>  .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
>  .../devicetree/bindings/watchdog/apple,wdt.yaml    |    4 +-
>  arch/arm64/boot/dts/apple/Makefile                 |    5 +
>  arch/arm64/boot/dts/apple/t8122-j433.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j434.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j504.dts           |   37 +
>  arch/arm64/boot/dts/apple/t8122-j613.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-j615.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-jxxx.dtsi          |   48 +
>  arch/arm64/boot/dts/apple/t8122-pmgr.dtsi          | 1149 ++++++++++++++=
++++++
>  arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi     |   32 +
>  arch/arm64/boot/dts/apple/t8122.dtsi               |  444 ++++++++
>  18 files changed, 1859 insertions(+), 5 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260319-apple-m3-initial-devicetrees-5c546ad977a2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
