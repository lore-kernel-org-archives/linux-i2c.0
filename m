Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCB2FDC53
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211051; cv=none; b=KT+phq6hFn6vuFIAhYr4apShRnvfRoYRgpv3pYF+POUot66V/rM7McLsqHF78ybgQ6KOY1sEFevB1okjTutmzXwaeVAD1Ife+QXO72u9T4eLDUJC4LzGyVUshFBsLAwihhH4qEbZSPo/RL8R5KgB2g/tyJmex31Px+VEqEsVGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211051; c=relaxed/simple;
	bh=3HAIaVwJb39EtojWjAM5K42+9y+A7loql5JR9LuzM2Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY9kNWMi0FOtpbqhwKC3v/xvkvD3RWeiwQdnheo2XF+vcNPN4kfxbPUVEdH75GssR+dZ8kcN1wV6AnrSxT5KLB2WpM9TEQx3EwhhXY1Qo2ReDMVLdKWrp3m6TNhn25uvuwdJXv/MN6Pg8JB8ZTvMgmDSBU8r0k+Ob3k00YPlmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg508n5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg508n5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E86C1F00A3E
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784211050;
	bh=34JcMwtTIwmIl5IaNprU5KFO/rz7xzd0lO4TuByW+Rk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Gg508n5eqGUKZUR/Glpbv+QwlXbZ3Cx5CpI4h0loLcx8K0p9yEwb79E9mWZKZqgAH
	 dkz/r3hGvk17WIzuH2aU4G1AkD/k+Ap988W4abLhJT02GLPDiECe6VNGq4DtuXDN/t
	 oNiCPCukQKPgytJbxR49+OhnZrR7mc6aAVeEqUwkJpUiDXla4OWf/JfXdikVZoKFjr
	 ddXbV16WGtK7S/PMP+3L7IvbO6r2MT4EjOMd7DZIuSAVX3IRZIlbh+DgXqA5Q7WfAY
	 qrtDDVELYLK012XZmj62ejlcLHx12l6NngpmI2g5saQuPXz9OEzaaWCN3p/aa+bSIB
	 Q6pxm6AT7bzrg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so58827231fa.2
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 07:10:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoO7OHXuA3uzkCTI9huotWVmTBXri2fwxyDR/nh7cR6mTuh3xgCHtkyQy1nq45RDZ4SSwrUxIeey4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbxJncHFnBhwEIWCIvKRopoG6fXqCEz9aSNpKFOkKIRzSvjEX
	rrxclOaDr+fLmfDb814CA6b8rFOO6RrIE1P1CGbiXXU1RcUO6sP6tIF3cUiC9zMCYdn3iVylO2A
	K9mVfeETZrgcYYhwJJ9Buc3uwCf2wnSX+1r7/IeBDww==
X-Received: by 2002:a05:651c:889:b0:39d:560a:fd9 with SMTP id
 38308e7fff4ca-39daa7d8c02mr27608921fa.18.1784211049315; Thu, 16 Jul 2026
 07:10:49 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 07:10:47 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 07:10:47 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716113055.41319-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716113055.41319-1-hardikprakash.official@gmail.com>
Date: Thu, 16 Jul 2026 07:10:47 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdN4AYdS8mz9JbVc8fCz7MOik+Dsthb-BviVtX3h987rQ@mail.gmail.com>
X-Gm-Features: AUfX_mx9ftyZy58DRNgAoP5nCLx0ZO1uoUzj338obXZNRJk1WtTsfv6Uox2tzcg
Message-ID: <CAMRc=MdN4AYdS8mz9JbVc8fCz7MOik+Dsthb-BviVtX3h987rQ@mail.gmail.com>
Subject: Re: [PATCH v12] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 13:30:55 +0200, Hardik Prakash
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

Looks good to me.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
