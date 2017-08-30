From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
Date: Wed, 30 Aug 2017 18:19:02 +0200
Message-ID: <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
References: <20170615185418.13980-1-javier@dowhile0.org> <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato> <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
 <20170829084831.hsdok3ksi7anxzuc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170829084831.hsdok3ksi7anxzuc@ninjato>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Larysch <fl-J+Jo6bLUB7M@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Dinh Nguyen <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Scott Wood <oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On Tue, Aug 29, 2017 at 10:48 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> I don't have a DT based system at hand now, but I'll test it again and
>> let you know probably tomorrow.
>
> I will try again today, too. Thanks!
>

Ok, I had some time to do some tests again. I used an ARM Chromebook
(Exynos Peach Pi) that has an I2C touchpad (Atmel maXTouch).

Tested the following cases:

1) Driver without OF device ID table (only a I2C table with a
"maxtouch" entry) and DTS defining a device node with a
"atmel,maxtouch" compatible string. This is the case without any of
the patches in this series.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
MODALIAS=i2c:maxtouch

2) Driver without OF device ID table (only a I2C table with a
"maxtouch" entry) and DTS defining a device node with a
"atmel,maxtouch", "generic,maxtouch" compatible string. This is the
case when platform maintainers merge the DTS patches without the
driver patch.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
OF_COMPATIBLE_1=generic,maxtouch
MODALIAS=i2c:maxtouch

3) Driver with an OF device ID table (with a "generic,maxtouch" entry)
and DTS defining a device node with a "atmel,maxtouch" compatible
string. This is the case when the driver patch is merged without the
DTS patches.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          of:N*T*Cgeneric,maxtouchC*
alias:          of:N*T*Cgeneric,maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
MODALIAS=i2c:maxtouch

4) Driver with an OF device ID table (with a "generic,maxtouch" entry)
and DTS defining a device node with a "atmel,maxtouch",
"generic,maxtouch" compatible string. This is the case when both the
DTS and driver patches are merged.

$ modinfo drivers/input/touchscreen/atmel_mxt_ts.ko | grep maxtouch
alias:          of:N*T*Cgeneric,maxtouchC*
alias:          of:N*T*Cgeneric,maxtouch
alias:          i2c:maxtouch

$ grep maxtouch /sys/devices/platform/soc/12e00000.i2c/i2c-8/8-004b/uevent
OF_COMPATIBLE_0=atmel,maxtouch
OF_COMPATIBLE_1=generic,maxtouch
MODALIAS=i2c:maxtouch

For all cases module autoload, driver probe and evtest worked for me.

You said that (3) doesn't work but I don't understand why is failing
for you. Probably I'm missing something.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
