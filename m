Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671033CEBA9
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175300; cv=pass; b=KmG8f2rb6mWMW9VOkKAuk2dwD7z7DrKOCmfJaY2F6Nt+m6FUJOZ5np2Vtg8QtWfHrcsR9dpRciIyrGzW+d2qHUMnUODAp1lwcIjYzzm1PTxrQkevLaNV91VmGBlhfvrH4k0JBfHC9FqDfMTLPJuHSmhhUr5kDXkQNJFf15j4SJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175300; c=relaxed/simple;
	bh=Oa7OyuO95iluKy8/COxKuVtDUJhdCWMtuZ3HGAOTMDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpj6RKzZJpV7iksEZU2y1/QJlHOi8yCHLajLO1K83JfhA30IBk9Os67b/hbtz7iyTL0IvUWiitlwroL9H7hFR0ezeK4aXNCpBLzxU5NprZTVdHz6Nu+q0D52Hhkbrhca2CzkqceOUTJokIvndi+Aslv8DuZFaQqfedbPSq+Zros=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6evZeL7; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6evZeL7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7ca947f9b00so26321667b3.0
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 00:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779175297; cv=none;
        d=google.com; s=arc-20240605;
        b=VycaZ+Hx7s3CRfUnvx8sL5iZikPjqkoiva+xXdGukzCzcnqTmqkQRChGBPdU/++nJ4
         DuaIdR7r2UUzIndCp3yglv2k2hY3ooUSxvF3e2bkytl3UG8R/fAuw5pgXz/EAMBV7bY+
         sv3EWBdVi1pKEvqXJuGc83afD6V1cqHJCF2qDFvxo4sHBbm9BBYQjJ/4i5JoxIUSc2HZ
         ZAGuC3NluNAEovPZ92aSnRit6o7rEdDV3Lbl7dHxsjnM16JEECQJG1DH53yPo7tUkxFG
         h36L0sDkXmsRkroASelo0hTEps8ix+O9pimKxqmbJtNcYqdMgxgqG5Ssnn5b5Ve5N6RD
         9+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wnP4OlID84iZ1pMkgqTUuHenz4qcP2CzbjiWM2ZLvmM=;
        fh=1qiNNPcPTKyXAQdg/Ms2btrPpbsu6zhWdmiCbfek8gc=;
        b=G4jkY8pXvrpO0P+eV3laHAQkOSL+JfWj48qpTOXAae4ECr9IyuPObfvQCkyt+4r8hs
         FpSlOJvWHjSM4LvblVHiDUVwFy1SDYMR3NaVUfmoKDfSoWgjV1C8viMI7UhSALHJzmi9
         iKzZVFx4c8BSKwWqvPGVDJ3I1+FfUOrocvzGLMhu2glQAeM+SQHJzzA/5hOGYX4EQm2l
         siKowXlWYa5Ba6XH5THGLE5p+RmjdWi+2oaGC2t5NfiZrH7qgM5Fv1WstsesBDF0zZb/
         GNwDKG/HXWEGkPJEAn2tUoWJPgcMDRrPxCxip7AL6MDAgkTkEKYIaygXhDAuGE9ooYIP
         5taA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779175297; x=1779780097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnP4OlID84iZ1pMkgqTUuHenz4qcP2CzbjiWM2ZLvmM=;
        b=E6evZeL7y5uh07IE+D1+hNPdDv421w/pZgqPoQsB1Vu5bPsSLKLrtm8WoOmgDIvBwX
         ASCyFNDkudCzZg2Z2farOxGUrMMsobTQYdVocRtO9Q3+zBVmQw64gAaJD8VoLGS5u83P
         QdEZBfU+0u0nq+hGbuagOUJgzEWSZ4FUJr5CmuOnxQC3karnVIJOv4W6ZccYR4ym4h8Q
         znnj+FwQsaqrBBO9E0m+HJiB+CrneYdmlCZEvsrULk7ClNdYTC9VTEvDY8R7h7vYHWjp
         mQi1IL4uPPdLvQErgTYSnhAu8YyOhgH6KP7L6cC1PlxRKPKp+SJDG9oV/w0Rsrs+Ya/v
         I4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175297; x=1779780097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wnP4OlID84iZ1pMkgqTUuHenz4qcP2CzbjiWM2ZLvmM=;
        b=kZiGpxcGsEyLL4PbILB+xh3q+sZiAofuIdpzje8yNjVucdpaePq3iu2thT9m7zCOSQ
         7B2BzrE/40CMnUiWiDg/KzuWi7SjfJkBYBt8Thwj/nO3APka2nEF2Q8RLkKjtuoOSyPG
         vlZj0wJl+yCFju+PiUZX8vtDeIR83QLiCgntY7B1/NsjGPRSwrZe3dSTtgLbOcW1kwX0
         XRJGSGl6iZ/ny7zzdpIrZBtfe6gIKZeBbAn4yFZ/G5MNnGQ9fuYT1zDHz/5nqTXEEqYc
         QHZxH4zTwnDIHq2iVl6O0rARYdSn7egjcTPqeg96O1GT+rzwcwLyZ9T8qQ2yZlg/ctE8
         ctBA==
X-Forwarded-Encrypted: i=1; AFNElJ8tgUb1MaIaS9mNkoKsvLpSG2sToIMBuR3N2HXeNF1QrvaRsbxukLuvhfcBV/JF6Of317Eggmy/vzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRweq3BXXk0aaX0kKbf2Zr1wmpDNZbtGpPJjVDgkf+4LwIp4nf
	c1QWslCKuqqZepV/9RhnozPV6eWtp7K7xCSCHlnOtMawjDwgo25BYuhVEAYhOgmtjlg6FLAFa8j
	HvHhrgOnyph5Fay0u7dRR70zZ7y7sPhM=
X-Gm-Gg: Acq92OEXnpS6ghNtsxxTeouZjH57iYuC4c9Ac7FoE/Y1kH0qGGoiufdkyJzkxEfV/DH
	3n0TO4LWSybPb4Vb8SljCNgpmcxBnXadh3TG486h3Xt/4QNdF52oER3NBPgjpQF3BeDLVWOlfiN
	RpTJYVG+f+88Y6pJ2IBXmuV5+UQzv2Ichs3rM2lJyHepsFuvlJXd+8dcjHZRj+0CjN+1ITW0mnH
	FDMjsqYQmn4vKCVD4W1/j4GwI+MHgGsUwrVtIidqaO2ZY8nJIuoUU4mWMaEbxTdFmLMBzwIhkBe
	RYPpWKaZYxzWDf5IkHAI28lV5RA1RhGA43CXnQbH2LCPZ0XE0MKZEzYAuD3UPLfDmYgRgYtLqJF
	933MmmQn8K3qXBDRnIN2l+6qQPOlr5+l5SrkJZ3dMiXusaJ165SK4Zb5hiTHjfJqqfD61hw==
X-Received: by 2002:a05:690c:112:b0:7bd:5d03:dc18 with SMTP id
 00721157ae682-7c95b82a8acmr212648737b3.29.1779175297320; Tue, 19 May 2026
 00:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518122814.8975-1-hardikprakash.official@gmail.com>
 <d57dd297-6be1-43a9-a38d-e40c8949e23a@amd.com> <CANTFpSWGC7GsAY-3UvPtBZzqjNek-T5haiDb59QYRoRgwuQf1w@mail.gmail.com>
 <7d0f0cf9-1936-4cf6-a425-228a37f83137@amd.com> <CAMRc=MdS_BVKb=FQLhky=8dpghBSoHeBhUk0LM5hROFxmJeyGQ@mail.gmail.com>
 <9d5da93e-bbe0-4359-9f17-e3c6b3a5cb34@amd.com> <CAMRc=MfT_WVMxPnYZW=mg52PHew0O4VQMGFrfo6G9vxZDDoArw@mail.gmail.com>
 <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com>
 <agsh652HlC4rg1_1@ashevche-desk.local> <CANTFpSU7XaNKwe_FPsTCkxQYeq78Tqusr-nsB-Ww0_teuiWdEA@mail.gmail.com>
 <f0ee2722-1e56-41b1-b70c-5503a2495853@amd.com>
In-Reply-To: <f0ee2722-1e56-41b1-b70c-5503a2495853@amd.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Tue, 19 May 2026 12:51:25 +0530
X-Gm-Features: AVHnY4IWrbCqzk7xRzwF54zOIXzOwyqH8XVXizOrpIbeofI7zwv-GkgovMipV3A
Message-ID: <CANTFpSWT+cR8Yxyr5jrB2MUidqKteWuPjHOyK_rpSkDUN6SWQQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 23:14, Mario Limonciello wrote:
> I'm still confused though.  Are you saying we're actually racing with
> amd_gpio_probe()?  Like the GPIO chip gets set up before the interrupt
> is ready?
>
> There is a dynamic debug statement already in amd_gpio_probe() for when
> it finishes, maybe you can sprinkle a few more around the start of probe
> and amd_gpio_irq_enable() to confirm?

Added debug statements and enabled dyndbg at boot. The trace confirms
the race:

  0.285415  amd_gpio_probe: start
  0.285496  amd_gpio_probe: calling irq_init
  0.285947  GPIO 157 enabled (quirk fires)
  0.285950  amd_gpio_probe: quirks applied
  0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
  0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
  0.290248  AMDI0010:00 dw_i2c_plat_probe: start
  0.295928  AMDI0010:01 dw_i2c_plat_probe: start
  0.301454  AMDI0010:02 dw_i2c_plat_probe: start <- races here
  0.306905  AMDI0010:03 dw_i2c_plat_probe: start
  2.348157  lost arbitration

gpiochip_add_data() at 0.285952 makes the GPIO chip visible to the
system before amd_gpio_probe() has finished. AMDI0010:02 starts probing
at 0.301454 while amd_gpio_probe() is still completing. This is why
device_is_bound() works and initcall promotion does not -- it waits for
probe completion, not just gpiochip registration.

Thanks,
Hardik

On Mon, 18 May 2026 at 23:14, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 5/18/26 12:22, Hardik Prakash wrote:
> > On Mon, May 18, 2026 at 19:57, Bartosz Golaszewski wrote:
> >> If you added wait_for_device_probe() right before requesting the
> >> interrupt, does it help?
> >
> > I'll test this. One concern: wait_for_device_probe() waits for all
> > pending probes to complete, not just pinctrl-amd. Calling it
> > unconditionally in dw_i2c_plat_probe() would affect every machine
> > running i2c-designware, potentially adding boot latency broadly.
> >
> > Would it make sense to guard it with the same DMI check, or is the
> > intention to make this unconditional?
>
> Our general aim should be to avoid DMI checks where possible.  If you're
> finding a timing problem on your system there can very likely be a
> timing problem on another system from someone not as willing or able to
> report it.
>
> So let's leave DMI hacks for fallback if we really can't figure this out.
>
> In an ideal world we would have a _DEP in the ACPI entries, but I don't
> think I've ever seen that for the GPIO controller.
>
> I'm still confused though.  Are you saying we're actually racing with
> amd_gpio_probe()?  Like the GPIO chip gets set up before the interrupt
> is ready?
>
> There is a dynamic debug statement already in amd_gpio_probe() for when
> it finishes, maybe you can sprinkle a few more around the start of probe
> and amd_gpio_irq_enable() to confirm?
>
> >
> > Thanks,
> > Hardik
> >
> > On Mon, 18 May 2026 at 19:58, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> >>
> >> On Mon, May 18, 2026 at 07:53:28PM +0530, Hardik Prakash wrote:
> >>> On Mon, May 18, 2026 at 19:35, Bartosz Golaszewski wrote:
> >>>> What is blocking the pinctrl driver from probing? Does it return
> >>>> -EPROBE_DEFER for some reason? Pin control core is ready at
> >>>> core_initcall() so it should work in theory.
> >>>
> >>> On Mon, May 18, 2026 at 19:16, Mario Limonciello wrote:
> >>>> Please try arch_initcall instead.
> >>>
> >>> Tested arch_initcall + patch 1. GPIO 157 now fires at 0.255s (earlier
> >>> than any previous boot), but arbitration errors still occur at 2.309s=
:
> >>>
> >>>    subsys_initcall + patch 1:   GPIO 157 at ~0.310s, arbitration erro=
rs
> >>>    arch_initcall + patch 1:     GPIO 157 at ~0.255s, arbitration erro=
rs
> >>>    patch 1 + patch 2 (v5):     no arbitration errors, touchscreen wor=
ks
> >>>
> >>> The driver is not returning -EPROBE_DEFER. The problem is that
> >>> amd_gpio_probe() hasn't completed by the time i2c_designware fires,
> >>> even with arch_initcall. Promoting the initcall level gets the driver
> >>> registered earlier, but probe itself takes time, and i2c_designware
> >>> catches it mid-probe regardless of registration timing.
> >>>
> >>> This is why device_is_bound() works where initcall promotion does not
> >>> =E2=80=94 it waits for probe completion, not just driver registration=
.
> >>
> >> The alternative solution is to have a registered notifier for the devi=
ce in
> >> question. But not sure if it will be less-invasive than given solution=
.
> >>
> >>> On Mon, 18 May 2026 at 19:41, Bartosz Golaszewski <brgl@kernel.org> w=
rote:
> >>>> On Mon, May 18, 2026 at 4:08=E2=80=AFPM Mario Limonciello
> >>>> <mario.limonciello@amd.com> wrote:
> >>>>> On 5/18/26 09:05, Bartosz Golaszewski wrote:
> >>>>>> On Mon, May 18, 2026 at 3:46=E2=80=AFPM Mario Limonciello
> >>>>>> <mario.limonciello@amd.com> wrote:
> >>>>>>> On 5/18/26 08:40, Hardik Prakash wrote:
> >>>>>>>> On Mon, May 18, 2026 at 18:17, Mario Limonciello wrote:
> >>>>>>>>> I'd still like to avoid a quirk if we can.
> >>>>>>>>>
> >>>>>>>>> I know my proposed patch to try to probe at an earlier stage di=
dn't
> >>>>>>>>> work, but could you perhaps try pulling pinctrl-amd even earlie=
r?
> >>>>>>>>>
> >>>>>>>>> Maybe fs_initcall()?
> >>>>>>>>
> >>>>>>>> Tested. fs_initcall + patch 1 still produces the same arbitratio=
n
> >>>>>>>> errors:
> >>>>>>>>
> >>>>>>>>      subsys_initcall + patch 1:   arbitration errors persist
> >>>>>>>>      fs_initcall + patch 1:       arbitration errors persist
> >>>>>>>>      patch 1 + patch 2 (v5):     clean boot, touchscreen fully f=
unctional
> >>>>>>>>
> >>>>>>>> The initcall level does not appear to be the determining factor =
on
> >>>>>>>> this hardware. i2c_designware is still probing AMDI0010:02 befor=
e
> >>>>>>>> pinctrl-amd finishes regardless of how early pinctrl-amd registe=
rs.
> >>>>>>>> The explicit device_is_bound() deferral in patch 2 is the only
> >>>>>>>> approach that has worked.
> >>>>>>>
> >>>>>>> Please try arch_initcall instead.
> >>>>>>
> >>>>>> What is blocking the pinctrl driver from probing? Does it return
> >>>>>> -EPROBE_DEFER for some reason? Pin control core is ready at
> >>>>>> core_initcall() so it should work in theory.
> >>>>>
> >>>>> Currently it's module_platform_driver() IE device_initcall().
> >>>>>
> >>>>> That's why I think we "should" be able to move it a lot earlier.
> >>>>
> >>>> I mean with fs_initcall() change - what's blocking it now?
> >>
> >> --
> >> With Best Regards,
> >> Andy Shevchenko
> >>
> >>
>
