From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c i2c-mv64xxx: send repeated START between
	messages in xfer
Date: Fri, 3 Dec 2010 02:30:20 +0000
Message-ID: <20101203023020.GE20097@trinity.fluff.org>
References: <1290787616-27106-1-git-send-email-giometti@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1290787616-27106-1-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 26, 2010 at 05:06:56PM +0100, Rodolfo Giometti wrote:
> As stated into file include/linux/i2c.h we must send a repeated START
> between messages in the same xfer groupset:

patch says 1/3, but only one turned up?
 
>  * Except when I2C "protocol mangling" is used, all I2C adapters implement
>  * the standard rules for I2C transactions.  Each transaction begins with a
>  * START.  That is followed by the slave address, and a bit encoding read
>  * versus write.  Then follow all the data bytes, possibly including a byte
>  * with SMBus PEC.  The transfer terminates with a NAK, or when all those
>  * bytes have been transferred and ACKed.  If this is the last message in a
>  * group, it is followed by a STOP.  Otherwise it is followed by the next
>  * @i2c_msg transaction segment, beginning with a (repeated) START.
> 
> Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> Signed-off-by: Mauro Barella <mbarella-RSoB1PSltFvQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c |   45 ++++++++++++++++++++++++++++++++------

Anyone got any commentson whether this is an -rc fix or for next merge
window... I'd be tempted to merge it as soon as possible.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
