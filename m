From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v1 i2c/for-next] i1c: i801: recover from hardware PEC
 errors
Date: Wed, 15 Apr 2015 14:08:34 +0200
Message-ID: <20150415140834.44b1add8@endymion.delvare>
References: <1428970319-32544-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428970319-32544-1-git-send-email-ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ellen,

On Mon, 13 Apr 2015 17:11:59 -0700, Ellen Wang wrote:
> On a CRC error while using hardware-supported PEC, an additional
> error bit is set in the auxiliary status register.  If this bit
> isn't cleared, all subsequent operations will fail, essentially
> hanging the controller.
> 
> The fix is simple: clear the bit at the same time we clear
> the error bits in the main status register.
> 
> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Thanks for the patch. I noticed the issue over a year ago and wrote a
patch on my own, but then couldn't find the time to test it and finally
forgot about it :( so I never posted it. You can read it here for
reference:
http://jdelvare.nerim.net/devel/misc/i2c-i801-07-check-pec-status.patch

I am currently working on other matters but I'll look into this ASAP. A
quick comparison between our patches suggests that yours only clears
the PEC status bit while mine also reports the error properly to the
caller, so mine might be a better working base. Maybe you could review
and/or test my patch as a replacement of yours?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
