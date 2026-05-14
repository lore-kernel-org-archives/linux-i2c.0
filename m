Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDA36A36C
	for <linux-i2c@vger.kernel.org>; Thu, 14 May 2026 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735584; cv=pass; b=I8TsWZl4nbxRmkEclg9jSHv96bvXsQHCXvxtEhjMrPB0O+WsZBfhs/1DGKrR5+VLmWKL/0m2RQh+wI2rPZKSAOfROIqvf7+oeq8zo1ziGL1L4qaDVYbOX956Lxi3F7nIcDCOk9iNesAtFrxmHURyN03pXE1ksN7BED4niMhA0i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735584; c=relaxed/simple;
	bh=OkdlTxJrIffafZLYBsN0a4k4dqZ5V+Hvm+XCe9BmCs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebR6KeLXeA++0wCKNNNHIm3qntpK4StfiR5WfB29u3t9sbEFrVY/Y5mXGKwVeUr34puNjZO9HQpjiPwiFa606sEWCFhoAvUTS0jExUjv4P210ukWv1fknFVUPXO703Hkp9Uu/d/uj+gQFGcujcHm2Rpg14nnUEoT6X2+JhmI5aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiS5p4go; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiS5p4go"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651b4d09141so8660697d50.1
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 22:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778735581; cv=none;
        d=google.com; s=arc-20240605;
        b=eKz1Ic3XJpamFfe4Uv20w6nNDpQaD3wCJrgM2KudHIL8vq4GhQZHOeklsK2slcH4rc
         GJTVtWQ9/RrFnwRJLVCYbY1V6p5n3P+UnOdwOpP3Fx8OvahjonjHAMI9zlVicMpCUbhY
         Nk8ePQJcy9adKoIO9nTv6a6+mByC9fHrzA1BllqBP07bDuTRGLHgS3Gv/zZYLn5P3/aC
         0SfMH7AVxBqPKgwkdZ0Z+F5RIKJNSY9lHaMKNLT3Os1Q5cWJ1kiEvh2x84Oh82u80xp+
         msdTV/i3QPuqLKETrnSBFm5lP8XaK83aXrTtmyzsYt1EM35wXeyga+Yf2Q+DMFGuuCTA
         UmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ldXGxXqstB4z6UJeQWyN/wPMyI1frnajQ+WrbjoPiwc=;
        fh=NHx6HyAfsMljKU6Pn/r3uNPQgm2ugsq/nE1+c1c+bWw=;
        b=YMDJiitUp7QbzEAwpv3VwXDG6bLZULZzGkl/sJwgQrZeH/F5QSeQwAiXxfajzsyqz/
         GI4rBdD5jv+E+prBEDwEAP8mdnKrmZt0x4C1+45tFf5MbWWZRC/r6xB1h8GInqcyWKrs
         WVtr6HHcGTwrwOCOyyW3b6QliaVOHHbqVk1A/Ia2DXZDAHYRvksEgUa7uKu7Q6bi/seW
         KSE14nskIrczwHwieufASfnCo4HccnZpoY3edOIIoMqBBe2+cHrcWg9QC76S1au+/jn9
         UA/ojEKxvuH6WKL1OSZqt2p+KPV2ofKa9qyMQeA1L1hbniEc5cRYISZb7yLENaQn/Okc
         8n3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778735581; x=1779340381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldXGxXqstB4z6UJeQWyN/wPMyI1frnajQ+WrbjoPiwc=;
        b=hiS5p4goMt0l4WxvMvVZGaeSq1tky4CAXXrr59q1P/T+nMpvacmOHtMOSUqbAQxa7m
         wmu+o6FjMMaDd82J+jLaOZMO0gb4bF8hKWEGZrnXeuhEIvJoYUTu1klA/g0FRfrxemJn
         pB+FLEmQp0cf9jVPbECGLPAmLD0KWmjYmrWta2iKqj+cRypLjEORJeGA4J2dcGA8rlRf
         IIi8xuFdI48ZdA2r5dJ7BMQRPO/eup/NG5QU1fv3QV9VjLF6MTgQrBw2eZD47kCPIq/E
         AOZZ4OUcs+zsI0dcDEq9hTRg476jaRRwvZtW121lUFpNgFyAuw2d7h+Re8Njru69+BDD
         y57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778735581; x=1779340381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldXGxXqstB4z6UJeQWyN/wPMyI1frnajQ+WrbjoPiwc=;
        b=h4/N7As24xJ3eUCQ9Ng0Ev4klOK1TZbcuJ+Ent9mHJGtpG1o+oZYWOdREXMblkZrzh
         gppYfgZmesllRZ03YIbl7r4godPBk9XAWW0oxUh0CqD4PFrbDHcqkndgLWt3wV8z1Ofz
         oW3H0uYDMl9LjEN5AXQarXXJZS+xiONLTxN1ZqGXGCL312RjlHsHTgSNuuGFpOcWA+Ks
         VGwfvhgbQL6Cdb5niT4eBFaskakn44cYSxzZzI8DTlYO/rT2Ed3v5P3i2eP8tGrbO0xe
         bhC48oZn0BFtNJV13GLQcz6jZFDPLLbZDgXT8AXQgVEu1m79xp6UOqMRCRnZV8zDsXUx
         w46A==
X-Forwarded-Encrypted: i=1; AFNElJ+FULIUTrp9cAIXbuut8HTh9v0+3vaG0h2x9RViFJ23ecxnbQX9IVg26lG/avUJ55paQWS5lPr3NXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAeA7Sc/XsW+zmxX0rHk/KLUguwnZRevPmAiUhYWFKr0LfcbO
	At9YEi09sokIsHAQwHdxHiN5avNYERL9CppJ/1td7Yhz+t3TdfM0q93y2fUn36jVrLfENPsPIF3
	M2YjRRYlNwXMB1/qGc82tt4syl7ITzr83/UYNcsDibw==
X-Gm-Gg: Acq92OEKqOmUiR00rJpEFrD1/PJK4I0htDQ3+zbWkiYVu6yAQqbfj0rcIAL2DGB5par
	0dTuY+qUfcm4q3E3PDzoDQCNiBMoN10Fui0AVzR9mkEOYaBEuChq2nYsIcBURuP+RMW/YMsVY7e
	T2JdiYKzzpWnF1TARJorFfI2OPKmfcLG7MNWFwKGdLYvKQOMsWUzoIXL2qa+HPxiLw3YSO7cBAd
	YHv4oECMo15rbUvuQKPBy6FPc9Gz67SxBRnZBPE4CdnHQNT0mY1F0DQTEXT+u8xsA2usFLiLbwT
	hA/Cir5isfEcH4BFJXMvCmjKQ1Gq8OqZ3vEeB0Ce1+N1UWd2Tukmm+fJzhenJ0dGHM7QUzkKxLJ
	mQ5FoXq5cem/OX67/63mDSpdl1D45aGGL2aDP8liHDB5rNLHuJs1LonpZwzfX9Lh+hHgua8Kshj
	MQSviJ
X-Received: by 2002:a05:690c:c4e8:b0:7bf:1433:8f92 with SMTP id
 00721157ae682-7c7e5d9034amr20480207b3.7.1778735580968; Wed, 13 May 2026
 22:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513061338.9348-1-hardikprakash.official@gmail.com>
 <20260513061338.9348-2-hardikprakash.official@gmail.com> <dcd84a44-d52b-4810-a1a8-5865f80db1ba@kernel.org>
 <CANTFpSUr7KWMA5D7wh48f5-Ty9hDo7U7Ydsob32YZuZ83dRiiw@mail.gmail.com>
In-Reply-To: <CANTFpSUr7KWMA5D7wh48f5-Ty9hDo7U7Ydsob32YZuZ83dRiiw@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Thu, 14 May 2026 10:42:48 +0530
X-Gm-Features: AVHnY4IUclQrg64HYPwoPct4FtYH8ADNAzz1IlmeFEwXBPHV-KJB5t6DYYtuh7k
Message-ID: <CANTFpSWty5VGoaM2cq6-nn=eJJDy5r9NozGNyB4ryY4+TaODbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl-amd: enable IRQ for WACF2200 touchscreen on
 Lenovo Yoga 7 14AGP11
To: Mario Limonciello <superm1@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, wsa@kernel.org, linus.walleij@linaro.org, 
	basavaraj.natikar@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resending with full Cc list =E2=80=94 apologies for the missed recipients.=
)

On Wed, May 13, 2026 at 22:53, Mario Limonciello wrote:
> I don't understand.  Our design is that the interrupt is disabled
> initially when driver loads (we don't trust state of the GPIO
> configuration pre-boot), and then when i2c-hid loads later it is
> re-enabled via amd_gpio_irq_enable().
>
> Why isn't that flow working on this system?

The flow breaks because i2c-hid never gets to probe. The lost
arbitration errors happen on AMDI0010:02 at ~2.3s after boot, before
any driver reaches the HID layer. Without the probe ordering fix,
i2c_designware probes the bus while pinctrl-amd is still initialising
and GPIO 157 (the WACF2200 GpioInt per ACPI _CRS) has its interrupt
bits cleared. The bus transaction fails immediately, the device never
appears in /sys/bus/hid/devices/, and i2c-hid has nothing to bind to.

With patch 1 alone (GPIO IRQ fix), the interrupt is enabled but the
probe ordering race still causes arbitration failures. With both patches
applied, the bus comes up cleanly and i2c-hid probes successfully.

However, see my reply on the 2/2 thread =E2=80=94 there may be a deeper cau=
se
related to _DSM.

Thanks,
Hardik


On Thu, 14 May 2026 at 10:36, Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> On Wed, May 13, 2026 at 22:53, Mario Limonciello wrote:
> > I don't understand.  Our design is that the interrupt is disabled
> > initially when driver loads (we don't trust state of the GPIO
> > configuration pre-boot), and then when i2c-hid loads later it is
> > re-enabled via amd_gpio_irq_enable().
> >
> > Why isn't that flow working on this system?
>
> The flow breaks because i2c-hid never gets to probe. The lost
> arbitration errors happen on AMDI0010:02 at ~2.3s after boot, before
> any driver reaches the HID layer. Without the probe ordering fix,
> i2c_designware probes the bus while pinctrl-amd is still initialising
> and GPIO 157 (the WACF2200 GpioInt per ACPI _CRS) has its interrupt
> bits cleared. The bus transaction fails immediately, the device never
> appears in /sys/bus/hid/devices/, and i2c-hid has nothing to bind to.
>
> With patch 1 alone (GPIO IRQ fix), the interrupt is enabled but the
> probe ordering race still causes arbitration failures. With both patches
> applied, the bus comes up cleanly and i2c-hid probes successfully.
>
> However, see my reply on the 2/2 thread =E2=80=94 there may be a deeper c=
ause
> related to _DSM.
>
> Thanks,
> Hardik
>
> On Wed, 13 May 2026 at 22:53, Mario Limonciello <superm1@kernel.org> wrot=
e:
> >
> > ++
> >
> > On 5/13/26 01:13, Hardik Prakash wrote:
> > > On Lenovo Yoga 7 14AGP11 (83TD), the WACF2200 touchscreen controller
> > > is wired via I2C2 (AMDI0010:02) with its interrupt on GPIO pin 157
> > > (confirmed via ACPI _CRS GpioInt decode). After amd_gpio_irq_init()
> > > clears all GPIO interrupts at boot, pin 157 is never re-enabled,
> > > preventing the touchscreen from signalling the driver.
> > >
> > > Windows keeps GPIO 157 INTERRUPT_ENABLE (bit 11) and INTERRUPT_MASK
> > > (bit 12) set after initialisation. Add a DMI quirk to restore these
> > > bits after amd_gpio_irq_init() on this hardware.
> > >
> > > Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> > > Assisted-by: Claude:claude-sonnet-4-6
> > > Assisted-by: GPT-Codex:gpt-5.2-codex
> > > ---
> > >   drivers/pinctrl/pinctrl-amd.c | 35 ++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 35 insertions(+)
> > >
> > > diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-=
amd.c
> > > index e3128b0045d22..64315b0edf2a6 100644
> > > --- a/drivers/pinctrl/pinctrl-amd.c
> > > +++ b/drivers/pinctrl/pinctrl-amd.c
> > > @@ -26,6 +26,7 @@
> > >   #include <linux/interrupt.h>
> > >   #include <linux/bitops.h>
> > >   #include <linux/pinctrl/pinconf.h>
> > > +#include <linux/dmi.h>
> > >   #include <linux/pinctrl/pinconf-generic.h>
> > >   #include <linux/pinctrl/pinmux.h>
> > >   #include <linux/string_choices.h>
> > > @@ -39,6 +40,39 @@
> > >   static struct amd_gpio *pinctrl_dev;
> > >   #endif
> > >
> > > +static const struct dmi_system_id amd_gpio_quirk_yoga7_14agp11[] =3D=
 {
> > > +     {
> > > +             .matches =3D {
> > > +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "83TD"),
> > > +                     DMI_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
> > > +             },
> > > +     },
> > > +     { }
> > > +};
> > > +
> > > +static void amd_gpio_apply_quirks(struct amd_gpio *gpio_dev)
> > > +{
> > > +     const unsigned int pin =3D 157; /* WACF2200 GpioInt per ACPI _C=
RS */
> > > +     unsigned long flags;
> > > +     u32 reg;
> > > +
> > > +     if (!dmi_check_system(amd_gpio_quirk_yoga7_14agp11))
> > > +             return;
> > > +     if (pin >=3D gpio_dev->gc.ngpio)
> > > +             return;
> > > +
> > > +     raw_spin_lock_irqsave(&gpio_dev->lock, flags);
> > > +     reg =3D readl(gpio_dev->base + pin * 4);
> > > +     reg |=3D BIT(INTERRUPT_ENABLE_OFF) | BIT(INTERRUPT_MASK_OFF);
> > > +     writel(reg, gpio_dev->base + pin * 4);
> > > +     raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> > > +
> > > +     dev_info(&gpio_dev->pdev->dev,
> > > +              "Enabled IRQ for GPIO %u (Yoga 7 14AGP11 touchscreen)\=
n",
> > > +              pin);
> >
> > I don't understand.  Our design is that the interrupt is disabled
> > initially when driver loads (we don't trust state of the GPIO
> > configuration pre-boot), and then when i2c-hid loads later it is
> > re-enabled via amd_gpio_irq_enable().
> >
> > Why isn't that flow working on this system?
> >
> > > +}
> > > +
> > >   static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned of=
fset)
> > >   {
> > >       unsigned long flags;
> > > @@ -1219,6 +1253,7 @@ static int amd_gpio_probe(struct platform_devic=
e *pdev)
> > >
> > >       /* Disable and mask interrupts */
> > >       amd_gpio_irq_init(gpio_dev);
> > > +     amd_gpio_apply_quirks(gpio_dev);
> > >
> > >       girq =3D &gpio_dev->gc.irq;
> > >       gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
> >
