Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD639A047
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580258; cv=none; b=IG8vBGWApEOO9y3bPW9A1s1BVqxEyu7XKt3/QbJQpP4EGFCJndCjrA/3kygOVHiwKvVmqb2dqjIzuM0ZYTWvTVsTjI09KFrYuWp38YQxxJ2ON548PfzIAJuIRRIzSOPXRBD5Zrd8Nz3/eSLRQ5F0UCswKEheGnCUaEsLWv0FpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580258; c=relaxed/simple;
	bh=zE1DhYiygNyFm3QVI6cLTKJVk4Hac3RzSWrO1ZXayvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEbpvc3oRfuIhBRtRZy1AP3eQbd0akIxj/cTTcTt95KmPOl7RIskwAXv4sweiulrCIKtaHpBq99By6vOmD8lZMmqFpKyVE26+I1wXfSddy5cOMaZe13a1CzCIf2XTwUX5niOLM4aCD98jShkcXP1E2kqqYNi9cdu1u0sbqJm5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA228nnc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA228nnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE856C2BCF6
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778580258;
	bh=zE1DhYiygNyFm3QVI6cLTKJVk4Hac3RzSWrO1ZXayvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FA228nnchS7UQlQ7jQ8STTKExZvj3vzWOkwTLbuDxjTXXePChFba5jwRMClbLagT3
	 3qyoUCLYA/3+9N0tBE3Kh4fxuRH2e/e4QHgxHgvg3X4KTFqHNzwkDRxKxoHR3bdpYM
	 qh45iLMVWDajyhNM2ad/aFu/VOUX84PwSZ91LLEVI5SbZDAExlMAJ5WeZHzZYVxD9c
	 ANSzaoAczRZWfM3mx3PhTcCMdha7CEUBDk5BVPQhNh3Ko5mihmJvlgJF/+5ZcibY/M
	 IaFjeASaik0Z2NCPDpatV1VvDgWAP5EuBr+RQmc4p86oI56wPGJf4PJ2idrfEAaB2z
	 5m3aBIORPPVMA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8eb07ec4aso127150e87.2
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 03:04:18 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw812i1M+l2F7yIFcJWQMFU2BTYPUJshAJsFKFQTByEfgjE33Bp
	t+tkoA8+0ab2KDcrnvLWe8zMkMOq4WySc5sbipfozS3R/breG1uHXVtnGdQtMkBOAb5RMCnd/43
	lXEDBi2OtkqAUZ90HBYBjctn676dpnIdxi7P9qMXO+w==
X-Received: by 2002:a05:6512:108f:b0:5a8:96cf:c8c4 with SMTP id
 2adb3069b0e04-5a8e30cf668mr795402e87.15.1778580257464; Tue, 12 May 2026
 03:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163518.51104-1-marex@nabladev.com>
In-Reply-To: <20260511163518.51104-1-marex@nabladev.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 12 May 2026 12:04:05 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
X-Gm-Features: AVHnY4KgBphS4VgppDDA888Al-cOjErya1_Sv0vkbhmtj4bW_rN-b3mm29cOgnU
Message-ID: <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: Mark nWP GPIO as non-exclusive
To: Marek Vasut <marex@nabladev.com>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:35=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> Mark the nWP GPIO as non-exclusive, because there is hardware in the
> field which has multiple AT24 EEPROMs with nWP GPIO line tied to a
> single GPIO. This allows such hardware to be described in DT and the
> nWP GPIO operated via NVMEM force_ro sysfs attribute.
>
> Note that GPIOD_FLAGS_BIT_NONEXCLUSIVE is a deprecated flag and should
> not be used, but thus far there seems to be no replacement.
>

There is a replacement now. It lives under
drivers/gpio/gpiolib-shared.c and drivers/gpio/gpio-shared-proxy.c.
Though the voting mechanism I implemented is hard-coded to drive the
line high if there's at least one consumer sharing the line that votes
high. I'm now thinking that this may be too rigid as yesterday, within
two hours I had two submissions wanting to do it the other way around
- drive the line low if there's at least one consumer that wants it
low.

I'll try to modify the gpio-shared-proxy driver to take into account
the value set when the line is first requested and treat it as the
"default" in the voting mechanism. IOW: when the first user requests
it out-high, we'll drive it low on the first user that votes for low
and drive it high again when the last user drivers it high. This
should work for both the Qualcomm shared GPIOs for audio use-cases and
the WP pin here as well as the SCL recovery shared GPIO we have in
I2C.

With that said: I'd prefer you not set the
GPIOD_FLAGS_BIT_NONEXCLUSIVE and see if you can make gpio-shared-proxy
work for you instead. I'll submit something soon for you to test.

Bart
