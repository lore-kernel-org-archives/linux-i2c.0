From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] i2c-xiic: Fix a possible NULL pointer access
Date: Sat, 18 Aug 2012 18:52:29 +0530
Message-ID: <CAM=Q2cvebZc_3ja+K=4v+hC4ttf5r_jT=xVVtJ=kQtsRwdZtUA@mail.gmail.com>
References: <1344519467-14295-1-git-send-email-shubhrajyoti@ti.com>
	<1344519467-14295-3-git-send-email-shubhrajyoti@ti.com>
	<20120818101752.GE24812@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120818101752.GE24812-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Aug 18, 2012 at 3:47 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Aug 09, 2012 at 07:07:43PM +0530, Shubhrajyoti D wrote:
>> platform_get_resource uses pdev so move the function
>> platform_set_drvdata(pdev, NULL) after the get_resource.
>
Yes agree.

> This descriptions sounds as you'd assume pdev is set to NULL here?
> Careful, platform_set_drvdata() does not clear pdev, but driver_data of
> pdev->dev!
>
> So, I guess the rest of this series is bogus?
>
> It would be worth checking if other drivers have the same pattern as the
> omap driver where the fix was valid for other reasons. Are you
> interested in doing that (perfectly fine to say no).

Yes I can take that , lest someone with the platform/ test set-up can
take that up.
>
> Regards,
>
>    Wolfram
>
