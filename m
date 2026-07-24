Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25936606E
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878210; cv=none; b=Qf1Oeev1xnljUt+EYHIog0LtGcZgtX4U0JRYklsuPLp1A6NBofubEaTqM5GR5CWKl3hJWzXBWGZ+PDaJ+vcSquOx4feWnPmCA3Z/Hvz65QlBsjRWEx4aIkqOkLlGbtiv+/e7/CigwQqRyJB27G760+oVNn6L/Wa8H9ui4oxUSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878210; c=relaxed/simple;
	bh=LFb3N34emiH2zLdUMKaoYPDkL+3zCkmvnP6DR0/mi7c=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Znrx+6k8CCp+SQCieuWLgkVOUhyT7Trtba0V78YtfGeaKVE/91D6zsvqklokzzeWwOnI9LW9MWO3DaxWYWA41wtEwPKPbR8Gd/TtASChawRykHL762USJZGC0d0E2Dtaj+MV9kIcch8Yzga2L5tKYMaJVd2Mo3fOcGgc4gtKurs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3znTwdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3znTwdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EA01F000E9
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 07:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784878209;
	bh=l2HnjmDsVL+478h85HttyiaUnc7yfrrCCk7USpLameA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=C3znTwdjOpChjm19xxpv0pQJtwpXmw+pSugpxaTU+3z5j21iWBPPBZfWhQIlBJkOO
	 Hh+CpNjV8CS/dX7JjvK/uHaMhHKow+d166Af77mmbyqu95d8J8WnNKN5ypRpGSuZwv
	 DqEvn6m82V5Dgybhbsi/L3lx/Ep8aEErNlJcTXXsq1sUJ+i94GacK6Icx4f0onKiB9
	 nD4YojDsJK7IPNpAfEwQ9RlnBO1Hy39/1HefFJG/NCA/hIYEoAwFSHJ6APM15aKX6T
	 wTzKwIlMJ5g+OACCQrBGvcku0471aZCVOJIg/s6cGIKaWAknSocYBGgZexDQ5zrtDs
	 HKbTqPTlr3pDg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b015b2d792so140319e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 00:30:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw0cuXcrAIyOzDCsP4p8YH1WxZ0OOcUApIZUeTKI4PY1242FiVs
	AHNURzISaOWGatz9z+/tlWkvoj/TcRxiC3dYF2i97EDqiyx72Tidv3JrRb0nApy8kZklVCLFDO8
	BJXbC6m2fI88Rxic2zirLOFWoSsAOftzxjtUaf0bTIQ==
X-Received: by 2002:ac2:523c:0:b0:5ae:be4b:675e with SMTP id
 2adb3069b0e04-5b2b2f7674dmr825335e87.52.1784878207926; Fri, 24 Jul 2026
 00:30:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:30:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:30:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <46051025-8b50-47de-839a-a901615b8227@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163518.51104-1-marex@nabladev.com> <CAMRc=Mdqxen+8rd-5yR+_cvtFkM=qeAG78uqG+ZHWR3CQsa1Ow@mail.gmail.com>
 <46051025-8b50-47de-839a-a901615b8227@nabladev.com>
Date: Fri, 24 Jul 2026 00:30:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfgsjFO9R3bzSQiWmA6tvHGWcprhWMLSDTMML60-NfhCg@mail.gmail.com>
X-Gm-Features: AUfX_mzd8WKTM6lmvGBY3uGAB91US3MGA7Bv-D0uH2uHQFI0hIb4T6TbrAwo4IE
Message-ID: <CAMRc=MfgsjFO9R3bzSQiWmA6tvHGWcprhWMLSDTMML60-NfhCg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: Mark nWP GPIO as non-exclusive
To: Marek Vasut <marex@nabladev.com>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 21:35:27 +0200, Marek Vasut <marex@nabladev.com> said:
> On 5/12/26 12:04 PM, Bartosz Golaszewski wrote:
>> On Mon, May 11, 2026 at 6:35=E2=80=AFPM Marek Vasut <marex@nabladev.com>=
 wrote:
>>>
>>> Mark the nWP GPIO as non-exclusive, because there is hardware in the
>>> field which has multiple AT24 EEPROMs with nWP GPIO line tied to a
>>> single GPIO. This allows such hardware to be described in DT and the
>>> nWP GPIO operated via NVMEM force_ro sysfs attribute.
>>>
>>> Note that GPIOD_FLAGS_BIT_NONEXCLUSIVE is a deprecated flag and should
>>> not be used, but thus far there seems to be no replacement.
>>>
>>
>> There is a replacement now. It lives under
>> drivers/gpio/gpiolib-shared.c and drivers/gpio/gpio-shared-proxy.c.
>> Though the voting mechanism I implemented is hard-coded to drive the
>> line high if there's at least one consumer sharing the line that votes
>> high. I'm now thinking that this may be too rigid as yesterday, within
>> two hours I had two submissions wanting to do it the other way around
>> - drive the line low if there's at least one consumer that wants it
>> low.
>>
>> I'll try to modify the gpio-shared-proxy driver to take into account
>> the value set when the line is first requested and treat it as the
>> "default" in the voting mechanism. IOW: when the first user requests
>> it out-high, we'll drive it low on the first user that votes for low
>> and drive it high again when the last user drivers it high. This
>> should work for both the Qualcomm shared GPIOs for audio use-cases and
>> the WP pin here as well as the SCL recovery shared GPIO we have in
>> I2C.
>>
>> With that said: I'd prefer you not set the
>> GPIOD_FLAGS_BIT_NONEXCLUSIVE and see if you can make gpio-shared-proxy
>> work for you instead. I'll submit something soon for you to test.
>
> I'm sorry for my late reply, I was completely overwhelmed by emails.
>
> I tried to look into the gpio-shared* , but I couldn't figure out how to
> describe it in DT. Do you have any examples?
>
> Take for example this DT snippet:
>
> gpio: gpio-controller { ... };
>
> i2c {
>    eeprom@0 {
>      wp-gpios =3D <&gpio 0 0>;
>      ...
>    };
>
>    eeprom@1 {
>      wp-gpios =3D <&gpio 0 0>;
>      ...
>    };
> };
>
> I assume there has to be some new glue node between the eeproms and the
> GPIO controller somewhere ?
>
> Thank you for your help !
>

No, this is literally how you do it. If you enable HAVE_SHARED_GPIOs and
DEBUG_GPIO, you should see it being picked up in the kernel log.

Bartosz
