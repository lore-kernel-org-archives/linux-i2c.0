Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500923DF00E
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877500; cv=none; b=ZEw9cB71Ye0484xoUt7qQp/3VKte8ROe9o+EHaCAdSDNq33sEsRzr1b+4OdfuD/iWIW3tTKzoGtb9Fk3xwvtW1uTGeMxTdg6qR+wMGfqF0wlpOtB+yUV6EnWmrB/VesS61EEUOtOEjXBb7EiCEJ3+EtT49HvNtGkiROtCr4uo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877500; c=relaxed/simple;
	bh=54Vut8yEUPqwoDxtfS6e/+CRmN6rV6D4iOKfCHrDefM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+a5omIm84tDdbEehCkmc7CjntQcuQvB+Z3og24oJcdzidhyjw6mh06p8RnTNO7Vc3rf0EyFQuuHPM92lSCVbcABii4wAfU9dIVv6v7EJL/jkptg4CyrZeR8Z2v9eeigoaOLhnTjpFHMhVNMIzSGdCtmM54LUl+0UBAtiTanIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiQnfptP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiQnfptP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036501F00A3A
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 10:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877499;
	bh=PhjmxFjwwCN9mtL0tweSuVfQWxjCoorbOogxFYHAm6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fiQnfptPOhWQF4VrktqLigvY3/5wu+QuTdnXVssp/5NGyJeTZq/O4Fj9Ij+Fq3OfT
	 iE/JdEjaaBFqhrhJqv37ovl0nASlhBOmMmZi6jqCigYW9SIs2ExwYnfy4njIgDktAf
	 uz8FCmh8yyvranRiyV9OZZDqyiGdggBIys9dc6eiZOmG9sa7dtaU1mJRo8wG1wnvLa
	 phn23ZAya5dck2djyhgHKn4dPHP1AbMFQe6LM3Ve8WxjEExEFbAiorbNgpuN60uCds
	 3eJopsetYpIk2zwBKWs7WZUiSTBc+KVNPGEXTTm4xig0Zu9cMJDypYqrUHgilBaQ/F
	 Rukc/2+AEs1gw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa4b50e054so637815e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 03:24:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+WEtuSTOMq9/Me+jwn9AiP8L7tV6aMAAQ8q438H9vN5GJgr2W7i6WkFQc5V4MyujxUwLUtOV3sKxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMvNAUsO1m0uDIxFnTCh6dp9BG9CVzYeunhevmqROfjvhIVsj
	/fM0dlL4DJ0aTPu5UdkYYPHgRUy3YkHdnLSjK6SKLmRc4kyiDnvzCwMTRFXn89uxH2GXos6LyMh
	2U18FD4euE0GjXV0ad/KBqNOGqmAQWnU=
X-Received: by 2002:a05:6512:66c6:20b0:5a8:fbe0:bc59 with SMTP id
 2adb3069b0e04-5aa323713femr5083827e87.26.1779877497800; Wed, 27 May 2026
 03:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520173129.1382489-1-markus.stockhausen@gmx.de> <CAMRc=Mf6EQDF-fSVb+jhmLvMUi2eJ5QhukKC08S-T12HKinibw@mail.gmail.com>
In-Reply-To: <CAMRc=Mf6EQDF-fSVb+jhmLvMUi2eJ5QhukKC08S-T12HKinibw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 27 May 2026 12:24:44 +0200
X-Gmail-Original-Message-ID: <CAD++jL=d9e5HiR=JtwNjiDy-ihq-kzPo+1JtxH4Mwm+LZ6CG5A@mail.gmail.com>
X-Gm-Features: AVHnY4KsezWlZhA89NKwYqbOlKvs0VxGBAW0VxlCJY7vE6O64KDdhO6fPwFE_8A
Message-ID: <CAD++jL=d9e5HiR=JtwNjiDy-ihq-kzPo+1JtxH4Mwm+LZ6CG5A@mail.gmail.com>
Subject: Re: [PATCH v3] i2c: i2c-gpio: Enhance driver for buses with shared SCL
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, wsa+renesas@sang-engineering.com, 
	andi.shyti@kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:59=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:

> >  /*
> >   * Toggle SDA by changing the output value of the pin. This is only
> >   * valid for pins configured as open drain (i.e. setting the value
> > @@ -53,7 +72,7 @@ static void i2c_gpio_setscl_val(void *data, int state=
)
> >  {
> >         struct i2c_gpio_private_data *priv =3D data;
> >
> > -       gpiod_set_value_cansleep(priv->scl, state);
> > +       gpiod_set_value_cansleep(priv->scl->gpio, state);
>
> That one bothers me a bit. We're driving a clock line but may end up
> sleeping? That doesn't sound right. We typically do:
>
> setscl();
> udelay();
>
> I know it's been like this before and maybe I'm not understanding the
> whole picture so feel free to disregard the comment.

I think there are people driving I2C on slow buses, i.e. a bit-banged
GPIO I2C on a GPIO expander which is itself on I2C.

I'm not saying such hardware design is a good idea, but I think
I've seen it...

The only way to make that work is to use gpiod_set_value_cansleep().

Yours,
Linus Walleij
