From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: About a suspicious msleep during doxfer in s3c2410 i2c bus driver
Date: Mon, 3 Aug 2009 09:04:14 +0100
Message-ID: <20090803080414.GF16303@trinity.fluff.org>
References: <5e9665e10907220112m1dbf4975icf1511bc4ac3a1bf@mail.gmail.com> <20090722124333.GC7622@sirena.org.uk> <E724615E-9F06-4406-9852-041261C5DAA6@gmail.com> <20090722160639.GB14026@rakim.wolfsonmicro.main> <20090730221841.GG8850@fluff.org.uk> <878wi5wa4z.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878wi5wa4z.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Dongsoo Kim <dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org, ????????? <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ????????? <bhmin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dongsoo Kim <dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ?????? ??? <jsgood.yang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 31, 2009 at 10:05:00AM +0200, Peter Korsgaard wrote:
> >>>>> "Ben" == Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:
> 
> Hi,
> 
>  >> It wasn't for the client devices, it was for issues with
>  >> synchronisation with the controller hardware.  I'm just going on
>  >> the basis of recollections of previous conversations with Ben
>  >> here; I'm not sure to what extent this might be an issue with the
>  >> way the hardware works requiring the driver to jump through hoops.
> 
>  Ben> I think this has been in here for a while, and may well not be
>  Ben> necessary any more. If anyone else has tested this without the
>  Ben> msleep() here, then I'd be interested to know.
> 
> I'll test on my 6410 board over the weekend. Notice that I've been
> hacking on the uboot drivers/i2c/s3c24x0_i2c.c file to add s3c64xx
> support, and I there had to add a udelay before setting the start
> condition to get it to work stable.

does it check for bus busy before starting?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
