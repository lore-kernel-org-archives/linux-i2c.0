From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 01/13] i2c: bcm2835: Use devm_request_irq()
Date: Tue, 17 Dec 2013 19:21:05 -0700
Message-ID: <52B10691.2010105@wwwdotorg.org>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com> <001d01cefaf3$b743e4c0$25cbae40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <001d01cefaf3$b743e4c0$25cbae40$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 12/16/2013 11:46 PM, Jingoo Han wrote:
> Use devm_request_irq() to make cleanup paths simpler.

This may not be safe. The interrupt used by the I2C controllers on the
BCM2835 chip is shared between two controllers. In theory, you could run
into a condition where you're remove()ing the driver for one of the
controller (a), while the driver for controller (b) is still active, yet
the HW for controller (a) comes along and triggers an interrupt after
remove() but before the devm IRQ cleanup. That would result in the IRQ
handler for controller (a) executing after the remove() of the
associated device, which could cause a variety of problems.

You might be able to make this safe by explicitly clearing any IRQ
enable registers in remove(), but leaving the code using plain
request_irq() might be simpler.
