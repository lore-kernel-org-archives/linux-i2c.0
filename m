From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when using DT
 ids through ACPI
Date: Fri, 10 Jun 2016 15:00:17 +0300
Message-ID: <bb2702c4-848a-4e0e-6381-66af079a7c13@intel.com>
References: <cover.1465477193.git.leonard.crestez@intel.com>
 <f5d92224a005bc7b82e210957719b7be142c6388.1465477193.git.leonard.crestez@intel.com>
 <20160610070424.GA1552@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160610070424.GA1552@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>
List-Id: linux-i2c@vger.kernel.org

On 06/10/2016 10:04 AM, Wolfram Sang wrote:
> On Thu, Jun 09, 2016 at 04:06:03PM +0300, Crestez Dan Leonard wrote:
>> When devices are instatiated through devicetree the i2c_client->name is
>> set to the compatible string with company name stripped out. This is
>> then matched to the i2c_device_id table to pass the device_id to the
>> probe function. This id parameter is used by some device drivers to
>> differentiate between model numbers.
>>
>> When using ACPI this id parameter is NULL and the driver usually needs
>> to do ACPI-specific differentiation.
>>
>> This patch attempts to find a valid i2c_device_id when using ACPI with
>> DT-like compatible strings.
> 
> Note that this DT behaviour is about to be dropped to match I2C with
> the "generic" behaviour".
> 
> https://lkml.org/lkml/2016/5/4/534

Looking at that series it seems that the intention is to eventually
remove the i2c_device_id argument from probe completely? That would
cause a lot of code churn. It would also require every driver that needs
to differentiate between models to pretty much duplicate the matching
logic performed by the core.

This does seem better than receiving an i2c_device_id parameter argument
which may or may not be NULL. Still, in order to support multiple models
using ACPI DT ids every driver would have to attempt some sort of
acpi_of_match_device, right?

Have you considered adding .probe_of(dev, of_device_id) and
.probe_acpi(dev, acpi_device_id) instead, with arguments which are
always guaranteed to be non-NULL? The main advantage would be that
drivers don't need to do their own matching and all rules are only
present ever in the core. Then ACPI with DT ids could be made to "just
work" without per-driver support.

-- 
Regards,
Leonard
