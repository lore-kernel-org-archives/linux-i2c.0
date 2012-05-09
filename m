From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core driver
Date: Wed, 9 May 2012 11:56:00 +0000
Message-ID: <201205091156.00322.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-12-git-send-email-lee.jones@linaro.org> <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Mattias WALLIN <mattias.wallin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 09 May 2012, Linus Walleij wrote:
> > +       else if (np)
> > +               ret = of_property_read_u32(np, "stericsson,irq-base", &ab8500->irq_base);
> > +
> > +       if (ab8500->irq_base == 0) {
> 
> Shouldn't this be (av8500->irq_base == NO_IRQ) now that we're tranisitioning to
> use 0 as NO_IRQ?

Since we're into bike-shedding already, why not make it :? :-)

	if (!ab8500->irq_base)

I usually prefer this syntax for testing if something has been assigned,
while I use a comparison with 0 only when it is a meant as a numeric value
rather than meant as validity test.

	Arnd
