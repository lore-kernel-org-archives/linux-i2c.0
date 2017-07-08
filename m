From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] i2c: core: Allow empty id_table in ACPI case as well
Date: Sat, 08 Jul 2017 23:16:16 +0300
Message-ID: <1499544976.22624.311.camel@linux.intel.com>
References: <20170706180140.49391-1-andriy.shevchenko@linux.intel.com>
         <20170708195709.422s6tdxqxsz6sbo@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170708195709.422s6tdxqxsz6sbo@ninjato>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, 2017-07-08 at 21:57 +0200, Wolfram Sang wrote:
> On Thu, Jul 06, 2017 at 09:01:40PM +0300, Andy Shevchenko wrote:
> > For now empty ID table is not allowed with ACPI and prevents driver
> > to be
> > probed.
> > 
> > Add a check to allow empty ID table.
> > 
> > Fixes: da10c06a044b ("i2c: Make I2C ID tables non-mandatory for
> > DT'ed devices")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Do we need this for 4.13 already?
> 

Yes (we have NFC chip which relies on it), even better down to stable
kernels which have mentioned commit.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
