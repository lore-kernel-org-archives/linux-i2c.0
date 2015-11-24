From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 03/13] device property: refactor built-in properties support
Date: Tue, 24 Nov 2015 15:37:45 +0100
Message-ID: <36215503.lOBnWKWWL0@vostro.rjw.lan>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com> <1448360579-79260-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, November 24, 2015 12:22:49 PM Andy Shevchenko wrote:
> Instead of using the type and nval fields we will use length (in bytes) of the
> value. The sanity check is done in the accessors.
> 
> The built-in property accessors are split in the same way such as device tree.

Do I understand correctly that this is indended to make the built-in properties
follow the DT layout?

Thanks,
Rafael
