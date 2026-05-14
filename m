Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BFD531
	for <linux-i2c@vger.kernel.org>; Thu, 14 May 2026 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735701; cv=pass; b=djB4/JK7pIUZ0Dm3Zpw0aZ9MCWolklK2S+rH4IYOHMParzf/wTh1mZLvU5bSg65QPrOkdFSany+9goirpknfk1TtKvq+0FkrtGZw7Mr8+vnK6kBN2WYlQBomD89L2/aHDOf4jteTZdYVn/BcMCsn6WTxJP3Ild1/hgmS9FKyoWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735701; c=relaxed/simple;
	bh=Esa6aMxHc3lqCK14T6SUOgeyDUdsfbMrcCgZll//QZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWeHzifMLUkcpnhBZeG5qBfpvoG7xyMEnY52ZVrSduWJy9hxYYxfMp2zxAa1WXm6x3Li9Al00g0AL6lJ8fTkqrUEViv9Ey4cl66MYkJ7NUezA8eUYoM3vVux9IAQSTF1fgfQBCzQSrIxx3kZgLgy1oznI/CyG6Q2+9WJz5o/OMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBvMmITC; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBvMmITC"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c5361142fso8846336d50.0
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 22:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778735699; cv=none;
        d=google.com; s=arc-20240605;
        b=h2es6f+t3ET6+mkOv7BSkb0B329VaahNcj0jCREUpnEY/kFJKdBToG35WyFto415eB
         zLJUFQLuQYUU/0YdN+VAQ0WV01REoGD7UKppiw51nUeQrpGOEaS5Bpg5Ac45MQJt+vAN
         bIckAIO3WPw0HAh+5xVPmubpEsOmDEFPQmkq+ETQZSa94PHLaqEktj8wJ5HCnONIqHoW
         fDZsdq21keasHYUsyLoeoQBCerNEbcnt/It6L9ABn9gu+/V3yXSS2ZfSFIX+afX8G1Ip
         BozfmBphS3k49UIM835kuaNCIClbPKADeweFCJ3DXtwDI/ruzMmTiq1NveC9uF3Uugxe
         xfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rNR/KRKvO9xK0+jIcZNTqxkNkqR2qZPifnFqEZLSgko=;
        fh=OCtp78J1oFejKwYnhgBqfY3/OOsJsOiMlRLXw+APUYY=;
        b=dlLIdbysWxhA/2qnQS4lKnYvHoautL2h9wETa+h5J7Z7LSa1Yt7exOSLSrXkyANnUr
         0pzIcLRdnygcZ8kYbVmbAFnJshwUciLOdwLXUltB2v9nzpkfeVr/D+hnJqpywHKzRYgm
         WuXVBO7JcLolUTRcPNhtz5wGOAOANRwRaYpbLcMQAEy1BhcetyZlCpCgkK2aOBk/9XzE
         YH67e6GCCRvpQ7gmdseeRQF0Pc2NdZKxcS/iPdLd/gPMrsedlMCbEYH80hpdXE5kCMto
         V1wztF6/NfPfmKJoDfFAEyTzh3STk+2/5lX37RyAJP9sPpvvXgocoyehNq+9iQbrw1br
         X4uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778735699; x=1779340499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNR/KRKvO9xK0+jIcZNTqxkNkqR2qZPifnFqEZLSgko=;
        b=CBvMmITC/CQ9nf4WSprwi2cUlk4W/fstP7Jr0F99Xqafrgu2dJpX6kbSZolGD2if0n
         7eLW/RfAI5f4i9nypEyLGx0rTnMD/fdYlenKqSyEJIipD+dHPKau0selJ5l/zT/zDkqk
         M6l/lnEVCL+rVxPsOQZITGaTXLDSp6CC7DwcyHoLddJTuymIlbx6Wxunoh0QCG+yCiHZ
         U9mxWk/NnYvuY7XfZJuKUVtRlMjKJe0CVp8hdNdnzT78dX65rtIHJXFTKIwMTQ/I6OsU
         1kXGzJ4GdxHod5l1rpSZBQWtzvoT2kFPfoi14sMsaWUdvSQFyUvLcWsReVF3RYc9+6aw
         82sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778735699; x=1779340499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNR/KRKvO9xK0+jIcZNTqxkNkqR2qZPifnFqEZLSgko=;
        b=OoJhbzDnRRoQzE7LQuJ60QU74XaH6KZO0mdO7eOY/mf/AgoUD9WUaJ6fDdxosb3xHO
         dwpXH3N+v6Xf5A0aAuEoLsI1IjSWrYI2+pTFd3EY13bLCLQTAUZRkqXzEakj5sQY8QA5
         SyFqEg3+FQh3d3QC7OG5CDQRJaQMIRekskFN8ALWDkcDeA5OWf265FvPikJ+p9sEz4yZ
         arszAeLcELxvVRPE7zw9Pu0R9N9v2rq+TgKBbRM50vntSox9nc2sVHUWrgaudHIFbXcP
         YRafhplazDe5zr9WcKAJJU0he6ssCyaiuX5gmJAopoio0+Z3yc6gUlLjovBDkd3iEcRh
         5jkA==
X-Forwarded-Encrypted: i=1; AFNElJ9OYuaoSQGcZ+XCoISjY/efoc0K4r6XyN9yf7ihaH1fnNzuEau8TEYUnvGSson750TpXg2nUyIKHeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfzYIC4Q8EnU/8nciuY3DvLhNDstq+iCFbDRa6YlWIClwTWJGj
	vZWwT3nNDG2LMUrnTGEytYkA2E74QetETm/W5tCZd0UCZePk0Q9etY/9E11Ov/rrM1C85UMLf3c
	7HWgz/+O8aP1zYVVTIjQ3QQR2qdeOrz4=
X-Gm-Gg: Acq92OG0l+Wkp1lFjAn/Qzl2qhXKhtEP19OZ29U0OmJbeeSrt5VLA0o65eqMnM+LxF1
	9IoxpSA2ts4QAU7TkhBAh1cSx8+27DQ59/eZ1OxnpC6VHVUAnj72eIilwTMR7/hy1OZabJ3NVAd
	eC1IBo27eD4ztJCvnX7m3zDPqZ5Xf2O3nSaCD2thJ+rmkjqg5YB4/68mXjuvvX0UL1NkcH+wKnk
	HvLdphCjdbct2wVCKciVC1yH1Hv5f+7FdwnkgAYGXrkhfC2sWsnCZbiDa6QF2fxcXhNNJbT7+9z
	kcNswrHH2clCOr/qDh38wmChU3LoXn8na7ON7FlxsW1hxrOJr+QQ35fpA1sRXUO7sJota4qeXwz
	SYivY6RwiIp4uWXnwBLTO3rtQ+J6nAs3Nt1cr/SixYSUlbHIOIIeswslzquDVPem4ZyQMmg==
X-Received: by 2002:a05:690e:1404:b0:653:3d0:f2b2 with SMTP id
 956f58d0204a3-65df6231b18mr6271191d50.20.1778735698888; Wed, 13 May 2026
 22:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513061338.9348-1-hardikprakash.official@gmail.com>
 <20260513061338.9348-3-hardikprakash.official@gmail.com> <agSw-Y_jjliO1gaE@ashevche-desk.local>
 <705ef2f4-3bdf-4e7c-be9c-980cc0a21544@kernel.org> <CANTFpSU=94RuX1uFf4UitRyzLPvu=cTF_S5khjjJNQUU1T_PtA@mail.gmail.com>
In-Reply-To: <CANTFpSU=94RuX1uFf4UitRyzLPvu=cTF_S5khjjJNQUU1T_PtA@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Thu, 14 May 2026 10:44:47 +0530
X-Gm-Features: AVHnY4I4_ClSXDmZ88nPOZOPNVNTwSxsM3n99Z3_DfzSd8a_608FgZvdDAFMfjY
Message-ID: <CANTFpSXBoiebqZEsZA644KukzFceYK1Ogvmioxv+Lqswy_OThw@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: designware: fix probe ordering for AMD GPIO on
 Lenovo Yoga 7 14AGP11
To: Mario Limonciello <superm1@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, brgl@kernel.org
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linus.walleij@linaro.org, wsa@kernel.org, basavaraj.natikar@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resending with full Cc list =E2=80=94 apologies for the missed recipients.=
)

On Wed, May 13, 2026 at 22:58, Mario Limonciello wrote:
> Yeah; I tend to think doing this with a quirk is hiding a bug.
>
> Are you sure this isn't a case of two masters on the bus?

I looked into this after your email. The DSDT for TPNL (WACF2200) does
have a _DSM with UUID 3cdff6f7-4267-4555-ad05-b30a3d8938de (HID I2C
Device). So yes =E2=80=94 this could be the same mechanism you saw on Dell.

> Could this be something similar that really calling the _DSM is the
> missing link?

Possibly. With my current patches applied, the probe ordering fix
ensures i2c_designware initialises AMDI0010:02 cleanly, i2c-hid
subsequently probes, and presumably calls the _DSM at that point =E2=80=94
which may be what finally releases the bus. Without the patches,
i2c-hid never gets that far.

The question I can't answer yet is whether the _DSM needs to be called
*before* the first I2C bus transaction attempt, rather than at i2c-hid
probe time. If the firmware is acting as I2C master until the _DSM is
called, then the arbitration errors at 2.3s would be explained entirely
by the missing _DSM call, independent of the GPIO IRQ state.

I'm investigating the _DSM content further. If you believe the correct
fix is an earlier _DSM call (similar to what 7d62beb did for S4), I'm
happy to test a patch for that approach and report back.

Thanks,
Hardik

On Thu, 14 May 2026 at 10:37, Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> On Wed, May 13, 2026 at 22:58, Mario Limonciello wrote:
> > Yeah; I tend to think doing this with a quirk is hiding a bug.
> >
> > Are you sure this isn't a case of two masters on the bus?
>
> I looked into this after your email. The DSDT for TPNL (WACF2200) does
> have a _DSM with UUID 3cdff6f7-4267-4555-ad05-b30a3d8938de (HID I2C
> Device). So yes =E2=80=94 this could be the same mechanism you saw on Del=
l.
>
> > Could this be something similar that really calling the _DSM is the
> > missing link?
>
> Possibly. With my current patches applied, the probe ordering fix
> ensures i2c_designware initialises AMDI0010:02 cleanly, i2c-hid
> subsequently probes, and presumably calls the _DSM at that point =E2=80=
=94
> which may be what finally releases the bus. Without the patches,
> i2c-hid never gets that far.
>
> The question I can't answer yet is whether the _DSM needs to be called
> *before* the first I2C bus transaction attempt, rather than at i2c-hid
> probe time. If the firmware is acting as I2C master until the _DSM is
> called, then the arbitration errors at 2.3s would be explained entirely
> by the missing _DSM call, independent of the GPIO IRQ state.
>
> I'm investigating the _DSM content further. If you believe the correct
> fix is an earlier _DSM call (similar to what 7d62beb did for S4), I'm
> happy to test a patch for that approach and report back.
>
> Thanks,
> Hardik
>
> On Wed, 13 May 2026 at 22:58, Mario Limonciello <superm1@kernel.org> wrot=
e:
> >
> > ++
> >
> > On 5/13/26 12:12, Andy Shevchenko wrote:
> > > Please, Cc AMD people on the AMD related stuff.
> > > +Cc: Mario
> > >
> > > +Cc: Bart
> > > (the GPIO enumeration and checks, smells like it might be done differ=
ently).
> >
> > Yeah; I tend to think doing this with a quirk is hiding a bug.
> >
> > Are you sure this isn't a case of two masters on the bus?
> >
> > [    2.286838] i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost
> > arbitration
> > [    2.286887] i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost
> > arbitration
> > [    2.286923] i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost
> > arbitration
> > [    2.286964] i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost
> > arbitration
> > [    2.287521] i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost
> > arbitration
> > [    2.287569] i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost
> > arbitration
> > [    2.287616] i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost
> > arbitration
> > [    2.287658] i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost
> > arbitration
> >
> > I saw something really similar on a Dell platform last year; but around=
 S4.
> >
> > It ended up being a situation that the EC had way to act as I2C master
> > and until the right method from I2C-HID was called it thought it was
> > still I2C master.
> >
> > https://git.kernel.org/torvalds/c/7d62beb102d6f
> >
> > Could this be something similar that really calling the _DSM is the
> > missing link?
> >
> > >
> > > On Wed, May 13, 2026 at 11:43:38AM +0530, Hardik Prakash wrote:
> > >> On Lenovo Yoga 7 14AGP11 (83TD), the WACF2200 touchscreen fails with
> > >> lost arbitration errors on AMDI0010:02 at boot. The root cause is a
> > >> probe ordering issue: i2c_designware probes AMDI0010:02 before
> > >> pinctrl-amd has finished initialising, so the GPIO 157 interrupt
> > >> needed by the touchscreen is not yet enabled.
> > >>
> > >> Add a DMI-matched deferral in dw_i2c_plat_probe() that uses
> > >> device_is_bound() under device_lock() to correctly wait until
> > >> pinctrl-amd's probe has fully completed. Use acpi_dev_get_first_matc=
h_dev()
> > >> for robust HID/UID-based GPIO controller lookup instead of string
> > >> name matching.
> > >
> > > ...
> > >
> > >> +static bool dw_i2c_needs_amd_gpio_dep(struct device *device)
> > >> +{
> > >> +    struct acpi_device *adev =3D ACPI_COMPANION(device);
> > >
> > > Split hard-to-maintain definition and assignment that's going to be v=
alidated.
> > >
> > >> +    if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
> > >> +            return false;
> > >> +    if (!adev)
> > >> +            return false;
> > >
> > >       struct acpi_device *adev;
> > >
> > >       if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
> > >               return false;
> > >
> > >       adev =3D ACPI_COMPANION(device);
> > >       if (!adev)
> > >               return false;
> > >
> > >> +    return acpi_dev_hid_uid_match(adev, "AMDI0010", "2");
> > >> +}
> > >
> > > ...
> > >
> > >> +static int dw_i2c_defer_for_amd_gpio(struct device *device)
> > >> +{
> > >> +    struct acpi_device *gpio_adev;
> > >> +    struct device *gpio_dev;
> > >> +
> > >> +    if (!dw_i2c_needs_amd_gpio_dep(device))
> > >> +            return 0;
> > >> +
> > >> +    /*
> > >> +     * Find the AMD GPIO controller by HID/UID and get its physical
> > >> +     * platform device. We need the platform device (not the ACPI d=
evice)
> > >> +     * because that is what gets bound by the amd_gpio driver.
> > >> +     */
> > >> +    gpio_adev =3D acpi_dev_get_first_match_dev("AMDI0030", "0", -1)=
;
> > >> +    if (!gpio_adev)
> > >> +            return -EPROBE_DEFER;
> > >
> > > Hmm... This is interesting case, smells like something similar to wha=
t we had
> > > with x86 Android quirk driver. Cc'ed to Bart to briefly look at this.
> > >
> > >> +    gpio_dev =3D acpi_get_first_physical_node(gpio_adev);
> > >> +    acpi_dev_put(gpio_adev);
> > >> +    if (!gpio_dev)
> > >> +            return -EPROBE_DEFER;
> > >> +
> > >> +    /*
> > >> +     * Check that amd_gpio probe has fully completed, not just that=
 the
> > >> +     * driver pointer is set. The driver pointer is assigned before=
 probe
> > >> +     * finishes, so checking it would allow i2c_designware to probe=
 before
> > >> +     * the GPIO IRQ quirk in amd_gpio_probe() has run.
> > >> +     */
> > >> +    device_lock(gpio_dev);
> > >> +    if (!device_is_bound(gpio_dev)) {
> > >> +            device_unlock(gpio_dev);
> > >> +            return -EPROBE_DEFER;
> > >> +    }
> > >> +    device_unlock(gpio_dev);
> > >> +
> > >> +    /*
> > >> +     * Create a device link so the driver core enforces probe/remov=
e
> > >> +     * ordering between this I2C controller and the GPIO controller=
.
> > >> +     */
> > >> +    if (!device_link_add(device, gpio_dev, DL_FLAG_AUTOREMOVE_CONSU=
MER))
> > >> +            dev_warn(device, "failed to add device link to %s\n",
> > >> +                     dev_name(gpio_dev));
> > >> +
> > >> +    return 0;
> > >> +}
> > >
> >
