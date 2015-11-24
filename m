From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 11/13] mfd: intel-lpss: Pass HSUART configuration via properties
Date: Tue, 24 Nov 2015 20:53:04 +0100
Message-ID: <6720400.mTdslW7yXO@wuerfel>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com> <1448360579-79260-12-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-12-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 24 November 2015 12:22:57 Andy Shevchenko wrote:
> +static struct property_entry uart_properties[] = {
> +       PROPERTY_ENTRY_U32("reg-io-width", 4),
> +       PROPERTY_ENTRY_U32("reg-shift", 2),
> +       PROPERTY_ENTRY_U8("snps,uart-16550-compatible", 1),
> +       { },
> 

If I read the binding correctly, the "snps,uart-16550-compatible" property
is meant to be boolean, meaning true if present and zero-length or false
if absent. Using a u8 propert instead feels wrong.

Maybe we can have a PROPERTY_ENTRY_BOOL() for that?

	Arnd
