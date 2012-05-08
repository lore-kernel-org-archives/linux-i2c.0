From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device Tree
Date: Tue, 8 May 2012 14:36:46 +0000
Message-ID: <201205081436.46471.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <201205081348.14269.arnd@arndb.de> <20120508142926.GT15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120508142926.GT15893-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 08 May 2012, Mark Brown wrote:
> On Tue, May 08, 2012 at 01:48:14PM +0000, Arnd Bergmann wrote:
> > On Tuesday 08 May 2012, Lee Jones wrote:
> 
> > > I did run this past Arnd before writing the code and he agreed that this 
> > > would be suitable; however, if you know of a better way in which I can 
> > > do this, I'd be pleased to hear of it.
> 
> > It was the best approach that I could think of for this, but I'm also
> > a total newbie on regulators.
> 
> It's not really a regulator thing, what the code is doing is blasting in
> a bunch of magic register writes to set things up, some of which are
> configuring things that the subsystem already knows how to configure.

Right, which is what the driver has done since 79568b9412 "regulator:
initialization for ab8500 regulators" with your ack, so we decided not
to change that and simply move the init data from platform code
to the device tree.

	Arnd
