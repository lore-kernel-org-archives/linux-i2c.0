From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: piix4: Avoid race conditions with IMC
Date: Wed, 11 Jan 2017 03:49:21 +0200
Message-ID: <CAHp75VdnoW84sQh-vf57NSC6_tXGqvb_36KCPpi-XFbktWiKfw@mail.gmail.com>
References: <20170110121600.30649-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35089 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdAKBtW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 10 Jan 2017 20:49:22 -0500
In-Reply-To: <20170110121600.30649-1-ricardo.ribalda@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jan 10, 2017 at 2:16 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> On AMD's SB800 and upwards, the SMBus is shared with the Integrated
> Micro Controller (IMC).
>
> The platform provides a hardware semaphore to avoid race conditions
> among them. (Check page 288 of the SB800-Series Southbridges Register
> Reference Guide http://support.amd.com/TechDocs/45482.pdf)

It would be nice to understand what kind of devices are accessing and to where.

Hans seems discovered one pretty nice issue on Intel
BayTrail/CherryTrail platforms where I2C semaphore is used to prevent
simultaneous access to P-Unit, but we have two paths there which are
not synchronized (yet). It brings a set of interesting (and
unfortunately "famous") bugs.

>
> Without this patch, many access to the SMBus end with an invalid
> transaction or even with the bus stalled.
>

> Credit-to: Alexandre Desnoyers <alex@qtec.com>

Never saw before. Did he suggested the solution or what?

> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -585,9 +585,28 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
>                  u8 command, int size, union i2c_smbus_data *data)
>  {
>         struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
> +       unsigned short piix4_smba = adapdata->smba;
>         u8 smba_en_lo;
>         u8 port;
>         int retval;
> +       int timeout = 0;
> +       int smbslvcnt;

Keep them just after your another added variable.

> +       /* Request the SMBUS semaphore, avoid conflicts with the IMC */
> +       smbslvcnt  = inb_p(SMBSLVCNT);

> +       while (++timeout < MAX_TIMEOUT) {

Usual pattern is countdown.

do {
...
} while (--timeout);

> +               outb_p(smbslvcnt | 0x10, SMBSLVCNT);
> +
> +               /* Check the semaphore status */
> +               smbslvcnt  = inb_p(SMBSLVCNT);
> +               if (smbslvcnt & 0x10)
> +                       break;
> +
> +               usleep_range(1000, 2000);
> +       }

> +       /* SMBus is still owned by the IMC, we give up */
> +       if (timeout == MAX_TIMEOUT)
> +               return -EBUSY;

Would caller do it again? Perhaps -EAGAIN?

Since the returned value is not -ETIMEDOUT, I suppose the name of
counter variable is a bit confusing. Basically it's amount of attempts
with some gap between them. Though, it's up to you and maintainer.

> +       /* Release the semaphore */
> +       outb_p(smbslvcnt | 0x20, SMBSLVCNT);

-- 
With Best Regards,
Andy Shevchenko
