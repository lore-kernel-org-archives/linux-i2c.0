From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: cros_ec: Remove EC_I2C_FLAG_10BIT
Date: Fri, 27 Jun 2014 08:49:15 -0700
Message-ID: <CAD=FV=WLw2D3sw2LaWt0SJXNEFSBk08eKOCa9O_zt=58UN+MLA@mail.gmail.com>
References: <1403558406-14519-1-git-send-email-dianders@chromium.org>
	<20140627123443.GC29156@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140627123443.GC29156@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

On Fri, Jun 27, 2014 at 5:34 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Jun 23, 2014 at 02:20:06PM -0700, Doug Anderson wrote:
>> In <https://lkml.org/lkml/2014/6/10/265> pointed out that the 10-bit
>> flag in the cros_ec_tunnel was useless.  It went into a 16-bit flags
>> field but was defined at (1 << 16).
>>
>> Since we have no 10-bit i2c devices on the other side of the tunnel on
>> any known devices this was never a problem.  Until we do it makes
>> sense to remove this code.  On the EC side the code to handle this
>> flag was removed in <https://chromium-review.googlesource.com/204162>.
>>
>> Reported-by: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>> Note that this patch is based atop my current series of posts to
>> cleanup cros_ec.  It wouldn't be hard to apply it to the current ToT
>> if someone wants to land this before the others.
>
> I could take it into my tree, but I think it makes more sense if we
> simply append it to your cleanup series?

Thanks, that sounds reasonable to me.  Lee has Acked the whole series
and Simon Glass has reviewed it too, so I'd imagine that we're just
waiting on the input subsystem's Ack on a few of the patches.

If I happen to send out the other series for some reason I'll tack
this onto the end of it.

-Doug
