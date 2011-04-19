From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] misc: Driver for Silicon Labs Si570 and compatibles
Date: Tue, 19 Apr 2011 13:19:50 -0700
Message-ID: <20110419201950.GA9725@suse.de>
References: <1303245022-5765-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1303245022-5765-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 19, 2011 at 01:30:22PM -0700, Guenter Roeck wrote:
> This driver adds support for Si570, Si571, Si598, and Si599
> programmable XO/VCXO.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/misc-devices/si570 |   61 ++++++
>  MAINTAINERS                      |    7 +
>  drivers/misc/Kconfig             |   10 +
>  drivers/misc/Makefile            |    1 +
>  drivers/misc/si570.c             |  398 ++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/si570.h        |   23 +++

This file should be in include/linux/platform_data/, right?

And as you have created sysfs files, you need to also provide the proper
Documentation/ABI/ files. Please add them in your next resend of this
patch.

Also, please run your patch through scripts/checkpatch.pl before sending
it out, and fix the issues it finds, otherwise people will just repeat
them here, which is boring...

thanks,

greg k-h
