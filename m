Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A13AE718
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534871; cv=none; b=GvurUux1z7io3td+sM3X6RPX5EuBYRW5O0/GUHMD4fZ24Y+I5GGQEuFs+rMvKe6kZtfMtgOHlJbtN4J0Kj5qC3KK4JTqqq7YZbsliOMbZg0Y/k8PNk1wzpDegC+ziKRnhwDbXPQjkeXQUTcJZoGkFMQ9e5NvecUChYecgpZHs8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534871; c=relaxed/simple;
	bh=mIiNQVt32TbIzXjPkcKOGw1Op6h963v7kdv0XZteIp4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a29bg7aeZJKbdkAr4pC7khdxCU3Md1UrFKak2LGHo8897pP25iFQeBaNs/OJf3kekoAJMetoSbaWHUctGU5f/2sje446/o4RG1nFYwOP4TOF6l67sEkxP87/kuqceT2OFsj9Jz37mTJqZpo0ePmZd3k30W8N1uTJewaCpyrSDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ays22GfR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ays22GfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F091F00A3F
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784534870;
	bh=fENncw0yTLVITUCnuGhw1WpfIualew5DWwVEidQ1gw0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Ays22GfRrcDN3V98PU0mGMFSmgUhqAgm5V8M63mOJ919E9J2hFkuui4/TsG1Ji6qF
	 8qcBI1uPrjXgesqPTln2XVRlnynzSED2Okc3OcFAEmjz+MK5WUzdQyZVF6YfoHNOa9
	 U/kHnhmYd8Y0EfOHwfppzp+OFa1JZHfTCkdFXwk4Bgl589l8dpQDG7BL5qsGNA48gw
	 XJ79ciImZWdWX2rMJe0Mwi4FloMLiLrnaYzJJgI22uU2YqSE4Bt4aZXuH9b4BrZPvp
	 krakjCxdkrnHy0HIsMh8SxtE1sLtXM/QkhMpgJdxy81xmasr4fZijS19MCFyVsAPvU
	 45l8FQjoYDyRA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c94d4fdb9so51877501fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 01:07:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzmcy/ltUX50imrkV2nGZcb9BxvPPFx0TajHLRTFtwcDVNWU+vi
	BfCd/rHXw9+SartkmLMnUKmqt5HNx1bIYB5wOjYVjgiY3f78eBs6e404apbx5a+twsnAxJoO5/g
	TfWqpPPC2/RnGPPh32dnCJ2VtPI2MdyH9ehOAQdmzSQ==
X-Received: by 2002:a05:651c:897:b0:38a:5bf2:80d6 with SMTP id
 38308e7fff4ca-39eb275e5dfmr20802651fa.5.1784534868780; Mon, 20 Jul 2026
 01:07:48 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 01:07:47 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 01:07:47 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260718054330.8975-2-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
Date: Mon, 20 Jul 2026 01:07:47 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdXGeCiaR4DnXT-jor0uh1EUJhXhmPrmkbMbQ-L35fGig@mail.gmail.com>
X-Gm-Features: AUfX_my3uX3rXq1Rbhan22z4FKLCJxPd2yLqXxSV3ZXgWl4R05HnU-7DcW1Aybg
Message-ID: <CAMRc=MdXGeCiaR4DnXT-jor0uh1EUJhXhmPrmkbMbQ-L35fGig@mail.gmail.com>
Subject: Re: [PATCH v13] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org, 
	chaitanya.kumar.borah@intel.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Jul 2026 07:43:31 +0200, Hardik Prakash
<hardikprakash.official@gmail.com> said:
> I2C controllers may have child devices with GpioInt resources that
> depend on GPIO controllers being fully initialized. If the I2C
> controller probes and enumerates children before the referenced GPIO
> controller has completed probe, GPIO interrupts may not be properly
> configured, leading to device failures.
>
> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> fail with lost arbitration errors:
>
>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>   2.348157  lost arbitration
>
> Add a dependency check that walks ACPI child devices and defers probe
> until any referenced GPIO controller is bound.
>
> Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> Assisted-by: Claude:claude-sonnet-5
> Assisted-by: DeepSeek:deepseek-v4-pro
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
