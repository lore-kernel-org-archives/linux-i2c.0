From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 2/2] i2c: add ACPI support for I2C mux ports
Date: Fri, 23 Oct 2015 16:40:04 +0300
Message-ID: <20151023134004.GB1526@lahna.fi.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
 <1445505462-27915-3-git-send-email-dustin@cumulusnetworks.com>
 <20151023084013.GS1526@lahna.fi.intel.com>
 <20151023101611.GH13380@katana>
 <20151023131311.GA1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151023131311.GA1526@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 23, 2015 at 04:13:11PM +0300, Mika Westerberg wrote:
> On Fri, Oct 23, 2015 at 12:16:11PM +0200, Wolfram Sang wrote:
> > On Fri, Oct 23, 2015 at 11:40:13AM +0300, Mika Westerberg wrote:
> > > On Thu, Oct 22, 2015 at 02:17:42AM -0700, Dustin Byford wrote:
> > > > Although I2C mux devices are easily enumerated using ACPI (_HID=
/_CID or
> > > > device property compatible string match), enumerating I2C clien=
t devices
> > > > connected through an I2C mux needs a little extra work.
> > > >=20
> > > > This change implements a method for describing an I2C device hi=
erarchy that
> > > > includes mux devices by using an ACPI Device() for each mux cha=
nnel along
> > > > with an _ADR to set the channel number for the device.  See
> > > > Documentation/acpi/i2c-muxes.txt for a simple example.
> > > >=20
> > > > To make this work the ismt, i801, and designware pci/platform d=
evs now
> > > > share an ACPI companion with their I2C adapter dev similar to h=
ow it's done
> > > > in OF.  This is done on the assumption that power management fu=
nctions will
> > > > not be called directly on the I2C dev that is sharing the ACPI =
node.
> > > >=20
> > > > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> > >=20
> > > This looks good to me.
> > >=20
> > > You did also some stylistic changes to the drivers in question wh=
ich I
> > > think should be placed to a separate patches.
> >=20
> > I am fine with those.
> >=20
> > > Regardless of that,
> > >=20
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >=20
> > I would love to get a Tested-by for the designware part. Then, I co=
uld
> > queue it for 4.4 already.
>=20
> Tested on Intel Baytrail and Skylake and the existing I2C devices
> (touchpad, touchscreen) still work so for the designware part you can
> also add my,
>=20
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Ah, forgot to mention that the i2c-designware-pcidrv.c misses include o=
f
<linux/acpi.h> so that needs to be fixed. Otherwise we get:

drivers/i2c/busses/i2c-designware-pcidrv.c: In function =E2=80=98i2c_dw=
_pci_probe=E2=80=99:
drivers/i2c/busses/i2c-designware-pcidrv.c:259:2: error: implicit decla=
ration of function =E2=80=98ACPI_COMPANION_SET=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
drivers/i2c/busses/i2c-designware-pcidrv.c:259:33: error: implicit decl=
aration of function =E2=80=98ACPI_COMPANION=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
