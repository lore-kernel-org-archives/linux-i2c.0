Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20132C92D
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253365; cv=pass; b=qkuugA/Avr1SfxwFYJ7hBvbXVAI72Pprq/IGE+ExWF0YA5QAKdXERvJABovs0WSJX1Adb3+SWLVgKnQQ8p+YNwj19Q2U4VZ4MXcVK6AYj5yCI6R9q47zj5Ues2Cvvxe3MfJ+YzobP/NkZtSNHnATW6KgG8x5RUOKpfO0nXZrFKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253365; c=relaxed/simple;
	bh=kOMU4JRALAx1PPMHviOfocpGbFLDk2uw1Uwsz4sKjmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhynlERxavTBxefF7I0eO69lxxf+/zuA9G7vHSON6q+hhzdrRaCXTTZPQiRUsXRWGr+HrPjaU4eyTC2wthWwKOgGqGoUw7XLxQsRgnWkAOKOWUu6X73TQj/fCgQkehCdsdrhJLQh/ywRsICmsFSSYPKsjTynqLXcl4Akav1Ybk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIZk0PEN; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIZk0PEN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7b41fdf9de2so29684837b3.0
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 22:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779253362; cv=none;
        d=google.com; s=arc-20240605;
        b=iNOouIMM5Yf2rj6MXUb0YS/TNqCJkZmy5G2sNsElpKBNjdM0oChH2kfMQgriYaXwZ+
         Wuq42Ov19nalYI7z4pb+33toCJgd0iA8kXL8EdkM46vm4oxeZidFkr47JHetCHCytpL5
         8Ct9KjVJHMDGO/xNnoCZu+myrPZ2zVmDtsp2HYueIE9eVIBuKiNTeIQpm1xm9q5ctNXE
         N/JBP//UQ2wkGSvRCJokRExCTYXyOUxshO05IIk0RyuTM3w9avN5kULTV4UXt4xqN7WR
         fSZ0okAwjtCsYwFZJ1etOwykUwXomJ/LsqNqWGwYDYZBKMQHMekHODnp9R40/TumkPvV
         o3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IRQZffS2t0p0/rIvRDX0SBwpdKZj3l88oeth2+pVups=;
        fh=AWmsr51Uzf/FSboZF9Ah4Dn8p6HI0K7YBRXb4zK5EB8=;
        b=lCSGta3PXHQ+cqmL4U+teiDf6tIoJZthF4pNE+jbxt27a+w9WZ2yN67n9mhFJYFaR6
         NGr/KboGey2HKLfnGdeCc9k59NXKNj1YoT2IrK8lFQlLOLjynAvGTai4a3mVK95T6s3J
         42i1NtbbYBK2SdNovscwQfkwEthNrISBsns4LydFl9AzkOucCNv0KaVTiNVpCzqbmMGI
         bxGMbtpFlnfyg+jwdKjAACNMaw3UscN/pqmPN0glSmrlzNEA8c40hcB7p/kE0Deaw9pU
         F3KvSZfgurmjUWrPkbnK1azQdJPFk3D2ED5j9Ntjzs8YcUORIuU7gWbMM1jGWZGUCBYl
         uYug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779253362; x=1779858162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRQZffS2t0p0/rIvRDX0SBwpdKZj3l88oeth2+pVups=;
        b=VIZk0PENp9raoyuZwcZWY33iDSS4mT9MTXxJQshGwCMFfnpYwtQsj2DXCwnqzRqPia
         wxmjnwEacjZ+ijTsLyzu9UJStf9QsuzSi2M5x7lQy7BZgrXQ7dx+XEBP3OLiWVF3MDWP
         CZZmTPmwEqXeYFqcmOuRJ0lhKrsTCh2e9Vw4rsaLFR8GTnna5SO+1gFT5nwOT4bsocxT
         VMxHnTj7hzwVv9EzVMosnLcN5NTBYp8dD1cwwmcNsG/bBPpyT5hwN81z8ycRa7H2JSk7
         L7GjUwVKf7AQAhzW0JGNEKx3SItPJTHvZxR696avbBrrm6R4tgKiwRH6o1exUS0KnTEA
         DAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253362; x=1779858162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRQZffS2t0p0/rIvRDX0SBwpdKZj3l88oeth2+pVups=;
        b=hahvg8T1yOxjYWxJ3FC00EM6CAgcbJ//aFsBaivW8Jej12dSJlslupfbQrEOImOkvQ
         8hLGXXqkYu5Wlp3JsLRzStboGrI8JsT8pSbkt5zgbPMis7Ur5zcBlBXDnIBTjlFLEiZk
         9U1OnrZVYLxIqNZb1W9mu5PW8HvhIRchE+XWjS2hX/lGRIiOMkdNLKCvx7rG0SZNTNt2
         UDSH6ESI0DQNDlQj6IZw1Wor8KPI/ZEnsXh4ks7cM55HkQlN5UKetkY4F50uJBQwow/s
         E+JteOB3GPFRzlC4xsEdSlNjNFa8dNSwQ0s9wafrFAIn+8UbQpse3ASXn9481+bVyzlR
         WyzA==
X-Forwarded-Encrypted: i=1; AFNElJ9m2+IJ6UzOHgyvWXHQNT6YAJbRp+HO9/Q7V9K4iq5r4iJeHTYYTWC/lXjdeu1cWd1GAEH9WxeaHN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiG8ZWM+zDassh148/xoUuQ+R7+REpO7sLUHUboS2Pz581llUo
	EnL34qi1ELdxdZ+voV3W3ywme5wiqS4FlwIU2IeQoPvEwPCxJ0fuHc7+WZZGcLH9m5Jy8zeJvOH
	1CbXMWan0DB8h+WiQlLgPHu4ZvrOjZnE=
X-Gm-Gg: Acq92OHYo4zQsyE/6Us+y24OfkgAp3jAmROVgbWB3XKvRzycoo3Ra12RJ30nVvrlc8o
	q7+4U2yuOQOFDBlVjgf6hM5dcI0yAMo9WWanzaL4N7B6hRPo4jCoDOMp/h62Olmtlvz6DdzRhQZ
	KFxp3iYJUUuc36GJYPRNGrBK59RVqArmsYmiKaxNiTK7sj01idmy9j1PZnlFEzGTrKMs4Q9Z1I9
	YNpht22SM3igeyOaQpVHzQJzofHifuOaPESs9j9w1p6e9ZHysWAnN36+ksuDc9IM80wmSj8vxEG
	IWuHTyQi1goSL2zfh4T1+pntRuxlbjBuIkn9w4k1mQyQp5mz0QfrYlmD/djpMtNMrPKPdGDwUYX
	XLhfLbiCez8JXWVDJtatXg//zTlelGWxO2H0x0WJhcdpO6tcBRJT+qMnatg==
X-Received: by 2002:a05:690c:d84:b0:7cf:d9bc:8079 with SMTP id
 00721157ae682-7cfd9bcee40mr45213447b3.32.1779253362325; Tue, 19 May 2026
 22:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518122814.8975-1-hardikprakash.official@gmail.com>
 <CANTFpSWGC7GsAY-3UvPtBZzqjNek-T5haiDb59QYRoRgwuQf1w@mail.gmail.com>
 <7d0f0cf9-1936-4cf6-a425-228a37f83137@amd.com> <CAMRc=MdS_BVKb=FQLhky=8dpghBSoHeBhUk0LM5hROFxmJeyGQ@mail.gmail.com>
 <9d5da93e-bbe0-4359-9f17-e3c6b3a5cb34@amd.com> <CAMRc=MfT_WVMxPnYZW=mg52PHew0O4VQMGFrfo6G9vxZDDoArw@mail.gmail.com>
 <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com>
 <agsh652HlC4rg1_1@ashevche-desk.local> <CANTFpSU7XaNKwe_FPsTCkxQYeq78Tqusr-nsB-Ww0_teuiWdEA@mail.gmail.com>
 <f0ee2722-1e56-41b1-b70c-5503a2495853@amd.com> <CANTFpSWT+cR8Yxyr5jrB2MUidqKteWuPjHOyK_rpSkDUN6SWQQ@mail.gmail.com>
 <c4993bce-5d39-416f-90ed-d870f4ac9254@amd.com> <CAMRc=McSLEF_nrkRdJJu9=Bc_KmPWYKDHd6tOD9tJqs0fksv0w@mail.gmail.com>
 <498bad3f-6a0c-4da8-b645-1cc837ba1836@amd.com> <CANTFpSWB6Fb3mo9sUtxo2Aaa-Ryx-YqUw-tqT-y1RpurJfq57A@mail.gmail.com>
 <CANTFpSU+wTQeESDGqV=xizrJeQw_LA8y7stDYMm=H-UrbWXeYQ@mail.gmail.com> <e31e28e7-62b0-44a3-b155-57504be09c69@amd.com>
In-Reply-To: <e31e28e7-62b0-44a3-b155-57504be09c69@amd.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Wed, 20 May 2026 10:32:31 +0530
X-Gm-Features: AVHnY4ISQ7dzkyung1tqqCXziMIawOzymKcYnxYgzGW2fo_vdd7Wy2YItbxaY20
Message-ID: <CANTFpSVnhst-25KPa-m2e14rR_dqJNq_s6k_ZO-MFazqLa=AEQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 02:23, Mario Limonciello wrote:
> In the same line of thinking - how about something like this instead
> (AI generated and attached).
>
> Basically walk through the resources at probe time and make sure they're
> all bound.

Tested. Works perfectly =E2=80=94 clean boot, no arbitration errors, touchs=
creen
and stylus fully functional:

  patch 1 + generic GPIO dependency check:   clean boot, touchscreen works

The generic approach is better. With this patch, patch 2 (the
DMI-specific i2c-designware deferral) is no longer needed.

Note: I applied kzalloc(sizeof(*ref), GFP_KERNEL) in place of
kzalloc_obj(*ref, GFP_KERNEL), and moved the goto outside the
scoped_guard using a local bool. Happy to share the exact diff I tested
if useful.

Thanks,
Hardik

On Wed, 20 May 2026 at 02:23, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 5/19/26 14:49, Hardik Prakash wrote:
> > On Tue, May 19, 2026 at 20:18, Mario Limonciello wrote:
> >> I like this idea. I guess something like this:
> >> [gpiolib-acpi-core.c patch]
> >
> > Tested patch 1 + gpiolib-acpi deferral, without patch 2. Arbitration
> > errors persist:
> >
> >    patch 1 + gpiolib-acpi deferral:   arbitration errors, WACF2200 does=
 not probe
> >    patch 1 + patch 2 (v5):           clean boot, touchscreen fully func=
tional
> >
> > I think the reason is that i2c-designware does not call acpi_get_gpiod(=
)
> > during its probe. The GpioInt resource is on the WACF2200 touchscreen
> > device (TPNL), not on the I2C controller itself. So the deferral in
> > acpi_get_gpiod() never triggers for AMDI0010:02 -- nothing in that prob=
e
> > path requests a GPIO descriptor.
> >
> > The race is between amd_gpio_probe() completing and dw_i2c_plat_probe()
> > starting for AMDI0010:02. Without something that explicitly checks
> > whether the GPIO controller is fully bound before the I2C controller
> > probes, the race remains.
> >
>
> In the same linke of thinking - how about something like this instead
> (AI generated and attached).
>
> Basically walk through the resources at probe time and make sure they're
> all bound.
>
> > Thanks,
> > Hardik
> >
> > On Wed, 20 May 2026 at 00:37, Hardik Prakash
> > <hardikprakash.official@gmail.com> wrote:
> >>
> >> On Tue, May 19, 2026 at 19:58, Mario Limonciello wrote:
> >>> You add a debug statement to amd_gpio_irq_enable() too right? Can you
> >>> please share your debugging messages patch and full log?
> >>
> >> I did not add debug to amd_gpio_irq_enable() - the statements were
> >> only in amd_gpio_probe() and dw_i2c_plat_probe(). I can add one there
> >> if useful, but given Bart's suggestion below I'll hold off unless
> >> needed.
> >>
> >>> What is the boot time impact to adding device_is_bound() check?
> >>
> >> I haven't measured this explicitly. The deferral only fires on DMI-
> >> matched hardware (Lenovo 83TD), so on other machines dw_i2c_defer_for_
> >> amd_gpio() returns 0 immediately with no overhead.
> >>
> >> On Tue, May 19, 2026 at 20:18, Mario Limonciello wrote:
> >>> I like this idea.
> >>
> >> I'll test this patch, and let you know how it goes.
> >>
> >> Thanks,
> >> Hardik
> >>
> >> On Tue, 19 May 2026 at 20:18, Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>>
> >>>
> >>> On 5/19/26 09:39, Bartosz Golaszewski wrote:
> >>>> On Tue, May 19, 2026 at 4:28=E2=80=AFPM Mario Limonciello
> >>>> <mario.limonciello@amd.com> wrote:
> >>>>>
> >>>>>>
> >>>>>> gpiochip_add_data() at 0.285952 makes the GPIO chip visible to the
> >>>>>> system before amd_gpio_probe() has finished. AMDI0010:02 starts pr=
obing
> >>>>>> at 0.301454 while amd_gpio_probe() is still completing. This is wh=
y
> >>>>>> device_is_bound() works and initcall promotion does not -- it wait=
s for
> >>>>>> probe completion, not just gpiochip registration.
> >>>>>
> >>>>> What is the boot time impact to adding device_is_bound() check?
> >>>>>
> >>>>> Bartosz, thoughts?
> >>>>>
> >>>>
> >>>> My thoughts are that ACPI could use some fw_devlink. :) It's not a n=
ew
> >>>> problem, we've fixed it for OF systems.
> >>>>
> >>>> Could we modify gpiolib-acpi.c to return -EPROBE_DEFER if the parent
> >>>> device of the GPIO chip is not bound yet instead? When resolving the
> >>>> reference to the remote GPIO controller we have an address of the
> >>>> struct acpi_device. I suppose there's a platform device that is its
> >>>> child and then the logical GPIO controller device, is that correct?
> >>>> Can we check if the platform device in question is bound at the
> >>>> subsystem level?
> >>>>
> >>>> Bart
> >>>
> >>> I like this idea.  I guess something like this:
> >>>
> >>> diff --git a/drivers/gpio/gpiolib-acpi-core.c
> >>> b/drivers/gpio/gpiolib-acpi-core.c
> >>> index eb8a40cfb7a98..e3511398b1f84 100644
> >>> --- a/drivers/gpio/gpiolib-acpi-core.c
> >>> +++ b/drivers/gpio/gpiolib-acpi-core.c
> >>> @@ -142,6 +142,13 @@ static struct gpio_desc *acpi_get_gpiod(char *pa=
th,
> >>> unsigned int pin)
> >>>           if (!gdev)
> >>>                   return ERR_PTR(-EPROBE_DEFER);
> >>>
> >>> +       if (gdev->dev.parent) {
> >>> +               scoped_guard(device, gdev->dev.parent) {
> >>> +                       if (!device_is_bound(gdev->dev.parent))
> >>> +                               return ERR_PTR(-EPROBE_DEFER);
> >>> +               }
> >>> +       }
> >>> +
> >>>           /*
> >>>            * FIXME: keep track of the reference to the GPIO device so=
mehow
> >>>            * instead of putting it here.
> >>>
