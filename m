From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device Tree
Date: Tue, 8 May 2012 13:48:14 +0000
Message-ID: <201205081348.14269.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <20120508121940.GL15893@opensource.wolfsonmicro.com> <4FA913BA.30908@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA913BA.30908-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 08 May 2012, Lee Jones wrote:
> This piece of code plucks pre-defined initialisation values and from the 
> Device Tree and uses them to set-up regulator related registers on the 
> u8500. See 'struct ab8500_regulator_reg_init ab8500_regulator_reg_init' 
> in arch/arm/mach-ux500/board-mop500-regulators.c for reference.
> 
> I did run this past Arnd before writing the code and he agreed that this 
> would be suitable; however, if you know of a better way in which I can 
> do this, I'd be pleased to hear of it.

It was the best approach that I could think of for this, but I'm also
a total newbie on regulators.

	Arnd
