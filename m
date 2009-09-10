From: Bart Van Assche <bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c/chips: Remove deprecated pcf8575-driver
Date: Thu, 10 Sep 2009 12:52:17 +0200
Message-ID: <e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	 <1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1252531371-14866-3-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 9, 2009 at 11:22 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
>
> The pcf8575-driver in drivers/i2c/chips which just exports its regist=
er to
> sysfs is superseeded by drivers/gpio/pcf857x.c which properly uses th=
e gpiolib.
> As this driver has been deprecated for more than a year, finally remo=
ve it.
>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Bart Van Assche <bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> =A0Documentation/i2c/chips/pcf8575 | =A0 69 --------------
> =A0drivers/i2c/chips/Kconfig =A0 =A0 =A0 | =A0 18 ----
> =A0drivers/i2c/chips/Makefile =A0 =A0 =A0| =A0 =A01 -
> =A0drivers/i2c/chips/pcf8575.c =A0 =A0 | =A0198 ---------------------=
------------------
> =A04 files changed, 0 insertions(+), 286 deletions(-)
> =A0delete mode 100644 Documentation/i2c/chips/pcf8575
> =A0delete mode 100644 drivers/i2c/chips/pcf8575.c

This patch removes the documentation file
Documentation/i2c/chips/pcf8575 while there is no documentation under
Documentation/ for the drivers/gpio/pcf857x.c driver. Shouldn't proper
documentation for the pcf857x driver be added to the kernel tree
before the pcf8575 driver is removed ?

Bart.
