From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c: omap: Prevent NULL pointer dereference in remove
Date: Thu, 9 Aug 2012 19:18:24 +0530
Message-ID: <CAM=Q2cv3AH2-RTWAuLZb_kSvobta4hk9YrhF4Q0oyh=9DaOizA@mail.gmail.com>
References: <1344519467-14295-1-git-send-email-shubhrajyoti@ti.com>
	<1344519467-14295-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344519467-14295-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 9, 2012 at 7:07 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
> Prevent the NULL pointer access by moving the platform_set_drvdata function
> after the access of the pdev.
>
> [  654.961761] Unable to handle kernel NULL pointer dereference at virtual address 00000070
> [  654.970611] pgd = df254000
> [  654.973480] [00000070] *pgd=9f1da831, *pte=00000000, *ppte=00000000
> [  654.980163] Internal error: Oops: 17 [#1] SMP ARM
> [  654.985076] Modules linked in:
> [  654.988281] CPU: 1    Not tainted  (3.6.0-rc1-00031-ge547de1-dirty #339)
> [  654.995330] PC is at omap_i2c_runtime_resume+0x8/0x148
> [  655.000732] LR is at omap_i2c_runtime_resume+0x8/0x148
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
applies on top of Felipe's cleanup series.
