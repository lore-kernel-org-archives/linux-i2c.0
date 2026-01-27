Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6532D9EE4
	for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507173; cv=none; b=kasA+w6uFFzr/+jVU3AHMhz/CIIAJVMDAtEEIHC0Tku2r1OUzTO8oWnsR4GiCr5srFQskgTm98dF8xS5KoEPIAKCQwC0B28PGc0ujmiVgskM5L8MMWsLZalW9TGxjb5y1//DoiVStH97tpvCKjLZwWh8mnr/q/nQ0/UiXPKq/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507173; c=relaxed/simple;
	bh=SpwD5941uhefrbZg3fBPLX/14WZZ+dwxh4A2/dRc4hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uslxY6tLL3vxXnyDu4rnbImgT4TUcwja5qF0F6YTEsEUc22D+tJMocrap6fnNHRDTtOgQSsrbGTuyffQRAhC2Fve9ZS8oFZsfB/nybeFVT0BlePPEGuoDhI0L/p2m+38j1PAIniO8s1yKA92T6DAwSC6AiNjIMGUqzKpPl66OtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYpEjJGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYpEjJGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355E0C2BC87
	for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769507173;
	bh=SpwD5941uhefrbZg3fBPLX/14WZZ+dwxh4A2/dRc4hs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GYpEjJGLnMI+1qmqsDYvrrE7EWnT0j4iYAUQmMj5vNdXpnU3Pz1IqYC1xXif1Gy2C
	 +FDeeoxxr3SKS0zseHK7iVsf6/VIhFZ8yXu2eJFzTrz37pUlslKnC2EUktO3x8fDfz
	 39pnTgakZO/O3/b1lFwkfHKBVWCU5hl6AMKdM+fb+tPKuqJfUHJwlsnQ4fZhYG2c5s
	 hMUkKCMB9ekpMEf2C24Z92BOAlmxTnKB8kcB2mSjC6U6sAKZGFzBu/0zoGXm5GFAV8
	 Vdz0wslgAQX9dpIcnhwZsbbGd1KMfJfVEEb6WrtoSriZy3TvZ5eO+V97kY1BmrOSMo
	 KPeG0SVAy6vLA==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-649523df010so4867258d50.0
        for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 01:46:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVk5ZZHcLKxU+qAdlrUxn9omRM6/LfQDB7gzbgWczRol2uUXxGjcc4L/7qY1bnJQ30cAp3e2P6ecnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDMyOoi/1dlj9ow+M9CH/l6a7HFkQ3HukByakKB9eOWvZCHDR
	/2hwiWSiv4F/I2dvjp3HyVkaUWNe7u5XsVKf0AsqVkHvi8mhIP7hNnBHMhA+Qo0Gywj5Z0XcQj9
	G89ZI/F2MLfWGxBj0kVa+9nJMMyx0PlY=
X-Received: by 2002:a05:690e:1384:b0:649:44ac:cc01 with SMTP id
 956f58d0204a3-6498fc461f6mr630414d50.55.1769507172501; Tue, 27 Jan 2026
 01:46:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD++jLmGMWjCD0gUcaJPuK0UzJa7nX1bdoVu-BA7aHAgcLTSpg@mail.gmail.com>
 <20260125195123.248798-1-jie.i.li@nokia.com> <20260125195123.248798-2-jie.i.li@nokia.com>
In-Reply-To: <20260125195123.248798-2-jie.i.li@nokia.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 27 Jan 2026 10:46:01 +0100
X-Gmail-Original-Message-ID: <CAD++jLmFAKhhjtQQ1GHrV+RBa8MBtw9q=OdbVx2Vnoji6-ESqA@mail.gmail.com>
X-Gm-Features: AZwV_Qg-YM7xFzk5kIoWtva2VIeoFubXD2ozCIwkKSCML81e_RaP4cAgkH1WuiY
Message-ID: <CAD++jLmFAKhhjtQQ1GHrV+RBa8MBtw9q=OdbVx2Vnoji6-ESqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: add gpiod_is_single_ended() helper
To: Jie Li <lj29312931@gmail.com>
Cc: wsa@kernel.org, linus.walleij@linaro.org, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Li <jie.i.li@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 8:51=E2=80=AFPM Jie Li <lj29312931@gmail.com> wrote=
:

> The direction of a single-ended (open-drain or open-source) GPIO line
> cannot always be reliably determined by reading hardware registers.
> In true open-drain implementations, the "high" state is achieved by
> entering a high-impedance mode, which many hardware controllers report
> as "input" even if the software intends to use it as an output.
>
> This creates issues for consumer drivers (like I2C) that rely on
> gpiod_get_direction() to decide if a line can be driven.
>
> Introduce gpiod_is_single_ended() to allow consumers to check the
> software configuration (GPIO_FLAG_OPEN_DRAIN/GPIO_FLAG_OPEN_SOURCE) of
> a descriptor. This provides a robust way to identify lines that are
> capable of being driven, regardless of their instantaneous hardware state=
.
>
> Signed-off-by: Jie Li <jie.i.li@nokia.com>

This makes sense!

> +/**
> + * gpiod_is_single_ended - check if the GPIO is configured as single-end=
ed
> + * @desc: the GPIO descriptor to check
> + *
> + * Returns true if the GPIO is configured as either Open Drain or Open S=
ource.
> + * In these modes, the direction of the line cannot always be reliably
> + * determined by reading hardware registers, as the "off" state (High-Z)
> + * is physically indistinguishable from an input state.
> + */
> +int gpiod_is_single_ended(struct gpio_desc *desc)

Switch to bool
bool gpiod_is_single_ended(struct gpio_desc *desc)

> +{
> +       if (!desc)
> +               return 0;

return false;

> +
> +       if (test_bit(GPIOD_FLAG_OPEN_DRAIN, &desc->flags) ||
> +               test_bit(GPIOD_FLAG_OPEN_SOURCE, &desc->flags))
> +               return 1;

return true;

> +
> +       return 0;

return false;


> +static inline int gpiod_is_single_ended(struct gpio_desc *desc)
> +{
> +       return 0;
> +}

bool

return false;

Yours,
Linus Walleij
