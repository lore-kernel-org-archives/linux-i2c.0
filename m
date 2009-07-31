From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: About a suspicious msleep during doxfer in s3c2410 i2c bus
	driver
Date: Fri, 31 Jul 2009 13:32:14 +0100
Message-ID: <20090731123213.GD17091@sirena.org.uk>
References: <5e9665e10907220112m1dbf4975icf1511bc4ac3a1bf@mail.gmail.com> <20090722124333.GC7622@sirena.org.uk> <E724615E-9F06-4406-9852-041261C5DAA6@gmail.com> <20090722160639.GB14026@rakim.wolfsonmicro.main> <20090730221841.GG8850@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090730221841.GG8850-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Dongsoo Kim <dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org, ????????? <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ????????? <bhmin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dongsoo Kim <dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ?????? ??? <jsgood.yang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 30, 2009 at 11:18:41PM +0100, Ben Dooks wrote:

> I think this has been in here for a while, and may well not be
> necessary any more. If anyone else has tested this without the
> msleep() here, then I'd be interested to know.

I didn't notice any issues when I tested on s3c64xx systems but this
wasn't a particularly scientific test.
