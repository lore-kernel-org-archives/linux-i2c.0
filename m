From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/8] i2c: i2c-bfin-twi: Break dead waiting loop if i2c
 device misbehaves.
Date: Thu, 17 May 2012 10:50:24 +0530
Message-ID: <CAM=Q2csTziLb0niCTj6oW9G=BPa2VWN58rW2jF-A1VJKXwNfCQ@mail.gmail.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
	<1337152826-9850-3-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337152826-9850-3-git-send-email-sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, May 16, 2012 at 12:50 PM,  <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> Some fault i2c device may hold the sda/scl line and cause i2c driver
> wait in the BUS busy loop. This patch breaks this potential dead
> loop.
How about using a non-busy loop while you are at it.

>
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> git-svn-id: svn://localhost/svn/linux-kernel/trunk@9291 526b6c2d-f592-4532-a319-5dd88ccb003d
