From: Jack Daniel <wanders.thirst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/6] i2c: davinci updates for 2.6.35
Date: Wed, 14 Jul 2010 21:04:49 +0530
Message-ID: <AANLkTilL-nD_QVXPGqQbqJMmCNrQvPo_jrKfSrZyDqNb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 19, 2010 at 5:06 PM, Ben Dooks <ben-li...-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Tue, Apr 06, 2010 at 10:42:12AM -0700, Kevin Hilman wrote:
>> This series of davinci I2C driver updates and fixes is targetted for
>> 2.6.35.  It has been tested in davinci git on multiple davinci SoCs.
>>
>> Ben, since these changes are isolated to the davinci driver only, if
>> you prefer I can merge them upstream along with my davinci changes for
>> 2.6.35.
>
> I'll get them into -next when I rebase it.

>Ben, this series never made it in for 2.6.35.

>I've now rebased this against v2.6.35-rc3 and it's available here:

>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
>davinci-i2c

>Please pull for 2.6.36.  Thanks.

>Kevin

Would like to know when this bug fix "i2c: davinci: Fix smbus Oops
with AIC33 usage" will be included? I can't find it in the 2.6.35-rc5
of Linus tree.

Cheers,
Jack
