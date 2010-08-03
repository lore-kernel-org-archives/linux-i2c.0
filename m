From: Jack Daniel <wanders.thirst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: davinci updates for 2.6.35
Date: Tue, 3 Aug 2010 12:58:40 +0530
Message-ID: <AANLkTim=w1VPYPZe62sEdakUDHASFy0EUruRT4z4cpqA@mail.gmail.com>
References: <AANLkTilL-nD_QVXPGqQbqJMmCNrQvPo_jrKfSrZyDqNb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTilL-nD_QVXPGqQbqJMmCNrQvPo_jrKfSrZyDqNb-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Wed, Jul 14, 2010 at 9:04 PM, Jack Daniel <wanders.thirst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
> On Mon, Apr 19, 2010 at 5:06 PM, Ben Dooks <ben-li...-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrot=
e:
>> On Tue, Apr 06, 2010 at 10:42:12AM -0700, Kevin Hilman wrote:
>>> This series of davinci I2C driver updates and fixes is targetted fo=
r
>>> 2.6.35. =A0It has been tested in davinci git on multiple davinci So=
Cs.
>>>
>>> Ben, since these changes are isolated to the davinci driver only, i=
f
>>> you prefer I can merge them upstream along with my davinci changes =
for
>>> 2.6.35.
>>
>> I'll get them into -next when I rebase it.
>
>>Ben, this series never made it in for 2.6.35.
>
>>I've now rebased this against v2.6.35-rc3 and it's available here:
>
>> =A0 git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davi=
nci.git
>>davinci-i2c
>
>>Please pull for 2.6.36. =A0Thanks.
>
>>Kevin
>
> Would like to know when this bug fix "i2c: davinci: Fix smbus Oops
> with AIC33 usage" will be included? I can't find it in the 2.6.35-rc5
> of Linus tree.

This has not made it to 2.6.35, pray tell what might be the reason for
its non-inclusion? Your tree is still at 2.6.34-rc5, are you not
taking any more patches? You did not reply to my previous mail,
perhaps you did not like the fact that I use a forwarded mail ? This
was because I did not subscribe to the i2c mailing list and had to
copy the message. I know of no other way.

Thanks and regards,
Jack.
