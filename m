Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98AF367B81
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220187; cv=pass; b=TTKafqFarVFI8pFsOw5RaViroseW0aBZ261fejII2QngT5tIAsyego1KEdTSvh1E03HKbAKP1FrYDYEpwZ8etZLf/mIkQPwEFik49QcY/XdGe7p90eYtmeiWBXOXgyCX9+dd0+VPs7jklAUiHz5z6wgJbOSj0gEvHRSP4MVxh+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220187; c=relaxed/simple;
	bh=y2gWKlwGRB+xVuWmkMmTtzJu8kvrmLQtIXa25GTguuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLipXUXWmv9F7vSgZ3y09p52hjTBE+y7aSfwRU78h8tBBLQbqJUiOpOdr+2YrvGNbONSTStTmz7Xq7XYkNJyLpU/05/MxLUcH31/mAtRfFLW3CSe1ltUYLWs1gXnuaKT3df54sow9Sn4BKdkRxrSN6w70DRnJBlMs3e/h7U8DN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL6VGClj; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL6VGClj"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651c7ddf514so3735302d50.1
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220185; cv=none;
        d=google.com; s=arc-20240605;
        b=Tk4Wv8d+OokOBUr7gj9GCUhdjMGf9U/M1RqNwtmZkyiaoebRlf7OnMDBD3jBw6qPKq
         NEHpZtgp5sJxxSeyNC2PoQmyJFb47iIwUrF5k3PxPYae4aUjGwx8RzJbzF86wj03j1s2
         UDTnZXoZPOVSTsEfIG0AHJWVmngLC28IjB2Hz+05LBBFCvYErNPQgU+6s0m1innFni9i
         Qe9GkajozVvm0knHD5sXIXXtG8/NJRdzie0uYMh8A/tIFmPdpgAmla5M0sn1vwggnuGC
         KdGpphafDVobivXZpYBln7rubmmPBEiwZx4O+joqOm44rIUjXT7uoRVFFQ9SzDxOa93E
         NP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=68NJ95LIG8tl/ruYTxXjrAILSDWZ0MxjLi9Z7WQJkQ8=;
        fh=EwiBOr5mYiqERIyO1Mi28Zi7EJhriIFPPG8C7FI2Sdc=;
        b=Y0MvXPWPR6W5TMeB9vrQEP/Xob1x3IuaF5H2Dv9Dd7+RZpA4wZcDHktSL2YsOy3kWU
         WQpJM3xhmSzax06wbycbP51IbRZAqLDWyR+OV4/zoQTJ4Zkd+NJoC0tdD7boi4Ww2DFK
         wEaoPsWrZntWVn8CMiUasGjb1QZdeNa2/hTPfHlQnT+Z7mbq1sOdJMa1Pzj9br6zot4J
         LiHhBn54JGCUgYxdJCi+rQ3qb06ZF25YlxcuErCMJFI9QZNggjpylL+2JwDRhNuzG1tK
         9GiAiqxsgwb/bn8K7/l8eGvxUJaNnwHbMomv/7cAxsbowkpfJ94IekeqrxWbaqWVtTTQ
         aGjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779220185; x=1779824985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68NJ95LIG8tl/ruYTxXjrAILSDWZ0MxjLi9Z7WQJkQ8=;
        b=JL6VGClj7Dr+jN8L85Rh1G/+89B/lufsBlQcZsQAOBlKLpDNldV+BTZukoOnUHFuC+
         YP/83lZ7Q8G7IXHe9jbyjsBF0wTxasectx3QjBdSdkb2y+5n+mHLgNlkDBr1u/Qd/SHi
         WQns6089KQVHRvk0/v4PSzrOK6iwrdpOF6WnqNfyOa3nksJ9LbG+kmfe+w7V2h6hFyo1
         NyPo5rUctvu7OY5xwLOxZVdAqTYUgsLPdxckzLETEIXBrftRrD5F5I0s9Pt0s5HG1Q/V
         Kncs4YK1GJv8gtTphhhu7OgIEK8drR0/bI2XdSkfEZqITrVCbH/IMAeAUuoAloLtXOzl
         KThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220185; x=1779824985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68NJ95LIG8tl/ruYTxXjrAILSDWZ0MxjLi9Z7WQJkQ8=;
        b=V00TJB3JLOEszfx5NI1LZtZKH2s+qdbOGuRqzHMq7piUz5cCAMiRBEUdUpQqVuLZ6v
         FFauSpBP+wmeyJdGmAYBpW1NYbE1e/s1OeIJNdZSwo638Uf1gWAN2Uk5cYfSLORinWtk
         QM6ei7I2SfuT3VOXYwNqPI/JChK2pJTzzi32WCul7+7VDJ9B3I8ipi8neMtWJzg/suh8
         DbOManc1R955UwEpAXC30TFujZt78WnSzKKo/AtpHw2KRNWROpj4z8num+M6XorOMRBH
         hFojJXLIkLxgTWp/txOVAPnMt1W7L+zoTYoLNKgPvPeVgUDKx2f2r7eRbYF6u1QXRbSL
         wM7w==
X-Forwarded-Encrypted: i=1; AFNElJ/Bzn3sLJWbeYi+mnzlrnU0DoWy+D/xrJyWHuN6YPZmZdZG1WHq2KEiw8+RWlSmfFxtBBUJ7gkpRQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4toNL0+G0Zx7hrAPYuEwBBe0M0cfYLKZtIu6uVxd6vkBi3IIV
	Nfkk7czWY5RPP0hVuMS1D1koI3aSXHb89g0HJFDKujje6AwFo7wN71oEWZlG/2M6V1wNWyUgonf
	1ciAN35kTtqM8jHct5LCyBYq5jtB2+v/VU+onH6HiHw==
X-Gm-Gg: Acq92OG3qyOnOc8OU+DQ0IdLu69xJBssPryxGdpMbqwMtsC2sS/bcBkXEy/P/EWLu+I
	c8A8mkHafkzt15ObtLtgSKgEWYoARWCvj/+UvKjFtAjNYB/uv9vmvhGBbV75xHXMoQ4sMHJOZHw
	NwmLGj4To4TuMWdXQpD8B14Z5w+Ocfrk+T32eCfoGpvbZwD3CattWwq336ySIEINZhJB9QLJmvE
	8oF8X4uxPI3I5l7qwYfNSq3ApCjhXUoSr15MZaGitY6lyMXwDGklQMrzi8nzsGm2i4AwN8b9Uo/
	fuunSIgOVGQQugccmvf6GeN9W6i8UauVNigUFObgoQZCmZfUe/JkBusXYeBT3B7+W5p33caiIZm
	2MCKyImFYE6GzLo6ATLUJQRYAOZ8aIVGeoyzEm4kawSGrnneq9exNkSLlSg==
X-Received: by 2002:a05:690e:140d:b0:65c:2738:c6a4 with SMTP id
 956f58d0204a3-65e2268bf87mr20723033d50.17.1779220184640; Tue, 19 May 2026
 12:49:44 -0700 (PDT)
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
 <498bad3f-6a0c-4da8-b645-1cc837ba1836@amd.com> <CANTFpSWB6Fb3mo9sUtxo2Aaa-Ryx-YqUw-tqT-y1RpurJfq57A@mail.gmail.com>
In-Reply-To: <CANTFpSWB6Fb3mo9sUtxo2Aaa-Ryx-YqUw-tqT-y1RpurJfq57A@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Wed, 20 May 2026 01:19:32 +0530
X-Gm-Features: AVHnY4LNkbrr-2Aon6iJF4VRXE83j0qjSsKssy86Zag0YWxbL_nqEwjZ7gYv0p8
Message-ID: <CANTFpSU+wTQeESDGqV=xizrJeQw_LA8y7stDYMm=H-UrbWXeYQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 20:18, Mario Limonciello wrote:
> I like this idea. I guess something like this:
> [gpiolib-acpi-core.c patch]

Tested patch 1 + gpiolib-acpi deferral, without patch 2. Arbitration
errors persist:

  patch 1 + gpiolib-acpi deferral:   arbitration errors, WACF2200 does not =
probe
  patch 1 + patch 2 (v5):           clean boot, touchscreen fully functiona=
l

I think the reason is that i2c-designware does not call acpi_get_gpiod()
during its probe. The GpioInt resource is on the WACF2200 touchscreen
device (TPNL), not on the I2C controller itself. So the deferral in
acpi_get_gpiod() never triggers for AMDI0010:02 -- nothing in that probe
path requests a GPIO descriptor.

The race is between amd_gpio_probe() completing and dw_i2c_plat_probe()
starting for AMDI0010:02. Without something that explicitly checks
whether the GPIO controller is fully bound before the I2C controller
probes, the race remains.

Thanks,
Hardik

On Wed, 20 May 2026 at 00:37, Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> On Tue, May 19, 2026 at 19:58, Mario Limonciello wrote:
> > You add a debug statement to amd_gpio_irq_enable() too right? Can you
> > please share your debugging messages patch and full log?
>
> I did not add debug to amd_gpio_irq_enable() - the statements were
> only in amd_gpio_probe() and dw_i2c_plat_probe(). I can add one there
> if useful, but given Bart's suggestion below I'll hold off unless
> needed.
>
> > What is the boot time impact to adding device_is_bound() check?
>
> I haven't measured this explicitly. The deferral only fires on DMI-
> matched hardware (Lenovo 83TD), so on other machines dw_i2c_defer_for_
> amd_gpio() returns 0 immediately with no overhead.
>
> On Tue, May 19, 2026 at 20:18, Mario Limonciello wrote:
> > I like this idea.
>
> I'll test this patch, and let you know how it goes.
>
> Thanks,
> Hardik
>
> On Tue, 19 May 2026 at 20:18, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> >
> >
> > On 5/19/26 09:39, Bartosz Golaszewski wrote:
> > > On Tue, May 19, 2026 at 4:28=E2=80=AFPM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > >>
> > >>>
> > >>> gpiochip_add_data() at 0.285952 makes the GPIO chip visible to the
> > >>> system before amd_gpio_probe() has finished. AMDI0010:02 starts pro=
bing
> > >>> at 0.301454 while amd_gpio_probe() is still completing. This is why
> > >>> device_is_bound() works and initcall promotion does not -- it waits=
 for
> > >>> probe completion, not just gpiochip registration.
> > >>
> > >> What is the boot time impact to adding device_is_bound() check?
> > >>
> > >> Bartosz, thoughts?
> > >>
> > >
> > > My thoughts are that ACPI could use some fw_devlink. :) It's not a ne=
w
> > > problem, we've fixed it for OF systems.
> > >
> > > Could we modify gpiolib-acpi.c to return -EPROBE_DEFER if the parent
> > > device of the GPIO chip is not bound yet instead? When resolving the
> > > reference to the remote GPIO controller we have an address of the
> > > struct acpi_device. I suppose there's a platform device that is its
> > > child and then the logical GPIO controller device, is that correct?
> > > Can we check if the platform device in question is bound at the
> > > subsystem level?
> > >
> > > Bart
> >
> > I like this idea.  I guess something like this:
> >
> > diff --git a/drivers/gpio/gpiolib-acpi-core.c
> > b/drivers/gpio/gpiolib-acpi-core.c
> > index eb8a40cfb7a98..e3511398b1f84 100644
> > --- a/drivers/gpio/gpiolib-acpi-core.c
> > +++ b/drivers/gpio/gpiolib-acpi-core.c
> > @@ -142,6 +142,13 @@ static struct gpio_desc *acpi_get_gpiod(char *path=
,
> > unsigned int pin)
> >          if (!gdev)
> >                  return ERR_PTR(-EPROBE_DEFER);
> >
> > +       if (gdev->dev.parent) {
> > +               scoped_guard(device, gdev->dev.parent) {
> > +                       if (!device_is_bound(gdev->dev.parent))
> > +                               return ERR_PTR(-EPROBE_DEFER);
> > +               }
> > +       }
> > +
> >          /*
> >           * FIXME: keep track of the reference to the GPIO device someh=
ow
> >           * instead of putting it here.
> >
