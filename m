From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 17:40:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0806041731250.10290@shell4.speakeasy.net>
References: <20080604201334.19636f30@hyperion.delvare>
	<20080604233335.13459512@hyperion.delvare>
	<Pine.LNX.4.58.0806041638080.10290@shell4.speakeasy.net>
	<200806041727.51746.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6092975972831826037=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806041727.51746.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--===============6092975972831826037==
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 4 Jun 2008, David Brownell wrote:
> On Wednesday 04 June 2008, Trent Piepho wrote:
> > Couldn't you say the probe function is called on a potential device? =
=A0The
> > probe function can return -ENODEV, in which can other driver's probes g=
et
> > called, and it's perfectly ok if no driver binds to it.
> >
> > The way PCI works, is that when a new pci bus is created, each address =
is
> > probed
>
> ... by config space accessors which all PCI devices support.

PCI is not immune to broken hardware.  It's much better than I2C of course,
which doesn't even have a scanning method devices are supposed to follow.

> > and a device is created if anything responds. =A0The generic bus code
> > tries to match each device to a driver or drivers
>
> ... using a formally managed set of product identifiers.

There are plenty of PCI devices with broken ids.

> >=09 and calls those drivers'
> > probe functions. =A0The drivers don't have to claim the device in the p=
robe
> > function. =A0The bus code handles all the cases of a driver or bus gett=
ing
> > added or removed in various orders.
> >
> > So why can't I2C do this too?
>
> No such product identifiers, and in general no way to tell
> what's sitting at a given address.  And in fact, there's no
> sure way to tell if a device is present there, since when
> an I2C device is busy, it's not required to ack its address.

So scanning an I2C bus doesn't work as well as with PCI, we all know that.
How does creating a new "i2c listeners" system solve any of these problems?
You still want to probe for a chip and there's no foolproof way to do that,
and there's still no way to know for sure what chip you have found.


--===============6092975972831826037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============6092975972831826037==--
