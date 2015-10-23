From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: [PATCH v4 4/5] at24: enable ACPI device found on Galileo Gen2
Date: Fri, 23 Oct 2015 12:20:09 -0500
Message-ID: <CAE7DoPb01p+iugRv_h9zqGgYggrkJJ=sypP4Rt7jMbi6Xncw+g@mail.gmail.com>
References: <1445591805-28886-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1445591805-28886-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1445591805-28886-5-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Fri, Oct 23, 2015 at 4:16 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There is a 24c08 chip connected to i2c bus on Intel Galileo Gen2 board. Enable
> it via ACPI ID INT3499.

I'm looking to do something similar with a 24C02 and would like to
know if there is an ID already defined for that.

Is there a master list of ACPI IDs?

The best I found is here: http://www.uefi.org/PNP_ACPI_Registry
But that doesn't seem to have individual numbers and it indicates that
the "INT" PNP ID is reserved by INTERPHASE CORPORATION.
Intel Corp looks to have "ICO" for the PNP ID and ACPI/INTC/INTL for ACPI IDs.

Thanks,
Ben
