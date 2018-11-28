From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 05/15] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Date: Wed, 28 Nov 2018 16:47:00 +0200
Message-ID: <20181128144700.GA2296@lahna.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-6-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 28, 2018 at 01:45:25PM +0200, Andy Shevchenko wrote:
> The caller would like to know the reason why the i2c_acpi_new_device() fails.
> For example, if adapter is not available, it might be in the future and we
> would like to re-probe the clients again. But at the same time we would like to
> bail out if the error seems unrecoverable, such as invalid argument supplied.
> To achieve this, return error pointer in some cases.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
