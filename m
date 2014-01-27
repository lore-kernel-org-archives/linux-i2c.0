From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: i2c-adi: move twi header from arch folder to
 generic include folder
Date: Mon, 27 Jan 2014 14:30:05 +0800
Message-ID: <CAJxxZ0OPo0oTNucv4=rOxJCFcExGA4kpcSeuSw28FpciNLTjRA@mail.gmail.com>
References: <1390720607-447-1-git-send-email-sonic.adi@gmail.com>
	<1390720607-447-2-git-send-email-sonic.adi@gmail.com>
	<20140126102929.GB2579@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140126102929.GB2579@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, Jan 26, 2014 at 6:29 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Sun, Jan 26, 2014 at 03:16:45PM +0800, Sonic Zhang wrote:
>> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> Any chance to simply include this in the driver?
>

After more investigation, I found the MMR bits macro and strcuts are
also used in arch/blackfin/kernel/debug-mmrs.c driver. So, I have to
leave them in the individual head file.

Regards,

Sonic
