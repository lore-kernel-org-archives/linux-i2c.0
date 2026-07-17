Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAA2C21D8
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263727; cv=pass; b=OfQWOYvd44z8nkF9UJzf9J+AGnZvQzqtbyLKiU1gr1eLUpByWVfuWg+VB9yzh/fr4cV8VP8ORC0c9lrLo4xAPpIK9KWU0oNJ/kgKs2+rANNGa5N4YiCbS50/6OD3eZkJptU75pZfH3TZr2A0khPgfcCpO65afhwM10Lcwkgqjns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263727; c=relaxed/simple;
	bh=7JM1LDclmOBV9cwjd2hYzaYxgan2M1wiesdreknP5+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhelGCDjGBOArrxiNdr2b0spEvHOpAzXjwLsESk0no1EE/T9NWr6n/TanM/mbDS/DSY/zNxN1s1oB/BAa/E6agWYSxX98DyCVHP+nqa27QtdtjD8Vjkas82JfhN4BsVrlSAn1WIkMUa5waGArt3Z0aUABf2ndRDNESOlH+1duas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POzKnmPf; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POzKnmPf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e8fa1b8d6so68769087b3.1
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 21:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784263725; cv=none;
        d=google.com; s=arc-20260327;
        b=fHcfuxBYCIFtQPTIEl6MEADfCQCjsvNp9TCtm4kTyP1Ju9m7bFx3toIVjdK8sFQNcz
         myggZ+zjRkLqYLc1bAvixq4pIzdleAZNEivtR8Fn1IQLbouSNsMJUKYQeZ7pm43C/NRB
         X+PR4S1eu5X6uznoEng2pnu9eB0PWDdtGB1hB8hFiYdACuH7lJUCKVwIXz9I4rpEK0cg
         rcCgna+Cmb5PUe+Y0+nqu7plgUgmDk2F7kIdXGpuMbGqgh397b6Jn+A8n2sdMXI9+7DV
         KbZYpQk6e74v1ZB9+nH19VyIKxp7ZpGoJQuFs0CxxWlOxKj8PGkqt+oSFmqBo8I4gQJi
         gOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ciE9XC5LcuEdOZlav9iwcHQoR/BjZCs7jVrad2jO0Xg=;
        fh=adlfq5vem7a9qUlFJy/Rg/TDNX2r9ReV6/uhR9RNyAA=;
        b=SdHiWiSGOvDLGzZLNyIxYuB3QSNYZJHKObSYevEcSoXTFng3stpBo3x6Olu78yM8hx
         Vr4xuX9PtwH9bnfbSBFqERdtyUgm2wMI07apaQxI1bLwiP+4zx6hUVaRg0FpneaS5Tn0
         CId5+S++8Eaijopwlg0THyLd4OSxvzrC+rUtC6nboA64jxm2zeZRh5PyeAXP0M8WpGwe
         kl714uhtV/nYEVGraRDddI0dIggovxIUhwJRtI2KsAAqPaLKIP2NjIUlOd9VWPK52prg
         1HTawXu8ZKytNO8IOThq28/y0btj8uJ5TO3ObaYIi6FSvI4d3JUyK7LR5ZhqxgAP1nKJ
         EjVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784263725; x=1784868525; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ciE9XC5LcuEdOZlav9iwcHQoR/BjZCs7jVrad2jO0Xg=;
        b=POzKnmPf7Uzf+F2aK4qkjXXvMkOpRHyF4GaDehJkolGokmxNuu2ndS1gRPdLyGtgHl
         FVzQIeAYjSX02wehfth3OyjeMhodevG/uAXSYX5HkYWrKw5dAM3LtDaoKVx909W4mJxN
         g+cJy2FPP4SGxfIkQ1m6BFOcljzPjga5NS7Mr6o4cVKS2OnO26tnvW3rCH4RcftqPVgI
         x6FJLESpJgrvB/ktBCZCNxyb2rHbxn4zOrbvwQlVC9LoPjdXr9HYchaWvnrjCCILWRog
         pQMd4s93c9Q/+aMnTYxjTgxYVaZZ5q1s/bhMhDyA/iDFovGU0rmuiiNa/7Ogwa6ZRXO6
         Qxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263725; x=1784868525;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ciE9XC5LcuEdOZlav9iwcHQoR/BjZCs7jVrad2jO0Xg=;
        b=pTNr/FYXOpO+5FE7+HSiA6Wvt/lNlUgRrU6Hy1xJDBOrWphWbhEHDolR09pP3NtCIA
         h+AT4pHYust+XCnhsN3ElmXZsMh3kpej5wDBX9HiOiZW9GACk7xuOCS8rA2J9pTatHGm
         4vLluVpFJgY9D5mFMDGNMOWbD0WBTIX1XXg4Hu9JEUXJOw0Dzk4VVnf+JooQCzWNEgll
         pK/RYEYK+1QKGKyiFUynKWyn3tgOtvIsXbRYVuwqdYju8z4DoE0+cSY7Hsl8c9pdd0gv
         bUGYduXpgHMkvW16r8hfxminVNa9JfoMbfH0gZhacis5peTSTXatymaqcMsHF+iIRZTu
         r5jQ==
X-Gm-Message-State: AOJu0YwdLWAQ1ySe65suC++jLVIbicp9EV2ajvVLG5dY7uUVO4ImG3Fn
	gM2+BcLlPI3XHqrW5Gcf44l+B8nL2UbhR13oZ895XmSlvqGS1/oBLh0/qiRNXt+zf/tZuOV1Dm/
	QP4okjVdMIIJr67Di9HMeONFOa33pmgQ=
X-Gm-Gg: AfdE7cltlnC9dcjs5bZc/2SdUGQryfHfi2ZuY5Vh8B3W4oHTALxLSNlwOgRb7mvGr/Y
	I84mOjsrg30278KS3sjuCJnpQHQZILe6AKjSqniECfFWifUnVAIdyJBjihe9bKPOuw8UrTnfE1/
	dOYAuoZjhOeFA0MqTNq1nNP+nSjnTOPs4OJJwIFItK8vRagxq93VHg2I7YklhnJXdRmA3qbi8Yd
	jfS+z9PfpJ6jkGVkREo7OAs0jx4xRZtzaubDA2eiDd5o4lZ0CI6MVRP+Lxq8wqlhfJmnyCpUzOy
	pmEQAcCk5O5gScVb+h27roQO5ksIHHuYbnJkTjwCTZC5H/vqXG4uckVxcMwmKjYNiCtvnGiZ8IO
	3DwzvOqukNyb5JaJcYgSrYUwAaACZkOybyQBY
X-Received: by 2002:a05:690e:4393:b0:667:dfad:8767 with SMTP id
 956f58d0204a3-6683bb03931mr170257d50.9.1784263725187; Thu, 16 Jul 2026
 21:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716113055.41319-1-hardikprakash.official@gmail.com> <alkpHdM0wBw6_DiX@ashevche-desk.local>
In-Reply-To: <alkpHdM0wBw6_DiX@ashevche-desk.local>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Fri, 17 Jul 2026 10:18:33 +0530
X-Gm-Features: AUfX_mzOfCrcJgb4NEiaUvKjrK4I24bze4f0kvePH-etF5y3YEEpO5QKA9UWBMc
Message-ID: <CANTFpSVGQikgNUgwPW6hCEvCP+FWRJ3Me1jg-Uea=K2JZ4tc9Q@mail.gmail.com>
Subject: Re: [PATCH v12] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jul 2026, Andy Shevchenko wrote:
> It's utterly wrong patch. Actually this whole saga shows how AI wastes
> more time than gains a productivity.
> ...
> So, make sure v13 is a real patch.

I am sorry for the bad patch. I will take some time to ensure all of
the feedback from v10, v11, v12 is properly incorporated and that v13
is a proper patch.

On Fri, 17 Jul 2026, Andy Shevchenko wrote:
> But this is wrong. It's a patch over v11 (basically it's a diff v11..v12).

For the next patch, should I carry the Ack over, given the underlying
content didn't change?

Thanks,
Hardik

On Fri, 17 Jul 2026 at 00:25, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 05:00:55PM +0530, Hardik Prakash wrote:
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
> It's utterly wrong patch. Actually this whole saga shows how AI wastes
> more time than gains a productivity.
>
> ...
>
> >       gpio_dev = gpio_device_to_device(gdev)->parent;
> > -     scoped_guard(device, gpio_dev) {
> > -             if (!device_is_bound(gpio_dev))
> > -                     return -EPROBE_DEFER; /* controller not bound yet: abort walk */
> > -     }
>
> > +     guard(device)(gpio_dev);
>
> When use guard()(), make sure it has a blank lines before and after, so it's
> visible as a separate entity.
>
> > +     if (!device_is_bound(gpio_dev))
> > +             return -EPROBE_DEFER; /* controller not bound yet: abort walk */
> >
>
> ...
>
> So, make sure v13 is a real patch.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
