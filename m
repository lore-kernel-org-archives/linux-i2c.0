Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CA38552C
	for <linux-i2c@vger.kernel.org>; Sat,  8 Aug 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208504; cv=pass; b=OMEIjx7G2KRw74f0371sUL61vU47BPaAyl+AVxdcwHkUCuAGUu10AyVoWfYMhLBmerP4wainNbFcs1ptVhQf191py4s3yTanKnD9enkRNFlLaUiJrKg33WE40XrInLhcZX37oCH88ZobRYYU0Ukd6c5Nazoc2y/jC6/8HP0LEKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208504; c=relaxed/simple;
	bh=BnMDSRNjNw20oAOI4gyQsj0DSZVWVcUWrdMCZjibsIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Le31Ki4BJEe0EmN12mLG62v6Ex8XI/v9u6ANfSDYJsyIZWiSW86dMRi4GJgTgvWkKLivJc82APOre0emoZzuPlhbH+CJM5ZvR4QQMz2LqGpVCwlW0VzIlW5hSB9VxBfZNFSa0LbjaVmW2uxqYLU1gqqLUuG/tFg0s3g8h6e6YLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6FP6hiy; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6FP6hiy"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6626b5ace23so4353342d50.0
        for <linux-i2c@vger.kernel.org>; Sat, 08 Aug 2026 10:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786208501; cv=none;
        d=google.com; s=arc-20260327;
        b=IKuoWhyvqayoOb4u72X56Xt49rMosEbLWTtnHmp0JVX/Hl5NIiLBsQmf1VhQrA+QfJ
         9yc3dZUymdSQ4AympVIGZfJ+5A3EtwuBH4xdts4ZsKQlryvNZt7yGieOo1Rd4POMB0Pl
         vcAh82M0iAn2L5IH7UDpWfRDvgANxkJIv1zwL50npr+LHvO5c4eLsdkQQkFSEAaB1O8x
         ZTZ5lJCMq5j6gZ0JUfvFz2vdLu9rgy1q1LlFShGcyct91jdOTQr3T8pbk/AD79IJEIrB
         lRLPa5ItcjEe0+4B816vZYymAQotr1CQygqdp8PwuWCQL98PQJc4/JC6RvB5naMhTeyJ
         POBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k5Kw6iWw8DKnsUx3b3rb1toOSaarB1+4MB2gi1oFZkI=;
        fh=COcTmKrebiTKFpAFw8wgBTh2qD8pB4lQdSKWngQYckw=;
        b=ke0dSvZH5LkNDdluN9QiIoFJTeJu+jElbkmluhWxPQ+5NGGk71ybQOIyU0RphYQWv8
         C7N51yQOyVrRAij8Z9xaNsp9y/IL72fZcEzMsT26e1uuYrYeCELUr48Vchynk7imLDwI
         lt4iI33esu9Bdxh7br196Rl4cCgotwC/XM8PTLZMqzvJKQNQ7TX/Iheuw8xx6k9UX+NV
         TK6JpisTxCx2D951srvm9IJ/ClZnTuqGTvSAli2YcHbAAWKOMkVpkEuKW8IE0XG9dlJR
         hdq6ChtDyqo1NMxwDXzve1rwkyFpBBQr0NIz76DLnxAdPBh4vhI7/Lwj7faN055Lnc9P
         akGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786208501; x=1786813301; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5Kw6iWw8DKnsUx3b3rb1toOSaarB1+4MB2gi1oFZkI=;
        b=c6FP6hiyS4WT7qICjwloNPpBoDBj2wzh3d2hQGieB/NV035i6QrtM+9x8GSxA1P7d0
         aP/zF1A3OEkaQJgW6F9HDfBNVS/CwgWoAZ/h353Au5l+HeE3UMDfL3smdMgAIrx6OiEf
         3q2Q0HUGwq3/8zEpWaW8CaF4Evqk2EHjIZvE0QVUTM+VZJpYcppOZta9TEqBrObyKd2M
         N23/7ZMBQ3I01aambgwXQZOo2s2ADtMuDvUiK56vLJGV91KGfeFIeiNXAf3kxPYL1Icp
         l/oXCTT6pKfdeiTu1gA+VGw2qt/LPiZM5uJI2ZFE34CUZ9DX4Z1aPSJbtyQXsE/z7jTy
         zGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786208501; x=1786813301;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k5Kw6iWw8DKnsUx3b3rb1toOSaarB1+4MB2gi1oFZkI=;
        b=KXTmXL98oHYZJQ5FHtYZixAI1lDIohQiEDe0C8tnTD5teRhdHceL6t/93yjZWJpt6D
         XIjqMhTnmgiTg1qoFAp8iLj2rR3l9Ss5n4oCHtOFor1ulgN7GrSPyaCC/0HSt3c6H2Q2
         drWP025uUZ363AnQxJ4hYoAQAbQMkRqQp1jTg6Y3UVND2lLpJVLHwKfIj3CXpZNo85/y
         Tw0B30cNl2BRLMXpI7bixbhTQbx7C6loRElbaeZ/bdbik3gUb3S+NqRr9z3yyob4enVh
         Uj2/BrL/77Y/8BxuVEE3zkq+7HZTf08mThv+FcDuf3zLMH2qEGHImJhEOQaOGDQ4r7Bl
         CCug==
X-Forwarded-Encrypted: i=1; AHgh+Rqcqwvo0oipFsvW9UMlfj76MeWfucYO5EOOPiLl4LnQl/EhhhbyaIyu0EIX+Sklw1325HTJ1xTkPt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpnphjwEknazGBrD5OadN9YJxLHxsg1qeWoaQFK0RHQTMSoI7
	gJ1UONBfpezFa+zozEULniri5dA4toUySSDFSWALvRhfVoNM/jC6rLXMBPlEhkMrEvuhxG/XIu9
	3nbe8mu7TjnGwRGzI6oUxb8d4oJz59ec=
X-Gm-Gg: AR+sD10ony5DykSg+16PZ/UiL7CJ7On9zEBDvmjQS9PKeh8m2GlUYillHC9ZL5h4BeY
	xQhY1TR14Trf8eKFneP3e++N947mq/Sk8RNbzeCz2V0h/Prm3dgTxf1E/knoPRB1Zco/6rgoMN3
	7MGq4qUTDc/xpOD4VOxIdNNjlfiav6YitWsGzaYsq2iX/DsjU1r9y2wU+tP/M0qZm/rkJkq4Y2U
	1blSXfAra1qdEwVo6hN0TtmO/4zsA43yHmkFAFf97RA0B/WTq0dwUiSABJn48F1vSFLoUXNyOJ4
	Ok1cM/RfMzVENVjaY3fvLf27OkU+fIqqDfmjUApOxqFzbFuxF6N4BpqkFAYoPjHkV9pp0vRV9Zc
	jUBJZUr7o9PuhKyT4JwrBhARL5vjjG4HBcfQ44kTNsyhunmxXBaZNmbGbhTwhYmLusYxy/N6qw3
	aoWmDuxHQDxJMPH7v9UQRR
X-Received: by 2002:a05:690e:440d:b0:668:43a3:de0c with SMTP id
 956f58d0204a3-66ada8b11b7mr2246918d50.15.1786208501149; Sat, 08 Aug 2026
 10:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu> <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
In-Reply-To: <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Sat, 8 Aug 2026 22:31:28 +0530
X-Gm-Features: AUfX_mzVDjIbW7plLibMpnBCE3SlFrPHY_Ps7vfYZh7gapEYkpLA_ZlcrT0jT5w
Message-ID: <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
Subject: Re: i2c designware change broke touchpad of a thinkpad (was: i2c:
 designware: defer probe if child GpioInt controllers are not bound)
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="00000000000034ea4606588c13bc"

--00000000000034ea4606588c13bc
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
> GpioInt controllers are not bound") and causes a regression for me: the
> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
> kernel log:
>
> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
> i2c_designware AMDI0010:01: controller timed out
> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
>
> Reverting this change in current mainline/master (f9a2394a23482) fixed
> things for me. Full dmesg of current master and master+revert can be
> found here:
>
> https://www.leemhuis.info/files/misc/dmesg-master
> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert

Thanks for the report and both dmesg dumps, that's very helpful. Comparing
the two: the working log shows SYNA8018:00 probing cleanly around 2.33s
with no GPIO-related activity, while the broken log hits lost arbitration
on AMDI0010:01 at almost the same timestamp. Neither log has dynamic debug
enabled for the relevant code paths, so I can't yet tell what my dependency
check actually decided for AMDI0010:01's children on your machine.

Two things that would help narrow this down, whenever you have a moment:

1. A DSDT dump, to see what GpioInt resource (if any) AMDI0010:01's
   children declare, and what it points to:

   sudo cat /sys/firmware/acpi/tables/DSDT > dsdt.dat
   iasl -d dsdt.dat

   The resulting dsdt.dsl, or just the section under AMDI0010:01, should
   help.

2. A dmesg with dynamic debug from a kernel built with the attached
   patch on top of current mainline/master (adds pr_info() tracing to
   the exact decision path, no functional changes):

   dmesg | grep i2c-dw-gpio-dbg

Both together should tell us whether the dependency check is finding a
GpioInt resource on your hardware and mishandling it, or whether
something else is going on. Appreciate you taking the time.

Thanks,
Hardik

On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> On 7/28/26 10:30, Andi Shyti wrote:
> > On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
> >> I2C controllers may have child devices with GpioInt resources that
> >> depend on GPIO controllers being fully initialized. If the I2C
> >> controller probes and enumerates children before the referenced GPIO
> >> controller has completed probe, GPIO interrupts may not be properly
> >> configured, leading to device failures.
> >>
> >> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> >> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> >> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> >> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> >> fail with lost arbitration errors:
> >>
> >>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >>   2.348157  lost arbitration
> >>
> >> Add a dependency check that walks ACPI child devices and defers probe
> >> until any referenced GPIO controller is bound.
> >>
> >> Fixes: 3812a9e84265 ("pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo Yoga 7 14AGP11")
> >> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > [...]
> > merged to i2c/i2c-fixes.
> >
> > Thanks,
> > Andi
>
> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
> GpioInt controllers are not bound") and causes a regression for me: the
> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
> kernel log:
>
> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
> i2c_designware AMDI0010:01: controller timed out
> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
>
> Reverting this change in current mainline/master (f9a2394a23482) fixed
> things for me. Full dmesg of current master and master+revert can be
> found here:
>
> https://www.leemhuis.info/files/misc/dmesg-master
> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>
> Ciao, Thorsten
>
> #regzbot introduced: 0a4bb2abc3e56d
> #regzbot title i2c: designware: ThinkPad touchpad broke
>
> >> ---
> >> v12 -> v13:
> >> - v12 was sent as an incomplete diff (generated against v11 rather than
> >>   against current master due to a git format-patch invocation mistake on
> >>   my end), not a real standalone patch (Andy Shevchenko)
> >> - Not carrying forward Bartosz Golaszewski's v12 Acked-by, per Andy's
> >>   request
> >> - Add blank line before guard(device)(gpio_dev) for readability (Andy
> >>   Shevchenko)
> >> - No other functional code changes since v12
> >>
> >> v11 -> v12:
> >> - Move gdev declaration to point of use with gpio_device_find_by_fwnode()
> >>   call (Andy Shevchenko)
> >> - Extract acpi_get_handle() return into acpi_status variable rather than
> >>   inline in ACPI_FAILURE() (Andy Shevchenko)
> >> - Use guard(device)(...) instead of scoped_guard(device, ...) {} for a
> >>   single following statement (Andy Shevchenko)
> >> - Use LIST_HEAD(res_list) instead of separate declaration + INIT_LIST_HEAD()
> >>   (Andy Shevchenko)
> >> - Check acpi_dev_get_resources() error before freeing the resource list,
> >>   restoring the check-then-free ordering that had regressed in v11
> >>   (Andy Shevchenko)
> >> - Split ACPI_COMPANION(dev) assignment onto its own line rather than at
> >>   declaration (Andy Shevchenko)
> >>
> >> v10 -> v11:
> >> - Replaced custom gpio_controller_ref list and dedup logic with
> >>   gpio_device_find_by_fwnode() (Suggested-by: Andy Shevchenko)
> >> - Moved resource-skip explanation from commit message into a code comment
> >> - Fixed device_is_bound() to check gpio_device_to_device(gdev)->parent
> >>   rather than the gpio_device's own internal class device, which is
> >>   registered on the synthetic "gpio" bus and never has a driver bound to it
> >>
> >> v9 -> v10:
> >> - Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
> >>   type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
> >> - Simplify string_source guard to a single string_length check, confirmed
> >>   sufficient via ACPICA parser in drivers/acpi/acpica/rsutils.c
> >>   (Andy Shevchenko)
> >> - acpi_dev_get_resources() on single line, free only on success path
> >>   (Andy Shevchenko)
> >> - Reversed xmas tree ordering for variable declarations (Andy Shevchenko)
> >> - Removed useless int ret = 0 assignment (Andy Shevchenko)
> >> - acpi_dev_for_each_child() on single line (Andy Shevchenko)
> >> - Use guard(device)(gpio_dev) pattern to avoid uninitialized variable
> >>   warning and deduplicate the !gpio_dev check (Andy Shevchenko)
> >>
> >> v8 -> v9:
> >> - Sent as a 2-patch series: revert of the broken v8 patch, plus a
> >>   corrected resubmission
> >> - Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
> >>   type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
> >> - Remove gpio_dep_ctx wrapper struct, pass list_head * directly (Andy Shevchenko)
> >> - Add const to gpio_controller_ref.path (Andy Shevchenko)
> >> - Add NULL check for resource_source.string_ptr to fix a crash on hardware
> >>   where GPIO resources have no named controller (Reported-by: Nathan
> >>   Chancellor, Reported-by: Chaitanya Kumar Borah)
> >> - Use acpi_dev_get_resources() return value properly (Andy Shevchenko)
> >> - Fix all error paths to call free_gpio_controller_list() (Andy Shevchenko)
> >> - Change guard to #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
> >> - Remove erroneous put_device() calls -- acpi_get_first_physical_node()
> >>   returns a borrowed pointer with no refcount increment
> >> - Use LIST_HEAD() macro, split adev declaration and assignment (Andy Shevchenko)
> >> - scoped_guard single statement without braces (Andy Shevchenko)
> >> - Remove misused Reported-by/Closes tags (Andy Shevchenko)
> >>
> >> v7 -> v8:
> >> - Add revert of the earlier pinctrl-amd DMI quirk (patch 1 of the original
> >>   v1-v7 series), confirmed unnecessary once probe ordering is fixed
> >>   (Mario Limonciello)
> >> - Collect Acked-by (Bartosz Golaszewski) and Reviewed-by (Mario Limonciello)
> >>
> >> v6 -> v7:
> >> - Fix unused 'ret' variable in check_child_gpioint() (kernel test robot)
> >> - Replace BugLink: with Link: (Bartosz Golaszewski)
> >> - Add Reported-by and Closes tags for kernel test robot warning
> >>
> >> v5 -> v6:
> >> - Replace DMI-specific deferral with a generic GpioInt dependency check
> >>   walking ACPI child devices (Suggested-by: Mario Limonciello)
> >>
> >> v4 -> v5:
> >> - Add blank line before #include <linux/acpi.h> (Bartosz Golaszewski)
> >> - Use scoped_guard(device, gpio_dev) (Bartosz Golaszewski)
> >>
> >> v3 -> v4:
> >> - Rebase onto Linus Walleij's tree (the original patch 1 already there)
> >> - Use --base so series is correctly 1/1 (Andy Shevchenko)
> >>
> >> v2 -> v3:
> >> - Fix variable declaration style (Andy Shevchenko)
> >> - Add BugLink tag (Andy Shevchenko)
> >> - CC AMD engineers (Andy Shevchenko)
> >>
> >> v1 -> v2:
> >> - Replace custom HID/UID lookup with acpi_dev_get_first_match_dev()
> >> - Use device_is_bound() under device_lock() with explanatory comments
> >> - Add Assisted-by tags per coding-assistants.rst
> >>
> >> Note: this patch was originally part of a 2-patch series (v1-v7) whose
> >> first patch was a DMI-specific pinctrl-amd IRQ quirk; that patch was
> >> merged separately into Linus Walleij's tree at v1 and later reverted at
> >> v8 once this patch made the manual IRQ restoration unnecessary.
> >>
> >>  drivers/i2c/busses/i2c-designware-platdrv.c | 80 +++++++++++++++++++++
> >>  1 file changed, 80 insertions(+)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> >> index 6d6e81242f74..c8a203fff4d1 100644
> >> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> >> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> >> @@ -8,12 +8,14 @@
> >>   * Copyright (C) 2007 MontaVista Software Inc.
> >>   * Copyright (C) 2009 Provigent Ltd.
> >>   */
> >> +#include <linux/acpi.h>
> >>  #include <linux/clk-provider.h>
> >>  #include <linux/clk.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/dmi.h>
> >>  #include <linux/err.h>
> >>  #include <linux/errno.h>
> >> +#include <linux/gpio/driver.h>
> >>  #include <linux/i2c.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/io.h>
> >> @@ -130,6 +132,80 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
> >>      return 0;
> >>  }
> >>
> >> +#if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
> >> +/*
> >> + * Check whether an ACPI GpioInt resource's referenced GPIO controller
> >> + * has finished probing. Resources with no named controller (resource
> >> + * source string) are skipped, since they can't be resolved to a
> >> + * struct device.
> >> + */
> >> +static int check_gpioint_resource(struct acpi_resource *ares, void *data)
> >> +{
> >> +    struct acpi_resource_gpio *agpio;
> >> +    struct acpi_device *gpio_adev;
> >> +    struct device *gpio_dev;
> >> +    acpi_handle handle;
> >> +    acpi_status status;
> >> +
> >> +    if (!acpi_gpio_get_irq_resource(ares, &agpio))
> >> +            return 1; /* not a GpioInt resource, skip */
> >> +
> >> +    if (!agpio->resource_source.string_length)
> >> +            return 1; /* no named controller, skip */
> >> +
> >> +    status = acpi_get_handle(NULL, agpio->resource_source.string_ptr, &handle);
> >> +    if (ACPI_FAILURE(status))
> >> +            return 1;
> >> +
> >> +    gpio_adev = acpi_fetch_acpi_dev(handle);
> >> +    if (!gpio_adev)
> >> +            return 1;
> >> +
> >> +    struct gpio_device *gdev __free(gpio_device_put) =
> >> +            gpio_device_find_by_fwnode(acpi_fwnode_handle(gpio_adev));
> >> +    if (!gdev)
> >> +            return -EPROBE_DEFER; /* controller not registered yet: abort walk */
> >> +
> >> +    gpio_dev = gpio_device_to_device(gdev)->parent;
> >> +
> >> +    guard(device)(gpio_dev);
> >> +    if (!device_is_bound(gpio_dev))
> >> +            return -EPROBE_DEFER; /* controller not bound yet: abort walk */
> >> +
> >> +    return 1; /* bound, skip adding to resource list, continue walk */
> >> +}
> >> +
> >> +static int check_child_gpioint(struct acpi_device *adev, void *data)
> >> +{
> >> +    LIST_HEAD(res_list);
> >> +    int ret;
> >> +
> >> +    ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, NULL);
> >> +    if (ret < 0)
> >> +            return ret;
> >> +
> >> +    acpi_dev_free_resource_list(&res_list);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> >> +{
> >> +    struct acpi_device *adev;
> >> +
> >> +    adev = ACPI_COMPANION(dev);
> >> +    if (!adev)
> >> +            return 0;
> >> +
> >> +    return acpi_dev_for_each_child(adev, check_child_gpioint, NULL);
> >> +}
> >> +#else
> >> +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> >> +{
> >> +    return 0;
> >> +}
> >> +#endif /* CONFIG_ACPI && CONFIG_GPIOLIB */
> >> +
> >>  static int dw_i2c_plat_probe(struct platform_device *pdev)
> >>  {
> >>      u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
> >> @@ -138,6 +214,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
> >>      struct dw_i2c_dev *dev;
> >>      int irq, ret;
> >>
> >> +    ret = i2c_dw_check_gpio_dependencies(device);
> >> +    if (ret)
> >> +            return ret;
> >> +
> >>      irq = platform_get_irq_optional(pdev, 0);
> >>      if (irq == -ENXIO)
> >>              flags |= ACCESS_POLLING;
> >>
> >> base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
> >> --
> >> 2.54.0
> >>
> >

--00000000000034ea4606588c13bc
Content-Type: text/x-patch; charset="US-ASCII"; name="i2c-designware-gpio-debug.patch"
Content-Disposition: attachment; filename="i2c-designware-gpio-debug.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mskmd1060>
X-Attachment-Id: f_mskmd1060

U3ViamVjdDogW0RFQlVHIE9OTFldIGkyYzogZGVzaWdud2FyZTogdHJhY2UgR3Bpb0ludCBkZXBl
bmRlbmN5IGNoZWNrIGRlY2lzaW9ucwoKVGVtcG9yYXJ5IGRlYnVnIGluc3RydW1lbnRhdGlvbiBm
b3IgZGlhZ25vc2luZyB0aGUgcmVncmVzc2lvbiByZXBvcnRlZApieSBUaG9yc3RlbiBMZWVtaHVp
cyBvbiBUaGlua1BhZCBUMTRzIEdlbiA0IChBTUQpLCB3aGVyZSBBTURJMDAxMDowMQpoaXRzICJs
b3N0IGFyYml0cmF0aW9uIiB3aXRoIDBhNGJiMmFiYzNlNTZkIGFwcGxpZWQuCgpBZGRzIHByX2lu
Zm8oKSB0cmFjaW5nIHRvIGV2ZXJ5IGJyYW5jaCBvZiB0aGUgZGVwZW5kZW5jeSBjaGVjayBzbyB3
ZQpjYW4gc2VlIGV4YWN0bHkgd2hhdCBpdCBkZWNpZGVzIGZvciBlYWNoIEFDUEkgY2hpbGQgZGV2
aWNlIGFuZApHcGlvSW50IHJlc291cmNlIG9uIGFmZmVjdGVkIGhhcmR3YXJlLiBObyBmdW5jdGlv
bmFsIGNoYW5nZXMuCkNvbXBpbGUtdmVyaWZpZWQgYWdhaW5zdCBjdXJyZW50IG1haW5saW5lIChh
N2M3MDc0YjU4ZDIpLgoKTm90IGZvciBzdWJtaXNzaW9uIC0tIGRpYWdub3N0aWMgb25seS4gQXBw
bHkgd2l0aDoKICBnaXQgYXBwbHkgdGhpcy5wYXRjaApvcgogIHBhdGNoIC1wMSA8IHRoaXMucGF0
Y2gKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWRlc2lnbndhcmUtcGxhdGRy
di5jIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1kZXNpZ253YXJlLXBsYXRkcnYuYwppbmRleCBj
OGEyMDNmZmY0ZDEuLmI3ZDMyM2IzYzY4OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pMmMvYnVzc2Vz
L2kyYy1kZXNpZ253YXJlLXBsYXRkcnYuYworKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWRl
c2lnbndhcmUtcGxhdGRydi5jCkBAIC0xNTAsMjcgKzE1MCw0NiBAQCBzdGF0aWMgaW50IGNoZWNr
X2dwaW9pbnRfcmVzb3VyY2Uoc3RydWN0IGFjcGlfcmVzb3VyY2UgKmFyZXMsIHZvaWQgKmRhdGEp
CiAJaWYgKCFhY3BpX2dwaW9fZ2V0X2lycV9yZXNvdXJjZShhcmVzLCAmYWdwaW8pKQogCQlyZXR1
cm4gMTsgLyogbm90IGEgR3Bpb0ludCByZXNvdXJjZSwgc2tpcCAqLwogCisJcHJfaW5mbygiaTJj
LWR3LWdwaW8tZGJnOiBHcGlvSW50IHJlc291cmNlX3NvdXJjZT0lLipzIChsZW49JXUpXG4iLAor
CQkoaW50KWFncGlvLT5yZXNvdXJjZV9zb3VyY2Uuc3RyaW5nX2xlbmd0aCwKKwkJYWdwaW8tPnJl
c291cmNlX3NvdXJjZS5zdHJpbmdfcHRyID8gYWdwaW8tPnJlc291cmNlX3NvdXJjZS5zdHJpbmdf
cHRyIDogIjxOVUxMPiIsCisJCWFncGlvLT5yZXNvdXJjZV9zb3VyY2Uuc3RyaW5nX2xlbmd0aCk7
CisKIAlpZiAoIWFncGlvLT5yZXNvdXJjZV9zb3VyY2Uuc3RyaW5nX2xlbmd0aCkKIAkJcmV0dXJu
IDE7IC8qIG5vIG5hbWVkIGNvbnRyb2xsZXIsIHNraXAgKi8KIAogCXN0YXR1cyA9IGFjcGlfZ2V0
X2hhbmRsZShOVUxMLCBhZ3Bpby0+cmVzb3VyY2Vfc291cmNlLnN0cmluZ19wdHIsICZoYW5kbGUp
OwotCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkKKwlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykp
IHsKKwkJcHJfaW5mbygiaTJjLWR3LWdwaW8tZGJnOiBhY3BpX2dldF9oYW5kbGUoKSBmYWlsZWQg
Zm9yICUuKnNcbiIsCisJCQkoaW50KWFncGlvLT5yZXNvdXJjZV9zb3VyY2Uuc3RyaW5nX2xlbmd0
aCwKKwkJCWFncGlvLT5yZXNvdXJjZV9zb3VyY2Uuc3RyaW5nX3B0ciA/IGFncGlvLT5yZXNvdXJj
ZV9zb3VyY2Uuc3RyaW5nX3B0ciA6ICI8TlVMTD4iKTsKIAkJcmV0dXJuIDE7CisJfQogCiAJZ3Bp
b19hZGV2ID0gYWNwaV9mZXRjaF9hY3BpX2RldihoYW5kbGUpOwotCWlmICghZ3Bpb19hZGV2KQor
CWlmICghZ3Bpb19hZGV2KSB7CisJCXByX2luZm8oImkyYy1kdy1ncGlvLWRiZzogYWNwaV9mZXRj
aF9hY3BpX2RldigpIHJldHVybmVkIE5VTExcbiIpOwogCQlyZXR1cm4gMTsKKwl9CisJcHJfaW5m
bygiaTJjLWR3LWdwaW8tZGJnOiBhY3BpX2ZldGNoX2FjcGlfZGV2KCkgc3VjY2VlZGVkLCBkZXZp
Y2U9JXNcbiIsIGRldl9uYW1lKCZncGlvX2FkZXYtPmRldikpOwogCiAJc3RydWN0IGdwaW9fZGV2
aWNlICpnZGV2IF9fZnJlZShncGlvX2RldmljZV9wdXQpID0KIAkJZ3Bpb19kZXZpY2VfZmluZF9i
eV9md25vZGUoYWNwaV9md25vZGVfaGFuZGxlKGdwaW9fYWRldikpOwotCWlmICghZ2RldikKKwlp
ZiAoIWdkZXYpIHsKKwkJcHJfaW5mbygiaTJjLWR3LWdwaW8tZGJnOiBncGlvX2RldmljZV9maW5k
X2J5X2Z3bm9kZSgpIHJldHVybmVkIE5VTEwsIGRlZmVycmluZ1xuIik7CiAJCXJldHVybiAtRVBS
T0JFX0RFRkVSOyAvKiBjb250cm9sbGVyIG5vdCByZWdpc3RlcmVkIHlldDogYWJvcnQgd2FsayAq
LworCX0KKwlwcl9pbmZvKCJpMmMtZHctZ3Bpby1kYmc6IGdwaW9fZGV2aWNlX2ZpbmRfYnlfZndu
b2RlKCkgc3VjY2VlZGVkXG4iKTsKIAogCWdwaW9fZGV2ID0gZ3Bpb19kZXZpY2VfdG9fZGV2aWNl
KGdkZXYpLT5wYXJlbnQ7CiAKIAlndWFyZChkZXZpY2UpKGdwaW9fZGV2KTsKLQlpZiAoIWRldmlj
ZV9pc19ib3VuZChncGlvX2RldikpCisJaWYgKCFkZXZpY2VfaXNfYm91bmQoZ3Bpb19kZXYpKSB7
CisJCXByX2luZm8oImkyYy1kdy1ncGlvLWRiZzogZGV2aWNlX2lzX2JvdW5kKCk9ZmFsc2UgZm9y
ICVzLCBkZWZlcnJpbmdcbiIsCisJCQlkZXZfbmFtZShncGlvX2RldikpOwogCQlyZXR1cm4gLUVQ
Uk9CRV9ERUZFUjsgLyogY29udHJvbGxlciBub3QgYm91bmQgeWV0OiBhYm9ydCB3YWxrICovCisJ
fQorCXByX2luZm8oImkyYy1kdy1ncGlvLWRiZzogZGV2aWNlX2lzX2JvdW5kKCk9dHJ1ZSBmb3Ig
JXNcbiIsIGRldl9uYW1lKGdwaW9fZGV2KSk7CiAKIAlyZXR1cm4gMTsgLyogYm91bmQsIHNraXAg
YWRkaW5nIHRvIHJlc291cmNlIGxpc3QsIGNvbnRpbnVlIHdhbGsgKi8KIH0KQEAgLTE4MCw5ICsx
OTksMTMgQEAgc3RhdGljIGludCBjaGVja19jaGlsZF9ncGlvaW50KHN0cnVjdCBhY3BpX2Rldmlj
ZSAqYWRldiwgdm9pZCAqZGF0YSkKIAlMSVNUX0hFQUQocmVzX2xpc3QpOwogCWludCByZXQ7CiAK
Kwlwcl9pbmZvKCJpMmMtZHctZ3Bpby1kYmc6IGNoZWNrX2NoaWxkX2dwaW9pbnQoYWRldj0lcylc
biIsIGRldl9uYW1lKCZhZGV2LT5kZXYpKTsKKwogCXJldCA9IGFjcGlfZGV2X2dldF9yZXNvdXJj
ZXMoYWRldiwgJnJlc19saXN0LCBjaGVja19ncGlvaW50X3Jlc291cmNlLCBOVUxMKTsKLQlpZiAo
cmV0IDwgMCkKKwlpZiAocmV0IDwgMCkgeworCQlwcl9pbmZvKCJpMmMtZHctZ3Bpby1kYmc6IGNo
ZWNrX2NoaWxkX2dwaW9pbnQgcmV0PSVkIChkZWZlcilcbiIsIHJldCk7CiAJCXJldHVybiByZXQ7
CisJfQogCiAJYWNwaV9kZXZfZnJlZV9yZXNvdXJjZV9saXN0KCZyZXNfbGlzdCk7CiAKQEAgLTE5
NCw5ICsyMTcsMTMgQEAgc3RhdGljIGludCBpMmNfZHdfY2hlY2tfZ3Bpb19kZXBlbmRlbmNpZXMo
c3RydWN0IGRldmljZSAqZGV2KQogCXN0cnVjdCBhY3BpX2RldmljZSAqYWRldjsKIAogCWFkZXYg
PSBBQ1BJX0NPTVBBTklPTihkZXYpOwotCWlmICghYWRldikKKwlpZiAoIWFkZXYpIHsKKwkJcHJf
aW5mbygiaTJjLWR3LWdwaW8tZGJnOiBpMmNfZHdfY2hlY2tfZ3Bpb19kZXBlbmRlbmNpZXMoJXMp
IEFDUElfQ09NUEFOSU9OPU5VTExcbiIsCisJCQlkZXZfbmFtZShkZXYpKTsKIAkJcmV0dXJuIDA7
CisJfQogCisJcHJfaW5mbygiaTJjLWR3LWdwaW8tZGJnOiBpMmNfZHdfY2hlY2tfZ3Bpb19kZXBl
bmRlbmNpZXMoJXMpXG4iLCBkZXZfbmFtZShkZXYpKTsKIAlyZXR1cm4gYWNwaV9kZXZfZm9yX2Vh
Y2hfY2hpbGQoYWRldiwgY2hlY2tfY2hpbGRfZ3Bpb2ludCwgTlVMTCk7CiB9CiAjZWxzZQo=
--00000000000034ea4606588c13bc--
