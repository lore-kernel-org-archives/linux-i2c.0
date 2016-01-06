From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH v2 00/16] intel-lpss: support non-ACPI platforms
Date: Wed, 6 Jan 2016 08:19:49 -0800
Message-ID: <568D3EA5.7040207@redhat.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1488447.PO5a3v7KWa@vostro.rjw.lan> <568C040F.2070000@redhat.com>
 <1855560.2DW9QAnCKL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1855560.2DW9QAnCKL@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-i2c@vger.kernel.org

On 01/05/2016 03:59 PM, Rafael J. Wysocki wrote:
> On Tuesday, January 05, 2016 09:57:35 AM Laura Abbott wrote:
>> On 12/06/2015 05:44 PM, Rafael J. Wysocki wrote:
>>> On Monday, November 30, 2015 05:11:28 PM Andy Shevchenko wrote:
>>>> This series includes few logical sets that bring a support of non-ACPI
>>>> platforms for Intel Skylake.
>>>>
>>>> First part is a refactoring of built-in device properties support:
>>>> - keep single value inside the structure
>>>> - provide helper macros to define built-in properties
>>>> - fall back to secondary fwnode if primary has no asked property
>>>>
>>>> Second is a propagating built-in device properties in platform core.
>>>>
>>>> Third one is modifications to MFD code and intel-lpss.c driver in particular
>>>> to define and pass built-in properties to the individual drivers.
>>>>
>>>> And last part is a fix for I2C bug found on Lenovo Yoga hardware and a first
>>>> converted user.
>>>>
>>>> Built-in device properties is an alternative to platform data. It provides a
>>>> unified API that drivers can use to cover all cases at once: DT, ACPI, and
>>>> built-in properties.
>>>>
>>>> With this series applied a platform data can be considered obsolete. Moreover,
>>>> built-in device properties allow to adjust the existing configuration, for
>>>> example, in cases when ACPI values are wrong on some platforms.
>>>>
>>>> The series has been tested on available hardware and doesn't break current
>>>> behaviour. But we ask people who have the affected hardware to apply the series
>>>> on your side and check with Lenovo hardware.
>>>>
>>>> Changelog v2:
>>>> - fix isuues found by kbuild bot (kbuild)
>>>> - append a patch to propagate device properties in polatform code (Arnd)
>>>> - update few existing and add couple of new patches due to above
>>>> - check with kmemleak
>>>>
>>>> Andy Shevchenko (9):
>>>>     device property: always check for fwnode type
>>>>     device property: rename helper functions
>>>>     device property: refactor built-in properties support
>>>>     device property: keep single value inplace
>>>>     device property: improve readability of macros
>>>>     device property: return -EINVAL when property isn't found in ACPI
>>>>     device property: Fallback to secondary fwnode if primary misses the
>>>>       property
>>>>     mfd: core: propagate device properties to sub devices drivers
>>>>     mfd: intel-lpss: Pass HSUART configuration via properties
>>>>
>>>> Heikki Krogerus (1):
>>>>     device property: helper macros for property entry creation
>>>>
>>>> Mika Westerberg (6):
>>>>     device property: Take a copy of the property set
>>>>     driver core: platform: Add support for built-in device properties
>>>>     driver core: Do not overwrite secondary fwnode with NULL if it is set
>>>>     mfd: intel-lpss: Add support for passing device properties
>>>>     mfd: intel-lpss: Pass SDA hold time to I2C host controller driver
>>>>     i2c: designware: Convert to use unified device property API
>>>
>>> I'm going to queue up this series for v4.5.
>>>
>>> If there are any problems with it or objections from anyone, please let me know.
>>>
>>
>>
>> Raising an old thread, I pulled this series into Fedora rawhide and
>> while it worked for Lenovo Yoga we received a report that it caused
>> a regression on the Dell Inspiron 7559 (see
>> https://bugzilla.redhat.com/show_bug.cgi?id=1275718#c27) . I haven't
>> asked the reporter about bisecting to see which patch broke it.
>> Were there any known follow up patches?
>
> There were a few.
>
> All of them are in my linux-next branch if you can try this one.
>
> Alternatively, I can expose a branch with these to you to test.
>
> Thanks,
> Rafael
>

I picked up all the patches from the device-properties merge but the
problem still shows up. Are there others I should pick up? Hardware
details about the touchpad are at https://bugzilla.redhat.com/show_bug.cgi?id=1275718#c34

Thanks,
Laura
