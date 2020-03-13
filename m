From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH] i2c: acpi: put device when verifying client fails
Date: Fri, 13 Mar 2020 13:29:32 +0200
Message-ID: <20200313112932.GA2540@lahna.fi.intel.com>
References: <20200312133244.9564-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200312133244.9564-1-wsa@the-dreams.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 12, 2020 at 02:32:44PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> i2c_verify_client() can fail, so we need to put the device when that
> happens.
> 
> Fixes: 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure notifications")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> RFC because I don't know if it can be that the returned dev is not an
> i2c_client. Yet, since it can happen theoretically, I think we should
> have the checks.

I agree,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
