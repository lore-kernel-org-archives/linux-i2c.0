Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660CF13AA2D
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179898; cv=pass; b=TEua8pye4e4HDQamySvHJZoFs9lR17t6wq3rGxjHfrRDZRzF0wpUFG7+hBiDJAICao8tDDinwhEYIODD7zGkaEnh/mRXpSQc4kT/2ERzHCeSvc1KBDYvG94asU/mQ0C47mqNBLei2RaGlr8RMsntCtuRlJHB085EJsdQZl17rX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179898; c=relaxed/simple;
	bh=vf1tLdwlxll7iMX8ejWjKoCj9GmbnCEI3OPdWhLotyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6IEGu2W51E8EF3vgEH9CaVWngvekUUC+VwLexa6LcL2wVd5UgESe7grBzHBVnz8vkhNFZRylrtzH3eWA5JOcBon3qvw3JEQRbOEKl9M2tJvN645ugc3UtIKwldIIg8lF+00C26Ugz6eCxEynDTaWiHESdDR1N0mrQsJReju/pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiwBBYWZ; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiwBBYWZ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80e2cfe6918so24330857b3.0
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 22:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784179896; cv=none;
        d=google.com; s=arc-20260327;
        b=qKPvUwJwBF3jOPyNT38e91Bz+e90+YfBNJxBw6sCvU4S8KXBpnkQScCKiapk7V1NYj
         S9HGpvhqMXI60JjKkMKu3GUIKnA5Wf6bRzLS59Ivbk4LWZWQU4Ab3g2HPVNL9Fd0soo4
         G8u3f/7SJiFvA1FXVE2L59v/tlSYok/x5h/UBgPN9n+4YiPlzvt8pcAoBlVSPKJ9cXKd
         DiOoxBP9XMZmj0pBwTei2wv4rHVaRRcXBcmcOBGen0zUrjDSHjenJjt7ybsgnWCrYC9L
         dgGwxYwAgbn/2PZWuRDq19ms6ueEQc7Ugrp2uND4o6qwD/WhhghMaJ03NmbCfH06eMTn
         b21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p2t8FhHOW+tC/RnLLbflTPK0p7GHhXVaV9v/WmWP7UU=;
        fh=adlfq5vem7a9qUlFJy/Rg/TDNX2r9ReV6/uhR9RNyAA=;
        b=XxiZCm1OUeIbsV3IWY/TMnuCRWQSNNTbGw4hmUwArLEEreYWCgvxW7uzcvNPashW2L
         TBHF/skY1i61RIFTAS5x3OOy20XV5CEQceAsup7lMzhObEEd0BbO6tFC779Ha4J9UrIj
         tGML1IVINnYIC4W4CTMATH72BRj0aICSLfPTbYagZL6ju3PqWFQtGjkFgKCt6y6Z7BUR
         IDevmd70U8Gj8WemuuOeuukyD3CUJO5LpXrCc5dtQMm5vnfnWVYXQbuwj5pwwwBhEaZn
         U93Qx0ZYvCKPkFkUU8RObO+IRXtUA3zV6T5euzunLQvLlq1MOcKL7TjuS8pj2k4Os2Wr
         1lcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784179896; x=1784784696; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2t8FhHOW+tC/RnLLbflTPK0p7GHhXVaV9v/WmWP7UU=;
        b=EiwBBYWZAodhT5/RFC0ifNHjx0ojY3qTkjf+GVqHukdRdzkRk6U8ldmKTJp9s2k9Js
         cnIuzNXEGAUrlHY4WQXMmZQMv4TFtIQWWEtWLVUd5qRE8m3OJ73TEy3BOpcblNXthPJp
         jAd9TlHNytWWREnkejv/yIsU/G+sAK9GZYrKtAGn9ruD7/nNR9O0IJ19yI8hAayofCq9
         Tyo2VugZyIIyg5UP9N3uue7iR1avRrYUK3mczURhZrJi4njGrRfSvxgYTwcx/gwlO/Tb
         oaQb/N825D250/3VddS5/DHevmqKMZRty1bAHM+4QHK3/6C1GYZCg2KAporYZpJtckDR
         evLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784179896; x=1784784696;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p2t8FhHOW+tC/RnLLbflTPK0p7GHhXVaV9v/WmWP7UU=;
        b=OdQIvzEoqcwqcxJRQ7CEb82f7FfGOGg7Exmy7HZRJ+NlY+kaUukg8GQ/EuLbA2cjET
         mnL3Hz0gcaV/RqTbSjrUDClpW3+Ly2wVfMejdgIiH+/Bar+wLWmlUnfujpbviLrUCME0
         1izUp6/IaZ+HT9tPDtcoyPnAYSEk0LpTtR8imqoxaa6Q+zNBWTyz3D1uWYEWAj3CvjiV
         /8M2ZP2xEqAlesxIIFsRkL5kHMYbt6pumBLsD+anS41WQ6M8xwCjEL1IWXW4Pk5OJcM4
         OM1FdX9To2d0vfqwp5WJ28O5Q7MTn+vu0gVCpUCg6yuA33P1wigxM+sl39B5T1rbRdSa
         U9fQ==
X-Gm-Message-State: AOJu0YyQtDXj88cBCpgEBmgxsKO9Eh/DcfnsaSX63E4BBPFp9S1ZXfvL
	kg5TnUWTIwEBy/xth3NQ7c0S90JK7KnCN/ti4kdiERV5cht/ApUMqqn4CJAEnHCzBZP2FJYG2bQ
	lyqMglmJIQ1KreaF+76Q47HzmY0J+ReQ=
X-Gm-Gg: AfdE7cllSSrPOaFPaygQCemvmAd642GH1zKRz/ijlgGNV3MBx63CQYVuKWQag1hdNxQ
	7Sp3X11W/UdURBIQFQS8cnTDEngY3qiltjWumou2idT4MDdNNBBY93XDdg/yWwnVG5I47vjZcqg
	IMFk1wJvcMvoVMsMg/OY0rRvj6IIaR/JxKrgWtoEUgBBxj2rKOj14ouwnMSXSY+wuJjcM6vw6MX
	J8mIaWN0fyYFGNVIFtEmVvbsRGH91XfOJHoNwNKHJgQNuoLNPif8G+U/8HNopo0HPe7lteAaozY
	M0K75mYdt3H9322ysXg+rfEmC8eHGL6SGc/OmUp+4VvbM+4/UIQip+FWRpcU4bkGIoc6HsILLE/
	tfnlQEeq4IOejm08kevXuFjwN5nEcs9rbohVG
X-Received: by 2002:a05:690c:60c6:b0:81e:7b95:c777 with SMTP id
 00721157ae682-81e9010b61emr160249437b3.35.1784179896265; Wed, 15 Jul 2026
 22:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715114701.7713-1-hardikprakash.official@gmail.com>
 <aleWco-IEiXdOZkp@ashevche-desk.local> <CANTFpSUBqqKm9d6OThea+i4oKd1-SNRSrFtYs-x=PbOaUboTrw@mail.gmail.com>
In-Reply-To: <CANTFpSUBqqKm9d6OThea+i4oKd1-SNRSrFtYs-x=PbOaUboTrw@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Thu, 16 Jul 2026 11:01:24 +0530
X-Gm-Features: AUfX_mxTGIxXs99b7SyBDBoVEY22it0VSXNJMUkHqbuy7xNleRLUI7durffyYyM
Message-ID: <CANTFpSU+CsTYZf5+w95eL7mXA+HxKU2n3xYo=_rfJ_ozCoG+Mw@mail.gmail.com>
Subject: Re: [PATCH v11] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026, Andy Shevchenko wrote:
> Instead just define with LIST_HEAD() macro.
>
>         LIST_HEAD(res_list);
>         int ret;
> [...]
> Check for errors when it's required. I believe you fixed it at some point
> and now it's again old version. Please, reduce full rely on AI, it's not
> helpful sometimes.

My bad, I checked and found the correct snippet in v10:

        ret = acpi_dev_get_resources(adev, &res_list,
check_gpioint_resource, data);
        if (ret < 0)
                return ret;

        acpi_dev_free_resource_list(&res_list);
        return 0;

I will post v12 with this and your other comments addressed.

Thanks,
Hardik

On Thu, 16 Jul 2026 at 10:59, Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> On Wed, 15 Jul 2026, Bartosz Golaszewski wrote:
> > Please include the entire changelog in every new iteration. I believe I gave
> > my Ack for this and now it's gone. I have no idea why because there's neither
> > a complete changelog nor links to previous versions.
>
> Sorry about that, I will include the full changelog history from now on.
>
> Here's a catch-up: since your v6, v7 Ack, the patch went through the v8
> regression (NULL ptr deref + probe deferral loop), a v9 revert+fix
> split, and now v11's restructure around gpio_device_find_by_fwnode()
> per Andy's suggestion. The core approach (generic GpioInt dependency
> check) is the same one you acked at v6.
>
> However, given the amount that's changed since v6, I wonder if you
> might want to take another look before re-acking.
>
> Thanks,
> Hardik
>
> On Wed, 15 Jul 2026 at 19:47, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Jul 15, 2026 at 05:17:01PM +0530, Hardik Prakash wrote:
> > > I2C controllers may have child devices with GpioInt resources that
> > > depend on GPIO controllers being fully initialized. If the I2C
> > > controller probes and enumerates children before the referenced GPIO
> > > controller has completed probe, GPIO interrupts may not be properly
> > > configured, leading to device failures.
> > >
> > > On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> > > AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> > > pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> > > AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> > > fail with lost arbitration errors:
> > >
> > >   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> > >   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> > >   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> > >   2.348157  lost arbitration
> > >
> > > Add a dependency check that walks ACPI child devices and defers probe
> > > until any referenced GPIO controller is bound.
> >
> > ...
> >
> > > v10 -> v11:
> > > - Replaced custom gpio_controller_ref list with gpio_device_find_by_fwnode(),
> > >   as suggested by Andy, dropping the linked list and dedup logic (~60 lines)
> > > - Moved resource-skip explanation from commit message into a code comment
> > > - Fixed device_is_bound() to check gpio_device_to_device(gdev)->parent
> > >   rather than the gpio_device's own internal class device, which never
> > >   has a driver bound to it
> >
> > Thanks for an update, looks much better!
> >
> > My comments below. I think v12 will be final if you address everything as
> > suggested and answer to the Bart's request.
> >
> > ...
> >
> > > +static int check_gpioint_resource(struct acpi_resource *ares, void *data)
> > > +{
> >
> > > +     struct gpio_device *gdev __free(gpio_device_put) = NULL;
> >
> > This style is discouraged. Please, move this below.
> >
> > > +     struct acpi_resource_gpio *agpio;
> > > +     struct acpi_device *gpio_adev;
> > > +     struct device *gpio_dev;
> > > +     acpi_handle handle;
> > > +
> > > +     if (!acpi_gpio_get_irq_resource(ares, &agpio))
> > > +             return 1; /* not a GpioInt resource, skip */
> > > +
> > > +     if (!agpio->resource_source.string_length)
> > > +             return 1; /* no named controller, skip */
> >
> > > +     if (ACPI_FAILURE(acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle)))
> > > +             return 1;
> >
> > Can be rewritten as
> >
> >         acpi_status status;
> >         ...
> >
> >         status = acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle);
> >         if (ACPI_FAILURE(status))
> >                 return 1;
> >
> > > +     gpio_adev = acpi_fetch_acpi_dev(handle);
> > > +     if (!gpio_adev)
> > > +             return 1;
> > > +
> > > +     gdev = gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
> >
> >         struct gpio_device *gdev __free(gpio_device_put) =
> >                 gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
> >
> > > +     if (!gdev)
> > > +             return -EPROBE_DEFER; /* controller not registered yet: abort walk */
> > > +
> > > +     gpio_dev = gpio_device_to_device(gdev)->parent;
> >
> > > +     scoped_guard(device, gpio_dev) {
> >
> > Can we use simple guard()() here?
> >
> > > +             if (!device_is_bound(gpio_dev))
> > > +                     return -EPROBE_DEFER; /* controller not bound yet: abort walk */
> > > +     }
> > > +
> > > +     return 1; /* bound, skip adding to resource list, continue walk */
> > > +}
> >
> > ...
> >
> > > +static int check_child_gpioint(struct acpi_device *adev, void *data)
> > > +{
> > > +     struct list_head res_list;
> > > +     int ret;
> > > +
> > > +     INIT_LIST_HEAD(&res_list);
> >
> > Instead just define with LIST_HEAD() macro.
> >
> >         LIST_HEAD(res_list);
> >         int ret;
> >
> > > +     ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
> >
> > > +     acpi_dev_free_resource_list(&res_list);
> > > +
> > > +     /*
> > > +      * ret is a nonnegative resource count on success, which must not
> > > +      * be mistaken for a nonzero "stop iteration" signal by
> > > +      * acpi_dev_for_each_child(); only forward genuine errors.
> > > +      */
> > > +     return ret < 0 ? ret : 0;
> >
> > Check for errors when it's required. I believe you fixed it at some point
> > and now it's again old version. Please, reduce full rely on AI, it's not
> > helpful sometimes.
> >
> >         ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
> >         if (ret < 0)
> >                 return ret;
> >         ...
> >         return 0;
> >
> > > +}
> >
> > ...
> >
> > > +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> > > +{
> > > +     struct acpi_device *adev = ACPI_COMPANION(dev);
> >
> > This style is discouraged as it brings an unneeded burden on a maintenance.
> >
> > > +     if (!adev)
> > > +             return 0;
> >
> >         struct acpi_device *adev;
> >
> >         adev = ACPI_COMPANION(dev);
> >         if (!adev)
> >                 return 0;
> >
> > > +     return acpi_dev_for_each_child(adev, check_child_gpioint, NULL);
> > > +}
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
