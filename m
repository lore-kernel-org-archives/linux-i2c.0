From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: About a suspicious msleep during doxfer in s3c2410 i2c bus
 driver
Date: Wed, 22 Jul 2009 17:06:40 +0100
Message-ID: <20090722160639.GB14026@rakim.wolfsonmicro.main>
References: <5e9665e10907220112m1dbf4975icf1511bc4ac3a1bf@mail.gmail.com>
 <20090722124333.GC7622@sirena.org.uk>
 <E724615E-9F06-4406-9852-041261C5DAA6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E724615E-9F06-4406-9852-041261C5DAA6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dongsoo Kim <dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org, ????????? <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ????????? <bhmin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dongsoo Kim <dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?utf-8?B?7KeE7ISxIOyWkQ==?= <jsgood.yang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 23, 2009 at 12:58:52AM +0900, Dongsoo Kim wrote:
> 2009. 07. 22, =EC=98=A4=ED=9B=84 9:43, Mark Brown =EC=9E=91=EC=84=B1:

> >My *recollection* is that this is mostly there for multi-master
> >configurations.

> I  wish I could answer clearly about this but not having much
> experience over various I2C bus devices so I can't say with a strict
> "yes". But in my experience, I've never seen any i2c bus driver
> serving platform data to be configured with delay support. Tho if it
> is really necessary for some specified class of i2c devices, we
> should make one.

It wasn't for the client devices, it was for issues with synchronisatio=
n
with the controller hardware.  I'm just going on the basis of
recollections of previous conversations with Ben here; I'm not sure to
what extent this might be an issue with the way the hardware works
requiring the driver to jump through hoops.

> I'm wondering why anybody has been issued this topic yet. the driver
> for s3c2410 i2c bus has been the way it is for ages I guess. It
> obviously seems to be taking long time to write down registers
> through the s3c2410 i2c bus driver than any other processor's i2c
> driver. maybe not so many people using enormous i2c register
> programming on Samsung processors could be the reason I suppose.
> anyway, let's figure it out the best way we can.
> Cheers,

I expect most people would, like you, much rather just remove the sleep
from the driver since in practice that seems to work well.  For various
reasons the S3C community isn't all that active upstream which doesn't
help with issues like this.
