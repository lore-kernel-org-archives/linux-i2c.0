From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: Prevent NULL pointer dereference in remove
Date: Thu, 6 Sep 2012 17:33:31 +0530
Message-ID: <CAM=Q2cvuC-Drd1fKwMpiRB_q8r5rttRvZX2GpngnJbv=oKLHxQ@mail.gmail.com>
References: <1345731686-26026-1-git-send-email-shubhrajyoti@ti.com>
	<20120829204759.467235e2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120829204759.467235e2-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,
Thanks for the review.

On Thu, Aug 30, 2012 at 12:17 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Thu, 23 Aug 2012 19:51:26 +0530, Shubhrajyoti D wrote:
>> Prevent the NULL pointer access of pdev->dev in remove. The platform_device is anyways
>> deleted so remove  platform_set_drvdata(pdev, NULL);.
>
[...]
>
>> @@ -1112,8 +1111,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
>>       struct resource         *mem;
>>       int ret;
>>
>> -     platform_set_drvdata(pdev, NULL);
>> -
>
> This OTOH is a good catch. But the problem isn't with calling
> platform_set_drvdata(pdev, NULL) per se. The problem is with calling it
> too early. It should be called after i2c_del_adapter(), and ideally
> before freeing the memory.
>

Just  sent a patch implementing your suggestion.
thanks,
