From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] i2c: davinci: Couple of patches to make i2c usable
 on Keystone SOCs
Date: Fri, 9 Aug 2013 16:09:34 -0400
Message-ID: <52054C7E.70108@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374712099-32095-1-git-send-email-santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram, Sekhar, 

On Wednesday 24 July 2013 08:28 PM, Santosh Shilimkar wrote:
> Keystone SOCs uses the same I2C IP as available on DaVinci SOCs. These
> couple of patches makes it possible to select the I2C_DAVINCI on
> Keystone SOCs.
> 
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> 
> Santosh Shilimkar (2):
>   i2c: davinci: remove useless mach/hardware include
>   i2c: davinci: Allow i2c driver available for keystone platforms
> 
Who is queuing up these patches ?

regards,
Santosh
