From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH -next] i2c: i2c-pxa-pci.c needs module.h
Date: Sun, 31 Jul 2011 15:41:50 -0400
Message-ID: <CAP=VYLr=GY1g==cJPnHKoBDBhsRy1am6FFkdJFkoO8HsB+6R2Q@mail.gmail.com>
References: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au>
	<20110729211430.6c4830bd.rdunlap@xenotime.net>
	<CAP=VYLrtumuSM_ncO6sEr7=HciiKcOsB=yN4NZnAxesjSSOgMw@mail.gmail.com>
	<20110731164208.GP15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110731164208.GP15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Jul 31, 2011 at 12:42 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Sat, Jul 30, 2011 at 03:09:32PM -0400, Paul Gortmaker wrote:
>> On Sat, Jul 30, 2011 at 12:14 AM, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org=
> wrote:
>> > From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
>> >
>> > i2c-pxa-pci.c uses interfaces from linux/module.h, so it should
>> > include that file. =A0This fixes build errors.
>>
>> Applied to module.h-split, thanks.
>
> ok, so I don't need to apply this one?

Nope, I've got it.  There are so many implicit module.h uses, that whil=
e
farming them all out to subtrees could in theory be done, it really isn=
't
all that practical (or timely).

Thanks,
Paul.

> Acked-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>
>> P.
>>
>> >
>> > Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
>> > ---
>> > =A0drivers/i2c/busses/i2c-pxa-pci.c | =A0 =A01 +
>> > =A01 file changed, 1 insertion(+)
>> >
>> > --- linux-next-20110729.orig/drivers/i2c/busses/i2c-pxa-pci.c
>> > +++ linux-next-20110729/drivers/i2c/busses/i2c-pxa-pci.c
>> > @@ -3,6 +3,7 @@
>> > =A0* It does not support slave mode, the register slightly moved. =
This PCI
>> > =A0* device provides three bars, every contains a single I2C contr=
oller.
>> > =A0*/
>> > +#include <linux/module.h>
>> > =A0#include <linux/pci.h>
>> > =A0#include <linux/platform_device.h>
>> > =A0#include <linux/i2c/pxa-i2c.h>
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-ne=
xt" in
>> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/
>
> Large Hadron Colada: A large Pina Colada that makes the universe disa=
ppear.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
