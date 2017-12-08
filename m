From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH RESEND v7 1/2] at24: support eeproms that do not
 auto-rollover reads.
Date: Fri, 8 Dec 2017 18:22:36 +0100
Message-ID: <CAMRc=MeWUwgG08XN_UWbnarDMfk9Zm5OoQJCRVG2aqSiv2AZ0g@mail.gmail.com>
References: <1512750511-24505-1-git-send-email-svendev@arcx.com> <1512750511-24505-2-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33679 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbdLHRWh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Dec 2017 12:22:37 -0500
Received: by mail-ot0-f195.google.com with SMTP id h9so9743205oti.0
        for <linux-i2c@vger.kernel.org>; Fri, 08 Dec 2017 09:22:37 -0800 (PST)
In-Reply-To: <1512750511-24505-2-git-send-email-svendev@arcx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <svendev@arcx.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner <david@lechnology.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

2017-12-08 17:28 GMT+01:00 Sven Van Asbroeck <svendev@arcx.com>:
> Some multi-address eeproms in the at24 family may not automatically
> roll-over reads to the next slave address. On those eeproms, reads
> that straddle slave boundaries will not work correctly.
>
> Solution:
> Mark such eeproms with a flag that prevents reads straddling
> slave boundaries. Add the AT24_FLAG_NO_RDROL flag to the eeprom
> entry in the device_id table, or add 'no-read-rollover' to the
> eeprom devicetree entry.
>
> Note that I have not personally enountered an at24 chip that
> does not support read rollovers. They may or may not exist.
> However, my hardware requires this functionality because of
> a quirk.
>
> It's up to the Linux community to decide if this patch is useful/
> general enough to warrant merging.
>
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  drivers/misc/eeprom/at24.c         | 39 ++++++++++++++++++++++++++------------
>  include/linux/platform_data/at24.h |  2 ++
>  2 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 625b001..06ffa11 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -251,15 +251,6 @@ struct at24_data {
>   * Slave address and byte offset derive from the offset. Always
>   * set the byte address; on a multi-master board, another master
>   * may have changed the chip's "current" address pointer.
> - *
> - * REVISIT some multi-address chips don't rollover page reads to
> - * the next slave address, so we may need to truncate the count.
> - * Those chips might need another quirk flag.
> - *
> - * If the real hardware used four adjacent 24c02 chips and that
> - * were misconfigured as one 24c08, that would be a similar effect:
> - * one "eeprom" file not four, but larger reads would fail when
> - * they crossed certain pages.
>   */
>  static struct at24_client *at24_translate_offset(struct at24_data *at24,
>                                                  unsigned int *offset)
> @@ -277,6 +268,30 @@ static struct at24_client *at24_translate_offset(struct at24_data *at24,
>         return &at24->client[i];
>  }
>
> +static size_t at24_adjust_read_count(struct at24_data *at24,
> +                                     unsigned int offset, size_t count)
> +{
> +       unsigned int bits;
> +       size_t remainder;
> +
> +       /*
> +        * In case of multi-address chips that don't rollover reads to
> +        * the next slave address: truncate the count to the slave boundary,
> +        * so that the read never straddles slaves.
> +        */
> +       if (at24->chip.flags & AT24_FLAG_NO_RDROL) {
> +               bits = (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
> +               remainder = BIT(bits) - offset;
> +               if (count > remainder)
> +                       count = remainder;
> +       }
> +
> +       if (count > io_limit)
> +               count = io_limit;
> +
> +       return count;
> +}
> +
>  static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
>                                 unsigned int offset, size_t count)
>  {
> @@ -289,9 +304,7 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
>         at24_client = at24_translate_offset(at24, &offset);
>         regmap = at24_client->regmap;
>         client = at24_client->client;
> -
> -       if (count > io_limit)
> -               count = io_limit;
> +       count = at24_adjust_read_count(at24, offset, count);
>
>         /* adjust offset for mac and serial read ops */
>         offset += at24->offset_adj;
> @@ -457,6 +470,8 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
>
>         if (device_property_present(dev, "read-only"))
>                 chip->flags |= AT24_FLAG_READONLY;
> +       if (device_property_present(dev, "no-read-rollover"))
> +               chip->flags |= AT24_FLAG_NO_RDROL;
>
>         err = device_property_read_u32(dev, "size", &val);
>         if (!err)
> diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
> index 271a4e2..841bb28 100644
> --- a/include/linux/platform_data/at24.h
> +++ b/include/linux/platform_data/at24.h
> @@ -50,6 +50,8 @@ struct at24_platform_data {
>  #define AT24_FLAG_TAKE8ADDR    BIT(4)  /* take always 8 addresses (24c00) */
>  #define AT24_FLAG_SERIAL       BIT(3)  /* factory-programmed serial number */
>  #define AT24_FLAG_MAC          BIT(2)  /* factory-programmed mac address */
> +#define AT24_FLAG_NO_RDROL  BIT(1)     /* does not auto-rollover reads to */
> +                                       /* the next slave address */
>
>         void            (*setup)(struct nvmem_device *nvmem, void *context);
>         void            *context;
> --
> 1.9.1
>

Applied, thanks!
