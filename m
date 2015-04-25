From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1 i2c/for-next] i2c-i801: recover from hardware PEC errors
Date: Sat, 25 Apr 2015 12:51:15 -0700
Message-ID: <553BF033.8050809@cumulusnetworks.com>
References: <1428970319-32544-1-git-send-email-ellen@cumulusnetworks.com> <20150415140834.44b1add8@endymion.delvare> <552ECE19.4090705@cumulusnetworks.com> <20150417091751.1ae986f2@endymion.delvare> <5535833F.7090809@cumulusnetworks.com> <20150424120852.717966f9@endymion.delvare> <CAGS+omCv0UL1hGRME_LiMGZhcd75G6x3eb7F9v5PvoxgwVAGVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omCv0UL1hGRME_LiMGZhcd75G6x3eb7F9v5PvoxgwVAGVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks!  Given that the driver is fully serialized, there really 
shouldn't be any subtleties there.

I'll update the patch after some more testing.

On 04/24/2015 04:00 AM, Daniel Kurtz wrote:
> Hi guys,
>
> On Fri, Apr 24, 2015 at 6:08 PM, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
>> Hi Ellen,
>>
>> On Mon, 20 Apr 2015 15:52:47 -0700, Ellen Wang wrote:
>>> This leads to a related question:  If the driver is serialized, then the
>>> (status = priv->status) inside wait_event_timeout() isn't strictly
>>> necessary, correct?  It can just be priv->status.  I'm just want to
>>> double check that there's no race and I can add a priv->auxsts and not
>>> have to stick something like this inside the wait_event_timeout():
>>>
>>>      (auxsts = priv->auxsts, status = priv->status)
>>
>> To be honest I'm not 100% certain. I think this was only a minor
>> optimization, but I may be wrong. Adding Daniel to Cc, he added that
>> code to the i2c-i801 driver. Daniel, any comment on this?
>>
>> Equally mysterious to me is:
>>
>>                  priv->status |= status;
>>
>> in i801_isr() where it would seem that a simple "=" would suffice.
>
> Sorry, it has been a long time since i looked at i801 code,
> I think you guys are correct.  You can probably just do:
>
>              wait_event(priv->waitq, priv->status);
>              status = priv->status;
>              priv->status = 0;
>              return i801_check_post(priv, status);
>
> And, I agree with Jean in i801_isr(),
>     priv->status |= status;
>
> Could probably just be:
>     priv->status = status;
>
> -Dan
>
>>
>> --
>> Jean Delvare
>> SUSE L3 Support
