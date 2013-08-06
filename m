From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Tue, 06 Aug 2013 14:05:24 +0200
Message-ID: <5200E684.5080003@free-electrons.com>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com> <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com> <20130716080503.GA3125@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130716080503.GA3125@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 16/07/2013 10:05, Maxime Ripard wrote:
> Hi Gregory,
> 
> On Mon, Jul 15, 2013 at 04:24:36PM +0200, Gregory CLEMENT wrote:
>> The I2C Transaction Generator offloads CPU from managing I2C transfer step by step.
>> 
>> This feature is currently only available on Armada XP, so usage of this mechanism is activated through device tree.
>> 
>> Based on the work of Piotr Ziecik and rewrote to use the new way of handling multiples i2c messages.
>> 
>> Signed-off-by: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> --- drivers/i2c/busses/i2c-mv64xxx.c | 207
>> ++++++++++++++++++++++++++++++++++++--- 1 file changed, 196 insertions(+), 11 deletions(-)
> 
> [...]
> 
>> +	/* +	 * For controllers embedded in new SoCs activate the +	 * Transaction Generator support. +	 */ +	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) +
>> drv_data->offload_enabled = true; +
> 
> Do you have a reason for not adding it to the match table? I mean, you will introduce a new compatible here, but if that compatible is used alone, won't probe the driver? That doesn't
> seem very right to me.

But we shouldn't use it alone: we should always use:
compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";

>From my point of view using  "marvell,mv78230-i2c" alone is an error.

Wolfram what is your opinion on it?


> 
> Also, you should probably add it to the bindings documentation.
See the patch 3 for the bindings documentation.

> 
> Maxime
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
