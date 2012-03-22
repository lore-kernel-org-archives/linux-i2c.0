From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Dynamically assign adapter id if it wasn't explictly
 specified
Date: Thu, 22 Mar 2012 11:07:35 -0700
Message-ID: <4F6B6A67.7040905@gmail.com>
References: <1331900343-6743-1-git-send-email-k.lewandowsk@samsung.com> <1331900343-6743-3-git-send-email-k.lewandowsk@samsung.com> <4F6B4532.7090806@samsung.com> <4F6B5A22.1090204@cavium.com> <4F6B65D0.1030506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F6B65D0.1030506-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rade Bozic <rade.bozic.ext-OYasijW0DpE@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Daney, David" <David.Daney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/22/2012 10:48 AM, Karol Lewandowski wrote:
> On 22.03.2012 17:58, David Daney wrote:
>
[...]

>>>> diff --git a/drivers/i2c/busses/i2c-octeon.c
>>>> b/drivers/i2c/busses/i2c-octeon.c
>>>> index ee139a5..8470232 100644
>>>> --- a/drivers/i2c/busses/i2c-octeon.c
>>>> +++ b/drivers/i2c/busses/i2c-octeon.c
>>>> @@ -581,7 +581,7 @@ static int __devinit octeon_i2c_probe(struct
>>>> platform_device *pdev)
>>>>
>>>>        i2c->adap = octeon_i2c_ops;
>>>>        i2c->adap.dev.parent =&pdev->dev;
>>>> -    i2c->adap.nr = pdev->id>= 0 ? pdev->id : 0;
>>>> +    i2c->adap.nr = pdev->id;
>>
>> I guess the OCTEON bit seems sane enough.  I don't fully understand why
>> this needs changing, because OCTEON platform code always passes a
>> non-negative pdev->id.
>
>
> i2c controllers instantiated from device tree seem to have -1 as id.
> Thus, trying to register more than one controller will fail as both
> will try to register on bus 0.
>
> However, I've just found that you got rid of this line altogether and
> switched to dynamic id allocation (i2c_add_adapter() instead of
> _numbered_ variant) in "MIPS: Octeon: Use Device Tree." RFC.
> Found here:
>
>    http://thread.gmane.org/gmane.linux.kernel/1104062
>
> In the light of above my (octeon-)fixup becomes redundant.
>
> Shall I repost this patch without octeon changes or is ok anyway?

My preference would be to omit the OCTEON portion from your patch.  As 
you noted, I plan to blow all that code away in the very near future, 
and the patch is not needed for correctness as far as I can see.

David Daney


>
> Thanks!
>
>>   But since you asked for it:
>>
>> Acked-by: David Daney<david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
