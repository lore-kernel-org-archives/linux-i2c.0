From: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c/chips: move max6875 to drivers/misc/eeprom
Date: Sat, 02 May 2009 06:41:19 -0500
Message-ID: <49FC315F.2060409@gmail.com>
References: <1241209409-29378-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1241209409-29378-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
> This driver only reads the user EEPROM of that chip, so we can move it
> to the eeprom-directory in order to further clean up (and later remove)
> drivers/i2c/chips.
> 
> The Kconfig text was updated to match the current functionality,
> dropping the meanwhile obsoleted parts.
> 
> Defconfigs have been adapted.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
> This is against linus-git of today. Jean, do you think such a patch 
> can make it at this point of the release cycle? It is a bit
> annoying because of all the defconfigs.
> 
> Ben, are you fine with these changes?

I'm fine with the changes.
Thanks for taking care of this.

Ben
