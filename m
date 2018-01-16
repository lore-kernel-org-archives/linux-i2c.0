From: Dmitry Mastykin <mastichi@gmail.com>
Subject: Re: i2c: core: report OF style module alias for devices registered
 via OF
Date: Tue, 16 Jan 2018 16:55:53 +0300
Message-ID: <CALieaeczi5iZPgKVdHw1B3ouyWcd2U_cqPzEYqvT+8JW4Uwi3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41008 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeAPNz4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 08:55:56 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Dmitry Mastykin <mastichi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Sun, 3 Dec 2017 22:40:50 +0100, Javier Martinez Canillas
<javierm@redhat.com> wrote:

> The buses should honor the firmware interface used to register the device,
> but the I2C core reports a MODALIAS of the form i2c:<device> even for I2C
> devices registered via OF.
>
> This means that user-space will never get an OF stype uevent MODALIAS even
> when the drivers modules contain aliases exported from both the I2C and OF
> device ID tables. For example, an Atmel maXTouch Touchscreen registered by
> a DT node with compatible "atmel,maxtouch" has the following module alias:
>
> $ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
> i2c:maxtouch
>
> So udev won't be able to auto-load a module for an OF-only device driver.
> Many OF-only drivers duplicate the OF device ID table entries in an I2C ID
> table only has a workaround for how the I2C core reports the module alias.
>
> This patch changes the I2C core to report an OF related MODALIAS uevent if
> the device was registered via OF. So for the previous example, after this
> patch, the reported MODALIAS for the Atmel maXTouch will be the following:
>
> $ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
> of:NtrackpadT<NULL>Catmel,maxtouch
>
> NOTE: This patch may break out-of-tree drivers that were relying on this
>       behavior, and only had an I2C device ID table even when the device
>       was registered via OF. There are no remaining drivers in mainline
>       that do this, but out-of-tree drivers have to be fixed and define
>       a proper OF device ID table to have module auto-loading working.
>

Hello Javier,
thank you for your patch!

I had problem with auto-loading max9611 module, because it has no I2C
device ID table:
$ cat /sys/class/i2c-adapter/i2c-0/0-0070/modalias
of:Nmax9611_0_70T<NULL>Cmaxim,max9611

With your patch it has been auto-loaded well:
[    0.796180] i2c i2c-0: of_i2c: register /ocp/i2c@44e0b000/max9611_0_70@70
[    0.796431] i2c i2c-0: client [max9611] registered with bus id 0-0070
[    6.260710] i2c-core: driver [max9611] registered

Additionally I use several modules with both I2C and OF device ID tables,
they work well with or without the patch (max1363, pinctrl_mcp23s08).

Regards,
Dmitry

Tested-by: Dmitry Mastykin <mastichi@gmail.com>

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/i2c/i2c-core-base.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index bf52cca87363..1596aa718bc8 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -124,6 +124,10 @@ static int i2c_device_uevent(struct device *dev,
> struct kobj_uevent_env *env)
>      struct i2c_client *client = to_i2c_client(dev);
>      int rc;
>
> +    rc = of_device_uevent_modalias(dev, env);
> +    if (rc != -ENODEV)
> +        return rc;
> +
>      rc = acpi_device_uevent_modalias(dev, env);
>      if (rc != -ENODEV)
>          return rc;
> @@ -416,6 +420,10 @@ show_modalias(struct device *dev, struct
> device_attribute *attr, char *buf)
>      struct i2c_client *client = to_i2c_client(dev);
>      int len;
>
> +    len = of_device_modalias(dev, buf, PAGE_SIZE);
> +    if (len != -ENODEV)
> +        return len;
> +
>      len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
>      if (len != -ENODEV)
>          return len;
