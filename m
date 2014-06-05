From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
Date: Thu, 5 Jun 2014 16:41:34 +0100
Message-ID: <CACxGe6vLuKygv0E7yq42qe-Lh+nMZ1wrL7PW_TAeoz55wz9q8A@mail.gmail.com>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-8-git-send-email-lee.jones@linaro.org> <20140605103009.85BE4C40A4D@trevor.secretlab.ca>
 <20140605103709.GE19550@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140605103709.GE19550@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 5, 2014 at 11:37 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, 05 Jun 2014, Grant Likely wrote:
>
>> On Wed,  4 Jun 2014 13:09:56 +0100, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > Currently this is a helper function for the I2C subsystem to aid the
>> > matching of non-standard compatible strings and devices which use DT
>> > and/or ACPI, but do not supply any nodes (see: [1] Method 4).  However,
>> > it has been made more generic as it can be used to only make one call
>> > for drivers which support any mixture of OF, ACPI and/or I2C matching.
>> >
>> > The initial aim is for of_match_device() to be replaced by this call
>> > in all I2C device drivers.
>> >
>> > [1] Documentation/i2c/instantiating-devices
>> >
>> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> I don't like this. It drops all type safety on the match entry
>> and the caller has no idea what it got back.
>
> Okay, so what's the best way forward?
>
> Introduce a i2c_of_match_device() call instead?

I still think the way to do it is to emulate the missing i2c_device_id
when calling the drivers .probe() hook by having a temporary copy on
the stack and filling it with data from the OF or ACPI table....
Actually I would completely skip trying to get the data from ACPI.
Since all of this is to continue supporting instantiating devices from
sysfs, having a fallback to the OF table completely solves that use
case.

Anticipating an objection of: "what do we do with drivers that are
ACPI only?"... That will be an incredibly rare case. If that ever does
happen then we'll solve it by simply adding an of_device_id table.

g.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
