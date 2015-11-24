From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 00/13] intel-lpss: support non-ACPI platforms
Date: Tue, 24 Nov 2015 23:17:27 +0100
Message-ID: <CAJZ5v0iXX_co4XbQ0aZR5S74aWM3gSaPKedZhtUT1k88ZEPU3A@mail.gmail.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<2529008.Qej2ZWi12S@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2529008.Qej2ZWi12S@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 24, 2015 at 9:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 24 November 2015 12:22:46 Andy Shevchenko wrote:
>> This series includes few logical sets that bring a support of non-ACPI
>> platforms for Intel Skylake.
>>
>> First part is a refactoring of built-in device properties support:
>>  - keep single value inside the structure
>>  - provide helper macros to define built-in properties
>>  - fall back to secondary fwnode if primary has no asked property
>>
>> Second one is modifications to MFD code and intel-lpss.c driver in particular
>> to define and pass built-in properties to the individual drivers.
>>
>> Last part is a fix for I2C bug found on Lenovo Yoga hardware and a first
>> converted user.
>>
>> Built-in device properties is an alternative to platform data. It provides a
>> unified API that drivers can use to cover all cases at once: DT, ACPI, and
>> built-in properties.
>>
>> With this series applied platform data can be considered obsolete. Moreover,
>> built-in device properties allows to adjust existing configuration, for
>> example, in cases when ACPI values are wrong on some platforms.
>>
>> The series has been tested on available hardware and doesn't break current
>> behaviour. But we ask you, Kevin, to apply the series on your side and check
>> with Lenovo hardware.
>
> I agree with Rafael, this looks really nice. I found one small thing that
> could be improved, see the comment on patch 11.
>
> Aside from that, I think we should have a nicer way to pass a property
> list through platform_device_info when calling
> platform_device_register_full(). You don't do that here because the drivers
> you change are based on MFD cells rather than direct platform devices,
> but it would fit in the series and should be easy enough to do.
>
> I don't know why Rafael didn't do that for the initial series already, maybe
> he had a good reason.

I was focusing on the generics rather than on any particular
individual bus type.

Thanks,
Rafael
