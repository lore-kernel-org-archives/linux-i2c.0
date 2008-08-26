From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Tue, 26 Aug 2008 13:35:35 -0700
Message-ID: <200808261335.36103.david-b@pacbell.net>
References: <200808251941.54964.david-b@pacbell.net>
	<200808261237.29870.david-b@pacbell.net>
	<9e4733910808261255v23b41f4dha3e345dc54529ca6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910808261255v23b41f4dha3e345dc54529ca6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 26 August 2008, Jon Smirl wrote:
> 
> Another solution is call_userspace_helper. GregKH convinced me to
> change some things like this to small user space apps in the graphics
> code. Is is easy to do the read/write from sysfs.

Some of us don't like the implication that the relevant hardware
can't properly boot without initramfs/initrd tools.  Even if it
doesn't need anything the least bit fancy like a RAID for rootfs.


> It doesn't say what driver it is that wants this capability. PC based
> video and network cards want to do this but in those cases the i2c bus
> is located on the card.
> 
> The embedded system I'm working could probably use this. The eeprom
> holding the MAC address is on the RTC chip. There is no direct way
> from the network driver to change the stored MAC address. I just set
> it from uboot.

In this case, manufacturing assigns the MAC address by writing it into
part of the EEPROM.  Board-specific code can know which part, and then
this patch lets it read the address and hand it to the MAC driver.

Last I heard, the U-Boot policy was not to touch controllers that are
not required during boot.  Despite relatively common cases like needing
to set up MAC addresses ... maybe this patch of Kevin's can make it a
bunch easier to cope with that U-Boot policy.  :)

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
