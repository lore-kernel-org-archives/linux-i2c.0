From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/8] i2c: i2c-bfin-twi: Tighten condition when failing I2C
 transfer if MEN bit is reset unexpectedly.
Date: Fri, 18 May 2012 11:52:41 +0530
Message-ID: <CAM=Q2ctYVmok6bJu4kRWM2CX07vp7NS0VTHyeVzbJa3TttLU2Q@mail.gmail.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
	<1337152826-9850-4-git-send-email-sonic.zhang@analog.com>
	<CAM=Q2cta_a2XcOLoOnnUUjZOpj1phUH99xfgZnh4nhxG8QX3-Q@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D16F64F8527E@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16F64F8527E-6SXM3jaLOct7xzP2fcxY8GoKb0G9Rp+C@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 18, 2012 at 8:11 AM, Zhang, Sonic <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> =
wrote:
>
>
>>-----Original Message-----
>>From: Shubhrajyoti Datta [mailto:omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>>Sent: Thursday, May 17, 2012 7:31 PM
>>To: Zhang, Sonic
>>Cc: Ben Dooks; Wolfram Sang; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; LKML; uclinux=
-dist-
>>devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
>>Subject: Re: [PATCH 4/8] i2c: i2c-bfin-twi: Tighten condition when fa=
iling I2C
>>transfer if MEN bit is reset unexpectedly.
>>
>>On Wed, May 16, 2012 at 12:50 PM, =A0<sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> wrote:
>>> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>>
>>> Correct I2C transfer may fail because interrupt status bits XMTSERV=
 and
>>> RCVSERV are not checked when MCOMP interrupt is handled.
>>>
>>Could you expand MCOMP?
>
> Master transfer complete (MCOMP)
> [1] The initiated master transfer has completed. In the absence of a
> repeat start, the bus has been released.
> [0] The completion of a transfer has not been detected.
>

A trivial suggestion may be the changelog could be enhanced.
Thanks for the explanation.

>
> Regards,
>
> Sonic
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
