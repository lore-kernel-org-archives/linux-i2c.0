Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3D3264FA
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101676; cv=none; b=IqW4wgGdEOcG6yCaPrUfTlCk1jIBdgk369+lN/TVcQH/AY7D2A9+ksxA6/6vWEXy8u1zcN5yH//i/HXvvNcloA8VVn7TGuRsJO0dS4s58RPKtOQacRXf6Z/8aKW/QmTnBlgqjZeCSw+w5LvrP0CNIYWLRFA9H90Ew3T/hWIzMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101676; c=relaxed/simple;
	bh=Q8LrmUclmwWiK0NYnu+pIWzuuuv3Ss27M2IBPzIuAOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5OoQg8RY7h5VdMmH65bZaHsTCl9C2OWW7r8SpAMwJDY99SGbQf8rXZI3aQSKPe/wxch1FTBR3NxsSuSaPP9W2ciM4JbcLs5FXB2xuM3OBUaIb6KuDwW9swYMg3tGGZbBt3FHxTLmy/x1B2E5Oo2bvVtN0ouumNSwQKMjThrccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9QZwoIT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9QZwoIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A10C2BCB7
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779101676;
	bh=Q8LrmUclmwWiK0NYnu+pIWzuuuv3Ss27M2IBPzIuAOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l9QZwoITt5hxVQ6NR+fU4AGntK2HZS5pmzxq9WY/VtnD6PcZWGl7qKWFVNojD0pFD
	 y191roGalj10jDaFRc6kPInAqM2imReao3pQZ72nbYiGandHjXoAysQuQ69MAFaDmY
	 sa/3AV7Neg+CwxJDfCZsk3PCq7r0Q7+ARDxqjwzM3piZ4kSK8afZGiVLipvhe0Y1Eu
	 a3y1Z5DsGvgIvWg/WdDuUsvLyPdtalehII9GfX/228Km2Tnj+/6MEDUu07FiU9qq1Y
	 yFyEj9aokYBtaqItPZoGF5ds8NwyVPZsaRrtEhi9WRc7nAqYKl0OhnQW7x0pE93jox
	 PbZ2gE1lrwX5Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso2739050e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 03:54:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx2w/hzs/DqZ4aqwZmoiXDzngIH7kM+34YKpMWKeOJdMnIZ4R16
	tG1azfWX/wo07Xf00ozC1py37AU5RUmWfChHNJBcprL9azHVTUAxnMVN6PcbyCassEVmiWmCQgr
	Z1NOyFVG+fsN02aVk4yIadIP+WjTtFymkG8tYuUP53Q==
X-Received: by 2002:a05:6512:33d2:b0:5a8:afc8:c37 with SMTP id
 2adb3069b0e04-5aa0e60128emr4147185e87.4.1779101674772; Mon, 18 May 2026
 03:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518071816.26629-1-hardikprakash.official@gmail.com> <20260518071816.26629-2-hardikprakash.official@gmail.com>
In-Reply-To: <20260518071816.26629-2-hardikprakash.official@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 18 May 2026 12:54:21 +0200
X-Gmail-Original-Message-ID: <CAMRc=Me8ieVzXojZ=eNhBPvjjmT5gc6hJXnpC8Bc6WofDbXP4A@mail.gmail.com>
X-Gm-Features: AVHnY4KenI_ZMg_L6AupGxRtux76NG-iMnv9PJwA8-64qEH2Kfpx85-qn1tZU2Q
Message-ID: <CAMRc=Me8ieVzXojZ=eNhBPvjjmT5gc6hJXnpC8Bc6WofDbXP4A@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:19=E2=80=AFAM Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> On Lenovo Yoga 7 14AGP11 (83TD), the WACF2200 touchscreen fails with
> lost arbitration errors on AMDI0010:02 at boot. The root cause is a
> probe ordering issue: i2c_designware probes AMDI0010:02 before
> pinctrl-amd has finished initialising, so the GPIO 157 interrupt
> needed by the touchscreen is not yet enabled.
>
> Add a DMI-matched deferral in dw_i2c_plat_probe() that uses
> device_is_bound() under device_lock() to correctly wait until
> pinctrl-amd's probe has fully completed. Use acpi_dev_get_first_match_dev=
()
> for robust HID/UID-based GPIO controller lookup instead of string
> name matching.
>
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> Assisted-by: Claude:claude-sonnet-4-6
> Assisted-by: GPT-Codex:gpt-5.2-codex
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D221494
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 77 +++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 3351c4a9ef118..3ffc3d757fbd1 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2007 MontaVista Software Inc.
>   * Copyright (C) 2009 Provigent Ltd.
>   */

Maybe add a newline here if you're at it.

> +#include <linux/acpi.h>
>  #include <linux/clk-provider.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> @@ -86,6 +87,78 @@ static const struct dmi_system_id dw_i2c_hwmon_class_d=
mi[] =3D {
>         { } /* terminate list */
>  };
>
> +static const struct dmi_system_id dw_i2c_amd_gpio_defer_dmi[] =3D {
> +       {
> +               .ident =3D "Lenovo Yoga 7 14AGP11",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83TD"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
> +               },
> +       },
> +       { } /* terminate list */
> +};
> +
> +static bool dw_i2c_needs_amd_gpio_dep(struct device *device)
> +{
> +       struct acpi_device *adev;
> +
> +       if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
> +               return false;
> +
> +       adev =3D ACPI_COMPANION(device);
> +       if (!adev)
> +               return false;
> +
> +       return acpi_dev_hid_uid_match(adev, "AMDI0010", "2");
> +}
> +
> +static int dw_i2c_defer_for_amd_gpio(struct device *device)
> +{
> +       struct acpi_device *gpio_adev;
> +       struct device *gpio_dev;
> +
> +       if (!dw_i2c_needs_amd_gpio_dep(device))
> +               return 0;
> +
> +       /*
> +        * Find the AMD GPIO controller by HID/UID and get its physical
> +        * platform device. We need the platform device (not the ACPI dev=
ice)
> +        * because that is what gets bound by the amd_gpio driver.
> +        */
> +       gpio_adev =3D acpi_dev_get_first_match_dev("AMDI0030", "0", -1);
> +       if (!gpio_adev)
> +               return -EPROBE_DEFER;
> +
> +       gpio_dev =3D acpi_get_first_physical_node(gpio_adev);
> +       acpi_dev_put(gpio_adev);
> +       if (!gpio_dev)
> +               return -EPROBE_DEFER;
> +
> +       /*
> +        * Check that amd_gpio probe has fully completed, not just that t=
he
> +        * driver pointer is set. The driver pointer is assigned before p=
robe
> +        * finishes, so checking it would allow i2c_designware to probe b=
efore
> +        * the GPIO IRQ quirk in amd_gpio_probe() has run.
> +        */
> +       device_lock(gpio_dev);

You can use scoped_guard(device, gpio_dev) here.

> +       if (!device_is_bound(gpio_dev)) {
> +               device_unlock(gpio_dev);
> +               return -EPROBE_DEFER;
> +       }
> +       device_unlock(gpio_dev);
> +
> +       /*
> +        * Create a device link so the driver core enforces probe/remove
> +        * ordering between this I2C controller and the GPIO controller.
> +        */
> +       if (!device_link_add(device, gpio_dev, DL_FLAG_AUTOREMOVE_CONSUME=
R))
> +               dev_warn(device, "failed to add device link to %s\n",
> +                        dev_name(gpio_dev));
> +
> +       return 0;
> +}
> +
>  static const struct i2c_dw_semaphore_callbacks i2c_dw_semaphore_cb_table=
[] =3D {
>  #ifdef CONFIG_I2C_DESIGNWARE_BAYTRAIL
>         {
> @@ -138,6 +211,10 @@ static int dw_i2c_plat_probe(struct platform_device =
*pdev)
>         struct dw_i2c_dev *dev;
>         int irq, ret;
>
> +       ret =3D dw_i2c_defer_for_amd_gpio(device);
> +       if (ret)
> +               return ret;
> +
>         irq =3D platform_get_irq_optional(pdev, 0);
>         if (irq =3D=3D -ENXIO)
>                 flags |=3D ACCESS_POLLING;
> --
> 2.54.0
>

The patch looks fine but I too would prefer this to be handled at a
higher-level. If we know which ACPI devices we're waiting for and what
the ordering should be - is it possible to somehow setup the devlink
for the platform devices that will be the children of these ACPI
devices?

If that can't be done, I'm fine with this as a workaround.

Bartosz
