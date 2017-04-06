From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v6] platform/x86: Add Intel Cherry Trail ACPI INT33FE
 device driver
Date: Thu, 6 Apr 2017 15:48:15 -0700
Message-ID: <20170406224815.GA13110@fury>
References: <20170406072436.12898-1-hdegoede@redhat.com>
 <1491476636.24567.25.camel@linux.intel.com>
 <8b6df86e-06eb-5be8-ee8c-9af980691fa5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8b6df86e-06eb-5be8-ee8c-9af980691fa5@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 06, 2017 at 02:17:11PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 06-04-17 13:03, Andy Shevchenko wrote:
> > On Thu, 2017-04-06 at 09:24 +0200, Hans de Goede wrote:
> > > The INT33FE ACPI device has a CRS table with I2cSerialBusV2 resources
> > > for
> > > 3 devices: Maxim MAX17047 Fuel Gauge Controller, FUSB302 USB Type-C
> > > Controller and PI3USB30532 USB switch.
> > > 
> > > This commit adds a driver for this ACPI device which instantiates
> > > i2c-clients for these, so that the standard i2c drivers for these
> > > chips
> > > can bind to the them.
> > 
> > Given one more thought, if the devices should be present all to make it
> > work, than you perhaps may use component framework.
> 
> Actually the fuel-guage is completely independent, the PI3USB30532 USB
> switch will get set based on extcon cable events from the FUSB302 USB
> Type-C controller, but otherwise both drivers are independent and the
> FUSB302 USB Type-C controller pretty much operates stand-alone.
> 
> > In this case this so called "pseudo" device is not so pseudo, but
> > "master".
> 
> I think this is really some Windows weirdness, if I configure the BIOS
> to boot "Android" the ACPI INT33FE device goes away and instead I
> get 3 separate ACPI devices for the 3 chips.

So if this is this case, what is the value in supporting "windows weirdness" if
the end user can select "Android" and be presented with 3 separate devices?

-- 
Darren Hart
VMware Open Source Technology Center
