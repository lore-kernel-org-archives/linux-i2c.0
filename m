Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451936212C
	for <linux-i2c@vger.kernel.org>; Mon, 10 Aug 2026 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786341260; cv=pass; b=o7w1ozGNU/Kwmdn17lc5hno3WPCPub0t5Az9xwdfOamwxNGKHiCpeW9jv7qCYnWYtWOHh0UhVcfgdXTkBnXCvMn+3+OxWNrzHOrmyEXurQvqZoZTOyVnHeXCiRGa6t9rNfwOwjybRokCUXU8Gwph4L49bZQO7lCmWs0s3IHdFj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786341260; c=relaxed/simple;
	bh=suUjvTf3P1y0cIsVCuDKytXXdqHPIMwVWtmL6zKDomU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAUx5na4XU2orZwDiojx+8i/3Jl2ghnKRfOyESpOuROMF30Z5u+0SHxDzoRBHycal1GE+JoDhYYcIDhYLrvyjiTh/iq33wOUv3gSPrEH8CR4Mg7bZ2w+D0L7X1qrIeN+PfIbPh4ammNyijsXXohjamsiYwjhdz0R0P5l+3LUxX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9lqP6NQ; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9lqP6NQ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ed073fed0so19971727b3.0
        for <linux-i2c@vger.kernel.org>; Sun, 09 Aug 2026 22:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786341258; cv=none;
        d=google.com; s=arc-20260327;
        b=AKuG8SO3lKpuJ773+SRYdYoRBkreW9EGrSM7Zv8y8+MCqb7kczAOpHxILPS66hflOT
         lF9RaIRjpRsnQJphozhmfv7yxJSHFf6jR5mLP/XfRdps/ijiM1GKr9QJf732ZfeYsgSS
         u0OnM8r2ollmGdKt/zl6W5Dp7SyaxwaIMXe+4bsIDGD5QusPDvRf63z7Y3Gma0/zaNtU
         GI514AK/YJkJpIgH/ohVaHG5giFvyRhjV0Zao/GbTcC1T1rxCAcw4JRxK9ZF8B4nG2NV
         AS2ABAiTTf/BWs8UcRS13rSoO29h/RrjQu1jUgY+f5oc+UoV2G9hCvag17bHnyXBaWtJ
         aL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uwGD58QbD1UPefAzp4tzFsyiBGkUf2nddf4HvF828lA=;
        fh=HAjmgChtSnGdYuJfzP9U12xSENgRBSLgG8rRcconACk=;
        b=FC5SsYu2UIq5OrAFPYxYxDb2np5gRTsSOKYEK9bwBqCXKlyJL7dbo0OJC3qQSPXh4V
         AptIphTZ+ojSLAP4nsxHL8csya1HdeGU2unKfqbhW1CGIi0ugZ7ImCef+SZjexsm+T0q
         r3sEUppFOKP33S7zz8UDDFrYqgEBilYiBI9G/88UWWFrzbsQtsSjUjjuGuWXMgb/3O6g
         qAxM8zHSIgbvroIxVO0uGvrT08CWrb066oxDCJIVj8l/JVzHqIV0IKwadQRb62ZF0tCw
         IQq8AE4df1KJpyBBgrnQAicxXZeh8zvMbdouycZi2s9LSVaePkCsQsL1WeP50ma7kvVc
         0b8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786341258; x=1786946058; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uwGD58QbD1UPefAzp4tzFsyiBGkUf2nddf4HvF828lA=;
        b=W9lqP6NQWxKthg5VK9Ot9mOJY2HPfDOZySxTQlimxgwwnDtroib5Iy4ysfTYEljEPq
         2tGCs0yVZgIoH9ZKHjAngeNSCN7aSnaoyXkHLoXmWtY3bivcrxmfflwFEdW/ArSFBj73
         JfCpA7BZ3Hf6/4vbWbuVbpneqComJYJ3F5tY1aDrF4Hxk7zBySp4V/ZeO86L/os+jc19
         yQcRTuyzM+YQA3G3hYZTK3W2GJiJ0uLK3MAuoo3WxFoezBRFfg1FGy9uT99XM4ITMwPm
         /a4D8K++/LLfiPFlCmln2RX4TgP1mOJ4NikNKnxfbQFO8/PLToqd6rQJKaDT6+1TwUre
         LxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786341258; x=1786946058;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uwGD58QbD1UPefAzp4tzFsyiBGkUf2nddf4HvF828lA=;
        b=jBGUMXFasmqiXh0Gs5Xgxe1R0Kw7lmLQZRc/3YT2zADbhWNtnn+pO4OLCQPd2A2xA4
         HKcwmQYWYuZpSOJIEjQ75juzzSHlO74WKzm728pwsBJn0ZTmcFgbnecR346P83ViQPpI
         wdDjcWTk1RzIcG+eIrV8s71CB6hSrLEsSO0cbo3AEKEd42J/dvLI71PZavF/HgVwSJyE
         eMgO/Ghtcur8xnJkVA5ZfaDbezDDVM7Uiwz6712k1aQMbFpbYRLKBREgkYkpMJjk5wMg
         dgeTgg4LpFsXMIBvbUZWyOtd9CJxkA6ouxbS8XGlzK7T1LmxH+yxo+gBLBIpehz2fxqP
         FRRA==
X-Forwarded-Encrypted: i=1; AHgh+RrDyCrR/rF+5wXkW8dV8tV3SJ7dmX01DVQcYK1leHhGNgmiO1O8YQez08es+zHZv0I9RVjAyN9nsNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8pbrxldwyVwpfPylNhan8IY8ZrgN+ky66mT/WP+F3prIai9l
	xnx+Q/ymswQTnJWKo8Hs7RxsXq0lafbxMKWzy/K+p810oFdif/VSHsz9Sruc36ZBfiYmTUiejoB
	uwsVMZxMxj47WThzz/pjwD6sYlmwG4nPcUcVrsic=
X-Gm-Gg: AR+sD11F/Lc7Hi6Vg32RZeI92hBZKAsRXI3RCcubuKR295bGfg0fQzZMRWKdRuAkDc3
	jtvhz6acAM7sS0+Be0BVu7koXR2RwFlW/ZpOtA7hYNPlGuJVwxy4gfYqAHpvE+t2ei3oTqqt/uX
	i0RT+V/TBRGIR2Jaz1GTFJEs7Y81dmghpvx9RQ/Oh55ihY6garVknsd/FHSa8uTDWlYHQarPcv4
	SK/9hPW+pEf+P4XAwhM++Vib8sRCU0OwdjaqZOXLgX7D/2fGSw/G7NUud8m0ykSUVD/6e29rzMf
	0gbVkrgNrgTH6atAGdN1PnYVTGN3mMVLrwTe7g6+tgWewa9mqe7OL12yYUfj4bLW/iADCdZu0wI
	NdwBq06wcIC1H/1pxzyyitEkfvE7PMkqIMEgBFnGIKqr5jekJ4Pmjemvdjwmb2f5zqnDBgylnx+
	GW0qHmzo0/Ra4pY+F5nKKYOBd5YXSX0g==
X-Received: by 2002:a05:690c:498d:b0:81f:889c:2078 with SMTP id
 00721157ae682-8201bc89d5cmr240796707b3.7.1786341258104; Sun, 09 Aug 2026
 22:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu> <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
 <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
 <aneQvMN_Zet2b62n@ashevche-desk.local> <b5b95476-636f-40b1-8575-47918169b7bb@leemhuis.info>
 <CANTFpSWzV9tzMwc2cURCQBhpZmrv1SsZqnwBEu0jt=ZQWfvWgQ@mail.gmail.com> <1a209e14-05c6-4796-a8fc-d0c3a776520d@leemhuis.info>
In-Reply-To: <1a209e14-05c6-4796-a8fc-d0c3a776520d@leemhuis.info>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Mon, 10 Aug 2026 11:24:06 +0530
X-Gm-Features: AUfX_mwrTPHihRlbGamOP_Zjb7bYCzzTQ_X6CZ2JeBClHEdHTOPV1XytPUE6eeo
Message-ID: <CANTFpSWnTjoTS8hBOvVM_w3pWHyOiBhch_GXe_mG-d56WeF-0w@mail.gmail.com>
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Aug 2026, Thorsten Leemhuis wrote:
> Sorry, picked the wrong file while preparing the mail, it's here:
> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg

Thanks, that's the one. Full timeline from that boot:

  0.619s  AMDI0010:00 and AMDI0010:01 defer (AMDI0030:00 not registered)
  1.136s  Retry succeeds: device_is_bound()=true for AMDI0030:00,
          confirmed for all three children (XXXX0000:00, SYNA8018:00,
          NXP1001:00)
  2.222s  lost arbitration on AMDI0010:01 (x3)
  3.260s  controller timed out, HID descriptor fetch fails

The dependency check itself is behaving correctly here -- it defers,
then correctly confirms AMDI0030:00 is bound before letting probe
continue. The arbitration failure happens over a second *after* that,
when the touchpad attempts its actual first transaction.

So this doesn't look like a logic bug in the check itself. My read: by
delaying dw_i2c_plat_probe() by ~500ms (correctly, for GPIO's sake),
something else ends up contending for the AMDI0010:01 bus by the time
the touchpad's first transaction actually happens -- a window that
the original (undeferred, earlier) probe attempt apparently avoided.

Mario -- does this look like a known AMD I2C/PSP semaphore contention
pattern to you? Wondering if there's a shared bus/firmware consumer
that could explain a ~1s-later collision like this, independent of
the GPIO controller itself being ready.

Thorsten, if you have it handy: /proc/interrupts and lsmod from this
boot would help narrow down what else might be touching that bus
around the 2.2s mark.

Thanks,
Hardik

On Mon, 10 Aug 2026 at 11:06, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> On 8/10/26 07:23, Hardik Prakash wrote:
> > On Sat, 8 Aug 2026, Thorsten Leemhuis wrote:
> >> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>
> >> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >> [...]
> >> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >
> > Thanks, this trace looks correct on its face (defer at 0.619s, retry
> > succeeds at 1.122-1.136s), but the link above points to the same file
> > you sent last round (the master+revert baseline, no debug patch, no
> > i2c-dw-gpio-dbg lines in it at all) rather than this new capture.
> >> Could you share the full, unfiltered dmesg from this exact boot (the
> > one with the debug patch applied)? I need to see where
> > "lost arbitration" falls relative to the trace above.
>
> Sorry, picked the wrong file while preparing the mail, it's here:
> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
>
> Ciao, Thorsten
>
> > Separately, from your DSDT: NFC1 (NXP1001), which shows up as a child
> > of AMDI0010:01 in your trace, declares its _CRS as a raw resource
> > buffer containing three GPIO resources referencing \_SB.GPIO -- one
> > GpioIo and two separate GpioInt entries. Not sure yet if that's
> > relevant, but it's a pattern I haven't seen on my hardware
> > which I've tested against.
> >
> > Thanks,
> > Hardik
> >
> > On Sun, 9 Aug 2026 at 21:49, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>
> >> On 8/8/26 22:25, Andy Shevchenko wrote:
> >>> On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
> >>>> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
> >>>>> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
> >>>>> GpioInt controllers are not bound") and causes a regression for me: the
> >>>>> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
> >>>>> kernel log:
> >>>>>
> >>>>> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
> >>>>> i2c_designware AMDI0010:01: controller timed out
> >>>>> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
> >>>>> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
> >>>>>
> >>>>> Reverting this change in current mainline/master (f9a2394a23482) fixed
> >>>>> things for me. Full dmesg of current master and master+revert can be
> >>>>> found here:
> >>>>>
> >>>>> https://www.leemhuis.info/files/misc/dmesg-master
> >>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>>> [...]
> >>>> Two things that would help narrow this down, whenever you have a moment:
> >>
> >> Thx for looking into this. Here we go:
> >>
> >>>> 1. A DSDT dump
> >>
> >> https://www.leemhuis.info/files/misc/dsdt.dsl
> >>
> >>>> 2. A dmesg with dynamic debug from a kernel built with the attached
> >>>>    patch on top of current mainline/master
> >>
> >> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>
> >> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >> [    0.619018] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
> >> [    0.619076] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >> [    0.619079] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >> device=AMDI0030:00
> >> [    0.619080] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
> >> NULL, deferring
> >> [    0.619082] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
> >> [    0.619102] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
> >> [    0.619104] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
> >> [    0.619159] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >> [    0.619162] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >> device=AMDI0030:00
> >> [    0.619162] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
> >> NULL, deferring
> >> [    0.619164] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
> >> [    1.122517] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >> [    1.122523] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
> >> [    1.122625] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >> [    1.122636] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >> device=AMDI0030:00
> >> [    1.122639] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >> [    1.122642] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >> [    1.135894] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
> >> [    1.135898] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
> >> [    1.135976] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >> [    1.135980] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >> device=AMDI0030:00
> >> [    1.135983] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >> [    1.135985] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >> [    1.135987] i2c-dw-gpio-dbg: check_child_gpioint(adev=NXP1001:00)
> >> [    1.136005] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >> [    1.136008] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >> device=AMDI0030:00
> >> [    1.136009] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>
> >> HTH, Ciao, Thorsten
> >>
> >>>> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>>>> On 7/28/26 10:30, Andi Shyti wrote:
> >>>>>> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
> >>>>>>> I2C controllers may have child devices with GpioInt resources that
> >>>>>>> depend on GPIO controllers being fully initialized. If the I2C
> >>>>>>> controller probes and enumerates children before the referenced GPIO
> >>>>>>> controller has completed probe, GPIO interrupts may not be properly
> >>>>>>> configured, leading to device failures.
> >>>>>>>
> >>>>>>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> >>>>>>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> >>>>>>> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> >>>>>>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> >>>>>>> fail with lost arbitration errors:
> >>>>>>>
> >>>>>>>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >>>>>>>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >>>>>>>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >>>>>>>   2.348157  lost arbitration
> >>>>>>>
> >>>>>>> Add a dependency check that walks ACPI child devices and defers probe
> >>>>>>> until any referenced GPIO controller is bound.
> >>>
> >>> [...]
> >>>
> >>>>> #regzbot introduced: 0a4bb2abc3e56d
> >>>>> #regzbot title i2c: designware: ThinkPad touchpad broke
> >>>
> >>
> >
>
