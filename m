Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28015366064
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631069; cv=pass; b=b1f4DzWkRMHYZvw/jPayXs/F+XjtJlV1vj+HN9SbCvBgKGHPrZ0+9KgxzytglLIKmVpyTw6yaRNI/BVK4bEdNG0po8PRgB8wqPMcj/FtNon6jKL8B+sfg3n9XcfLCOIBPQdJp+QkzHEwPAKiARAf2bQGrk2uaqP5azoi6RqLJM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631069; c=relaxed/simple;
	bh=bC10K83OlDdfvr2htwpjLlKwvpR995Jtaa8b2VaNWRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjUke2LAvMPXZjEUzngqXNcMYZOlbM1hl/V7uP1czWy1fz5bKdO0ovQacjfUN9CEctxLAySjqDXhf2TzcKLqGrd8x1A+ias3v7mpwj4CU10oUbhvrqpfKOtqagRPr2TwwfAMmq9vGUiy2g3YFA0iDFp8EUIznuFQdfq6cORjSeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHe4hmOl; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHe4hmOl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dd3e979ceso3172510e87.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 01:57:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770631065; cv=none;
        d=google.com; s=arc-20240605;
        b=EDxmahi7Dv/6ciuPO1jhSOPbMMV7sIcaS2bpJPNLsfyn9eOHRtYxnu3Hu2FxY2elWR
         oZFSGdasUJWatsQSB0OGYJponAUfJovNymY5kYD9A0K/W5oHW8dxOynCqgR58WLJTfjO
         yBtd9qtktFhlMte8jYhfTXkWYFyQN0rDz8exQHLrGLMZzHbMJNi8I+GnonTJo6ADZSCQ
         06q8IoDDcK1YzN/nGJwWzksL/LdApPsWVMLKkN9/1hBp8mavd0SgPCwBppu7jcLEggE5
         FlW9o6hFjKHMxx5NSzvvi/T1d51LHrxxPddCgOruFDY2Xhc/hSEUn0MMnVvvM1k4VKyM
         N/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        fh=JClkvQqZJy0TYbGygllT2vCpan9p7HL2JOhSrAAHdO8=;
        b=G2JkSCwkEKW4cfnS96+o4zS7CS0aUY3NzTlBa/QMPbS5H4DPNWUsV6r3P717lHu5Bn
         lJjkCsCmckAwhmxtprCu7Q4W0hQbtFy0gM4h2JkEez9RcrSA1yA0AOfb+J5TwMmemHFM
         eCXvtO12lUECLr6ou2FQlnO/wlZbZJ0grAKrihNCo78lL3e2VdhVgE3oN5RU6Qsrkadh
         6r1uWRRfeYHAoDDP3ReHU69jCYGzYmeOMv0MIOi4W4r2Q3ET6AJqgFclvN+8865sZMby
         FVvIi7M5r6uyv5FqqhCSYhfnhKgmRb65AKIyr0Hc6j1Lg8JK2fwkMhsG1+o73Bob4Wzl
         kPuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770631065; x=1771235865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        b=IHe4hmOl9w7pUpUQyLkq/OgztYofxuV5/j5kZqVf8IuLW8jsfSkKju7oFLOuFmO+Ok
         OuFB7tI5XhFwXmudwca2G0nYRBQ7eEr59JH2p9nQqOTDdW7Y2gLLMsCnKuWV4LpK8sMg
         QEhJgWugZkGH8AlPG3KIjl+KmD0zJUnuheHF85f1h7T24sKIswi0tGubJyQrgfXVOHcH
         068szk1RA7QB0OCEWzd4kP3VEp4dtKPFLkidYA4mXBpOOysC+6s4HXG+8zne7P8+mUJC
         0JfCkcMfokYv8neInNUS7ZSf0KHQvK4NmCQEumO+4rTfN36qUquObsdAu9osKWCZSwzx
         gwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770631065; x=1771235865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        b=rs6+TnLsb3lI3Lts2o3N3p5FFGLpaIUPgo05GsU/GrvV0uteO279LMHtH3zw4+wEzS
         5V0DINsBAtmMh+7cTBbEVlBOAcSYrKN+HXTHo/bezbycAcD2ef/oAeHyxsCe+QPF7X0Y
         bKH2vX2GvaOzUINflzphELJmXD3OtD/ACZM+MlSjb05xPPzFVd1XCWpsg2u9Kcbxu7ZC
         xJTCTnvkYSjT1FSxyqbQEOHFX+Lv1TculQqHMEULlJ3LZRZug/DQh3IIDx46oitAjVuw
         T0b2ncv0sbLJ6jg/9d1gKpzVM+n74/8l5WWxWnw90PSc4bzRlcmDPJrDlxnLFrjfzir+
         tJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUleKvgUi1JN9qifIUbW18N2k/9o9II8wZ478jEFEZEkh/O+tP/XOMgWdSji1qkIC0gtS6kJNFX83k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjTRY/uDSlUAtcDrkDvuz3CdNmTO3CSAYODzhwgZf7zToern2
	bTAN4fVRUZgg1h8wnfoubbupbLoXMEX9p8Pnf1r6pr0YMVVCO0W/hd7HpHgtqPEjoZeM0uMNzJZ
	TuEWiG7BgWzOrqeESE30z/vRQZueg27+HStuYJSlF+g==
X-Gm-Gg: AZuq6aJM6IX92RnI1QYlAwumYiKvsKTtEHL4skJZ5VXhCklHNzZclIaM/dNtj8ioYnR
	a2aSbDwOkzW7Q5wZCLQEx4V6kXoXGAMMIErFZYkyRNUao0cIDdrmkp3N0ywvJQEUFlBs1P0P7Ro
	L5yV3CsgBVhUDMnGlIIRx1OMjqxR9A2G2y6pAi8S+ci8j7V2Xf6LjZ51MewsEdZxKu8tCAjcpoE
	8wclcCdAsjaOAFFA/ezvmuxzrSIhRRDLtKrYNVlC84Nczvze1xTGupFb51bodTTmKxNDmGj
X-Received: by 2002:a05:6512:230e:b0:59e:25a7:e46e with SMTP id
 2adb3069b0e04-59e4517351bmr3165761e87.36.1770631065180; Mon, 09 Feb 2026
 01:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 10:57:09 +0100
X-Gm-Features: AZwV_QjtuvXehDumL81rfo3XecEhBGMIVZdeTW9qGb9n_Rk2fTCxSh0YYaQSYSY
Message-ID: <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:39, Josua Mayer <josua@solid-run.com> wrote:
>
> Some Renesas SoC based boards mux SD and eMMC on a single sdio
> controller, exposing user control by dip switch and software control by
> gpio.
>
> Purpose is to simplify development and provisioning by selecting boot
> media at power-on, and again before starting linux.
>
> Add binding and driver support for linking a (gpio) mux to renesas sdio
> controller.
>
> Introduce generic helper functions for getting managed and selected
> mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v9:
> - compile-tested on x86 with MULTIPLEXER=m/y/unset.
> - fixed Kconfig changes so that CONFIG_MULTIPLEXER can be selected.
>   through menuconfig / .config as intended.
> - updated trailers
> - document null return value for mux_control_get_optional.
> - fix build error for CONFIG_MULTIPLEXER=m, found with x86_64
>   allmodconfig: replaced ifdef ... with if IS_ENABLED(...).
>   (Reported-by: Mark Brown <broonie@kernel.org>)
> - Link to v8: https://lore.kernel.org/r/20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com

[...]

I have already applied for v8 and it's going to be in my pull-request
for v7.0 in a few hours.

Please send incremental fixes on top instead of a new version of the
series, then I can pick them as fixes for v7.0.

Kind regards
Uffe
