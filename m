From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 17:27:51 -0700
Message-ID: <200806041727.51746.david-b@pacbell.net>
References: <20080604201334.19636f30@hyperion.delvare>
	<20080604233335.13459512@hyperion.delvare>
	<Pine.LNX.4.58.0806041638080.10290@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0806041638080.10290-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 04 June 2008, Trent Piepho wrote:
> Couldn't you say the probe function is called on a potential device? =A0T=
he
> probe function can return -ENODEV, in which can other driver's probes get
> called, and it's perfectly ok if no driver binds to it.
> =

> The way PCI works, is that when a new pci bus is created, each address is
> probed

... by config space accessors which all PCI devices support.


> and a device is created if anything responds. =A0The generic bus code =

> tries to match each device to a driver or drivers

... using a formally managed set of product identifiers.


>	 and calls those drivers' =

> probe functions. =A0The drivers don't have to claim the device in the pro=
be
> function. =A0The bus code handles all the cases of a driver or bus getting
> added or removed in various orders.
> =

> So why can't I2C do this too?

No such product identifiers, and in general no way to tell
what's sitting at a given address.  And in fact, there's no
sure way to tell if a device is present there, since when
an I2C device is busy, it's not required to ack its address.



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
