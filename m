From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Tue, 20 Oct 2015 12:16:04 +0300
Message-ID: <1445332564.22669.2.camel@linux.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
	 <1445293740-28537-1-git-send-email-dustin@cumulusnetworks.com>
	 <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37144 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbbJTJQJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 05:16:09 -0400
In-Reply-To: <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, "Puustinen, Ismo" <ismo.puustinen@intel.com>

+Cc: Ismo Puustinen

On Mon, 2015-10-19 at 15:29 -0700, Dustin Byford wrote:
> Although I2C mux devices are easily enumerated using ACPI (_HID/_CID
> or
> device property compatible string match) enumerating I2C client
> devices
> connected through a I2C mux device requires a little extra work.
>=20
> This change implements a method for describing an I2C device
> hierarchy that
> includes mux devices by using an ACPI Device() for each mux channel
> along
> with an _ADR to set the channel number for the device.=C2=A0=C2=A0See
> Documentation/acpi/i2c-muxes.txt for a simple example.

Ismo, can you test this patch on top of what you have to see if it goes
smoothly (no break of Galileo Gen2 support) ?

>=20
> Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> ---
> =C2=A0Documentation/acpi/i2c-muxes.txt | 58
> ++++++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/i2c/i2c-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 15 +++++++++--
> =C2=A0drivers/i2c/i2c-mux.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A08 ++++++
> =C2=A0include/linux/acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06 +++++
> =C2=A04 files changed, 85 insertions(+), 2 deletions(-)
> =C2=A0create mode 100644 Documentation/acpi/i2c-muxes.txt
>=20
> diff --git a/Documentation/acpi/i2c-muxes.txt
> b/Documentation/acpi/i2c-muxes.txt
> new file mode 100644
> index 0000000..9fcc4f0
> --- /dev/null
> +++ b/Documentation/acpi/i2c-muxes.txt
> @@ -0,0 +1,58 @@
> +ACPI I2C Muxes
> +--------------
> +
> +Describing an I2C device hierarchy that includes I2C muxes requires
> an ACPI
> +Device () scope per mux channel.
> +
> +Consider this topology:
> +
> ++------+=C2=A0=C2=A0=C2=A0+------+
> +| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
> +|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0| 0x70 |--CH=
01--> i2c client B (0x50)
> ++------+=C2=A0=C2=A0=C2=A0+------+
> +
> +which corresponds to the following ASL:
> +
> +Device (SMB1)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0Name (_HID, ...)
> +=C2=A0=C2=A0=C2=A0=C2=A0Device (MUX0)
> +=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Name (_HID, ...)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Name (_CRS, Resource=
Template () {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0AddressingMode7Bit, "^SMB1", 0x00,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0ResourceConsumer,,)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Device (CH00)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Name (_ADR, 0)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Device (CLIA)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Name (_HID, ...)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Name (_CRS, ResourceTemplate () {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0I2cSerialBus (0x50, =
ControllerInitiated,
> I2C_SPEED,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Addressi=
ngMode7Bit, "^CH00", 0x00,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Resource=
Consumer,,)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Device (CH01)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Name (_ADR, 1)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Device (CLIB)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Name (_HID, ...)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Name (_CRS, ResourceTemplate () {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0I2cSerialBus (0x50, =
ControllerInitiated,
> I2C_SPEED,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Addressi=
ngMode7Bit, "^CH01", 0x00,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Resource=
Consumer,,)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +}
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 579b99d..af0811c 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -156,7 +156,7 @@ static acpi_status
> acpi_i2c_add_device(acpi_handle handle, u32 level,
> =C2=A0	info.fwnode =3D acpi_fwnode_handle(adev);
> =C2=A0
> =C2=A0	memset(&lookup, 0, sizeof(lookup));
> -	lookup.adapter_handle =3D ACPI_HANDLE(adapter->dev.parent);
> +	lookup.adapter_handle =3D ACPI_HANDLE(&adapter->dev);
> =C2=A0	lookup.device_handle =3D handle;
> =C2=A0	lookup.info =3D &info;
> =C2=A0
> @@ -212,7 +212,7 @@ static void acpi_i2c_register_devices(struct
> i2c_adapter *adap)
> =C2=A0{
> =C2=A0	acpi_status status;
> =C2=A0
> -	if (!adap->dev.parent || !has_acpi_companion(adap-
> >dev.parent))
> +	if (!has_acpi_companion(&adap->dev))
> =C2=A0		return;
> =C2=A0
> =C2=A0	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE,
> ACPI_ROOT_OBJECT,
> @@ -1667,6 +1667,17 @@ int i2c_add_adapter(struct i2c_adapter
> *adapter)
> =C2=A0	struct device *dev =3D &adapter->dev;
> =C2=A0	int id;
> =C2=A0
> +	/*
> +	=C2=A0* By default, associate I2C adapters with their parent
> device's ACPI
> +	=C2=A0* node.
> +	=C2=A0*/
> +	if (!has_acpi_companion(dev)) {
> +		struct acpi_device *adev =3D ACPI_COMPANION(dev-
> >parent);
> +
> +		if (adev)
> +			ACPI_COMPANION_SET(dev, adev);
> +	}
> +
> =C2=A0	if (dev->of_node) {
> =C2=A0		id =3D of_alias_get_id(dev->of_node, "i2c");
> =C2=A0		if (id >=3D 0) {
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 2ba7c0f..00fc5b1 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -25,6 +25,7 @@
> =C2=A0#include <linux/i2c.h>
> =C2=A0#include <linux/i2c-mux.h>
> =C2=A0#include <linux/of.h>
> +#include <linux/acpi.h>
> =C2=A0
> =C2=A0/* multiplexer per channel data */
> =C2=A0struct i2c_mux_priv {
> @@ -173,6 +174,13 @@ struct i2c_adapter *i2c_add_mux_adapter(struct
> i2c_adapter *parent,
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> +	/*
> +	=C2=A0* Associate the mux channel with an ACPI node.
> +	=C2=A0*/
> +	if (has_acpi_companion(mux_dev))
> +		acpi_preset_companion(&priv->adap.dev,
> ACPI_COMPANION(mux_dev),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan_id);
> +
> =C2=A0	if (force_nr) {
> =C2=A0		priv->adap.nr =3D force_nr;
> =C2=A0		ret =3D i2c_add_numbered_adapter(&priv->adap);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 51a96a8..66564f8 100644



> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -505,6 +505,12 @@ static inline bool has_acpi_companion(struct
> device *dev)
> =C2=A0	return false;
> =C2=A0}
> =C2=A0
> +static inline void acpi_preset_companion(struct device *dev,
> +					=C2=A0struct acpi_device *parent,
> u64 addr)
> +{
> +	return;
> +}
> +
> =C2=A0static inline const char *acpi_dev_name(struct acpi_device *ade=
v)
> =C2=A0{
> =C2=A0	return NULL;

=46or me seems this one can go separately. Rafael, what do you think?

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
