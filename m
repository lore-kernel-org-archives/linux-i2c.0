From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c: davinci: Fix problems discovered on Keystone
 CPU
Date: Wed, 11 Mar 2015 20:35:29 +0200
Message-ID: <55008AF1.80405@linaro.org>
References: <55003E60.3070306@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55003E60.3070306-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/11/2015 03:08 PM, Alexander Sverdlin wrote:
> During intensive I2C tests on Keystone CPU we've discovered several problems
> with the i2c-davinci driver. Maybe Keystone is the first relatively powerful CPU
> utilizing davinci controller and therefore the races in the driver became more
> obvious, but it's clear that many users had problems with the driver and even
> though driver has received many band aids over the years, nobody addressed the
> original racy design.
> 
> The series address the follwing problems:
> "i2c: davinci: Rework racy ISR" -- stop the parallel activities in the driver
> including concurrect registers access. Also simplifies the design and removes
> some bad aids.
> "i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()" -- the routine is
> over-designed and instead of "waiting" will trigger the bus recovering
> immediately.
> "i2c: davinci: Avoid sending to own address" -- works around one davinci
> controller issue when it unexpectedly switches to some sort of slave mode
> trying to send to its own address. The controller remains in this locked state
> until reset, so it's better to avoid this situation than to deal with transfer
> timeouts.
> 


Have you used git format-patch --cover-letter?
Overall stats and list of patches are missing.

Also I think It'll be better to send patches 2/3 first, as
they have more chances to be merged. 

regards,
-grygorii
