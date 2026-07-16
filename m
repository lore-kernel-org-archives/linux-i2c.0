Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F63451CF
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179777; cv=pass; b=g9a6Qb2xPYytXPVkl4jkMY1Jxsbg3wCZUgHSoeieyhajiz9InMCrB9b5yizua3jnuY3Ked+hc/ZRY56xrjVEjJjjnKhei9bcXDmUu1KG8MxQO7T0dy2/vOOIV4/ud8e2rCvWsSkanbZUMz1145kfxyyPAhXJgFSJRHcxOs6nC4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179777; c=relaxed/simple;
	bh=TfXSdIHJZHVeZvsBhPmQzYpHw4qGEy2sm/iJXLYrUCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gccytuO9i8SvdHDBs1vAAi1SArKTxNGtggLedz0y/YmF80tATAQKZaZa2pjkdi7pNTEe3F6KfCYdc2kXQCM6z2NbMknSRvjV+ykoPN2DuApX6n4wBEv7HbXsnv5OF0LHHyVToyJbKCqxlMkPSV/qFuHEx66IJSTW1cdh5lzj4gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq3n2R+m; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq3n2R+m"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8111c0c7561so86267087b3.3
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 22:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784179775; cv=none;
        d=google.com; s=arc-20260327;
        b=ozgki6X/JaHbyyxI95jsmy+RvHXJsR5SI7TTzA5hlQ4dEcLLzICK5GK0TP/JqKYcBD
         upe0wgOv6eNHw8tzb9u9PNFdAxP2UOb5GtrH5yJGKQMKqGOxwoavcGM2lpleO7iUWhJa
         4IRUpQpliRMRGi6R3gr/pv83hpG8WoDbShDGw723k5XbC66P3TvOo88ECvET4iOUCY7x
         Iakd+tsnyM1fqTEd8Zo9s4/qOHEO+/NRJ6+Q5dUrqmTT099GgzALFtWXMLIX45tiWF/2
         wGyhxr8UViznofCsBMHpgAb+qQP7DurmkT7G1sdwfZgzzyg1U32kIxqCGAW2ofVFPa/5
         h5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pvcVlUjrY6LXJRgT8HSChI2okJYi2RCEoHfgsrqcQlQ=;
        fh=adlfq5vem7a9qUlFJy/Rg/TDNX2r9ReV6/uhR9RNyAA=;
        b=m7OfOP5WLYKB/DpL6ey/Da8UhrArWapfYbakZwxTov89b3rLGSUXYdl/nFNDUDsZni
         Jhz7ITmiMMpEeN4tHSqPiz0q+6L0Vpr0+WNZQYORXIXC/rBCk3eOemQSrZoB8YrYSojh
         ABzwItgfDCC3LzI8t3fbXGD4u3wi15k/cmLocW9Yd3VxNdQWqhsj1pqS5Eg1+6WH/BRI
         29KRiRLBOA7Y+Ed2hClkrEEtRXRwWGdQTlGyfzOeh8SJ/ffMrO6bYdIyebNvjIGb9AMQ
         iUD7qdiVVT0iwEj7Q3iCiKWYmKgcLInugl+7P7ttTMOLJhaXJs5xLnvRzpysok9kPOKr
         +Dzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784179775; x=1784784575; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvcVlUjrY6LXJRgT8HSChI2okJYi2RCEoHfgsrqcQlQ=;
        b=Bq3n2R+mkjfaWA+t+nRwajBvDnRidIWngpaaQG3Tl2uTqTShfoLdCgIfgeYmJRhWuz
         Z34lVD60UP1psnT3e6ccXssMB2Qf6DSs97QEQEf+BjTjtHIa7hWUFCZp/z7O/dxpYKhw
         HjwUC3d46iBYgojZN8Yl7797O9gbruW7N+wDqVAD3lzh29iy9iO3XsX/OJ/ufUtCVP9Z
         QKsduINAvi1LGuXB2cYlbWL2yP74oK5Aykh7lIeUwM9bVII8xiagbj2BKzxFhFS1yKql
         NsjYHPS5zHu5DNA0Gq8XOSozFIlNKZiX4Jxv6vSLo0wuskFC7u0JtnLfQlPz4YXKzy6O
         UNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784179775; x=1784784575;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pvcVlUjrY6LXJRgT8HSChI2okJYi2RCEoHfgsrqcQlQ=;
        b=nVmZgp+sB7I/KWORCmYHsgtvb0Nna3jOo/2NBFStQw9Z6GiEVZuBj43cZHR0iVJMgQ
         MP1DuLDD0FCnNGHbpK6spGDv1veKixC7WYTDqT7JGJtyJPtx4dg66c0IXZ2BNIUdOplM
         mw12wT/G/ioIIPyx/qkYILbuXzJJmE99wLRgUtVCcr7VR6kztgZtvvViEwDGciJ1iRHv
         K/4KMf8QxFzMUX1NoI3tGykILJDFQy7+gLkl1OwkxHqSP61TyaMxFbNMg1qmHhcOiXKm
         zQxtlyuI5G9qQCiobp2h3GAKnlj6X7nJ20U2GI/fQtOoRTV1p0MnqNtLr3F66NXxrBNy
         6W2Q==
X-Gm-Message-State: AOJu0YzQ7Uc+9rFGg/1Ukz9IHsmC/UFHf5CT9llarxKE5oMMGircDeqB
	Q94MAE87+PSRtpYJEjgAwac0kVnfciHbuKqK7qtFpmmgbZNmIxsw/QkV6kYAkzphmuy079eP1W2
	n/Jkfgfy2ge/ULeMXrbt6g/FXreNNtNo=
X-Gm-Gg: AfdE7clbwtHTPxf+qh6F9YfkMz0s5jH+ParhBADN5zaGAwcXvJ2Ou9JUVb+fuXhaX5J
	1eBS6rvFERicXQUXlVHz4JRQulHSYCIKmZIHMkUQek+ELZCad5tUHUHXXo75pzkgcxNsFuOH/z3
	YWtaDfmJtFVxX98reIM4o2mO8QgdQS2t5Rz5JzFS8NkDFPZ6RTRDmyAk40p1hXKfnEmdhYrpDCv
	1xmvKYtpUyeiJsQvm/vjl0ug/LLv5VceGAdF5GnmfTfLDYCpyn7LlVpVsfakvIYrUl5AZYMsg5H
	GrBQUGKZ302sMOK8n/jXRpeG13jipJ+O/7FFQToldzT6VdRf6/qhewDUY4QM65v4ghyz/5KH3s1
	qRrSUQPT45VVTch9HVENN0Td+wvcfjM5lkmQUzS60E0/HyP0=
X-Received: by 2002:a05:690e:4361:b0:667:c93a:82f6 with SMTP id
 956f58d0204a3-6680771e5c3mr4976955d50.35.1784179774880; Wed, 15 Jul 2026
 22:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715114701.7713-1-hardikprakash.official@gmail.com> <aleWco-IEiXdOZkp@ashevche-desk.local>
In-Reply-To: <aleWco-IEiXdOZkp@ashevche-desk.local>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Thu, 16 Jul 2026 10:59:23 +0530
X-Gm-Features: AUfX_mw_l_QppdCMRGjsIfdh9SRLpxQ572KbjLg1YIn74-j3-l5hrcLXg0vkWoA
Message-ID: <CANTFpSUBqqKm9d6OThea+i4oKd1-SNRSrFtYs-x=PbOaUboTrw@mail.gmail.com>
Subject: Re: [PATCH v11] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026, Bartosz Golaszewski wrote:
> Please include the entire changelog in every new iteration. I believe I gave
> my Ack for this and now it's gone. I have no idea why because there's neither
> a complete changelog nor links to previous versions.

Sorry about that, I will include the full changelog history from now on.

Here's a catch-up: since your v6, v7 Ack, the patch went through the v8
regression (NULL ptr deref + probe deferral loop), a v9 revert+fix
split, and now v11's restructure around gpio_device_find_by_fwnode()
per Andy's suggestion. The core approach (generic GpioInt dependency
check) is the same one you acked at v6.

However, given the amount that's changed since v6, I wonder if you
might want to take another look before re-acking.

Thanks,
Hardik

On Wed, 15 Jul 2026 at 19:47, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jul 15, 2026 at 05:17:01PM +0530, Hardik Prakash wrote:
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
>
> ...
>
> > v10 -> v11:
> > - Replaced custom gpio_controller_ref list with gpio_device_find_by_fwnode(),
> >   as suggested by Andy, dropping the linked list and dedup logic (~60 lines)
> > - Moved resource-skip explanation from commit message into a code comment
> > - Fixed device_is_bound() to check gpio_device_to_device(gdev)->parent
> >   rather than the gpio_device's own internal class device, which never
> >   has a driver bound to it
>
> Thanks for an update, looks much better!
>
> My comments below. I think v12 will be final if you address everything as
> suggested and answer to the Bart's request.
>
> ...
>
> > +static int check_gpioint_resource(struct acpi_resource *ares, void *data)
> > +{
>
> > +     struct gpio_device *gdev __free(gpio_device_put) = NULL;
>
> This style is discouraged. Please, move this below.
>
> > +     struct acpi_resource_gpio *agpio;
> > +     struct acpi_device *gpio_adev;
> > +     struct device *gpio_dev;
> > +     acpi_handle handle;
> > +
> > +     if (!acpi_gpio_get_irq_resource(ares, &agpio))
> > +             return 1; /* not a GpioInt resource, skip */
> > +
> > +     if (!agpio->resource_source.string_length)
> > +             return 1; /* no named controller, skip */
>
> > +     if (ACPI_FAILURE(acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle)))
> > +             return 1;
>
> Can be rewritten as
>
>         acpi_status status;
>         ...
>
>         status = acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle);
>         if (ACPI_FAILURE(status))
>                 return 1;
>
> > +     gpio_adev = acpi_fetch_acpi_dev(handle);
> > +     if (!gpio_adev)
> > +             return 1;
> > +
> > +     gdev = gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
>
>         struct gpio_device *gdev __free(gpio_device_put) =
>                 gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
>
> > +     if (!gdev)
> > +             return -EPROBE_DEFER; /* controller not registered yet: abort walk */
> > +
> > +     gpio_dev = gpio_device_to_device(gdev)->parent;
>
> > +     scoped_guard(device, gpio_dev) {
>
> Can we use simple guard()() here?
>
> > +             if (!device_is_bound(gpio_dev))
> > +                     return -EPROBE_DEFER; /* controller not bound yet: abort walk */
> > +     }
> > +
> > +     return 1; /* bound, skip adding to resource list, continue walk */
> > +}
>
> ...
>
> > +static int check_child_gpioint(struct acpi_device *adev, void *data)
> > +{
> > +     struct list_head res_list;
> > +     int ret;
> > +
> > +     INIT_LIST_HEAD(&res_list);
>
> Instead just define with LIST_HEAD() macro.
>
>         LIST_HEAD(res_list);
>         int ret;
>
> > +     ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
>
> > +     acpi_dev_free_resource_list(&res_list);
> > +
> > +     /*
> > +      * ret is a nonnegative resource count on success, which must not
> > +      * be mistaken for a nonzero "stop iteration" signal by
> > +      * acpi_dev_for_each_child(); only forward genuine errors.
> > +      */
> > +     return ret < 0 ? ret : 0;
>
> Check for errors when it's required. I believe you fixed it at some point
> and now it's again old version. Please, reduce full rely on AI, it's not
> helpful sometimes.
>
>         ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
>         if (ret < 0)
>                 return ret;
>         ...
>         return 0;
>
> > +}
>
> ...
>
> > +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> > +{
> > +     struct acpi_device *adev = ACPI_COMPANION(dev);
>
> This style is discouraged as it brings an unneeded burden on a maintenance.
>
> > +     if (!adev)
> > +             return 0;
>
>         struct acpi_device *adev;
>
>         adev = ACPI_COMPANION(dev);
>         if (!adev)
>                 return 0;
>
> > +     return acpi_dev_for_each_child(adev, check_child_gpioint, NULL);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
