From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 14/16] mfd: intel-lpss: Pass SDA hold time to I2C host
 controller driver
Date: Mon, 8 Feb 2016 12:45:39 +0200
Message-ID: <CAHp75VdtpBm4ZHjf44=Y9Ty9zwDVwmBLi0nBXRS6ww=BVq9nRw@mail.gmail.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1448896304-87928-15-git-send-email-andriy.shevchenko@linux.intel.com>
	<20160208100942.GA2220@tetsubishi>
	<20160208102911.GC1794@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160208102911.GC1794@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 8, 2016 at 12:29 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Feb 08, 2016 at 11:09:43AM +0100, Wolfram Sang wrote:
>> On Mon, Nov 30, 2015 at 05:11:42PM +0200, Andy Shevchenko wrote:

>> There has been a request to get this into stable:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=108581
>>
>> Since we probably don't want to backport the whole device_property
>> series, is there a simpler fix to backport for stable?
>
> Basically all it needs is to have:
>
>         dev->sda_hold_time = 28
>
> in dw_i2c_acpi_configure(). However, we cannot just unconditionally set
> it as it will break existing non-SKL systems so there should be some way
> to check if this is SKL or not. Perhaps we could look for DMI entries of
> the affected machines?
>
> BTW, this is not a regression in a sense as SKL I2C never worked before
> this series.

I could add that "backporting" something which is drastically
different to the original mainstream may probably prevent a smooth
backporting the fixes come later if any. Thus, I would try to port as
much closer as we can to the existing upstream code.

-- 
With Best Regards,
Andy Shevchenko
