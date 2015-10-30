From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 0/6] enable I2C devices behind I2C bus on Gen2
Date: Fri, 30 Oct 2015 21:05:58 +0200
Message-ID: <CAHp75VcYBcG5uFgCDnv3MeQEXbPaWF3z7bvDauWZ8vYA_O32jA@mail.gmail.com>
References: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1445439954.22669.38.camel@linux.intel.com>
	<20151030185450.GM4058@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151030185450.GM4058@x1>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 30, 2015 at 8:54 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 21 Oct 2015, Andy Shevchenko wrote:
>
>> On Wed, 2015-10-07 at 13:18 +0300, Andy Shevchenko wrote:
>> > There is a board in the wild, i.e. Intel Galileo Gen2, that has ACPI
>> > enumerated
>> > devices behind I2C bus.
>>
>> Lee, since Wolfram is going to apply patches 1 and 5, how could we
>> proceed with the rest? Patches are indeed build independent, though
>> they are unified by enabling logically piece-by-piece. It would be
>> great if you think you may apply them to your v4.4 queue.
>
> So we're just waiting for Thierry's Ack now, right?

That's right. Either Ack, or he might apply patch by himself. It
wouldn't be harmful in any case.

-- 
With Best Regards,
Andy Shevchenko
