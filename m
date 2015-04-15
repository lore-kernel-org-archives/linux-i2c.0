From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1 i2c/for-next] i1c: i801: recover from hardware PEC
 errors
Date: Wed, 15 Apr 2015 13:46:17 -0700
Message-ID: <552ECE19.4090705@cumulusnetworks.com>
References: <1428970319-32544-1-git-send-email-ellen@cumulusnetworks.com> <20150415140834.44b1add8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150415140834.44b1add8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thanks for the quick reply.  My answers are below:

On 4/15/2015 5:08 AM, Jean Delvare wrote:
> Hi Ellen,
>
> On Mon, 13 Apr 2015 17:11:59 -0700, Ellen Wang wrote:
>> On a CRC error while using hardware-supported PEC, an additional
>> error bit is set in the auxiliary status register.  If this bit
>> isn't cleared, all subsequent operations will fail, essentially
>> hanging the controller.
>>
>> The fix is simple: clear the bit at the same time we clear
>> the error bits in the main status register.
>>
>> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-i801.c |   21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>
> Thanks for the patch. I noticed the issue over a year ago and wrote a
> patch on my own, but then couldn't find the time to test it and finally
> forgot about it :( so I never posted it. You can read it here for
> reference:
> http://jdelvare.nerim.net/devel/misc/i2c-i801-07-check-pec-status.patch
>
> I am currently working on other matters but I'll look into this ASAP. A
> quick comparison between our patches suggests that yours only clears
> the PEC status bit while mine also reports the error properly to the
> caller, so mine might be a better working base. Maybe you could review
> and/or test my patch as a replacement of yours?

My version does actually report the error, because the main status 
register error bit is also set in this case, and that gets detected and 
reported.  It just doesn't doesn't return a specific errno for PEC error.

The main difference between our versions is that you check and clear the 
CRC error bit in i801_check_pre() and i801_checkpost(), while I do it in 
i801_isr().  i801_isr() is also where it checks and clears the main 
status register for errors, so it seems natural to do it also for the 
auxiliary status.

Probably what we should do is combine the two versions, especially if we 
want to return a PEC-specific errno.  I think to do that properly in the 
current structure of the code, we should save the auxiliary status in 
priv->auxsts in i801_isr(), the same way it saves priv->status.  This 
ways, isr() can clear the error in the hardware and check_post() can 
still see it and process accordingly.  What do you think?  (I actually 
thought of this, but opted for a minimal fix.)  This is more 
complicated, and functions like i801_wait_intr() return the status and 
it can't return two values easily.

If we decide to go with your version, I can certainly test it.  We have 
a machine with the right hardware combination, and it generates PEC 
errors deterministically.

By the way, I noticed a small bug in i801_transaction(). At line 391, it 
has "status = -ETIMEOUT", but "status" at that point should be the 
register value not -errno.  It probably should be "return -ETIMEOUT", 
but I'm not sure whether hardware cleanup is necessary at that point.

> Thanks,

Thank you!
