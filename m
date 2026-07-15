Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80172449EB8
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117321; cv=none; b=IZ94wALCYjonGr13k3oGs0AmtzV+biZZVA1G9vc+usJ+86rvmBG7OErmzJB8//Kej8vUyrpoXkwDN9RyNrZYlhUWdOVu6tDbDpKks77WZx/BaFxTdUbU2oUx/+oOibXwzPa48nt6/m1ZQMuGc2Mdb4xP2OJqwlGi0Ql+66ngcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117321; c=relaxed/simple;
	bh=O3D4DuMVlFnowfwB55XmZhgK8QP5M8Jnyw3tCtKzBZE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhGu17E2gy67c6hWihppKhTe57hdcSWAFEsmFcVhmsyKAiJQqsDKw0bThtQc7BOB9GaAoaooelVpt4627bX5YjWSB17/IRDgZG1ejBHe/GeeD2JYKiSLzR+xPQLdVDXHX6tPDZL8MmBB9t6c0vsF+iTA/fajPt1EaizHH92817U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htydiT+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htydiT+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4371F00A3E
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784117317;
	bh=PAbQMU3a4zsk62hRhiYERiZWy5WaKH4uugNgN6vzCrg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=htydiT+oBRyNeK4R/AwGY+qFYk4IT7UVR839fWR3r67TEb37R4AplS0mYG1q+RNuK
	 bZyBEIRamrijZGVGAqxb+hbTOcfACvKPmMn0ZW4MXIlCqxH3bJVG1F7zOCfDiv6u73
	 Zp3e/VXhtebvzy77KsGk6mCY8d6l/17g22VnXIH+4w16D5NxMd/e/6gbbZUZHoJBaE
	 QlN9PaWo4r+DzMOSoX71zFh32NGOjk5HW+y+SY/sJ12ebwLkO42bZDvvyi4DdKM24A
	 kmag4Ujsd9puGy12UBfL95WMmOzGdQd9UHFB7DwMlwzHrKZgnhTVbTiBrK2E0amxLi
	 9QRfDCqUxhQyA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39b22d0e488so60124021fa.3
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 05:08:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq0ghnvIGDSdThxvdC2WN53uaK8UqLXm7UuWF6tyNOeqiRc08xahpN8/DmEgDFgbLzf5RPk/6iprqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzElaohq7oRdz9s0uwkp0RhlwfIllaQN00BuoRbSMSFNAAoU25Q
	lxAdXXMFgqkqKX1N8utOGVxUoGskPJqG5D7oHQUokKB5pAb5p87O2od7vVgJM26FgoqKSsL5eYR
	GyNRN6LqOzQe0D5O2RFplXMni4VLasfIxPDs0uMsWWw==
X-Received: by 2002:a05:651c:b2a:b0:394:184:f7a7 with SMTP id
 38308e7fff4ca-39db6ba2f04mr6775831fa.6.1784117316161; Wed, 15 Jul 2026
 05:08:36 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 12:08:34 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 12:08:34 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260715114701.7713-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715114701.7713-1-hardikprakash.official@gmail.com>
Date: Wed, 15 Jul 2026 12:08:34 +0000
X-Gmail-Original-Message-ID: <CAMRc=MdCn7BtFCQvraax5vV1t+G=Tjs4OP4ikd7RquFAj+G=Ww@mail.gmail.com>
X-Gm-Features: AUfX_my3syVuuoAttMGOdOgurOycsXARkvaCzELF8v-pCujG44vgqsxmC-_c92M
Message-ID: <CAMRc=MdCn7BtFCQvraax5vV1t+G=Tjs4OP4ikd7RquFAj+G=Ww@mail.gmail.com>
Subject: Re: [PATCH v11] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026 13:47:01 +0200, Hardik Prakash
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
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> Assisted-by: Claude:claude-sonnet-5
> Assisted-by: DeepSeek:deepseek-v4-pro
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 80 +++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> v10 -> v11:
> - Replaced custom gpio_controller_ref list with gpio_device_find_by_fwnode(),
>   as suggested by Andy, dropping the linked list and dedup logic (~60 lines)
> - Moved resource-skip explanation from commit message into a code comment
> - Fixed device_is_bound() to check gpio_device_to_device(gdev)->parent
>   rather than the gpio_device's own internal class device, which never
>   has a driver bound to it
>

Please include the entire changelog in every new iteration. I believe I gave
my Ack for this and now it's gone. I have no idea why because there's neither
a complete changelog nor links to previous versions.

Bart
