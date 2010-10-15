From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/2] Short timeout for I2C transfers
Date: Fri, 15 Oct 2010 14:51:49 +0200
Message-ID: <20101015145149.2f688c9d@endymion.delvare>
References: <1286977510-16702-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286977510-16702-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Samu,

On Wed, 13 Oct 2010 16:45:08 +0300, Samu Onkalo wrote:
> There are chips which doesn't work perfectly in certain
> I2C operations. For example lp5523 led driver chip causes
> always I2C timeout when SW reset is commanded to the chip.

The timeout is a symptom as the controller level. What is the root
cause at the LP5523 device level? What exactly happens on the wire?

I am asking because maybe some of the already available protocol
mangling flags would work for you, in particular I2C_M_IGNORE_NAK. See
Documentation/i2c/i2c-protocol.

> Patches add a possibility to tell that this access is likely
> to cause time out and there is no need to wait normal time.
> For example in omap time out is 1 second and the bus is reserved
> all the time.

You should ask yourself whether a 1 second timeout is a sane thing to
have in the first place.

You should also check why you hit the timeout condition. Ideally the
hardware would report problems as they happen, quickly, rather than
having to rely on the driver's timeout mechanism. The timeout should
really only be a safety mechanism, for when the bus controller itself
misbehaves at the hardware level.

> By setting I2C_M_SHORT_TIMEOUT flag to i2c-message, adapter is
> requested to use shorter timeout.
> 
> Samu Onkalo (2):
>   drivers: i2c-core: Add a flag to allow short timeout
>   drivers: i2c-omap: Add support for shorten I2C timeout
> 
>  drivers/i2c/busses/i2c-omap.c |    9 ++++++++-
>  drivers/i2c/i2c-core.c        |    2 +-
>  include/linux/i2c.h           |    1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)

I'm skeptical. If you know that the transfer will "fail" and you don't
care, why do you want to wait a short time, rather than not waiting at
all?

-- 
Jean Delvare
