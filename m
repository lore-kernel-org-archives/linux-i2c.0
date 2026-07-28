Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935A372661
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218686; cv=pass; b=pnqQXlVshAhms1n7xeRHYRXt4kYkvhfHd1017blT3c02+95cE88XPVu3ZQYMWb9nc482a8oShTd1G4l/680utxt3nDe4mmQgow5UWF1fQvoV4WDjZVjsFmCZLZWSL7vzv4Dg4PLEh2VNJw9YGGJrHlk0ZBmVp46yIYmN3TfMKfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218686; c=relaxed/simple;
	bh=s5epezU8+nVa2HZkHk30QpaTBqzBX10432LDzMEeYLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdVtuc5yVh9L9Cx/ixNIpgOz/MCA2Skg2A0TwaAMGk7s/kNJ7T0izRN0XBuGuORyYRxYDGDr5CUG02+7FucdwSC7gG1trbF3xquui3tsirFvHsaSA6fNyixUl+cUZlLun8dPwKdFYgpQfqfhuekJbmNCgueTVENkXPtdsXZije4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTN5kML8; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTN5kML8"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66843304cbaso5226395d50.2
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 23:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785218684; cv=none;
        d=google.com; s=arc-20260327;
        b=J/WUocijs5WlthNhHuV51f5OtfCtnwtlxoMXamxCtuCxowojoMaY0Eb7w4my7aOTTn
         41a4lknLJ8DRAvUfEqa/ugN0syklbh+2ykq7SfSbgHkR582If3cXQG3w32z0L/CxMJuM
         GrGpCeg/ggKJRXRVLhtsCUymC1/3FSHIj1w0hl3tQIBowsZiWX0sm0qGH0+e8sdggjO1
         YDPdn4JhZtKAyYudOrvBUynyxq6CRk7uecHCG+BOKqLxywgxPczhUFVT1G0NVYUX4Wb+
         ZH6y9NrnnrXNNiKLARDmJvpeK0e+7Urhwo6kWQGSNOyzf6wRrzUhFdhqpWGR2jV/mUcl
         DiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tPvQKt2i7eXrMO5OaISPk9CgOionShn/uZChS4URYxE=;
        fh=fL/3u0EyjJcAaTyD/cP1MU0iBL3iB/XZWMSBraLkTXg=;
        b=L9lCG7gYTiGiJ/xoNkXuvjANlVu/lI8d/b+IbsXqklOY0OV2UEtuob9AZ/F+3D5F3n
         J3a/i3U7lgc1GK41/pEDb7cyoNaA8bhyTUGQjlnK0zj+cS7g9416dn6IS5sR9XNTlNxs
         ZQ8RCRPOOgeu0CNMhM6et97lPulRxc5jGsZPlDKfAp5Ob3GsR99ns+/cv76CmyrrLAZz
         PawQ/Sqd5w6BF3qvzaGzZEb/Vjyl95ncIG9B16pK3t28ITTNffsZydyqYWKDqYQDIgcA
         05Wk+/GC10KB6Cxnf8lGHJ0u4QxW4HD+lTwyMg1PyKvb2A2DUNmf916D5YkokjoO2NzJ
         lw5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785218684; x=1785823484; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPvQKt2i7eXrMO5OaISPk9CgOionShn/uZChS4URYxE=;
        b=mTN5kML8YbdwB3EWpzCgvt4Ozq4BGU5O89TZ+1ZJ/7y39BLVD41tbg4nPCnbrALgpT
         LKnMokyEzRsq/9y1YAbM9uIs88wNHuNy1dutqx7gR/yaGAfoY61N3yZ55S1gDVp/HkWM
         2ioYt7nJ1GVYLHy8PZbuMN57EfO722S/rhsgJufuODWbtXpxu+ZTbsvYPU4mxcuZg1G5
         QMyEkkVI6M9SOAUUGdtL945G3B+afqapib7UepZ5LztryvTXNuiKBY0M4XuDIKQBfJ4H
         jxChNQ7JGXsOMzEBomdPBZxuwvwyvy7WbORhp+kHlMPdqMjZNhOmTw83scb7Ty3lB7+/
         CkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785218684; x=1785823484;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tPvQKt2i7eXrMO5OaISPk9CgOionShn/uZChS4URYxE=;
        b=DrHlJSv2R0eY9GDlgjcRnhlx4VsiTWpq57zwDd7pDSOzybobS5MNwW4UGn1T3PBIBc
         2sX0qvddUmhsSBsUi7KckzbTWH+CMUPPXx2g19OaQ7Z3Ed0/1JEcIC749l8ib0Pz23cM
         j7UAA/ucBrnrfpVDXc7mvf8sjFdGMLAn72a366CQPz41NpBTHkBBkpQCMMPD43WPDE/C
         c1IDie4+4E3PdfgxwF7KRLOYR8l6Lna8gXhMAeWPNlulYfTdA0v/e2nGRpjcB7iLf5Ts
         f8bBOdy47z41uKC6tt04HC2mCyXY9/xn+BV4UKkT7WpSuDwCCOKZgnekqep+aLuiGQ3n
         FJSg==
X-Gm-Message-State: AOJu0YxgCDoTL4xP+BqrHVQTGXIIEhuVCWITOo1khwWOjXgqmTTRJPhI
	/QvcTrgbAph+3GfWfg2tzUSyANuSaacMGDWYBMdtoMCv0KtZsUmiyKoZ4yQmTSshNayZj61S1ly
	HOH/8LzAuRH2wlsEksUFAEsCQ/OKIYKw=
X-Gm-Gg: AR+sD12FfXQoMANJtlwxvmXTI39OpOIkjJuhLU+auyHlReBKtgxQLrGsgq/i6i0ENMu
	2/fqVudhmQiRpOPTeE+PLtgUolLRRWkGhnNEZCUwQp5SUqoLcDKKjGRyjw9AT4InTs6KCY1ZaPt
	m9tSrVNOEQZ6UyuIq8lbf4Gx9tsK7UoxkkBE48CbsNafCDHPFluRiRIS/ojHvi8QrOMGRuYpxk/
	a03qM/VB+KvFI4nSrwHulsRv0WjJ67/RD67bi9meUfgBxo7jXZRqiT89HclJ/5NuP8H2db7bn4g
	cxrvuZC8LJt2Jg9a9eXts9kUPF3TvkTKgBI74rSIRHnNGUpvSobVdfq9AcAGIuNMee2tJsKxit4
	LsXIq1yn7CFgyKwxnm6IwrXuypeWY/sCW0J3w
X-Received: by 2002:a05:690c:64c1:b0:81c:b865:2221 with SMTP id
 00721157ae682-81f993761c8mr4831037b3.33.1785218683887; Mon, 27 Jul 2026
 23:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718054330.8975-2-hardikprakash.official@gmail.com> <CAMRc=MdXGeCiaR4DnXT-jor0uh1EUJhXhmPrmkbMbQ-L35fGig@mail.gmail.com>
In-Reply-To: <CAMRc=MdXGeCiaR4DnXT-jor0uh1EUJhXhmPrmkbMbQ-L35fGig@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Tue, 28 Jul 2026 11:34:32 +0530
X-Gm-Features: AUfX_mx1D7zYt_neMZjzc8posXDfBhO_CdkITOYNmSrJiz_7-6bJROpHlDSLoN4
Message-ID: <CANTFpSXmRqoYNCFkL62tRLLcMum72DGjCq5k5wYBgcKvUgqUhg@mail.gmail.com>
Subject: Re: [PATCH v13] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: wsa@kernel.org, andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram, Andi,

This has Reviewed-by from Andy and Acked-by from Bart. Could this be
queued for the next merge window?

Thanks,
Hardik

On Mon, 20 Jul 2026 at 13:37, Bartosz Golaszewski <brgl@kernel.org> wrote:
>
> On Sat, 18 Jul 2026 07:43:31 +0200, Hardik Prakash
> <hardikprakash.official@gmail.com> said:
> > I2C controllers may have child devices with GpioInt resources that
> > depend on GPIO controllers being fully initialized. If the I2C
> > controller probes and enumerates children before the referenced GPIO
> > controller has completed probe, GPIO interrupts may not be properly
> > configured, leading to device failures.
> >
> > On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> > AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> > pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> > AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> > fail with lost arbitration errors:
> >
> >   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >   2.348157  lost arbitration
> >
> > Add a dependency check that walks ACPI child devices and defers probe
> > until any referenced GPIO controller is bound.
> >
> > Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> > Assisted-by: Claude:claude-sonnet-5
> > Assisted-by: DeepSeek:deepseek-v4-pro
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
> > ---
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
