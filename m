Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43892877DA
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037784; cv=pass; b=XQ6pUnhrg4N1Hq3FZMBj1WeeXudnH2n0ri5m7tQvC29OglR4074Ub0HuVSG+2rgQ/uj4rQIBtkBbgaVmNblhHFyXKAPgqJ514L2dnggVLjUXtPXVFcV1ZbIetNA8tAUe/ntRNJd2W4ARTpuUgEIsvw/6/NAeAbWST6SIzAlLKKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037784; c=relaxed/simple;
	bh=xB+Sur1GqPbjl5ET974ruqqk+eG+zLGijo7T4vkVNnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6utWqD1mQeop/l+dsktVL5XUM1UU9RYHJnwDADj1u/wtmMcLg86HE0pDn3juq1wD+lstFBcd/zhC/UEw+XCbcRbdhqQ1PLuTEebRww8T6K0YkG37IrU2ryDvrEpIqAQWYH5g/jY1nQqDjSTEUgUJrqbWx99lZ3PXoP6MJPE/d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltxkcw4a; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltxkcw4a"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65db820588aso11117109d50.2
        for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 23:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780037783; cv=none;
        d=google.com; s=arc-20240605;
        b=YP9mNHvqBwd+laYfwdSLpBWRNSK0X8DKtvhbf06wgMrf5o/G09A1bMgIgRlfNelvJi
         n3FmTXF7TL2nrLRrxkXdoVHeXny9o5e3RBtnjhuhkKPRYg/HGoJJ8kZAelXuHTZXoXNF
         txijCMl6yS+GJcl4w4RDcV9q3gkbWB7w/RTFFm5jcJIbMm0oNvBlTglnto8U2lQKyQQ1
         BKmPhDj1lTVPI49MSW43dgObYaIni6jwGaZ//P9fiqjg2kHlZ7Ki8pHHKE4nOdVEbHRh
         yMZOfbNvBKNfr3Riegjec1NH0lVwuPfW6Ay+y3qjVsIfoX95SD//vBajVlns7AOmBF04
         3IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=q8F9cvCOm3X5D1v0nxPYlv0+DQo5Uw0eR/Z0LcoLAGA=;
        fh=Vc2PCwbJknJHGClVfzd8bxCcryzD42rhxY00hdfXtM0=;
        b=j+5lYJ6WcvFVet3bpdeSdWrZng7tYzK4fK2l1eTAU8rEFHIXtE8NJGaGxcIvjMNDex
         A40dQCcaRzkh2TMZthEISP+pTjHQ8EETfHrctdI72dQxDkjZx899aphbulGZWanZ6ee3
         jjQA2XCU2oONt0QivCrG6Uzpd5Qw2i2Zb3WrUkPBpJr+gIDKuSHYOXNTNTieJ+fyT147
         K51CjWpji0IQ+a/Wmzz4H2Rr4B60kQ09fvGc3U/jueg1fbdQQxpd3JPry+HCgfCVJ3P8
         tR2qVe9AbDlll1c7o9KmV9VF40Fb2BQpF1SfKdegC+2goKzwBTXZsgvEYEhjwio/cgnq
         RDfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780037783; x=1780642583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8F9cvCOm3X5D1v0nxPYlv0+DQo5Uw0eR/Z0LcoLAGA=;
        b=ltxkcw4agSsVf6BeyrOuKCGeAp20v5eGln+OSjO3LgXVGEv3+2YjlNRMK+RS+jz2cE
         neUV1WtviGgpBccsoK/3+7po/Ee9p5cNebq6/xjiUR33vDw3Ny5TCFW2sGvvL/ZItxph
         tj+p/CyhqT4QJhGAzY+IF7GMp1p0IObYMXIQ9evggCL3nqi+hnVmP4kd75mjmYKtA5Jf
         A/C1qLMEXZ7Q0rejRJNQO2gPiNirCMt3w9c7Rx2/cKqKVv1DbM28UBt1EfHBB6jWGOQb
         ALje5SdxERELnCNCwPWRtuQh/RuZTwpJynlVpNtxwsbCr/4pr2pjp/HTai/WChghyuEm
         Vcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780037783; x=1780642583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8F9cvCOm3X5D1v0nxPYlv0+DQo5Uw0eR/Z0LcoLAGA=;
        b=QqeALWCKHJ0swoepfvuL+guEtpuRbY1qAAnjQii8GON7iKNQpX09MPbx3HH8MG83Cy
         0tbP/XB7OGmwrrd01AWxGkUD9AftEYJ6STGA5tvXCOTvXhsfaHbU2h6foLqQGE0ha3Dm
         KLzW4p5Kk5HlkOOQpMDxLSqw1+db8nshb09fej5qjUn0w0zclYdddIb3HJtCiQCPCsjD
         lLUI7/O9BCcXR8ljm/2eW/OAAz/alyZDFJtQH825DtgHW0OjoW4yZIDYPctTS/6qeLFD
         O2Eavne5ac1XBbw4bPIJYCkMFP1oJIYDJH0zHha6RDEkkMHDAxczoHhYbPQzll6Z9EYJ
         C+Xw==
X-Forwarded-Encrypted: i=1; AFNElJ+4B87Zd4dI3ulN52tiGUPicYGY36DDHGihFPPrlQoYzZnaiBrLA6p+mUsD0OOigkbD5dhnhFLQLY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOh2uIvOAs7CM6AdHiSXaHkLC89YUW5O3DEqjSaIk3aKVwhHr+
	vWn4P69PXTbzIS8eKRm9dU4zMQbq/QAafau84gcJKUYw6A6RwDio6Clbtn+13342ysB/NwYPAht
	O6dD8lNSaO4kpBLOcduWVvJCTsonzvFI=
X-Gm-Gg: Acq92OGaRFGpOOSAVpJpiemAOv8pNblMwzDSDK5Qf52PKE/yS24/6g4cu0xXHkvaJLb
	lc951zKW6LM/0681DCvVxKnZCxkxq8yg7OkgvHhsp0FlpKu2W9CZKfnzGDe2R2xpK9Fit6ptyGl
	91Oq+dzzzN+uwoz99gOvTwhEgRNbShJBjJIn5icGqa1EzqLqi+Qm5DQYS9HkoH3BgAspwghwXfB
	G5iLAo6U8GFbIehhTyjfQohANLh2DttJcDUlMlfTdFdThkC4DP9upnnLlf9vVztMTpKtv66EXGi
	Nvw6PAx/hz3izfpHqGxy0Rtr+epDNTuR428q926gnkkk2XMHnsRn583ZK66lZ+HCE12LzEnSWHY
	f7oOf8JG55ZuXIY6XbTDmtzfzFjnz8oStTyzCFw2t2y20T662/LlLPtkwuVZ7F11q5idQN4FPAL
	1HJD3s
X-Received: by 2002:a05:690e:1209:b0:651:b8fc:5490 with SMTP id
 956f58d0204a3-66053101959mr967309d50.38.1780037782714; Thu, 28 May 2026
 23:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523174440.9629-1-hardikprakash.official@gmail.com>
 <20260523174440.9629-2-hardikprakash.official@gmail.com> <CAMRc=Mc7KrsmB4Svjoj4WMRa-=D2xitqURVRJVWhDH9qyzOVhg@mail.gmail.com>
 <63e6fdb6-1679-44f5-acfb-563ed3b56a54@kernel.org>
In-Reply-To: <63e6fdb6-1679-44f5-acfb-563ed3b56a54@kernel.org>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Fri, 29 May 2026 12:26:11 +0530
X-Gm-Features: AVHnY4K-Ck31Y2C37irW_tEewS0ZGz7G_MYT3OUSmVHgoyNuZ4eh5ZVQt5iPiFM
Message-ID: <CANTFpSVX8YZxY+6pMcv=HhHBRbkPymox1GHhSCoBHzknatnfQg@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Mario Limonciello <superm1@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linux-i2c@vger.kernel.org, linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, May 29, 2026, at 04:43, Mario Limonciello wrote:
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> Please make sure that we drop the now unnecessary patch that was
> committed from the earlier series when queuing this. If that has
> already made it into a PR to linus (as part of -fixes or so) we should
> get it reverted.

Linus Walleij confirmed it has already been pulled into Torvalds' tree,
so a revert will be needed. I'll leave that to the maintainers to
coordinate.

I'll send v8 now with your Reviewed-by and Bart's Acked-by collected.

Thanks,
Hardik

On Fri, 29 May 2026 at 04:43, Mario Limonciello <superm1@kernel.org> wrote:
>
>
>
> On 5/26/26 11:42, Bartosz Golaszewski wrote:
> > On Sat, 23 May 2026 19:44:40 +0200, Hardik Prakash
> > <hardikprakash.official@gmail.com> said:
> >> I2C controllers may have child devices with GpioInt resources that
> >> depend on GPIO controllers to be fully initialized. If the I2C
> >> controller probes and enumerates children before the referenced GPIO
> >> controller has completed probe, GPIO interrupts may not be properly
> >> configured, leading to device failures.
> >>
> >> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> >> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> >> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> >> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> >> occur before the GPIO IRQ quirk in amd_gpio_probe() has run, causing:
> >>
> >>    i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost arbitration
> >>
> >> Add a generic dependency check in i2c-designware that walks ACPI child
> >> devices, identifies any GpioInt resources, resolves the referenced GPIO
> >> controllers, and defers probe if those controllers are not yet bound.
> >>
> >> This ensures GPIO controllers complete initialization (including IRQ
> >> setup and quirks) before I2C child enumeration begins, fixing the race
> >> without device-specific quirks or DMI matching.
> >>
> >> The probe ordering race was confirmed via dynamic debug tracing:
> >>
> >>    0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >>    0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >>    0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >>    2.348157  lost arbitration
> >>
> >> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> >> Assisted-by: Claude:claude-sonnet-4-6
> >> Assisted-by: GPT-Codex:gpt-5.2-codex
> >> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=221494
> >
> > I don't think we use this tag anymore. Just make it Link:
> >
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> Please make sure that we drop the now unnecessary patch that was
> committed from the earlier series when queuing this.  If that has
> already made it into a PR to linus (as part of -fixes or so) we should
> get it reverted.
>
>
