From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: [PATCH] i2c: designware: Fix failure on baytrail
Date: Mon, 12 Feb 2018 09:56:41 -0600
Message-ID: <CAE7DoPZmS8S8TD7+jM-ipcMMKx+6eZ=N7qwHS73NshXf0YY5kw@mail.gmail.com>
References: <1518450764-6652-1-git-send-email-gardner.ben@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:37020 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932457AbeBLP4n (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Feb 2018 10:56:43 -0500
Received: by mail-io0-f195.google.com with SMTP id f89so17741988ioj.4
        for <linux-i2c@vger.kernel.org>; Mon, 12 Feb 2018 07:56:43 -0800 (PST)
In-Reply-To: <1518450764-6652-1-git-send-email-gardner.ben@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Ben Gardner <gardner.ben@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

I didn't make it clear in the subject line, but this patch is intended
for the 4.9 kernel.
The earlier patch (Feb 9, 2018) was for 4.14, 4.15 and future.

On Mon, Feb 12, 2018 at 9:52 AM, Ben Gardner <gardner.ben@gmail.com> wrote:
> The I2C driver for my Atom E3845 board has been broken since 4.9.
> My board has two I2C devices on a bus that are declared via ACPI.
> At startup, both drivers attempt to access the devices at the same time,
> resulting in two back-to-back I2C transactions initiated by the kernel.
> The second transaction fails.
>
> The root issue is that the I2C port takes a while to enable and somewhere
> along the way, the 'enable-and-wait' approach to enabling the adapter
> was changed to 'enable'.
> That caused the driver and hardware to get out of sync and fail.
>
> These kernel logs show up whenever an I2C transaction is attempted after
> this failure.
> i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
> i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready
>
> The driver is unable to recover the bus at this point, but that is a
> separate issue.
>
> This patch has been tested on 4.9.
>
> Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index b403fa5..980e5a1 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -509,7 +509,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>         i2c_dw_disable_int(dev);
>
>         /* Enable the adapter */
> -       __i2c_dw_enable(dev, true);
> +       __i2c_dw_enable_and_wait(dev, true);
>
>         /* Clear and enable interrupts */
>         dw_readl(dev, DW_IC_CLR_INTR);
> --
> 2.7.4
>
