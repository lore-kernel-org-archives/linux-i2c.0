From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] i2c: i2c-bfin-twi: Move blackfin TWI register access
 Macro to head file.
Date: Fri, 25 May 2012 15:40:16 +0530
Message-ID: <CAM=Q2cveBrYUiNYEbUgXyTnK2JhVD8UyhGgYJ=Zr86YnMMJ6Dg@mail.gmail.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
	<1337152826-9850-8-git-send-email-sonic.zhang@analog.com>
	<CAM=Q2csSuQ3R9U=XKwj9F0xijTxx_ULperAiQYD_X3a5GKVjFg@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D170230E5ADF@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D170230E5ADF-6SXM3jaLOct7xzP2fcxY8GoKb0G9Rp+C@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi ,
On Fri, May 25, 2012 at 3:24 PM, Zhang, Sonic <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> =
wrote:
>
>
>>-----Original Message-----
>>From: Shubhrajyoti Datta [mailto:omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>>Sent: Friday, May 25, 2012 5:48 PM
>>To: Zhang, Sonic
>>Cc: Ben Dooks; Wolfram Sang; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; LKML; uclinux=
-dist-
>>devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
>>Subject: Re: [PATCH 8/8] i2c: i2c-bfin-twi: Move blackfin TWI registe=
r access
>>Macro to head file.
>>
>>Hi ,
>>Some minor comments/ doubts.
>>On Wed, May 16, 2012 at 12:50 PM, =A0<sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> wrote:
>>> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>>
>>
>>A small description may be helpful.
>>Also the $SUBJECT says move the patch looks more like the remove.
>>Am I missing something.
>
> The subject says these definitions are moved to a head file by the ot=
her patch for Blackfin architecture.

Got it thanks.

You may want to add a dependency otherwise it might lead to a compilati=
on break?


>
> Regards,
>
> Sonic
