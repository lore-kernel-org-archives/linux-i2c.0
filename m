From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
	interface protocol
Date: Wed, 15 Jul 2009 16:54:52 +0100
Message-ID: <20090715155452.GD18019@sirena.org.uk>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com> <4A5CB908.4060404@cam.ac.uk> <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com> <4A5D6C0A.7030903@gmx.de> <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com> <4A5DEB12.3020602@cam.ac.uk> <528f13590907150846o7f4e41daw4cd6e37ff3afef70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528f13590907150846o7f4e41daw4cd6e37ff3afef70-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 15, 2009 at 10:46:27AM -0500, alfred steele wrote:

> It does not have the "<linux/gpio.h>" and  the "<regulater/consumer.h>
>  which export
> regulator_register_notifier()/regulator_unregister_notifier() functions.
> So, i will have to look into how to backport this. THe gpio lib thing
> may be straightforward but i am way ignorant on  the regulator/pmic
> infrastructure. It would greatly help you can shed some light on the

The regulator API should backport simply by copying it over, all it uses
from the core kernel that I can recall is very basic stuff like mutexes
and lists.

> regulator part and if there is any quick way to get around to backport
> the regulator specific functions.
> Thanks in advance for your help!
> -Alfred.
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
