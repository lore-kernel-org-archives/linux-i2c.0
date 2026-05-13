Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649BB2C032C
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679440; cv=none; b=mTsfOXzNdE/GY3HGc6bvkspsq5YycJ2yurQbw1WyKUBMkD+i8pD4GSd9lEaHG69n4xLcaUdrHx+s6XmOsoXO0jQ6LNhHlBme1+1gAciNMwZb/ALFRo/57FP3YW6C7u3uBsSoiW3dW1Xq8BrVyX/pf0dLOgSNjNaKsmv1F+pcL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679440; c=relaxed/simple;
	bh=K2K0ZIDmDouzIYjOgQrDHa+obDFg7JDm6ArC3vxrn58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk5rTkj3rQIJW0j0eVTSOZKiHXsA5lKiqmqPooicVVv9sFRssEJ25Ex3N8RtKlxcG3DqahYFEPaMaOD7h0WjckAg2zocI2bJRFrVanfAlxRr3iUWSkpgT3iU8zP7Dp6W1euPuUFizy0P2eh/6KLqLEwGt5ESCVk/So0qITG8u4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1mkykF1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1mkykF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BF0C2BCB8
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778679440;
	bh=K2K0ZIDmDouzIYjOgQrDHa+obDFg7JDm6ArC3vxrn58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p1mkykF10sGMcnkI4zGd8+MrvAv07Rpfsg7wnzLYvADPoJxCSZcVKZ9hfsZPAbdOp
	 aOaS0+HYEjjm72bGvt/08o4tg553smMoX86Y4IvYRTHuZ/waEgOET7tXGYrim4xjGF
	 UJ9OYJBBNoiA7jvVe0ToHrH+vm3y4zcYzu6Z3EweI/SQ40ntFkFWgfZ1Pkhf/2anmw
	 BNJR2+sA/h4iaJximBT7QNEOJcIsxDk3/MH0EIM1Uyu1dTSTb4V55q070M/zmHtXPE
	 ncEgoJAMZLZu4Zlv8tSxCDfDOJP4NFgrYEug+dUn/HiK8HAynR4zVOxmGaR4p/exiW
	 hvrfa13vSpqBQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso6759553e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 06:37:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8vHKcPHg8RbW6+oqsE9Wv3Cpt5DnOHPyNtYbpCwJ8/ZpmhKMCxSF8ATVSxHy1gv0ELQ/l3RsyOzKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHukA8b/NllIq5nlVHpArcMdvDs778HjAlJeW7/C8kUykmai/h
	Koyp0H70bMIHRR33Dx/VglFFXzYqEfXsjQnkt9vUZU2kT9OxGIfImI8gIPuiIj9+n0PKNlZEmHi
	rXaF8ZepQG8r/AiqhOsSZSdHBJapyJXAmAvlZcVG8rg==
X-Received: by 2002:a05:6512:224b:b0:5a8:b8bf:f742 with SMTP id
 2adb3069b0e04-5a8ef987a62mr1294266e87.20.1778679438834; Wed, 13 May 2026
 06:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513123758.4955-1-chaitanya.msabnis@gmail.com>
In-Reply-To: <20260513123758.4955-1-chaitanya.msabnis@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 13 May 2026 15:37:06 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mc=kcWv1Eo=Z5j8C+O49skeLfsBOB+rEZBF=Gy-VwLC4w@mail.gmail.com>
X-Gm-Features: AVHnY4IFyN40KMvyDcVQAeiIe3pL67V2UuNqra_cNWQHkSdc-tBvVbPq0awIgIc
Message-ID: <CAMRc=Mc=kcWv1Eo=Z5j8C+O49skeLfsBOB+rEZBF=Gy-VwLC4w@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: i2c: convert davinci i2c to dt-schema
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, bartosz.golaszewski@oss.qualcomm.com, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 2:38=E2=80=AFPM Chaitanya Sabnis
<chaitanya.msabnis@gmail.com> wrote:
>
> Convert the Texas Instruments DaVinci and Keystone I2C controller
> bindings from legacy text format to modern dt-schema (YAML).
>
> During the conversion, the `interrupts` property was made required
> to match the strict requirement in the driver probe function. The
> custom `ti,has-pfunc` and `power-domains` properties were also
> properly defined to match SoC-specific hardware features.
>
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---

I left my Ack under v3. Please keep tags when resending.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
