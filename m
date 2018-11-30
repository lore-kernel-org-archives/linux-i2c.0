From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 14/15] ACPI / scan: Create platform device for INT3515
 ACPI nodes
Date: Fri, 30 Nov 2018 11:56:56 +0200
Message-ID: <20181130095656.GI10650@smile.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-15-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gCyvS+VkGadYBSy34AzAQ4-20Rjeigc3eV7GZ1x79cfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gCyvS+VkGadYBSy34AzAQ4-20Rjeigc3eV7GZ1x79cfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, jic23@kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 29, 2018 at 09:58:51PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 28, 2018 at 12:48 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The ACPI device with INT3515 _HID is representing a complex USB PD
> > hardware infrastructure which includes several I2C slave ICs.
> >
> > We add an ID to the I2C multi instantiate list to enumerate
> > all I2C slaves correctly.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> and I'm assuming that you will route the whole series through the
> platform/x86 drivers tree.

Thanks, Rafael, will route through PDx86!


-- 
With Best Regards,
Andy Shevchenko
