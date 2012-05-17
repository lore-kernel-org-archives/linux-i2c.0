From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/8] i2c: i2c-bfin-twi: Break dead waiting loop if i2c
 device misbehaves.
Date: Thu, 17 May 2012 01:23:09 -0400
Message-ID: <CAMjpGUf-AQHigrpBhxmOGJZgjfqfCWvRa29wURpGkVuj58suPg@mail.gmail.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
 <1337152826-9850-3-git-send-email-sonic.zhang@analog.com> <CAM=Q2csTziLb0niCTj6oW9G=BPa2VWN58rW2jF-A1VJKXwNfCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2csTziLb0niCTj6oW9G=BPa2VWN58rW2jF-A1VJKXwNfCQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 17, 2012 at 1:20 AM, Shubhrajyoti Datta
<omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, May 16, 2012 at 12:50 PM, =C2=A0<sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> wrot=
e:
>> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> Some fault i2c device may hold the sda/scl line and cause i2c driver
>> wait in the BUS busy loop. This patch breaks this potential dead
>> loop.
>
> How about using a non-busy loop while you are at it.

the timings here are fairly small ...
-mike
