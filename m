From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1 i2c/for-next] i2c-i801: recover from hardware PEC errors
Date: Mon, 20 Apr 2015 15:52:47 -0700
Message-ID: <5535833F.7090809@cumulusnetworks.com>
References: <1428970319-32544-1-git-send-email-ellen@cumulusnetworks.com>	<20150415140834.44b1add8@endymion.delvare>	<552ECE19.4090705@cumulusnetworks.com> <20150417091751.1ae986f2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150417091751.1ae986f2-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4/17/2015 12:17 AM, Jean Delvare wrote:
> Hi Ellen,
>
> On Wed, 15 Apr 2015 13:46:17 -0700, Ellen Wang wrote:
>> On 4/15/2015 5:08 AM, Jean Delvare wrote:
>>> On Mon, 13 Apr 2015 17:11:59 -0700, Ellen Wang wrote:
>>>> On a CRC error while using hardware-supported PEC, an additional
>>>> error bit is set in the auxiliary status register.  If this bit
>>>> isn't cleared, all subsequent operations will fail, essentially
>>>> hanging the controller.
>>>>
>>>> The fix is simple: clear the bit at the same time we clear
>>>> the error bits in the main status register.
>>>>
>>>> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
>>>> ---
>>>>    drivers/i2c/busses/i2c-i801.c |   21 +++++++++++++++++++++
>>>>    1 file changed, 21 insertions(+)
>>>
>>> Thanks for the patch. I noticed the issue over a year ago and wrote a
>>> patch on my own, but then couldn't find the time to test it and finally
>>> forgot about it :( so I never posted it. You can read it here for
>>> reference:
>>> http://jdelvare.nerim.net/devel/misc/i2c-i801-07-check-pec-status.patch
>>>
>>> I am currently working on other matters but I'll look into this ASAP. A
>>> quick comparison between our patches suggests that yours only clears
>>> the PEC status bit while mine also reports the error properly to the
>>> caller, so mine might be a better working base. Maybe you could review
>>> and/or test my patch as a replacement of yours?
>>
>> My version does actually report the error, because the main status
>> register error bit is also set in this case, and that gets detected and
>> reported.  It just doesn't doesn't return a specific errno for PEC error.
>
> Correct, I did not remember this, sorry.
>
>> The main difference between our versions is that you check and clear the
>> CRC error bit in i801_check_pre() and i801_checkpost(), while I do it in
>> i801_isr().  i801_isr() is also where it checks and clears the main
>> status register for errors, so it seems natural to do it also for the
>> auxiliary status.
>
> The check in i801_check_pre() is in case the CRC error bit is set at
> the time the driver is loaded. If it is, and we don't clear it, the
> driver won't work (for PEC transactions or even for all transactions,
> I'm not sure.) So I think it is needed either way.

Right.  The driver doesn't work for any type of transaction if the CRC 
error bit is set.

> At the end of the transaction, the main status register is cleared in
> both i801_isr() and i801_check_post(). The latter is needed in case the
> driver operates in polling (non-interrupt) mode. That was the only mode
> available originally and my patch is so old that it is entirely
> possible that I wrote it before interrupt support was added to the
> driver. In fact that might even be the reason why I never submitted it,
> it may not support interrupt mode properly.
>
> So it is possible that the aux status register must be cleared in both
> i801_isr() and i801_check_post() to be on the safe side.
>
>> Probably what we should do is combine the two versions, especially if we
>> want to return a PEC-specific errno.  I think to do that properly in the
>> current structure of the code, we should save the auxiliary status in
>> priv->auxsts in i801_isr(), the same way it saves priv->status.  This
>> ways, isr() can clear the error in the hardware and check_post() can
>> still see it and process accordingly.  What do you think?  (I actually
>> thought of this, but opted for a minimal fix.)  This is more
>
> Sounds like a good idea, but I still believe that i801_check_post()
> will also have to clear the CRC error bit, for the non-interrupt case.

Yes.  My fix doesn't work in the polling case.

>> complicated, and functions like i801_wait_intr() return the status and
>> it can't return two values easily.
>
> I don't think we actually need to deal with the aux status register
> value in i801_wait_intr(). According to my notes, whenever the CRC
> error bit is set, SMBHSTSTS_DEV_ERR is also set in the main status
> register. So it's enough to check for that bit in i801_wait_intr(). If
> you need to pass the aux register status to i801_check_post(), in the
> non-interrupt case you could simply do:
>
> 	return i801_check_post(priv, status, inb_p(SMBAUXSTS(priv)));
>
>> If we decide to go with your version, I can certainly test it.  We have
>> a machine with the right hardware combination, and it generates PEC
>> errors deterministically.
>
> Well as I wrote above, it is possible that my patch doesn't work at all
> in the interrupt case, or that it works but is racy. So most probably
> we have to do as you said and combine both patches into one.

I will do that.

I see that I didn't understand that priv->status is only used in the 
interrupt case.

This leads to a related question:  If the driver is serialized, then the 
(status = priv->status) inside wait_event_timeout() isn't strictly 
necessary, correct?  It can just be priv->status.  I'm just want to 
double check that there's no race and I can add a priv->auxsts and not 
have to stick something like this inside the wait_event_timeout():

    (auxsts = priv->auxsts, status = priv->status)

>> By the way, I noticed a small bug in i801_transaction(). At line 391, it
>> has "status = -ETIMEOUT", but "status" at that point should be the
>> register value not -errno.  It probably should be "return -ETIMEOUT",
>> but I'm not sure whether hardware cleanup is necessary at that point.
>
> I can't see any bug there. status can be either the (positive) register
> value or a negative error code. It is passed to i801_check_post() which
> can deal with both.

You're right.  I didn't see that case in check_post().

Thanks!
