Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EDA33E346
	for <linux-i2c@vger.kernel.org>; Tue,  2 Jun 2026 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429847; cv=pass; b=MGC3JxOHsLysYm7Q9v6//En2AtaVfdYIwtTAeA02ro/lNyGCFH91FrCJuQ0TlZg5S5t7+qoWl6r8+BP0FkwVlD2aNJt3JSI1J3fY80Zxs0951HhmYfJ4KQ6HrGRpvoGtNqmTZe6/MnRfIUkv2uT9eeTLTf/T0L2He2/+54TJ9BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429847; c=relaxed/simple;
	bh=J45nwhea9f9olm16V+BBvXy/k/57kC760j+0uwbt4Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYiobNIWMmChodFvhlifNaXelwbbedx6S2Ior2v1pl4bPBMJX3xIjYBdte2kjOC8VoxvrItHnop+lMOU0ljc9Vca8iE63AqcnPsQDmD2gztNDBYQcweEiu5vNEVZPeDprTBG9uZsidjA4wCckAj7PyyNgfApcxmBpuszDmdy4Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpK/VwTe; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpK/VwTe"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dbcb505578so66259677b3.3
        for <linux-i2c@vger.kernel.org>; Tue, 02 Jun 2026 12:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780429836; cv=none;
        d=google.com; s=arc-20240605;
        b=i2kVK+w379q4ZcMh34McTqNkO2/lKygkI1Apc2P2oVKi8U3CNgkGgO2uZLaiyWX4xl
         NvMNn2Gc72b22fPKAn20YBUxSP6V2sRtnm2lul923E42ls3QNKd7+KvKRheVcv7TMCsj
         W2oPu4hPRYCn1O/odSY6Cb5foZJPP2vbF/l1MAs0oP8fpqU8SNIt9PeA4cA46jc7Nx08
         RTNUdFFDg6N1feQsOLQ/5BCXVnV3AanGoVU2ibB6b4O8CbcSfZ+0YGzZ8bg+IF2oPbZQ
         WitW5KfFzLgGtxo8asKAZ2/UzOL92OFYQuPXQElSKpHQu/5aDyQbJtJiE56C0EMvsxlc
         KzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Al3rwWp3zUx80yaxoVbyfox6wzbYBQTtLuZ4Tpteh8I=;
        fh=u0nGkts/Qx8ADRA+OfXLc5aPiHZKRIQq+/WVvGFSpEw=;
        b=CRKJF6LjCz7B3lhqhSKnCaOcgX2FTNV/KrOwtQjXkT6fEVCVXC4RHRbkDc6f4S/XI5
         b0IUs9+5i8DBSVFdo72XcWlxDRWk7B7P7c8rjRYDwNfbmaujfeU0GKltDW6OsqEznrA/
         bSOcFrQdlz7E30vN1K6+ywpdpf3Fx2+IMbA8DSqEqdzCtdsI66+oUAiXjLjHkQShdJlq
         gWUlzCei36n3Qz9TQ07AyzVG5ZqslOCtGHWJp422xN3Mz28vkC8Km0PZAjzswOgFYEEH
         BHDWzUoCMUCuUabZUumFi0ymZrXUfKDmGZ0noy6wFgfb202dK1FG3yE1OIEguwl+G550
         m8+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429836; x=1781034636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Al3rwWp3zUx80yaxoVbyfox6wzbYBQTtLuZ4Tpteh8I=;
        b=QpK/VwTe4T1KLhdQlJ7zrnzHRkIyl1maZJvfmFfJXkk6ztj6AtaimNVvW26ajzJcMn
         Deo+UUUP0+2XfDmz1Ut/F1wqF1kZd46KF6rleMbfPWnc258/CMnMMznMKEXZa5rRQQj3
         QpJZMsiq7QVFUNuQlS2nYwV0MOX7znMfjbMdP+l0yt/F52viVlMT7hR1QZ1WOezvvZrR
         vZBGPRBhYuA04+2JbOBOhRXuBAiCy98FLRnL3b1YTcv1HphXNNabIVAYIg7doEaaAPvH
         sUGOgqYHpRH+3VRnuiSOUNSlRgZ/6x/syG4is5ci38HBqXtjmF1Dwfwah2fpihbGIWsY
         poHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429836; x=1781034636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al3rwWp3zUx80yaxoVbyfox6wzbYBQTtLuZ4Tpteh8I=;
        b=O2b99RQeizuX5Fw7oybeYot+nhDc8PpboNxPJyBvbJuc6dmz7ze2/83n4l6InoZwQz
         8Fq1RYrH2ZOvqi78NxUn3c4KgG94UBijpYHz8Qz8s2/wf3WJOBwoSe5rGOrvqT0ezNuD
         wks8jiSpMFhXCEtHkp5eQvUhJ8XAQZhW+zCUpqQuLEoRYsRy7ltOoEnOnlc4Rk2ADq3T
         YqXAzAaJeALYpk0doRn/HttsZXB4O5e8w5yYoUhGORKSFM2SDXN/6fvvYUY1K9a+jdwC
         L32nxl0uruY3I7DS5jYCoyhh6jm84hGVBj4pBQIsNWp8uLqkWDTaQffMyiPxkGl8Tuaq
         RvTA==
X-Gm-Message-State: AOJu0YxpKTooD1tiAD8Oyo8Q7dtsvNEYA4125k2d6i7yk2mmI/qtbz9c
	ZrEC4+7aF3zHcO90HaLGq9UmTPfIAZha0JVgvR4hbiOdamHZmC3bkm6Z1GnHWlQl22Gcb6hffZs
	k6dv46hZKhGxoPkvTTFyKQB/aYts7TgAzC2c0ywiLKw==
X-Gm-Gg: Acq92OHLxWZEsJdg5tYWTdurxVLNOyjOqi99XzMsqLeQjFtcQa8JUHwy/EOdOTI+0U0
	BayZchTG66kB1s1X+1IWK5D1s8n7N0qr2UKvqeed7R+bndcezy99TGCMQcSs74ZZUMBAIsgehP3
	JOI++C0bc9W/kFp4Co4zWlxhAy0fYaapXCC+uxA5b+Lwnv39PPL38pf9Ck2bxXkUdWWwDUAYtbR
	MvkrxJ0gAk+C0vh/C1ACuQSmIj1CBrRosVNCLl2ai9pf9KAwAD1/Z3M95iZCJdu7fntrsu2io5T
	imUA8ZMLL84YN7k2DREK6UJsHAFAlXXw+D58CvrGuybuT0TzXnX/Aeud+q/O0Ajbvvd5lpyQRsa
	wCnbxoNs5LE89Tt1+7A933yrT/iFSrUhee3k95QKO9sFaczPy0fd3BgsJgHSG4laEfI0KaQ==
X-Received: by 2002:a05:690c:c:b0:7dc:a5a8:89d with SMTP id
 00721157ae682-7ea49872db5mr3751757b3.10.1780429836496; Tue, 02 Jun 2026
 12:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com> <20260602185339.GA404948@ax162>
In-Reply-To: <20260602185339.GA404948@ax162>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Wed, 3 Jun 2026 01:20:24 +0530
X-Gm-Features: AVHnY4J4lsO4dRAVoHeZvlKwJpL15EtqjbgzcGJZ5ADm6FFAZWXDLWJU7PS7ofo
Message-ID: <CANTFpSX0Ehpno7b=xrnqzmENn=sfKj1UcyRzXvMyy4Rcyr7NhA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 03, 2026 at 00:23, Nathan Chancellor wrote:
> I bisected boot issues with a few of my test machines to this change
> in -next as commit ef76a3a28c79. I seem to recall a crash in strcmp()
> in one log but I cannot be too sure.

Thank you for bisecting this.

The strcmp() crash is likely the issue. In
check_gpioint_resource(), we access agpio->resource_source.string_ptr
without checking whether it is NULL first:

    if (!strcmp(tmp->path, agpio->resource_source.string_ptr))
    ref->path = kstrdup(agpio->resource_source.string_ptr, ...)

The acpi_resource_source struct has a string_length field -- when it is
0, string_ptr will be NULL. On your machines, likely some GPIO resource
apparently has no resource source string, which we did not account for.

I am preparing a fix that skips GPIO resources with no resource source
string (string_length == 0 || string_ptr == NULL). I will test it on
my hardware first and send a patch shortly.

Sorry for the regression.

Thanks,
Hardik

On Wed, 3 Jun 2026 at 00:23, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Hardik,
>
> On Fri, May 29, 2026 at 03:38:37PM +0530, Hardik Prakash wrote:
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
> > occur before the GPIO IRQ quirk in amd_gpio_probe() has run, causing:
> >
> >   i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost arbitration
> >
> > Add a generic dependency check in i2c-designware that walks ACPI child
> > devices, identifies any GpioInt resources, resolves the referenced GPIO
> > controllers, and defers probe if those controllers are not yet bound.
> >
> > This ensures GPIO controllers complete initialization (including IRQ
> > setup and quirks) before I2C child enumeration begins, fixing the race
> > without device-specific quirks or DMI matching.
> >
> > The probe ordering race was confirmed via dynamic debug tracing:
> >
> >   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >   2.348157  lost arbitration
> >
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > Assisted-by: GPT-Codex:gpt-5.2-codex
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202605240959.Kcf1lIg4-lkp@intel.com/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
>
> I bisected boot issues with a few of my test machines to this change in -next
> as commit ef76a3a28c79 ("i2c: designware: defer probe if child GpioInt
> controllers are not bound"). I consistently get no display output and I do not
> have serial access to these machines, so I do not have much to go on here at
> the moment. Occasionally, the network controller will be initialized so I can
> remote in but I have not been able to do it recently to try and gather logs.
> What information would be useful for trying to figure out what is going on
> here? I seem to recall a crash in strcmp() in one log but I cannot be too sure
> since it was late at night when I was doing my initial triage.
>
> # bad: [08484c504b55a98bd100527fbe10a3caf55ff3ff] Add linux-next specific files for 20260601
> # good: [e43ffb69e0438cddd72aaa30898b4dc446f664f8] Linux 7.1-rc6
> git bisect start '08484c504b55a98bd100527fbe10a3caf55ff3ff' 'e43ffb69e0438cddd72aaa30898b4dc446f664f8'
> # good: [57fb910db1b6051476b91a4d4ae18bc027a7f36d] Merge branch 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect good 57fb910db1b6051476b91a4d4ae18bc027a7f36d
> # good: [18ea7e3ca91e7a9eb9e43c11154350cec160830b] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
> git bisect good 18ea7e3ca91e7a9eb9e43c11154350cec160830b
> # good: [a5696dd9c080352e25b576acf24450cef255b6eb] Merge branch 'tty-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> git bisect good a5696dd9c080352e25b576acf24450cef255b6eb
> # good: [c158564f40f0d2a68833610ac136f9714fc51b16] Merge branch 'staging-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> git bisect good c158564f40f0d2a68833610ac136f9714fc51b16
> # bad: [4240c928a5edeb13fb3953248dfc45e5d9f42f00] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> git bisect bad 4240c928a5edeb13fb3953248dfc45e5d9f42f00
> # good: [2e24f5964b72ef213ecdb959a0b0d60b2dc00a3b] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git
> git bisect good 2e24f5964b72ef213ecdb959a0b0d60b2dc00a3b
> # good: [6a350ccc4dc3f46ed2ee2592e3050956e415ef64] pinctrl: add new generic groups/function creation function for pinmux
> git bisect good 6a350ccc4dc3f46ed2ee2592e3050956e415ef64
> # good: [b12e12ee4138e30d786eda02223e87044c989bb1] gpiolib: Mark gpio_devt, gpiolib_initialized and gpio_stub_drv as __ro_after_init
> git bisect good b12e12ee4138e30d786eda02223e87044c989bb1
> # good: [446fa334d186316e76cbdc4e94e42af7d040a79c] pinctrl: qcom: Replace open coded eoi call with irq_chip_eoi_parent()
> git bisect good 446fa334d186316e76cbdc4e94e42af7d040a79c
> # good: [a8754838f83a9905af516f38dd2633744a94f71a] gpio: max77620: Unify usage of space and comma in platform_device_id array
> git bisect good a8754838f83a9905af516f38dd2633744a94f71a
> # bad: [ef76a3a28c79b628890431aa344af633e892035b] i2c: designware: defer probe if child GpioInt controllers are not bound
> git bisect bad ef76a3a28c79b628890431aa344af633e892035b
> # good: [b0c13ec17438577f90b379d448dfed1233e2c0a4] pinctrl: mcp23s08: Read spi-present-mask as u8 not u32
> git bisect good b0c13ec17438577f90b379d448dfed1233e2c0a4
> # good: [3f786abd23951f3f600a62fef42469d9200d5f52] Revert "pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11"
> git bisect good 3f786abd23951f3f600a62fef42469d9200d5f52
> # first bad commit: [ef76a3a28c79b628890431aa344af633e892035b] i2c: designware: defer probe if child GpioInt controllers are not bound
>
> --
> Cheers,
> Nathan
