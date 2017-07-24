From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Resend, PATCH v2] i2c: core: Allow empty id_table in ACPI case
 as well
Date: Mon, 24 Jul 2017 13:45:59 +0300
Message-ID: <20170724104559.GS629@lahna.fi.intel.com>
References: <20170717141328.52286-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717141328.52286-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 17, 2017 at 05:13:28PM +0300, Andy Shevchenko wrote:
> For now empty ID table is not allowed with ACPI and prevents driver to
> be probed.
> 
> Add a check to allow empty ID table.
> 
> This introduces a helper i2c_acpi_match_device().
> 
> Note, we rename some static function in i2c-core-acpi.c to distinguish
> with public API.
> 
> Fixes: da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed devices")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
