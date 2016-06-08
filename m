From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 0/2] Match i2c_device_id when using DT ids through ACPI
Date: Wed, 08 Jun 2016 02:15:04 +0200
Message-ID: <1943200.ETapnCIHt7@vostro.rjw.lan>
References: <cover.1465242308.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1465242308.git.leonard.crestez@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Monday, June 06, 2016 11:03:26 PM Crestez Dan Leonard wrote:
> Linux supports instantiating devices using devicetree ids from ACPI by setting
> the id to PRP0001 and adding the devicetree compatible string in _DSD
> properties. This is described in Documentation/acpi/enumeration.txt.
> 
> I've tried to use this feature using custom ACPI tables and one issue I
> encountered is that a lot of i2c device drivers are written for DT only and
> expect a valid i2c_device_id *id parameter to their probe function but this is
> always NULL for the PRP0001 case. Others call of_match_device in order to
> determine their exact model number and that will also fail.
> 
> Drivers normally do this in order to differentiate between minor model numbers
> supported by the same driver, for example hmc5883 versus hmc5983.
> 
> For ACPI it is common to add calls to acpi_match_device in order to do such
> differentiation. It might make sense to call some form of acpi_of_match_device
> except no such function is currently exported. I think it makes a lot of sense
> to refactor the current acpi_of_match_device to return the of_device_id and
> export it.
> 
> This is in PATCH 1. After exposing this function it could be called from each
> driver that needs to support multiple models through PRP0001. I guess the
> alternative to exposing acpi_of_match_device would be for driver code to poke
> at acpi_device->data.of_compatible?
> 
> Going further it might make sense to attempt to fetch the i2c_device_id when
> instantiating through PRP0001. This already happens automatically for
> devicetree and it makes a lot of sense it would work through ACPI with DT ids.
> Patch 2 hacks an additional search in i2c register code. This makes some
> drivers "just work" without manually handling the "ACPI with DT ids" case.
> 
> For P1 it might make sense to change the parameters around so that
> acpi_of_match_device will have the same signature as of_match_device.
> 
> The purpose of these changes would be to make more drivers easier to
> instantiate through ACPI firmware. It's possible that I misunderstood and this
> problem already has a different solution.
> 
> Crestez Dan Leonard (2):
>   acpi: Expose acpi_of_match_device
>   i2c: Pass i2c_device_id to probe func when using DT ids through ACPI

It would be good to CC the actual patches to the same set of addresses as this
message.

Thanks,
Rafael

