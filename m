From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/10] Introduce Juniper PTXPMB CPLD driver
Date: Fri, 7 Oct 2016 19:17:08 -0700
Message-ID: <57F85724.4000706@gmail.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
 <57F8324C.2040804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57F8324C.2040804-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Debjit Ghosh <dghosh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Georgi Vlaev <gvlaev-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, JawaharBalaji Thirumalaisamy <jawaharb-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Rajat Jain <rajatjain-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/07/16 16:39, Frank Rowand wrote:
> On 10/07/16 08:17, Pantelis Antoniou wrote:
>> Add Juniper's PTXPMB FPGA CPLD driver. Those FPGAs
>> are present in Juniper's PTX series of routers.
>>
>> The MFD driver provices watchdog/i2c/gpio/mtd devices.
>>
>> There are full device tree binding documents for the
>> master mfd driver and for all slave drivers.
>>
>> This patchset is against mainline as of today: v4.8-9431-g3477d16
>> and is dependent on the "Juniper prerequisites" and
>> "Juniper infrastructure" patchsets sent earlier.
> 
> Pointers to the patchsets please.
> 

Nevermind.  Found them.

-Frank

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
