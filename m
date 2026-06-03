Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500F30CDBC
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470269; cv=pass; b=UlYPk3OZZ31+2d2a6lRW26wk5j3iOdyYo6g5NL3p90Z3e9njkr8rQSYCwB/P3Aw3StjXqFHgNq/F4cAsVVPAc+DQkxw3dj6Zdlga5yP/+tUHcX5cEtbdx9TuG57m5RsGGwVQ6lgU1NS8kxQgh3cx30hm8IddKbpDp1whfzcoA/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470269; c=relaxed/simple;
	bh=o8pvyt194UnZGpP/NNEXkeam+tkA+4rAxFe6pRuyOl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=porFjYt38HnJaL+RATbfQg37fbTgl9CS06xEoMDWkMhXCxW+wfMBv8o7vZ0XLJ+aGpH9qcwwxuFDKregd5m5wVgcPdWCtEzmQJfFXPIJsUDnZC0k8bH16VWVSzq989i/693M9Gr3ZcBw6lEVFu+oXZoFu6//P4USp753HvHk/2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5IRhwVo; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5IRhwVo"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7dc6fbf3e86so76326587b3.3
        for <linux-i2c@vger.kernel.org>; Wed, 03 Jun 2026 00:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780470267; cv=none;
        d=google.com; s=arc-20240605;
        b=BUIxG1mQkKvguavmCcA0emiqzr2ZSRF9aRkTUeJIZMMpzNtaPBAh8SvAEhyGjmV3So
         vNMdl3eHL35gg12KeT/hFwKI0o1Vgfm18FMt/z3vwekKsvcg/5/KicFTHVDPx3859oy7
         yvzRA30cMtBK8LpKKsNcCxLTaL76JNPUnHWbTs0/f1eoDSIDI1PaazVerjY/GQokO33G
         2O6uXRE8/wt8dM8aw61tVpnsKOuhW5ktIHEtRQu6ALJ8s4Cs29hUWNoTzM2CcLFxoYVb
         HlcFGJB7zFJ7DSZaDt6bPGhW9ooUzf3z5eukrkCqDNwZcp5oCo44yxDqYBQMnScD+2sP
         McXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YFjfWS4vOB8ZIsi+lcNJimBrXZON8uJh/eIp35B9+MA=;
        fh=7NNsoZ8glPLGv/lDxvbAT+Z7tcS9un1Uo6TNeT9ha7g=;
        b=Mz+J817n/6Y3eOndfnJRiPAtSk3aD3/ouMgarpF7oLnAE8r+aC2QfFuLILnz1ea+rN
         AjA7G1WG+7RWnV8jmDDgHGTqT2/hnnXRwVHlbXrXJ9pGBFbG/QAx5e0Bh83DqB11iWsi
         1RTFl04bLXVV78pIwrpjQWIb4ZUJ7pdB9vdVuzjZAvJQPCVqZ1mB0HgtHzUf/LMKgolt
         ShOyuN1GH35P4D1kGU3ufMlUgTMaBGrX2ls64kKDpIiAq4qQwIDOAZ+Bswttk/Wk9x5O
         yRPPrUaEvAeVonSEZU4xrSg5SPnj97nMq/myLLok7wQDtxdezdrz7Es8GF9BeL7yhbZB
         378g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780470267; x=1781075067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YFjfWS4vOB8ZIsi+lcNJimBrXZON8uJh/eIp35B9+MA=;
        b=V5IRhwVoCswMHeLCwBXIHqpdxmhCTuSdifKUN1Apt5FCtFjwykZJWvzGcCvvJnTAhw
         hIoErGeM8wNaNQ97mIn+l5OJzGKWmFTWki9dfotZr6wI+g2ifX+pPJpPIHiXD9NgRGoX
         TRsiFrFgXYJIyDYbqzDuaXeM6NA6+T72JQ5ojoI7wUY+nztlyhn/H5W9MqPR9vn9Rd59
         RUuRuA+LC4Uo/P2sEdSDfyiXY2SJrJ4fuNPyMc9F4N+q2yGPQ59jiy6Kb+CNIIptWJMV
         xcg1+yXg5gUVsKkIcV2ifmydnqUGk28uZBo5ole1wKjTl5b0M8FXkz2AGK26q9eVpd9U
         8hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470267; x=1781075067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFjfWS4vOB8ZIsi+lcNJimBrXZON8uJh/eIp35B9+MA=;
        b=Cj8uguSzlg0tj6nJnhmLTtbsAPC1FEcuS+7sz0fMmYaRNeGRtOjU3s0NfTk3WCoAB7
         7yEbGde0pKjm457K758Xq6hhsAbw3pzSyxHY/LBeVajMQC9BIz9kMSaIyxf7aublL2nD
         AsrW/ESTJpS5G0q/6DLx4rOcqGEHD0bFqjvAmZy2BIJQUP6Ek3kAbox59MrN+2lUNDul
         EqJY6Wa8FbevvTZRnZCoWlltwKlZxt+J8/WeqUV/1Czgz4pjgVtjUtDGLmAtlJsKpHGx
         G4hmF9IDK6gmxITgY6y3DHWJV5crScbvbwq5w6a418b5S391JEGp3PxOp4Et/AMdsENe
         UUGg==
X-Forwarded-Encrypted: i=1; AFNElJ9IvFczCRDz8n4uZ95KL2qb1yvQNVGQL8ODR/+crXs+vM8T5nfhsdUMWD41HcHbFDznwDFfVbYVINI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAK4vY182KayY5AFy2CkbleY6dbCmZpgA4YJrAt6MqMlvhUOR
	eK0Tay/1c1varkjrbv3VsXe8xqbNblQLOAJPPZMaShu69hz+E8F/lDbLjipzV0GEoLWnmDMuEoW
	u0CnD0IJYnT4Rt90M+HNMJOhdQ0Yy0QA=
X-Gm-Gg: Acq92OFxBvhfaoLhoTXDdrK5ZTxq1tQtjILOqnSRvjr13jWyoYSVLcf3qIvHGPYXiqq
	xcJenM6fM6txP2BFVILBnYhpmX7XdL9MBDskROJDoBkGBQ0L7vl6mlDF8S1nu1jcEToS90+NttP
	EiOnYzLIP9UjSYVqJSiMYPLWPq4ea+byjxNZVnBZwa6Rt1w7In0s5c3txgEynjq6PQPjjmL8Fm2
	6qMkC0WH6FWbnBe5PQmzFKUG28j0dDvPQOvZPyDmGo01uGeohJKLQMsMuAUhkfOu7Is1lycMnNN
	MXgBMO0ZPfZcHTi/u6hLA6vl1O6XyTivhoEOvT1rH8dmCFjWeGeOJL3sk2l+QfBlUSMREvsoyKk
	OAIsAVAGY+Co2aNu8eaMdO34M8mEA7T0Rc10Jq/kg0pMFl5srO561JFszE4joX4Yb9ocA3A==
X-Received: by 2002:a05:690c:3707:b0:7c0:56f:5b7f with SMTP id
 00721157ae682-7ea483d5565mr19903837b3.20.1780470266693; Wed, 03 Jun 2026
 00:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com> <20260602185339.GA404948@ax162>
 <CANTFpSX0Ehpno7b=xrnqzmENn=sfKj1UcyRzXvMyy4Rcyr7NhA@mail.gmail.com> <ah9frnHDuIjF_1Su@ashevche-desk.local>
In-Reply-To: <ah9frnHDuIjF_1Su@ashevche-desk.local>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Wed, 3 Jun 2026 12:34:14 +0530
X-Gm-Features: AVHnY4IfePfp2mgJ42-3WHNo5a1Y9C179aCngSkASewMVW3OugcwPO9DdVH0LC8
Message-ID: <CANTFpSXAXP16TUK7n+pTBgZOYRqCyF4kqkf9X-TK9O_rKWY1VQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, mario.limonciello@amd.com, 
	brgl@bgdev.pl, basavaraj.natikar@amd.com, linusw@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 03, 2026 at 04:26, Andy Shevchenko wrote:
> Linus, if you applied this patch, please drop it. There are problems
> with patch code wise and functional wise. It needs more love and work.

Understood. I agree that the patch should be dropped. The NULL pointer
dereference reported by Nathan and the code issues you've identified
both need to be addressed properly before resubmission.

I will rework the patch addressing all your feedback and the NULL check
for resource_source.string_ptr. I will send a new version once all of the
issues are rectified.

Thanks,
Hardik

On Wed, 3 Jun 2026 at 04:26, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jun 03, 2026 at 01:20:24AM +0530, Hardik Prakash wrote:
> > On Wed, Jun 03, 2026 at 00:23, Nathan Chancellor wrote:
> > > I bisected boot issues with a few of my test machines to this change
> > > in -next as commit ef76a3a28c79. I seem to recall a crash in strcmp()
> > > in one log but I cannot be too sure.
> >
> > Thank you for bisecting this.
> >
> > The strcmp() crash is likely the issue. In
> > check_gpioint_resource(), we access agpio->resource_source.string_ptr
> > without checking whether it is NULL first:
> >
> >     if (!strcmp(tmp->path, agpio->resource_source.string_ptr))
> >     ref->path = kstrdup(agpio->resource_source.string_ptr, ...)
> >
> > The acpi_resource_source struct has a string_length field -- when it is
> > 0, string_ptr will be NULL. On your machines, likely some GPIO resource
> > apparently has no resource source string, which we did not account for.
> >
> > I am preparing a fix that skips GPIO resources with no resource source
> > string (string_length == 0 || string_ptr == NULL). I will test it on
> > my hardware first and send a patch shortly.
> >
> > Sorry for the regression.
>
> Linus, if you applied this patch, please drop it. There are problems with patch
> code wise and functional wise. It needs more love and work.
>
> > On Wed, 3 Jun 2026 at 00:23, Nathan Chancellor <nathan@kernel.org> wrote:
> > > On Fri, May 29, 2026 at 03:38:37PM +0530, Hardik Prakash wrote:
> > > > I2C controllers may have child devices with GpioInt resources that
> > > > depend on GPIO controllers to be fully initialized. If the I2C
> > > > controller probes and enumerates children before the referenced GPIO
> > > > controller has completed probe, GPIO interrupts may not be properly
> > > > configured, leading to device failures.
> > > >
> > > > On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> > > > AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> > > > pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> > > > AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> > > > occur before the GPIO IRQ quirk in amd_gpio_probe() has run, causing:
> > > >
> > > >   i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost arbitration
> > > >
> > > > Add a generic dependency check in i2c-designware that walks ACPI child
> > > > devices, identifies any GpioInt resources, resolves the referenced GPIO
> > > > controllers, and defers probe if those controllers are not yet bound.
> > > >
> > > > This ensures GPIO controllers complete initialization (including IRQ
> > > > setup and quirks) before I2C child enumeration begins, fixing the race
> > > > without device-specific quirks or DMI matching.
> > > >
> > > > The probe ordering race was confirmed via dynamic debug tracing:
> > > >
> > > >   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> > > >   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> > > >   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> > > >   2.348157  lost arbitration
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
