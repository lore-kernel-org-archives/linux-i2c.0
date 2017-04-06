From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6] platform/x86: Add Intel Cherry Trail ACPI INT33FE
 device driver
Date: Thu, 06 Apr 2017 14:03:56 +0300
Message-ID: <1491476636.24567.25.camel@linux.intel.com>
References: <20170406072436.12898-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170406072436.12898-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-04-06 at 09:24 +0200, Hans de Goede wrote:
> The INT33FE ACPI device has a CRS table with I2cSerialBusV2 resources
> for
> 3 devices: Maxim MAX17047 Fuel Gauge Controller, FUSB302 USB Type-C
> Controller and PI3USB30532 USB switch.
> 
> This commit adds a driver for this ACPI device which instantiates
> i2c-clients for these, so that the standard i2c drivers for these
> chips
> can bind to the them.

Given one more thought, if the devices should be present all to make it
work, than you perhaps may use component framework.

In this case this so called "pseudo" device is not so pseudo, but
"master".

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
