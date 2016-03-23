From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] i2c: Prevent endless uevent loop with dev_dbg
Date: Wed, 23 Mar 2016 17:35:38 +0100
Message-ID: <56F2C5DA.9070805@nokia.com>
References: <1458748247-9219-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:39568 "EHLO
	demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbcCWQfn (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Mar 2016 12:35:43 -0400
In-Reply-To: <1458748247-9219-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: EXT Jan Glauber <jglauber@cavium.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

Hi!

On 23/03/16 16:50, EXT Jan Glauber wrote:
> After enabling CONFIG_I2C_DEBUG_CORE my system was broken
> (no network, console login not possible). System log was
> flooded with the this message:
> 
>  ...
> [  608.052077] rtc-ds1307 0-0068: uevent
> [  608.052500] rtc-ds1307 0-0068: uevent
> [  608.052925] rtc-ds1307 0-0068: uevent
>  ...
> 
> The culprit is the dev_dbg printk in the i2c uevent handler.
> If this is activated (for instance by CONFIG_I2C_DEBUG_CORE)
> it results in an endless loop with systemd-journald.
> 
> This happens if user-space scans the system log and reads the uevent
> file to get information about a newly created device, which seems fair
> use to me. Unfortunately reading the "uevent" file uses the same
> function that runs for creating the uevent for a new device,
> generating the next syslog entry.
> 
> Ideally user-space would implement a recursion detection and
> after reading the same device file for the 1000th time call it a
> day, but nevertheless I think we should avoid this problem by
> removing the debug print completly or using another print variant.
> 
> The same problem seems to be reported here:
> https://bugs.freedesktop.org/show_bug.cgi?id=76886
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Yes, this is evil thing. Both components do legal stuff, but someone has
to stop this madness... I've analyzed journald code and it will suffer
from removing this uevent access and I see no easy way how to provide the
same level of information about the device in the log.
On the other hand the fix in the Kernel is trivial and we have no information
loss.
Maybe it deserves a comment, so that this call is not changed back at some
point in the future. But, in general:

Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  drivers/i2c/i2c-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 0f2f848..84165d9 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -539,7 +539,7 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	if (add_uevent_var(env, "MODALIAS=%s%s",
>  			   I2C_MODULE_PREFIX, client->name))
>  		return -ENOMEM;
> -	dev_dbg(dev, "uevent\n");
> +	pr_debug("uevent: device: %s\n", dev_name(dev));
>  	return 0;
>  }
