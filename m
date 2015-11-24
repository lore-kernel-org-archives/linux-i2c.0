From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 03/13] device property: refactor built-in properties
 support
Date: Tue, 24 Nov 2015 16:40:29 +0200
Message-ID: <1448376029.15393.21.camel@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1448360579-79260-4-git-send-email-andriy.shevchenko@linux.intel.com>
	 <36215503.lOBnWKWWL0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <36215503.lOBnWKWWL0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-11-24 at 15:37 +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 24, 2015 12:22:49 PM Andy Shevchenko wrote:
> > Instead of using the type and nval fields we will use length (in
> > bytes) of the
> > value. The sanity check is done in the accessors.
> > 
> > The built-in property accessors are split in the same way such as
> > device tree.
> 
> Do I understand correctly that this is indended to make the built-in
> properties
> follow the DT layout?

Correct.

> 
> Thanks,
> Rafael
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

