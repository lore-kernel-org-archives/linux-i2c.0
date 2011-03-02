From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 2/6] ARM: pxa2xx: reorganize I2C files
Date: Wed, 02 Mar 2011 00:49:42 +0000
Message-ID: <4D6D9426.8030905@fluff.org>
References: <1298461100-14869-1-git-send-email-bigeasy@linutronix.de> <1298461100-14869-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298461100-14869-3-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 23/02/11 11:38, Sebastian Andrzej Siewior wrote:
> This patch moves the platform data definition from
> arch/arm/plat-pxa/include/plat/i2c.h to include/linux/i2c/pxa-i2c.h so
> it can be accessed from x86 the same way as on ARM.
>
> This change should make no functional change to the PXA code. The move
> is verified by building the following defconfigs:
>    cm_x2xx_defconfig corgi_defconfig em_x270_defconfig ezx_defconfig
>    imote2_defconfig pxa3xx_defconfig spitz_defconfig zeus_defconfig
>    raumfeld_defconfig magician_defconfig mmp2_defconfig pxa168_defconfig
>    pxa910_defconfig
>

Russell/others, you OK with this going through my tree?
