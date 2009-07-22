From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: About a suspicious msleep during doxfer in s3c2410 i2c bus
	driver
Date: Wed, 22 Jul 2009 13:43:34 +0100
Message-ID: <20090722124333.GC7622@sirena.org.uk>
References: <5e9665e10907220112m1dbf4975icf1511bc4ac3a1bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5e9665e10907220112m1dbf4975icf1511bc4ac3a1bf-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Dongsoo, Nathaniel Kim" <dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org, ????????? <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ????????? <bhmin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dongsoo Kim <dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, jsgood.yang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 22, 2009 at 05:12:17PM +0900, Dongsoo, Nathaniel Kim wrote:

> Since I was working on S3C64XX and C1XX, I found something weird on
> I2C bus device.
> The thing is that when I try to write multiple registers through I2C
> bus, it takes much more time for multiple registers to be written than
> any other processor's i2c bus device.

Yes, this is extremely painful for a lot of devices - audio CODECs tend
to be noticably affected, especially at resume.  Depending on your
device and what you're doing you *may* be able to speed things up by
accessing many registers in a single I/O in the chip driver but
obviously that's not ideal.

> With several different target boards using s3c64xx and s5pc1xx, it
> went good without that msleep(). And of course it is working great
> with multiple i2c device attached as well.
> So, I want to ask Ben and anyone else using I2C device about removing
> that msleep might be ok or not. In my case, it went ok. Please let me
> know your opinion.

My *recollection* is that this is mostly there for multi-master
configurations.

I'm wondering if even if we can't remove the delay completely yet we
could add platform data to allow it to be configured on a per-board
basis?
