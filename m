From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Mon, 14 Oct 2013 11:13:17 +0300
Message-ID: <20131014081317.GC3521@intel.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20131011144946.GS3521@intel.com>
 <2393462.4JRAMNeigd@vostro.rjw.lan>
 <20131012050413.GY3521@intel.com>
 <525B907F.1020203@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <525B907F.1020203@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 14, 2013 at 09:34:39AM +0300, Jarkko Nikula wrote:
> On 10/12/2013 08:04 AM, Mika Westerberg wrote:
> >On Sat, Oct 12, 2013 at 12:16:02AM +0200, Rafael J. Wysocki wrote:
> >>>I think that this is intentional. We don't want that the i2c modalias
> >>>matches with the ACPI device (like with the i2c:INTABCD). Instead use ACPI
> >>>IDs that are added to the driver to match with the ACPI device.
> >>Well, I'm not really sure this was intentional, but I wonder how other bus
> >>types work in that respect?
> >We have the same for platform bus, if that's what you are asking.
> >
> Do we? I don't recall seeing per device modaliases on other
> platforms on their platform buses.

I mean for platform devices enumerated from ACPI.

> And actually I don't see that happening in drivers/base/platform.c:
> platform_uevent() either where just pdev->name is used but not
> pdev->id (which is used with pdev->name for dev_set_name()).
> 
> This makes me thinking that perhaps "pdevinfo.name =
> dev_name(&adev->dev);" in drivers/acpi/acpi_platform.c:
> acpi_create_platform_device() should be fixed too as now modalias
> for ACPI registered platform devices differ from platform devices
> that are registered in other subsystems (e.g. regulatory, pcspkr,
> alarmtimer, etc devices)?

Well, if you think that it doesn't hit us back later if we get a match that
isn't supposed to happen.
