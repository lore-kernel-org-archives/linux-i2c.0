Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258C404BFD
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006098; cv=pass; b=j92eYFpBwbVDdcy7o8CDYBt+EhGUQ57UZliLhDXrR9N+rarkvr/b29CoB3YhmOiP0RVP8sd0sbVe86zf2m2dV/QWl0xawTuBQle6jp4YtK7KRyhpFSwEpAjRHCoo6TVc/AieTay17HGpyge2+jgQhc42PmW79zF/UuYFOknHpDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006098; c=relaxed/simple;
	bh=/8BY25L6laIZ5eAQmofWM5er4R77uuo2qY2VW0xgUmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0tnYMRXuLA+x/j3n215FwZXLMjt8G59DCrwUflKwlpLpOPqluYpk4YPwiBDSDHCNJMBx5MhfjiMyW+xNDSd47MQggF1D3fNMRTpaMLrH+DCgRLJVFr2hWKukVirFvPucUYg9G+OrkMvHXQ7gHGb7r5eeh/SfW7aqYMNtg7hjqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS+lSTPA; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS+lSTPA"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e87602f26aso60354587b3.1
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 04:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781006093; cv=none;
        d=google.com; s=arc-20240605;
        b=UrU+afOnp6J+VEuoJYpXL5PIeD0M46oTE1AVqNRa4BQJrObjIo7e0hJUjWAng/ffKt
         JAWlrsXEHS8Nu4wSq1HoRzey3UG0ayV1F/es6Q48eRzDvl+4lPmr9AnzsrAJ5IkU9nCT
         mtZY7kLY9oW+iZ7lbibddpb3p2KYPCgPbOgGWnDQnfa1JW1w6Jabn1LZwHcWyWaiWlWx
         0Phlqxmg67/r3kkSfK1dKg2JzkX/AeB44E55hc5HzZPfdFzs1KPx36akP8vcIg0ST0hL
         6vi9ZHxcyMbacJKm2lgekLSLfuI9+qfaKgiorvnvDxG/UmHzvbD9FzFJyMdfjGQqLqq5
         gTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XeQ+p77/d+Z7ZWKhcUmSiOA/AtiBMuey+b5sMyZaY/Q=;
        fh=RvkK+omLin2PWPlsyNIDx5JlCzHvWgmMeP40kcZLiXk=;
        b=cee+/lVKWHWI+DA3yQXhoLABvEXhQ9z+GBFERTJaC1CfKyR5UeJpRAJzfRpJtCr3pA
         ksgvTS0qMv4PAijygTRuWMdBHKYhG2l9kLWS1xLbftwcx1JKU+hZccWI9F+dBoEZj33b
         WsjKB2L+UsTGG0zKsWAaBWEYH6Fci6hscCg/uFucnRzMtQ+a9X0rzuWU3URULRTm/Rgm
         mgOFMxpFgPOF3kbTbMXpXpe/CdqVhizZXtXq9POT6V2CHgGDLdOea1a6qgrbieNFhtqw
         LrOksyKasunt/RXiPXQPINd7eZnquazVlNc8OVHL1akEECQKl0wduFpogZXlqttCchGw
         IxLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781006093; x=1781610893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XeQ+p77/d+Z7ZWKhcUmSiOA/AtiBMuey+b5sMyZaY/Q=;
        b=NS+lSTPAzUcrh+eVMOswdp9pHGCHaXR7HASZMoh+rroS1Dc9kU/J17lXL+ZpLzarRj
         QrD3Lgb3FMUovb/mQyPhFOvXAUi6yHGSUp51q5uhjXx57IIhbz1PP7LnV623N8IPfjl/
         iUQ7HWiSX0KWA5tfx05aqHDxpAcTgMSFztzGaRJwbHopIcmiVEFZyXuY8G71q1MIl+sW
         Y/KuGQqk9W3cMnSv1TCyftosO/EL1SuiLkKSqozmtgHzItyajc2QxpGQ87iNlnfdwFAc
         KdIPmYoH79MLUviFfxcZwAPEAUrBhYZMuROyEPS+0irEe7qJQ08n0o0YHkMAv9nCDl9r
         Mqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006093; x=1781610893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeQ+p77/d+Z7ZWKhcUmSiOA/AtiBMuey+b5sMyZaY/Q=;
        b=TXQovupX+2MsWn22ajkrj/QUCY15jyt00Che26jRdYapENeKjWEHytwRCCwTaU7aEH
         FCN0J8OfPAfITj9z56jdzdTv0um4qd1Q8YO8TKtYiSqXjf4mrqkFAhVZm3lhRzEwVbMV
         tpq57SIkQDbTVFKVUjcmtOXhp9gYX6cPIoUYtzofOCDLdyo3AhybfClmzRGfiZfj8xYS
         WTbgWvj+/51VYfuNj93Vd5hRcfg0NEjwb+VdtI8D6GzBWqySCa6rPzTAB1cWUmx8YqiK
         YZs9Kqu4Z4VG7EjrzbigO/iWx4ivOPjwWbHtMMIQ4RsmWRdr+8H/sy8q7b2rOove8i6m
         Ol4Q==
X-Gm-Message-State: AOJu0YyxnCSzl+KB6jD3fB+p3dfA/CRRzRyS93HM74Tdrz7l2PHBWqI5
	cQq1XIYF/H3hTvLkoHlVM/cXB1z8BoYHAsPdJyeJr1V7/2L/u4w8L7KBQSu2rjbaXokhIXT/U/s
	uuCVx81PSkj+9ESAoOBCvx8UY2u15vfU=
X-Gm-Gg: Acq92OHhR4eZo+kAtGIuVNawni3Io2+XGgBMKOdHfm4bC1tOPkszJTBqTTUSewLrugF
	kmjn/jpcJY4I5SRiPVR+/PVSpUdEt1QYq1GM8kDYlkj5xoy6uXPhDGccV9G+k9qG4a/OQFi4Y8A
	ceKGV1HxO/AY1Mct6R3veq7GIOk9/2oqF0dbdhEtegcIDi1zWvMQ8/t70LKlBYlGyG2ITFQTuJ0
	QbBIJqkuIvrpY6fpjONQIBEjzpPCg6Jh9juG7TkJ+PIHC9QpuvjzUHvsee7bsnoXqcSRFOUH4nC
	XZUdvj+rkz8PufDJLLT1ll9r/S34F7Q4aPGd939xv02nIe/PKIK5S1FyHv4yZDsOTgwfhajKPYa
	vQJADMcve+yn9ChDlwF7Jk85sZnBw3jFgIqc=
X-Received: by 2002:a05:690c:c641:b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-7ef9fd9ec08mr68513147b3.12.1781006092646; Tue, 09 Jun 2026
 04:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com> <90656be5-eca0-4a09-9b19-0c6e85f1d455@intel.com>
In-Reply-To: <90656be5-eca0-4a09-9b19-0c6e85f1d455@intel.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Tue, 9 Jun 2026 17:24:40 +0530
X-Gm-Features: AVVi8CdfZUz24SRju8INwnmTSUkgRXl7HmToTY6fmuk1j_i-qHGGLW828h7ZG9M
Message-ID: <CANTFpSV7N=5U9yuXcU-D=PDpwj=kD__JU89UGL1HQOYiaL77qg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, kernel test robot <lkp@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, ravitejax.veesam@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 08, 2026 at 16:18, Borah, Chaitanya Kumar wrote:
> This patch seems to cause a regression in our CI. Few of the machines
> are unable to boot to ssh console and therefore hindering our test
> execution. Bisect points to this patch and reverting this patch seems
> to fix the issue.

Thank you for the report and the log. The putty log shows the kernel
panic: "Timeout: Not all CPUs entered broadcast exception handler"
after what appears to be a probe deferral loop causing CPU starvation.

Andy Shevchenko already identified code issues with this patch on June
3rd and requested Linus Walleij drop it from his tree. The patch has
not been fixed yet -- it needs a proper rewrite addressing NULL pointer
dereferences and error path issues before it is safe to apply.

Linus, could you please drop commit ef76a3a28c79 from your fixes tree?
The regression affects multiple machines including Intel CI and Nathan
Chancellor's test systems.

I will send a corrected version once the rewrite is complete.

Sorry for the disruption.

Thanks,
Hardik

On Tue, 9 Jun 2026 at 16:18, Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
> Hello Hardik,
>
> On 5/29/2026 3:38 PM, Hardik Prakash wrote:
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
> >    i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost arbitration
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
> >    0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >    0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >    0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >    2.348157  lost arbitration
> >
>
> This patch seems to cause a regression in our CI [1]. Few of the machine
> are unable to boot to ssh console and therefore hindering our test exection.
>
> The issue first appeared with next-20260601 [2].
>
> Bisect points to this patch and reverting this patch seems to fix the issue.
>
> Putty logs are attached.
>
> Could you please check why the patch causes this regression and provide
> a fix if necessary?
>
> ==
> Chaitanya
>
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20260601
>
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > Assisted-by: GPT-Codex:gpt-5.2-codex
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202605240959.Kcf1lIg4-lkp@intel.com/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=221494
> > ---
> >   drivers/i2c/busses/i2c-designware-platdrv.c | 156 ++++++++++++++++++++
> >   1 file changed, 156 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index 3351c4a9ef11..1c01b0460385 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -8,6 +8,8 @@
> >    * Copyright (C) 2007 MontaVista Software Inc.
> >    * Copyright (C) 2009 Provigent Ltd.
> >    */
> > +
> > +#include <linux/acpi.h>
> >   #include <linux/clk-provider.h>
> >   #include <linux/clk.h>
> >   #include <linux/delay.h>
> > @@ -130,6 +132,152 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
> >       return 0;
> >   }
> >
> > +#ifdef CONFIG_ACPI
> > +struct gpio_dep_ctx {
> > +     struct list_head gpio_controllers;
> > +     int ret;
> > +};
> > +
> > +struct gpio_controller_ref {
> > +     struct list_head node;
> > +     char *path;
> > +};
> > +
> > +static int check_gpioint_resource(struct acpi_resource *ares, void *data)
> > +{
> > +     struct gpio_dep_ctx *ctx = data;
> > +     struct acpi_resource_gpio *agpio;
> > +     struct gpio_controller_ref *ref, *tmp;
> > +     bool found = false;
> > +
> > +     if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
> > +             return 1;
> > +
> > +     agpio = &ares->data.gpio;
> > +     if (agpio->connection_type != ACPI_RESOURCE_GPIO_TYPE_INT)
> > +             return 1;
> > +
> > +     /* Check if we've already tracked this GPIO controller */
> > +     list_for_each_entry(tmp, &ctx->gpio_controllers, node) {
> > +             if (!strcmp(tmp->path, agpio->resource_source.string_ptr)) {
> > +                     found = true;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!found) {
> > +             ref = kzalloc(sizeof(*ref), GFP_KERNEL);
> > +             if (!ref) {
> > +                     ctx->ret = -ENOMEM;
> > +                     return 0;
> > +             }
> > +
> > +             ref->path = kstrdup(agpio->resource_source.string_ptr, GFP_KERNEL);
> > +             if (!ref->path) {
> > +                     kfree(ref);
> > +                     ctx->ret = -ENOMEM;
> > +                     return 0;
> > +             }
> > +
> > +             list_add_tail(&ref->node, &ctx->gpio_controllers);
> > +     }
> > +
> > +     return 1;
> > +}
> > +
> > +static int check_child_gpioint(struct acpi_device *adev, void *data)
> > +{
> > +     struct gpio_dep_ctx *ctx = data;
> > +     struct list_head res_list;
> > +
> > +     INIT_LIST_HEAD(&res_list);
> > +
> > +     acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, ctx);
> > +     acpi_dev_free_resource_list(&res_list);
> > +
> > +     if (ctx->ret < 0)
> > +             return ctx->ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> > +{
> > +     struct acpi_device *adev = ACPI_COMPANION(dev);
> > +     struct gpio_dep_ctx ctx = { .ret = 0 };
> > +     struct gpio_controller_ref *ref, *tmp;
> > +     int ret = 0;
> > +
> > +     if (!adev)
> > +             return 0;
> > +
> > +     INIT_LIST_HEAD(&ctx.gpio_controllers);
> > +
> > +     /* Walk all child devices and collect GpioInt controller references */
> > +     ret = acpi_dev_for_each_child(adev, check_child_gpioint, &ctx);
> > +     if (ret < 0 || ctx.ret < 0) {
> > +             ret = ctx.ret ?: ret;
> > +             goto cleanup;
> > +     }
> > +
> > +     /* For each GPIO controller, check if its parent device is bound */
> > +     list_for_each_entry(ref, &ctx.gpio_controllers, node) {
> > +             acpi_handle handle;
> > +             acpi_status status;
> > +             struct acpi_device *gpio_adev;
> > +             struct device *gpio_dev;
> > +             bool bound;
> > +
> > +             status = acpi_get_handle(NULL, ref->path, &handle);
> > +             if (ACPI_FAILURE(status))
> > +                     continue;
> > +
> > +             gpio_adev = acpi_fetch_acpi_dev(handle);
> > +             if (!gpio_adev)
> > +                     continue;
> > +
> > +             gpio_dev = acpi_get_first_physical_node(gpio_adev);
> > +             acpi_dev_put(gpio_adev);
> > +
> > +             if (!gpio_dev) {
> > +                     ret = -EPROBE_DEFER;
> > +                     goto cleanup;
> > +             }
> > +
> > +             /*
> > +              * Check if the GPIO controller's device is bound. If not,
> > +              * defer probe to ensure GPIO initialization (including IRQ
> > +              * setup and quirks) is complete before we enumerate I2C
> > +              * child devices.
> > +              */
> > +             scoped_guard(device, gpio_dev) {
> > +                     bound = device_is_bound(gpio_dev);
> > +             }
> > +             if (!bound) {
> > +                     put_device(gpio_dev);
> > +                     ret = -EPROBE_DEFER;
> > +                     goto cleanup;
> > +             }
> > +
> > +             put_device(gpio_dev);
> > +     }
> > +
> > +cleanup:
> > +     list_for_each_entry_safe(ref, tmp, &ctx.gpio_controllers, node) {
> > +             list_del(&ref->node);
> > +             kfree(ref->path);
> > +             kfree(ref);
> > +     }
> > +
> > +     return ret;
> > +}
> > +#else
> > +static int i2c_dw_check_gpio_dependencies(struct device *dev)
> > +{
> > +     return 0;
> > +}
> > +#endif /* CONFIG_ACPI */
> > +
> >   static int dw_i2c_plat_probe(struct platform_device *pdev)
> >   {
> >       u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
> > @@ -138,6 +286,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
> >       struct dw_i2c_dev *dev;
> >       int irq, ret;
> >
> > +     /*
> > +      * Check if any child devices have GpioInt resources, and if so,
> > +      * defer probe until those GPIO controllers are fully bound.
> > +      */
> > +     ret = i2c_dw_check_gpio_dependencies(device);
> > +     if (ret)
> > +             return ret;
> > +
> >       irq = platform_get_irq_optional(pdev, 0);
> >       if (irq == -ENXIO)
> >               flags |= ACCESS_POLLING;
