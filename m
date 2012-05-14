From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device Tree
Date: Mon, 14 May 2012 16:18:33 +0000
Message-ID: <201205141618.33954.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <20120507170832.GO17002@opensource.wolfsonmicro.com> <4FB12981.8050603@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FB12981.8050603-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 14 May 2012, Lee Jones wrote:
> > You should be using of_regulator_match() for this (I think it's supposed
> > to do an equivalent job...) rather than open coding.
> 
> I've ripped this out completely and the code appears to continue be 
> fully functional. Happy days! :)

Ok, very good!

Of course it would still be helpful to understand the reasons of
the person putting that code in originally, but I'm at least comfortable
with leaving it out for now, and fixing any problems we see in a proper
way after your code is merged.


	Arnd
