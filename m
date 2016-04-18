From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Mon, 18 Apr 2016 08:20:11 -0700
Message-ID: <1460992811.8946.22.camel@linux.intel.com>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
	 <20160415080111.GD1714@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53648 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbcDRPTp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 18 Apr 2016 11:19:45 -0400
In-Reply-To: <20160415080111.GD1714@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, wsa@the-dreams.de, laurent.pinchart@ideasonboard.com, lars@metafoo.de, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>

On Fri, 2016-04-15 at 11:01 +0300, Mika Westerberg wrote:
> +Srinivas
>=20
> On Sun, Jan 31, 2016 at 04:33:00PM +0100, Jean-Michel Hautbois wrote:
> >=20
> > Some I2C devices have multiple addresses assigned, for example each
> > address
> > corresponding to a different internal register map page of the
> > device.
> > So far drivers which need support for this have handled this with a
> > driver
> > specific and non-generic implementation, e.g. passing the
> > additional address
> > via platform data.
> >=20
> > This patch provides a new helper function called
> > i2c_new_secondary_device()
> > which is intended to provide a generic way to get the secondary
> > address
> > as well as instantiate a struct i2c_client for the secondary
> > address.
> >=20
> > The function expects a pointer to the primary i2c_client, a name
> > for the secondary address and an optional default address. The name
> > is used
> > as a handle to specify which secondary address to get.
> >=20
> > The default address is used as a fallback in case no secondary
> > address
> > was explicitly specified. In case no secondary address and no
> > default
> > address were specified the function returns NULL.
> >=20
> > For now the function only supports look-up of the secondary address
> > from devicetree, but it can be extended in the future
> > to for example support board files and/or ACPI.
> It was not clear to me but does this support more than two addresses?

In past when we were looking at this for Invensese MPU60XX device, we
had two I2cSerialBus() entries, but they belong to two different
devices. The first one for the MPU60XX and second one for another
device which is a slave for MPU60XX. This slave device can be also be
reached from master i2c controller, by disabling i2c master capability
of MPU60XX device.
So ACPI spec is very vague in specifying what they really meant.

> For example we might a device with 3 I2cSerialBus() connectors:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0Device (CAM1)
> =C2=A0=C2=A0=C2=A0=C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Method (_CRS, 0, NotS=
erialized)=C2=A0=C2=A0// _CRS: Current Resource
> Settings
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Name (SBUF, ResourceTemplate ()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0I2cSerialBus (0x0010, ControllerInitiated,
> 0x00061A80,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AddressingMode7Bit, =
"\\_SB.I2C4",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x00, ResourceConsum=
er, ,)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0I2cSerialBus (0x000C, ControllerInitiated,
> 0x00061A80,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AddressingMode7Bit, =
"\\_SB.I2C4",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x00, ResourceConsum=
er, ,)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0I2cSerialBus (0x0054, ControllerInitiated,
> 0x00061A80,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AddressingMode7Bit, =
"\\_SB.I2C4",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x00, ResourceConsum=
er, ,)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0})
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Return (SBUF) /* \_SB_.I2C4.CAM1._CRS.SBUF */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
>=20
> Furthermore those do not have names.
Correct. Better to use indexes. I think Mika also proposed similar API
in past.

Thanks,
Srinivas
