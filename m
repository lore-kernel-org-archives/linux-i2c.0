Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387730BB80
	for <linux-i2c@vger.kernel.org>; Sat, 23 May 2026 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779522729; cv=pass; b=sl4KdoDcYvu9X4fuo78vWtmA2kBHz7S52V7Om7helgeMYUMF6yYmYuHg9N4OUglzyBkMQZelEbyrL+9LahBYatjBDeujYCQUu2GAZ5tqiN/e5dbho5Wxv9aRJ3CfTYNuCezKQqm+5670vBB8Pp028riaDfr0hYmLM4ALKpPOqXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779522729; c=relaxed/simple;
	bh=MZYvPVFypa3CJDmmhPXW8Fs9lY6t17REUNqPpBk2jIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWdo9nDa5V8of6cbaoq8e38gbFARy64g4ve3HbPijzWG6CFfuIlguSJTWIP1kr9/3ndrmKdgn7Jh3Bq+VXkWjavj2ObS+CkS3nmklj1OTJWIjajGLiQ6vYRig5e27hJL/lFmreQVj+qKky+I3kasu84vU5ei7SwpAjxCiEFOoc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIT2cJwb; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIT2cJwb"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65eb1b25c77so2646046d50.0
        for <linux-i2c@vger.kernel.org>; Sat, 23 May 2026 00:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779522727; cv=none;
        d=google.com; s=arc-20240605;
        b=NMsLAHa+RivHQ+9R9X9vmPzu+vFVHfIXiGITc4dcDsm+0WXe/vfWq9sWe1NBdd/4QC
         65RuIrlXJWN17HXpU7nHs8gUY6FwHXEGeghWCTgQRIbAYMjF1CVv/E4QEANopDSCBD+e
         oOY1iQdzeHhE0jKax9PovsjLrKpW+y3UdDpqosQl9Q7moDzUNfivUbYcjbPaNQ/M6esN
         83ywzoN0pA8Gs3fAjD1WSnZA+f70LR4aUVrpaP3GSC5PRQafyhqzbqpqG292kYb0C49b
         lUlS5NjydFlsXBz+ZPxqXxzjHJIDrnVkoc2Lz9ak4zyqv4AoYS8mDMpIGlpM2IiO5BCg
         h5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRt2RuH8xpBX2bONTpScPJtz9TEQ7OxlORJq33oz68A=;
        fh=JKXZhDJgns/ECXf0gRKf+r0iwXOb90uicu3EtP+P+2E=;
        b=DPN+VPcZFM17lejCcsNFqb3IjsT/JP5NnVK8sHttM+nW5hb+1aTPgsQ3vquCOV9+KP
         rTVKWObLCdxUvtpKBYicV85ok9fds3CYULL5QpJ3SoPL6pOi1VxuLI2KQSJ/izu4uuEO
         iitTifaBlas163oMaNKzp9IsdojTY6Vugd43qrsrbR3/ktli+FK4h/ClWIYTp7RoYnKZ
         bt2O3DQHb4dLnoWJlXE3PGBtOZRSvLKuf/oeOaUZYJ69I+OlL42wbcJPyh1QNNWbaRKz
         Iopiu97dZBHQukevXze1QIvjkQbQjC7RMSHIFUi+OypqmBOUQiSxlasJtEjU2/qdVmdQ
         hlMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779522727; x=1780127527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRt2RuH8xpBX2bONTpScPJtz9TEQ7OxlORJq33oz68A=;
        b=tIT2cJwb3ZN+v4S9PO6l9htO4hixgN0xlsbKA5pcr8g+u5UDO40l6CzIc3P8V4sR+M
         akaw84ntNAs9mCCCXcCYJ0TSpeXeSD6rcnGZxIXQgD8Q5+Jap0/RcT2zDB7PFw88pGjF
         4hUrvEpS4CATJYH1DcSCta0EGy2ixONAJtDWlhyJnLyOsnZAveAiUFDHu/4AoyqqRfZo
         djnte4TxRzJzyI+ZxmsR8ZahohJH4SUScvEIoO2opRVlhqTY7KVao/ftWTjHd6lGHmTP
         y/cxJrBxsmsogXFBDq+kkfBOJsQZljVgFHngMyWJFixTyRoAB2M+G2glmXPR1hg7lh/6
         c+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779522727; x=1780127527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRt2RuH8xpBX2bONTpScPJtz9TEQ7OxlORJq33oz68A=;
        b=sSZ0g60wsp0m4WKq2+CWLpZDki9ydmO5Ql5vkkRLO4cbRukYUhWEm7iOAtGsevgtQy
         Ut7ojTNp72XKM7a4mVuQ6cCyfenFJ8p77FaU19jzXwissH4nPZ/XmuWMocq7d794/hi1
         ycd4CWaallZShJoRjtyvmhmShl0H+2zR5/MwNflTCT2ycs9ubTobB5+tUn9QED3Xj8kG
         600zarnxEcxsFKfDg9Xv5ZQRWfMqN+X5N3N9fYavptS6khX2vyxPBInRa4kC1YOb+yn7
         cvAPZKOjX1MvE7LJjRN8bzX0Tkf8XMLHOrvFYAo5fjLoJODXwqmHWqm8K4JKrNfY9QU1
         K+IQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dN+HdrZJ0uD+/NaViPNKatBqEdX/ls/OidJJu+1203org/jKfWLVKvebtUZLGeRNrupi111lzMuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFFTjiso53yX7WYy7J1ROlMx6Gv2Lvox8Kn2G+OMsFaf4blfs
	wUNH7IKNbfr5GBmxuQaLYlIADoDYfAv04wohoUKpQhZzhTFbCBhaXZBxL4SZrWT24nIGb3uUoYP
	rkcgtnPe+uDja9xxW9oHu/RT7JdtjNF8=
X-Gm-Gg: Acq92OFew4OM2TclNyRCRtlOyHUcauF54nA4OniH4kvIZPmXqbDu+k7cD/8lQ8JNM58
	65FhR6cIgvkQFqhdvSRK/OTxqcYD68J/2utFt2Wd50sl6d77fz9ruE5AGR7DG8BigIIeLCtxEsU
	JQ3Kptj1/zP6Sxk/cIYKCmNwR7x81B02TKpT7tacoELA01vM5p/IQE2OjPp81Giqo3O6buLzbsv
	F2Jn0ITalBF7CVZqz480tT9Tu8YoANIhXyAb0aooJZTH/xopgs1hYPDGl8GAp5o19X6KedyGQ0B
	HiUFNhAqOKHxvAg8X3pn8vuk8c/RCbvIwBRBS865T8AvUZDJ9KmDtPlDc2DuY19skkFK7vr2rK/
	tM7QMwWoVVAU1HDKO3C7sqJIYnSdY78sTpeDAda9DSR2xC6wGNVsBeWIWNhCwEbqVBp+cww==
X-Received: by 2002:a05:690e:4383:b0:65c:6f79:1dd0 with SMTP id
 956f58d0204a3-65ec9774785mr5012436d50.20.1779522726802; Sat, 23 May 2026
 00:52:06 -0700 (PDT)
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
 <CANTFpSU+wTQeESDGqV=xizrJeQw_LA8y7stDYMm=H-UrbWXeYQ@mail.gmail.com>
 <e31e28e7-62b0-44a3-b155-57504be09c69@amd.com> <CANTFpSVnhst-25KPa-m2e14rR_dqJNq_s6k_ZO-MFazqLa=AEQ@mail.gmail.com>
In-Reply-To: <CANTFpSVnhst-25KPa-m2e14rR_dqJNq_s6k_ZO-MFazqLa=AEQ@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Sat, 23 May 2026 13:21:54 +0530
X-Gm-Features: AVHnY4IJEXKHf5m8M7KZKcY-PLPegQZldHYm7de-9MXUu6mKX4FhMCo8IHYX57E
Message-ID: <CANTFpSWLUfNZyjJXApgf60MyJ9imWYVKLy9vj=Lin3Lh=qoAMw@mail.gmail.com>
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

I've cleaned up your patch (fixed kzalloc_obj, moved goto outside
scoped_guard, wrote a proper commit message) and am planning to submit
it as v6 with Co-developed-by and Signed-off-by carrying your name.

Please let me know if you're happy with that, or if you'd prefer to
submit it yourself.

Thanks,
Hardik

On Wed, 20 May 2026 at 10:32, Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> On Tue, May 19, 2026 at 02:23, Mario Limonciello wrote:
> > In the same line of thinking - how about something like this instead
> > (AI generated and attached).
> >
> > Basically walk through the resources at probe time and make sure they'r=
e
> > all bound.
>
> Tested. Works perfectly =E2=80=94 clean boot, no arbitration errors, touc=
hscreen
> and stylus fully functional:
>
>   patch 1 + generic GPIO dependency check:   clean boot, touchscreen work=
s
>
> The generic approach is better. With this patch, patch 2 (the
> DMI-specific i2c-designware deferral) is no longer needed.
>
> Note: I applied kzalloc(sizeof(*ref), GFP_KERNEL) in place of
> kzalloc_obj(*ref, GFP_KERNEL), and moved the goto outside the
> scoped_guard using a local bool. Happy to share the exact diff I tested
> if useful.
>
> Thanks,
> Hardik
>
> On Wed, 20 May 2026 at 02:23, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> >
> >
> > On 5/19/26 14:49, Hardik Prakash wrote:
> > > On Tue, May 19, 2026 at 20:18, Mario Limonciello wrote:
> > >> I like this idea. I guess something like this:
> > >> [gpiolib-acpi-core.c patch]
> > >
> > > Tested patch 1 + gpiolib-acpi deferral, without patch 2. Arbitration
> > > errors persist:
> > >
> > >    patch 1 + gpiolib-acpi deferral:   arbitration errors, WACF2200 do=
es not probe
> > >    patch 1 + patch 2 (v5):           clean boot, touchscreen fully fu=
nctional
> > >
> > > I think the reason is that i2c-designware does not call acpi_get_gpio=
d()
> > > during its probe. The GpioInt resource is on the WACF2200 touchscreen
> > > device (TPNL), not on the I2C controller itself. So the deferral in
> > > acpi_get_gpiod() never triggers for AMDI0010:02 -- nothing in that pr=
obe
> > > path requests a GPIO descriptor.
> > >
> > > The race is between amd_gpio_probe() completing and dw_i2c_plat_probe=
()
> > > starting for AMDI0010:02. Without something that explicitly checks
> > > whether the GPIO controller is fully bound before the I2C controller
> > > probes, the race remains.
> > >
> >
> > In the same linke of thinking - how about something like this instead
> > (AI generated and attached).
> >
> > Basically walk through the resources at probe time and make sure they'r=
e
> > all bound.
> >
> > > Thanks,
> > > Hardik
> > >
> > > On Wed, 20 May 2026 at 00:37, Hardik Prakash
> > > <hardikprakash.official@gmail.com> wrote:
> > >>
> > >> On Tue, May 19, 2026 at 19:58, Mario Limonciello wrote:
> > >>> You add a debug statement to amd_gpio_irq_enable() too right? Can y=
ou
> > >>> please share your debugging messages patch and full log?
> > >>
> > >> I did not add debug to amd_gpio_irq_enable() - the statements were
> > >> only in amd_gpio_probe() and dw_i2c_plat_probe(). I can add one ther=
e
> > >> if useful, but given Bart's suggestion below I'll hold off unless
> > >> needed.
> > >>
> > >>> What is the boot time impact to adding device_is_bound() check?
> > >>
> > >> I haven't measured this explicitly. The deferral only fires on DMI-
> > >> matched hardware (Lenovo 83TD), so on other machines dw_i2c_defer_fo=
r_
> > >> amd_gpio() returns 0 immediately with no overhead.
> > >>
> > >> On Tue, May 19, 2026 at 20:18, Mario Limonciello wrote:
> > >>> I like this idea.
> > >>
> > >> I'll test this patch, and let you know how it goes.
> > >>
> > >> Thanks,
> > >> Hardik
> > >>
> > >> On Tue, 19 May 2026 at 20:18, Mario Limonciello
> > >> <mario.limonciello@amd.com> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On 5/19/26 09:39, Bartosz Golaszewski wrote:
> > >>>> On Tue, May 19, 2026 at 4:28=E2=80=AFPM Mario Limonciello
> > >>>> <mario.limonciello@amd.com> wrote:
> > >>>>>
> > >>>>>>
> > >>>>>> gpiochip_add_data() at 0.285952 makes the GPIO chip visible to t=
he
> > >>>>>> system before amd_gpio_probe() has finished. AMDI0010:02 starts =
probing
> > >>>>>> at 0.301454 while amd_gpio_probe() is still completing. This is =
why
> > >>>>>> device_is_bound() works and initcall promotion does not -- it wa=
its for
> > >>>>>> probe completion, not just gpiochip registration.
> > >>>>>
> > >>>>> What is the boot time impact to adding device_is_bound() check?
> > >>>>>
> > >>>>> Bartosz, thoughts?
> > >>>>>
> > >>>>
> > >>>> My thoughts are that ACPI could use some fw_devlink. :) It's not a=
 new
> > >>>> problem, we've fixed it for OF systems.
> > >>>>
> > >>>> Could we modify gpiolib-acpi.c to return -EPROBE_DEFER if the pare=
nt
> > >>>> device of the GPIO chip is not bound yet instead? When resolving t=
he
> > >>>> reference to the remote GPIO controller we have an address of the
> > >>>> struct acpi_device. I suppose there's a platform device that is it=
s
> > >>>> child and then the logical GPIO controller device, is that correct=
?
> > >>>> Can we check if the platform device in question is bound at the
> > >>>> subsystem level?
> > >>>>
> > >>>> Bart
> > >>>
> > >>> I like this idea.  I guess something like this:
> > >>>
> > >>> diff --git a/drivers/gpio/gpiolib-acpi-core.c
> > >>> b/drivers/gpio/gpiolib-acpi-core.c
> > >>> index eb8a40cfb7a98..e3511398b1f84 100644
> > >>> --- a/drivers/gpio/gpiolib-acpi-core.c
> > >>> +++ b/drivers/gpio/gpiolib-acpi-core.c
> > >>> @@ -142,6 +142,13 @@ static struct gpio_desc *acpi_get_gpiod(char *=
path,
> > >>> unsigned int pin)
> > >>>           if (!gdev)
> > >>>                   return ERR_PTR(-EPROBE_DEFER);
> > >>>
> > >>> +       if (gdev->dev.parent) {
> > >>> +               scoped_guard(device, gdev->dev.parent) {
> > >>> +                       if (!device_is_bound(gdev->dev.parent))
> > >>> +                               return ERR_PTR(-EPROBE_DEFER);
> > >>> +               }
> > >>> +       }
> > >>> +
> > >>>           /*
> > >>>            * FIXME: keep track of the reference to the GPIO device =
somehow
> > >>>            * instead of putting it here.
> > >>>
