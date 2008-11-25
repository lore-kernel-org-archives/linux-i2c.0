From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.28-rc5] i2c:  remove i2c_adapter.clist_lock
Date: Tue, 25 Nov 2008 10:12:03 +0100
Message-ID: <20081125101203.58e3f032@hyperion.delvare>
References: <200811201438.08788.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811201438.08788.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 20 Nov 2008 14:38:08 -0800, David Brownell wrote:
> From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> 
> Move list add/remove operations now protected by i2c_adapter.clist_lock
> into the driver model probe() and remove() calls, where driver model
> locking protects them.  This is a minor code and data shrink.
> 
> Note that the adapter "child list" is still protected inconsistently;
> this patch just simplifies locking, and makes this list more directly
> mirror the one maintained by the driver model.  Removing this list may
> need to wait until the legacy I2C driver binding model is removed.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   17 ++++-------------
>  include/linux/i2c.h    |    1 -
>  2 files changed, 4 insertions(+), 14 deletions(-)

I'm not sure I want to take this change at this point. Call me chicken,
but I seem to recall problems with legacy i2c clients last time we
tried to clean up this area. So I'd rather work on killing the legacy
binding model now, and once this is done, we can look into i2c-core
cleanups again.

The list of i2c drivers that still need to be converted can be found
here:
http://jdelvare.pck.nerim.net/linux/legacy_i2c_driver.list

Drivers that are neither marked "*" (done) nor "-" (deleted) are left
to convert.

Thanks,
-- 
Jean Delvare
