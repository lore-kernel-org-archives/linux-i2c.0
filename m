From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 01:15:08 -0700
Message-ID: <200806050115.08953.david-b@pacbell.net>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041914.27291.david-b@pacbell.net>
	<Pine.LNX.4.58.0806042349251.10290@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0806042349251.10290-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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

On Thursday 05 June 2008, Trent Piepho wrote:.
> 
> > PCI was designed explicitly for automatic configuration.
> > I2C was not.
> >
> >
> > > How does creating a new "i2c listeners" system solve any of these problems?
> >
> > That's an entirely different (and unrelated) question.
> 
> For a thread on the subject "Introduce i2c listeners", I don't think so.

For the subthread on why I2C can't scan like PCI ... it
sure seemed to me like it was!  But ok, you maybe weren't
focussed on that subthread.


> When I first saw the patch, I wondered why exsting driver model couldn't
> handle it.  It looks like Jon thought the same thing.  No one ever said
> scanning/probing/identifying/whatever an I2C bus worked as well as it does
> on a bus like PCI.  But I don't see why that prevents the driver model from
> being used.

Well, without commenting on these new listeners/notifiers ...

All I can observe is that what the driver model provides is just
the framework through which the device enumeration is exposed.

That device enumeration is bus-specific.  It can build on hardware
for device identification (as with USB and PCI) and maybe hotplug
(USB, and PCI flavors like Cardbus and hotplug PCI).  Or it can
build on software tables, as in PNPACPI and OpenFirmware.  You can
view cases like USB and PCMCIA cards (8/16 bits) as being hybrid:
hotplug hardware, combined with software tables in the device.

The I2C problem has been that hardware conventions can't work in
general, so Linux has had to come up with its own conventions for
software tables.

If nothing else, we have an existence proof (in "new style" I2C
drivers) that we *can* use the driver model with I2C.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
