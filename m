From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/8] i2c: i2c-bfin-twi: Tighten condition when failing I2C
 transfer if MEN bit is reset unexpectedly.
Date: Thu, 17 May 2012 17:00:40 +0530
Message-ID: <CAM=Q2cta_a2XcOLoOnnUUjZOpj1phUH99xfgZnh4nhxG8QX3-Q@mail.gmail.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
	<1337152826-9850-4-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337152826-9850-4-git-send-email-sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 16, 2012 at 12:50 PM,  <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> Correct I2C transfer may fail because interrupt status bits XMTSERV and
> RCVSERV are not checked when MCOMP interrupt is handled.
>
Could you expand MCOMP?
