From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Tue, 26 Aug 2008 12:37:29 -0700
Message-ID: <200808261237.29870.david-b@pacbell.net>
References: <200808251941.54964.david-b@pacbell.net>
	<9e4733910808252040j69b10ea8n1e3e40d16e86a3ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910808252040j69b10ea8n1e3e40d16e86a3ae-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Monday 25 August 2008, Jon Smirl wrote:
> On 8/25/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > My own comments on this:
> >
> >         - I'd like to see at24.c use something running before
> >           device_initcall, so suitably configured system can
> >           have drivers calling platform_device_probe() from
> >           their own initcalls and yet have access to the config
> >           data from the EEPROMs.
> >
> >         - Seems to me that "struct at24_iface" should be more
> >           generic ... the same notion works for SPI eeproms,
> >           NVRAM as found in RTCs, etc.
> >
> >  Comments?
> 
> Would it make sense to use bus notifiers to track the detection of a
> at24 chip? 

Not to me ... but then, I'm no fan of notifiers in such cases.
Some differences associated with these setup callbacks:
 
  - Notifiers would have to poke at the parameters to sort
    out (a) BUS_NOTIFY_BOUND_DRIVER (b) with a device bound
    to this specific driver, and in fact (c) which specific
    devices is involved, maybe platform_data pointer checks;
    and then (d) use some API that the driver exports, which
    implies (e) link-time dependencies.

  - setup() can be chip-specific, eliminating (a,b,c);

  - at24_iface just uses function pointers, eliminating (d,e).

Architecturally, the elimination of (d,e) seems significant;
but eliminating (a,b,c) is certainly convenient when writing
code to hook it all up!

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
