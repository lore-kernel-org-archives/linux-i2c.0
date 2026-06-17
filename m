Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00C30EF6C
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724182; cv=pass; b=U+fI0Zt4uyiWBW6IBddyJXJN86ICKf64qtjd0HExOD6/8+pe6YuXx1BNvE/1XmwMyhn3mlAmhFCkHvIOrezSjddfcax5hEAIRO0PHwWmrTHiUlqklNsISA9BNei2qSVq1QmB/IiECpHjhTtxBonIQqk2DyAR3DoRdyVwKCxx+7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724182; c=relaxed/simple;
	bh=kkdL8pb5EYmv26GllFDBQ07biypjdEituDlXNPeSrpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFv0Kilydn81+bifElqETtYGN18oRpA9wErEoRDtgI8lH5BEODs6qI5qbttWvQXf3wwm2CsUilKem6AGZqQMSlmZcJ3siyrv4dl3SDoS00K5sre6OkL1+jmcRzWEoQRcI1y6g6pWjXblyCCW8j39dvTLqZ54SKclev+2VzCr8Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqlsYcqz; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqlsYcqz"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7fe8bc0a01bso2042287b3.1
        for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 12:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781724179; cv=none;
        d=google.com; s=arc-20240605;
        b=jpe8aXHf1k8IIDS+qHpii5laPT5r6+CnBMWdZL6yovt/bw6QBZTRJEGw+Mkzvf/+gk
         o8JZ2uAqRyD4+bNN4X2MMHLxk8MAKkWNNTXLK7aJzebaE8s/8eBNoGWTcXO92oBeEuC4
         6hgqZFN9H/oUoYha8ov4/FDV/BMkvRzT/F+94UWQ2g+aqbrYpoU1O5hUld9iw1lNR+5t
         rDsv4WC8VL+Tyyp9Q6pbqfT4JsdINnSoahBuQgfRjSp+FFgZPVffgUGim7Z/J/Upm+iV
         fT+K31uoYpzD5s/iQMPc6mbzofBCHiGrnW/Okoa03scS22grAg45a8Xrp2t3ycHptwSv
         V4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qCYjocoLg3CrCDEI/FISPfSrPPe+uK1kIVJZnXGGH+8=;
        fh=adlfq5vem7a9qUlFJy/Rg/TDNX2r9ReV6/uhR9RNyAA=;
        b=bhUGaxI3V1hPVH0WwiZ4cuDacN+3MoUJIahMeFXcfFqREvTFq+WnKAvRxTFfUQENdN
         3BVqSfe/HLq+cj7osJ5QotlNigtI1VSyJyfQqr8AFZNlnXPrluOe2ejbevXokj3evDsq
         fvp454x5R5sYes/RmMp2OeLMKR+NniGB8SA0hJG4c1xQLgcTk0a2c3sB2RVhk5AbD+YM
         lPD/RfdEm3HBgBt/MuQd/ktWaVpR/CIG52xqP42qodfTgKUcFWa0IJOsrVE5IA1QG5Bk
         GWegvgJh6NsVY2O6qr9y5V6skrX8lQqqLBdgb6VfMie2i7nR2PFbnwS6pjhrLKL5VTSo
         5O3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781724179; x=1782328979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qCYjocoLg3CrCDEI/FISPfSrPPe+uK1kIVJZnXGGH+8=;
        b=AqlsYcqzLP4SxskCR9DxcqMI9jL+8IbdkuWcMbMjiFE71Zczd1gjIa7OxA21dqgZBu
         SqxzNLe+QemKO7uby3nkYdT2Q/Q1TeITGHxgWQvH1FGvGNwIrHWIv4hYvd5NfQxXIQrL
         4w2cq1J1FSQHzNtaPFlMo24Q32bUSembfwOtdNt2KSbCUqnQB8OrCbjRtNFLvxNaNK0V
         z12E2qRxuTv2DEbp9gv+5dLHjE7zssIZSTWRC4WYNXRklPjMmfZPRVu6xnRxN/cbq1Oc
         6hdNlw7G59hDF0i0fXmxwRTrgUI0aTUp12c4SD5aJdF1no32iTOVba9BLxTS2M179Ih4
         GCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724179; x=1782328979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCYjocoLg3CrCDEI/FISPfSrPPe+uK1kIVJZnXGGH+8=;
        b=FhoM+JKD1JXQjtOO0Z/RpqIT8kM7XV+GMvXpwfHU+fVHtu7IU/K+20P5KnQ6GLeOys
         zMgyc3BG81S4BjpnZN1yWxfev9Ra9wnx8NJOmVehMQDbaF+w2A8SFVrfaJhTXJD5X/gH
         kd7EeLo/YhiEBY9dRmxwoE/27Fcs+m3giN3tvKM5rbWrT0FSMgNlKLYaiIeMME61q4Ms
         6Fh6zJA3HaxSSuL0pw1b9XyEpEfDdhvmuX0p/y2iO0nktNgujo3ebLX89mEi9OxOgYEm
         GrBkkt1+RTnNulklHnOOKWe+JDIrMJl3TRi7k/LwO40TUqY7N85nqbZkGdf8oK/TMker
         5LwA==
X-Gm-Message-State: AOJu0Yzjn+QKGZPyt3kapX6pMUTX1D+a9SxEPQQ/q/qNhXpZh9HoDoXq
	VzIxp+PbZGDzZILlI80XtYYOCLQ1zAxTKqwGGaaHtkVwXNK/R74MsW8ewTcy7bFJf5x7e38uqTI
	UFApuikBTAZHDb5SGVpHUD3lG/v59Res=
X-Gm-Gg: AfdE7ckStIhNdVqD6tefjw32kWsnxTBUTQ/w/dBczasmOajV3f4WPACscMhRKYEDQJ2
	7banKzOU+4lIgPYguv1wkBUEIsBMNdmAt68JZf6eRVvRbGVzX37kJkaKZrdBq8IZXD90hWJP2I1
	1kAqsJhVN1fLW6U6v10SuFaBsgb6BiXY3mB6kTiCulHSG9WdzGoZNDOviNwo65z4+A4mPVr/ivP
	t8y3xeGJGxzQ8ycniFdtyJ0VmrMGpJ/s8R7DGKiTa/FLPBwvrGBWUFpEszDtaZBBqIc26yAuo+1
	argamKl0j9j9o3GFh+whlgvqH/kZhYnu58bicLBqcyftOI24vLxhs27B3A6FImTSpYFA/mar4nF
	IDZVjPEqZpqvx1x+UukiZzzbrYTkiYNSp8YomRrHWlKkXV7LDEaed6ra5BQ==
X-Received: by 2002:a05:690c:15:b0:7ff:1a06:472 with SMTP id
 00721157ae682-7ffc504f31amr3633587b3.4.1781724179369; Wed, 17 Jun 2026
 12:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617065922.26004-1-hardikprakash.official@gmail.com>
 <20260617065922.26004-3-hardikprakash.official@gmail.com> <ajJobvY67HKufaTs@ashevche-desk.local>
In-Reply-To: <ajJobvY67HKufaTs@ashevche-desk.local>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Thu, 18 Jun 2026 00:52:46 +0530
X-Gm-Features: AVVi8CdEl_6za-R-STzgXEeecIrtTkqRjlP_oenlQE43jm7-diiS5o2-ORNN9WQ
Message-ID: <CANTFpSUSKwTj-z0E2w3C_8ue8wANE+dHtDKboZ1+rqwN98C3cA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 17, 2026 at 14:57, Andy Shevchenko wrote:
> > +     if (!agpio->resource_source.string_length ||
> > +         !agpio->resource_source.string_ptr)
> > +             return 1;
>
> I'm wondering if we simply can move to strncmp() instead of this check
>
> > +     list_for_each_entry(ref, gpio_controllers, node) {
> > +             if (!strcmp(ref->path, agpio->resource_source.string_ptr))
>
>                 if (!strncmp(ref->path, agpio->resource_source.string_ptr))

Could you clarify? strncmp() with n=string_length would protect the
dedup check against a NULL or unterminated string_ptr, but we still
need string_ptr to be non-NULL before passing it to kstrdup(). Should
we keep a NULL/zero-length guard before kstrdup() and only replace the
strcmp() in the dedup loop with strncmp()?

Thanks,
Hardik

On Wed, 17 Jun 2026 at 14:57, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jun 17, 2026 at 12:29:22PM +0530, Hardik Prakash wrote:
> > I2C controllers may have child devices with GpioInt resources that
> > depend on GPIO controllers to be fully initialized. If the I2C
> > controller probes and enumerates children before the referenced GPIO
> > controller has completed probe, GPIO interrupts may not be properly
> > configured, leading to device failures.
> >
> > On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> > AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> > pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> > AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> > fail with lost arbitration errors.
> >
> > Add a generic dependency check in i2c-designware that walks ACPI child
> > devices, identifies any GpioInt resources, resolves the referenced GPIO
> > controllers, and defers probe if those controllers are not yet bound.
> > Uses acpi_gpio_get_irq_resource() to avoid duplicating GPIO resource
> > parsing logic from gpiolib-acpi. Skips resources with no resource
> > source string (string_length == 0 or string_ptr == NULL) to avoid
> > crashes on hardware where GPIO resources have no named controller.
> >
> > The probe ordering race was confirmed via dynamic debug tracing:
> >
> >   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >   2.348157  lost arbitration
>
> ...
>
> > +static int check_gpioint_resource(struct acpi_resource *ares, void *data)
> > +{
> > +     struct list_head *gpio_controllers = data;
> > +     struct acpi_resource_gpio *agpio;
> > +     struct gpio_controller_ref *ref;
> > +
> > +     if (!acpi_gpio_get_irq_resource(ares, &agpio))
> > +             return 1;
>
> > +     if (!agpio->resource_source.string_length ||
> > +         !agpio->resource_source.string_ptr)
> > +             return 1;
>
> I'm wondering if we simply can move to strncmp() instead of this check
>
> > +     /* Skip if we've already tracked this GPIO controller */
> > +     list_for_each_entry(ref, gpio_controllers, node) {
> > +             if (!strcmp(ref->path, agpio->resource_source.string_ptr))
>
>                 if (!strncmp(ref->path, agpio->resource_source.string_ptr))
>
>
> > +                     return 1;
> > +     }
> > +
> > +     ref = kzalloc(sizeof(*ref), GFP_KERNEL);
> > +     if (!ref)
> > +             return -ENOMEM;
> > +
> > +     ref->path = kstrdup(agpio->resource_source.string_ptr, GFP_KERNEL);
> > +     if (!ref->path) {
> > +             kfree(ref);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     list_add_tail(&ref->node, gpio_controllers);
> > +     return 1;
> > +}
> > +
> > +static int check_child_gpioint(struct acpi_device *adev, void *data)
> > +{
> > +     struct list_head res_list;
> > +     int ret;
> > +
> > +     INIT_LIST_HEAD(&res_list);
>
> > +     ret = acpi_dev_get_resources(adev, &res_list,
> > +                                  check_gpioint_resource, data);
>
> Make it a single line.
>
> > +     acpi_dev_free_resource_list(&res_list);
>
> It's not critical double free (it will try to free an empty list) on error.
>
> > +     return ret < 0 ? ret : 0;
>
>         ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, data);
>         if (ret < 0)
>                 return ret;
>
>         acpi_dev_free_resource_list(&res_list);
>         return 0;
>
> > +}
> > +
> > +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> > +{
> > +     struct acpi_device *adev;
> > +     LIST_HEAD(gpio_controllers);
> > +     struct gpio_controller_ref *ref;
>
> Reversed xmas tree order.
>
> > +     int ret = 0;
>
> Useless assignment.
>
> > +     adev = ACPI_COMPANION(dev);
> > +     if (!adev)
> > +             return 0;
> > +
> > +     /* Walk all child devices and collect GpioInt controller references */
>
> > +     ret = acpi_dev_for_each_child(adev, check_child_gpioint,
> > +                                   &gpio_controllers);
>
> Make it a single line.
>
> > +     if (ret < 0)
> > +             goto cleanup;
> > +
> > +     /* For each GPIO controller, check if its platform device is bound */
> > +     list_for_each_entry(ref, &gpio_controllers, node) {
> > +             acpi_handle handle;
> > +             acpi_status status;
> > +             struct acpi_device *gpio_adev;
> > +             struct device *gpio_dev;
>
> Reversed xmas tree order.
>
> > +             bool bound;
> > +
> > +             status = acpi_get_handle(NULL, ref->path, &handle);
> > +             if (ACPI_FAILURE(status))
> > +                     continue;
> > +
> > +             gpio_adev = acpi_fetch_acpi_dev(handle);
> > +             if (!gpio_adev)
> > +                     continue;
>
> > +             gpio_dev = acpi_get_first_physical_node(gpio_adev);
> > +             acpi_dev_put(gpio_adev);
> > +             if (!gpio_dev) {
> > +                     ret = -EPROBE_DEFER;
> > +                     goto cleanup;
> > +             }
>
> > +             /*
> > +              * Defer probe until the GPIO controller is fully bound,
> > +              * ensuring its IRQ setup is complete before we enumerate
> > +              * I2C child devices.
> > +              */
> > +             scoped_guard(device, gpio_dev)
> > +                     bound = device_is_bound(gpio_dev);
>
> > +             if (!bound) {
>
> Some of the compilers might complain the use of uninitialised variable (they
> might not parse properly scoped_guard() case).
>
> > +                     ret = -EPROBE_DEFER;
> > +                     goto cleanup;
> > +             }
>
> To make it sure and deduplicate above the whole stuff can be written as
>
>                 gpio_dev = acpi_get_first_physical_node(gpio_adev);
>                 acpi_dev_put(gpio_adev);
>                 if (gpio_dev) {
>                         guard(device)(gpio_dev);
>
>                         bound = device_is_bound(gpio_dev);
>                 } else {
>                         bound = false;
>                 }
>                 /*
>                  * Defer probe until the GPIO controller is fully bound,
>                  * ensuring its IRQ setup is complete before we enumerate
>                  * I2C child devices.
>                  */
>                 if (!bound) {
>                         ret = -EPROBE_DEFER;
>                         goto cleanup;
>                 }
>
> > +     }
> > +
> > +cleanup:
> > +     free_gpio_controller_list(&gpio_controllers);
> > +     return ret;
> > +}
> > +#else
> > +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> > +{
> > +     return 0;
> > +}
> > +#endif /* CONFIG_ACPI && CONFIG_GPIOLIB */
>
> I'm not sure if it's good to have all this quirk here or simply start
> a i2c-designware-quirks.c. Theoretically the PCI counterpart might,
> but I think quite unlikely, want to have something similar in the future.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
