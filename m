From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Sat, 12 Oct 2013 08:04:13 +0300
Message-ID: <20131012050413.GY3521@intel.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20131011144946.GS3521@intel.com>
 <2393462.4JRAMNeigd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2393462.4JRAMNeigd@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Sat, Oct 12, 2013 at 12:16:02AM +0200, Rafael J. Wysocki wrote:
> > I think that this is intentional. We don't want that the i2c modalias
> > matches with the ACPI device (like with the i2c:INTABCD). Instead use ACPI
> > IDs that are added to the driver to match with the ACPI device.
> 
> Well, I'm not really sure this was intentional, but I wonder how other bus
> types work in that respect?

We have the same for platform bus, if that's what you are asking.

It probably doesn't hurt to have this patch applied but it might cause
inadvertent match if for some reason there is an I2C client driver that
happens to have INTABCD I2C id in its list.
