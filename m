From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-bfin-twi: handle faulty slave devices better
Date: Sun, 9 May 2010 14:23:58 -0400
Message-ID: <o2l8bd0f97a1005091123le4e59343j798a70d5db76c66e@mail.gmail.com>
References: <1273403087-3326-1-git-send-email-vapier@gentoo.org>
	<20100509113420.GB2589@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100509113420.GB2589-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, May 9, 2010 at 07:34, Ben Dooks wrote:
> On Sun, May 09, 2010 at 07:04:47AM -0400, Mike Frysinger wrote:
>> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> Faulty slave devices might drive SDA low after a transfer finishes. =
=C2=A0So,
>> when this scenario is detected, have the master generate up to 8 ext=
ra
>> clocks until the SDA is properly released.
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
>> ---
>> Note: this requires the existing Blackfin TWI patches already sent o=
ut
>
> hmm, it is late in the -rc series for anything other than critical
> bugfixes, will update series tomorrow.

this patch is fine for 2.6.35, but the rest of the series should have
been merged for like 2.6.33 ...

>> =C2=A0drivers/i2c/busses/i2c-bfin-twi.c | =C2=A0 22 ++++++++++++++++=
++++++
>> =C2=A01 files changed, 22 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/=
i2c-bfin-twi.c
>> index fb26e5c..f9c05e1 100644
>> --- a/drivers/i2c/busses/i2c-bfin-twi.c
>> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
>> @@ -20,6 +20,7 @@
>> =C2=A0#include <linux/completion.h>
>> =C2=A0#include <linux/interrupt.h>
>> =C2=A0#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>>
>> =C2=A0#include <asm/blackfin.h>
>> =C2=A0#include <asm/portmux.h>
>> @@ -159,6 +160,27 @@ static void bfin_twi_handle_interrupt(struct bf=
in_twi_iface *iface,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mast_stat & BUF=
WRERR)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_dbg(&iface->adap.dev, "Buffer Write Error\n");
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Faulty salve devices,=
 may drive SDA low after a transfer
> spello: slave

ok, i'll resend in a bit
-mike
