From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: [PATCH v4] eeprom/at24: use device_property_*() functions instead
 of of_get_property()
Date: Thu, 9 Feb 2017 14:31:11 -0600
Message-ID: <CAE7DoPYcU4+9CDKSXkhM3h0GZSvJe7r+mE4NGy5faBhZ39GHpg@mail.gmail.com>
References: <CAE7DoPan8Y_-F-Fj22xYkKBeCTPPD60MvEAv+hjSzU+H5DHovg@mail.gmail.com>
 <1486661768-21456-1-git-send-email-gardner.ben@gmail.com> <20170209195859.GB1431@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170209195859.GB1431@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 9, 2017 at 1:58 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Note: Matching the driver to the I2C device requires another patch.
>>  http://www.spinics.net/lists/linux-acpi/msg71914.html
>
> Do I get it right? With the patch applied we won't have a regression but
> the new feature will only be available when the above series is
> upstream? So, it is a "weak" dependency?

That is correct.
This patch shouldn't cause any regressions, but isn't useful without
the other patch series.

The other patch series was picked up today by Rafael J. Wysocki.
http://marc.info/?l=linux-acpi&m=148664872023023&w=2

Ben
