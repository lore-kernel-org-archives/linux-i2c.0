From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Tue, 26 Aug 2008 15:55:00 -0400
Message-ID: <9e4733910808261255v23b41f4dha3e345dc54529ca6@mail.gmail.com>
References: <200808251941.54964.david-b@pacbell.net>
	<9e4733910808252040j69b10ea8n1e3e40d16e86a3ae@mail.gmail.com>
	<200808261237.29870.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200808261237.29870.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 8/26/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Monday 25 August 2008, Jon Smirl wrote:
>  > On 8/25/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>  > > My own comments on this:
>  > >
>  > >         - I'd like to see at24.c use something running before
>  > >           device_initcall, so suitably configured system can
>  > >           have drivers calling platform_device_probe() from
>  > >           their own initcalls and yet have access to the config
>  > >           data from the EEPROMs.
>  > >
>  > >         - Seems to me that "struct at24_iface" should be more
>  > >           generic ... the same notion works for SPI eeproms,
>  > >           NVRAM as found in RTCs, etc.
>  > >
>  > >  Comments?
>  >
>  > Would it make sense to use bus notifiers to track the detection of a
>  > at24 chip?
>
>
> Not to me ... but then, I'm no fan of notifiers in such cases.
>  Some differences associated with these setup callbacks:
>
>   - Notifiers would have to poke at the parameters to sort
>     out (a) BUS_NOTIFY_BOUND_DRIVER (b) with a device bound
>     to this specific driver, and in fact (c) which specific
>     devices is involved, maybe platform_data pointer checks;
>     and then (d) use some API that the driver exports, which
>     implies (e) link-time dependencies.
>
>   - setup() can be chip-specific, eliminating (a,b,c);
>
>   - at24_iface just uses function pointers, eliminating (d,e).
>
>  Architecturally, the elimination of (d,e) seems significant;
>  but eliminating (a,b,c) is certainly convenient when writing
>  code to hook it all up!

Another solution is call_userspace_helper. GregKH convinced me to
change some things like this to small user space apps in the graphics
code. Is is easy to do the read/write from sysfs.

It doesn't say what driver it is that wants this capability. PC based
video and network cards want to do this but in those cases the i2c bus
is located on the card.

The embedded system I'm working could probably use this. The eeprom
holding the MAC address is on the RTC chip. There is no direct way
from the network driver to change the stored MAC address. I just set
it from uboot.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
