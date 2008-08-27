From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
 reading/writing EEPROM
Date: Tue, 26 Aug 2008 19:04:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0808261852580.2423@shell2.speakeasy.net>
References: <200808251941.54964.david-b@pacbell.net>
	<200808261237.29870.david-b@pacbell.net>
	<9e4733910808261255v23b41f4dha3e345dc54529ca6@mail.gmail.com>
	<200808261335.36103.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200808261335.36103.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 26 Aug 2008, David Brownell wrote:
> On Tuesday 26 August 2008, Jon Smirl wrote:
> > Another solution is call_userspace_helper. GregKH convinced me to
> > change some things like this to small user space apps in the graphics
> > code. Is is easy to do the read/write from sysfs.
>
> Some of us don't like the implication that the relevant hardware
> can't properly boot without initramfs/initrd tools.  Even if it
> doesn't need anything the least bit fancy like a RAID for rootfs.

Having the kernel use a userspace helper to read an eeprom via the kernel
eeprom driver does seem ridiculously round-about and overly complicated.

Lots of tv cards have eeproms with configuration information.  They use an
I2C driver called tveeprom that exports this:
int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int len)

> Last I heard, the U-Boot policy was not to touch controllers that are
> not required during boot.  Despite relatively common cases like needing
> to set up MAC addresses ... maybe this patch of Kevin's can make it a
> bunch easier to cope with that U-Boot policy.  :)

U-boot can put the MAC address into a property of the MAC's device node in
the OF device tree (which u-boot passes to the kernel).  The Linux mac
driver can then use that to set the address.  U-boot doesn't actually need
to touch the mac.  It does need to read the eeprom then (which could store
u-boot environment).

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
