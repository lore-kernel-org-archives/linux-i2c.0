From: "Andrew Victor" <avictor.za-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC: 2.6 patch] remove the i2c-at91.c driver
Date: Thu, 4 Sep 2008 20:55:56 +0200
Message-ID: <cd73a99e0809041155m1f9e576dt5659da679fffb56d@mail.gmail.com>
References: <20080831161005.GC3695@cs181140183.pp.htv.fi>
	<cd73a99e0809010613w40569b3fv9f5fc96a7bfb6a29@mail.gmail.com>
	<20080902101127.GJ2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080902101127.GJ2716-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

hi Ben,

>> This driver should be usable on the new AT91SAM9G20 processor.
>> Atmel have supposidly resolved all the hardware issues that caused
>> this driver to fail.
>
> Then would it be possible to have a patch to update the driver's
> help text, and possibly update the Kconfig to reflect the dependency
> on having working silicon?

I think the help text at the moment is pretty clear that the driver is
marked as broken.
All the in-kernel boards now by default use the bit-banging driver.

I don't actually have G20 hardware to test it on, but until
somebody/Atmel have verified if this driver works or not, I'd prefer
to just to leave it as broken.
If it still doesn't work, then just remove all references to the driver.


Regards,
  Andrew Victor

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
