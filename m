From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] i2c-designware: Allow mixed endianness
Date: Thu, 21 Jan 2010 14:46:56 +0900
Message-ID: <4B57EA50.9050006@necel.com>
References: <20100119140234.689304000@octasic.com> <4B57E54D.8020909@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B57E54D.8020909-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Cc: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Shinya Kuribayashi wrote:
> Jean-Hugues Deschenes wrote:
>> This is the v2 version of the patch which adds support
>> for the i2c Designware controller when its endianness
>> differs from that of the cpu.
>>
>> ---
>> Changelog v1->v2
>> - rename i2c_dw_(read|write)l to dw_(read|write)l (Shinya Kuribayashi)
>> - rename dw_(read|write)l's addr argument to offset (Shinya Kuribayashi)
>> - replace (if constant == x) with (if x == constant) (Ben Dooks)
>> ---
>>
>>
>> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
> 
> All three patches look good, and work for my BE machines.
> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>

Oops, wrong tag.

Acked-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>

-- 
Shinya Kuribayashi
NEC Electronics
