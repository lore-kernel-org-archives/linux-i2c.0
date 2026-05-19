Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FF372B26
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217651; cv=pass; b=Sdv/7xoopVl/6bJtzS/UtnYEAGiLUZwku2/DQmV4mBtTQCnD6Y9jCrncGtZYcru0f1zRYAseQzLQFOgXR2tMc5sPzwjU37Ch6fYx5H2W/jV9d97rA5FzOxjvjrFQpp9TvznOO4PqjBNYmuDsVg+oZ72W7oCtO1dKjC8ebb0r/jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217651; c=relaxed/simple;
	bh=Z+OAyukKoZU4RGHbotX4DJNahNNzuKMHL9tY24/Bsfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEwjeC8zI1Ne0bwjOrqHk/oklWrk2vPO8VuFUuXFFTF6raVB0bL8m5UFXwKY3sPR9pSTmGTKe33ZedvvjsjPA/AfmbDJlsx4byVZJO3yiTVzxsCC9oZN6Jo1o1EyGc3BUY5ni2neQIeeqgXz+F6j/iTe9MKHUhEWnlr9lbywnjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfa8mWyv; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfa8mWyv"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65d071aac6eso3327107d50.0
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779217649; cv=none;
        d=google.com; s=arc-20240605;
        b=LMf5xnMEIeodYLspq5IGyg8oNDV/ixWcu+73vTmI/BMTxsK4k7UpZ760bF88l2kUQL
         L6Wr2xjMWA74PL11fQ7M3ENqQ0oOoEsyN2Kj766YaNegeq7Wi6SA4qiOfBVWzJ9F23Rp
         x9T/8+vXYpJdWKmdB/ct8ZT5hiL2eLsLEJwkp7j7XxrfWjWE9hgHZE+RVdE5mzXOcAWB
         peBH1QDSINSSY5c6vYhJFC/mMdgDYr1C/mfQ7mglUCQy+/B4i1MActIMNxI7jn/R5rV5
         bFxm3oTZ1nfhNxJ6MvmVEwiV4TUbAMKUApQ51XCyBd16Cz8/G+ImoC2empxNHaioSqtK
         BSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6k2pw07xoUFAncnGMxOpwBVGQh1ig9EOyCZMb029UtA=;
        fh=PDLJQJrCCdg/1f7lAsAl1kEhJDjgLlTd0r43St3t7Lw=;
        b=CXYHh1kFsu4upHpXNmEk80Nz9I9qTheUWSyIn2sqn3h5X7udPRYyl8JXW6w4R3R10J
         zh0dmBj5UA9FB1ezBrdoNnGadjztolaR1kSMfxwxFtoF2bG4zHKvaDR9h8d2cqGBt0Q5
         TkpPdTsm8fY9sBHbUMmaK6LnIagAFecxcPxOtSI4Y8aDBJuUDXYRhQxd/ep4oB8KSpaP
         MLFCm82UABb74+mGlB0PrPhesfMeL1w7Xg7FybbYnzk0yQIazc6Q7B7c3gnODCoAI4A0
         poch1l2UdyCoGFcVErMTe9N75BIu0tmL+dbw6WxN/VYKtzCJXaLCEembJVuheq+r03n/
         QUlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217649; x=1779822449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k2pw07xoUFAncnGMxOpwBVGQh1ig9EOyCZMb029UtA=;
        b=Rfa8mWyvc2x6u5VgMMaZwid3jZ6C8+xuY1VU/9nn/BQfvhfnUwd6hbn1p/uBSa0AT/
         Ybl0cPIfWNSe+mGKbxL4aZqJU5IY7av6rALsjN1WtOKg208yvLZOViyKbP51PNJ4qz+3
         NmnaQH9WeEEDkQR1odEUf2b74SPfwdqeQHPIfwXGsguCQhYvBZ8A+VMIQDGtd6UBnRm3
         GLmx2h66cd7bRC0lUKWsrIexIkV8e5msOMzTDbPBUf3Y3Sl8bb/rrZU6DkRVsvnfJYdz
         fCGTYJo9AmRF544f8h9LCPbUH6Up3fFlCjtjJzHKmXRuNkWzqMDfRF9C9/pbDLkyN6pi
         CWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217649; x=1779822449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6k2pw07xoUFAncnGMxOpwBVGQh1ig9EOyCZMb029UtA=;
        b=XvdEdNjtlKcd/CXr5x2g6rGNWtELPl/ttksFQdcmUdo5DZ79BCMNC8VcTZ9PVDjB1v
         Jxrf1ug4Cap+roherVRtkYf8x29d/RCVLJoqveDdSy/h7IMB2hi28KejnftzZDqbFd5/
         ONTFDONveB/48Oul3nFWwTGlQS9RYnuwbzuMooNwTEOuIf9L0tfE2Jmja/uzJOLBp6B2
         lD7hKxa7HLI0OAR8m0lLBqW8BtbOV+cHXRhqbx7DpFCapxTL04gR6MNEjGUxt6z5flw2
         Qnqtx3OQmTAhf8L4PELspw/h00+ACD6I5lVX/uMlmrvwRz15636Ick7iAVCiKkv1ZNZO
         6A5A==
X-Forwarded-Encrypted: i=1; AFNElJ/7MGFRkh/7dM71yOwOEoW6SLdDD6HY04HStd5DbaIYiE3XplCvlwvoExvjd0McB6rAomn6k8IYjSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5Qas8iM4vRAwEETSAfGXn6m4oVRG0SjA/ZFNTlZxe1rf/K3X
	no/T4k0BwqLaQOaRTdhhwfAaQg2OJUnEvPN/jzX9bxTWaHy+aKON1pedvqZOwx/Pn1Hi3gdivJh
	5zGR5tamFM3Hs5gND5hoPLoWRUEMQai0=
X-Gm-Gg: Acq92OFQAldfNtCOkZ4k6IYbkxJJKXot417jnGN1muVgBKHK3BH5o55pi7XAuRxwdFN
	OwVd8/Wq6nMP7Vm0ekIQVpA1bi7c/7Eh/+osQUx/UKGtkRxMOW+QNqpM2XcPejUUX7eZM2SvZMl
	wk0uotTN/TczYxSr2ii/T3k/A7O2Pcm2iBIacJbz1FuOeGkTVzf+3d15139oVwUdYONGzuzzyhz
	TpuOb+emwwyR4aLfBqnTtLZG4tbJz8IddKKWdKXIjEjJSzKxQYJeZ0olBKLT1ev8eYdvpQMYNY2
	tVEOTsNgHkkKMXL5sNIyK9jNvkpUGrX6F8HTybiO/iRHUEuxZyIIVxflNwtyrs2SsJ+A70NeBvC
	JcVTqGbSGkqmrSU1XFOsHINEMjii289zPgS2sWe5SqXniI0jN59aJdwNZIE4UStWJZBGKB93eQ1
	tFLAo=
X-Received: by 2002:a05:690e:d47:b0:651:be50:af09 with SMTP id
 956f58d0204a3-65e2267428cmr17622134d50.3.1779217648729; Tue, 19 May 2026
 12:07:28 -0700 (PDT)
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
 <f0ee2722-1e56-41b1-b70c-5503a2495853@amd.com> <CANTFpSWT+cR8Yxyr5jrB2MUidqKteWuPjHOyK_rpSkDUN6SWQQ@mail.gmail.com>
 <c4993bce-5d39-416f-90ed-d870f4ac9254@amd.com> <CAMRc=McSLEF_nrkRdJJu9=Bc_KmPWYKDHd6tOD9tJqs0fksv0w@mail.gmail.com>
 <498bad3f-6a0c-4da8-b645-1cc837ba1836@amd.com>
In-Reply-To: <498bad3f-6a0c-4da8-b645-1cc837ba1836@amd.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Wed, 20 May 2026 00:37:17 +0530
X-Gm-Features: AVHnY4JLPLREjlFQlvgLENpmGP3E8pQd4KIJLbfBlcZiF8utheggWRXZeetRwws
Message-ID: <CANTFpSWB6Fb3mo9sUtxo2Aaa-Ryx-YqUw-tqT-y1RpurJfq57A@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 19:58, Mario Limonciello wrote:
> You add a debug statement to amd_gpio_irq_enable() too right? Can you
> please share your debugging messages patch and full log?

I did not add debug to amd_gpio_irq_enable() - the statements were
only in amd_gpio_probe() and dw_i2c_plat_probe(). I can add one there
if useful, but given Bart's suggestion below I'll hold off unless
needed.

> What is the boot time impact to adding device_is_bound() check?

I haven't measured this explicitly. The deferral only fires on DMI-
matched hardware (Lenovo 83TD), so on other machines dw_i2c_defer_for_
amd_gpio() returns 0 immediately with no overhead.

On Tue, May 19, 2026 at 20:18, Mario Limonciello wrote:
> I like this idea.

I'll test this patch, and let you know how it goes.

Thanks,
Hardik

On Tue, 19 May 2026 at 20:18, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 5/19/26 09:39, Bartosz Golaszewski wrote:
> > On Tue, May 19, 2026 at 4:28=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >>>
> >>> gpiochip_add_data() at 0.285952 makes the GPIO chip visible to the
> >>> system before amd_gpio_probe() has finished. AMDI0010:02 starts probi=
ng
> >>> at 0.301454 while amd_gpio_probe() is still completing. This is why
> >>> device_is_bound() works and initcall promotion does not -- it waits f=
or
> >>> probe completion, not just gpiochip registration.
> >>
> >> What is the boot time impact to adding device_is_bound() check?
> >>
> >> Bartosz, thoughts?
> >>
> >
> > My thoughts are that ACPI could use some fw_devlink. :) It's not a new
> > problem, we've fixed it for OF systems.
> >
> > Could we modify gpiolib-acpi.c to return -EPROBE_DEFER if the parent
> > device of the GPIO chip is not bound yet instead? When resolving the
> > reference to the remote GPIO controller we have an address of the
> > struct acpi_device. I suppose there's a platform device that is its
> > child and then the logical GPIO controller device, is that correct?
> > Can we check if the platform device in question is bound at the
> > subsystem level?
> >
> > Bart
>
> I like this idea.  I guess something like this:
>
> diff --git a/drivers/gpio/gpiolib-acpi-core.c
> b/drivers/gpio/gpiolib-acpi-core.c
> index eb8a40cfb7a98..e3511398b1f84 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -142,6 +142,13 @@ static struct gpio_desc *acpi_get_gpiod(char *path,
> unsigned int pin)
>          if (!gdev)
>                  return ERR_PTR(-EPROBE_DEFER);
>
> +       if (gdev->dev.parent) {
> +               scoped_guard(device, gdev->dev.parent) {
> +                       if (!device_is_bound(gdev->dev.parent))
> +                               return ERR_PTR(-EPROBE_DEFER);
> +               }
> +       }
> +
>          /*
>           * FIXME: keep track of the reference to the GPIO device somehow
>           * instead of putting it here.
>
