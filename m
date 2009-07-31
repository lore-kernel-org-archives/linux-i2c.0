From: Dongsoo Kim <dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: About a suspicious msleep during doxfer in s3c2410 i2c bus driver
Date: Fri, 31 Jul 2009 09:20:11 +0900
Message-ID: <D4080451-AD4C-4BA2-AEAE-2FC02B22C791@gmail.com>
References: <5e9665e10907220112m1dbf4975icf1511bc4ac3a1bf@mail.gmail.com> <20090722124333.GC7622@sirena.org.uk> <E724615E-9F06-4406-9852-041261C5DAA6@gmail.com> <20090722160639.GB14026@rakim.wolfsonmicro.main> <20090730221841.GG8850@fluff.org.uk>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=EUC-KR;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090730221841.GG8850-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org, ????????? <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ????????? <bhmin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dongsoo Kim <dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ?????? ??? <jsgood.yang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

2009. 07. 31, =BF=C0=C0=FC 7:18, Ben Dooks =C0=DB=BC=BA:

> On Wed, Jul 22, 2009 at 05:06:40PM +0100, Mark Brown wrote:
>> On Thu, Jul 23, 2009 at 12:58:52AM +0900, Dongsoo Kim wrote:
>>> 2009. 07. 22, ?????? 9:43, Mark Brown ??????:
>>
>>>> My *recollection* is that this is mostly there for multi-master
>>>> configurations.
>>
>>> I  wish I could answer clearly about this but not having much
>>> experience over various I2C bus devices so I can't say with a stric=
t
>>> "yes". But in my experience, I've never seen any i2c bus driver
>>> serving platform data to be configured with delay support. Tho if i=
t
>>> is really necessary for some specified class of i2c devices, we
>>> should make one.
>>
>> It wasn't for the client devices, it was for issues with =20
>> synchronisation
>> with the controller hardware.  I'm just going on the basis of
>> recollections of previous conversations with Ben here; I'm not sure =
=20
>> to
>> what extent this might be an issue with the way the hardware works
>> requiring the driver to jump through hoops.
>
> I think this has been in here for a while, and may well not be
> necessary any more. If anyone else has tested this without the
> msleep() here, then I'd be interested to know.
>
> I will try and sort out testing a few boards as soon as possible to
> see what is going on.
>

I've been tested without msleep on s3c64xx and also s5pc1xx. And it =20
went well.
What I'm concerned is s3c24xx because I had no chance to test on it.
Cheers,

Nate

>>> I'm wondering why anybody has been issued this topic yet. the drive=
r
>>> for s3c2410 i2c bus has been the way it is for ages I guess. It
>>> obviously seems to be taking long time to write down registers
>>> through the s3c2410 i2c bus driver than any other processor's i2c
>>> driver. maybe not so many people using enormous i2c register
>>> programming on Samsung processors could be the reason I suppose.
>>> anyway, let's figure it out the best way we can.
>>> Cheers,
>>
>> I expect most people would, like you, much rather just remove the =20
>> sleep
>> from the driver since in practice that seems to work well.  For =20
>> various
>> reasons the S3C community isn't all that active upstream which =20
>> doesn't
>> help with issues like this.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-=20
>> i2c" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --=20
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>
>  'a smiley only costs 4 bytes'
