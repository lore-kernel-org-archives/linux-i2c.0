From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when using DT
 ids through ACPI
Date: Fri, 10 Jun 2016 09:32:32 +0300
Message-ID: <20160610063232.GR1791@lahna.fi.intel.com>
References: <cover.1465477193.git.leonard.crestez@intel.com>
 <f5d92224a005bc7b82e210957719b7be142c6388.1465477193.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f5d92224a005bc7b82e210957719b7be142c6388.1465477193.git.leonard.crestez@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 09, 2016 at 04:06:03PM +0300, Crestez Dan Leonard wrote:
> When devices are instatiated through devicetree the i2c_client->name is
> set to the compatible string with company name stripped out. This is
> then matched to the i2c_device_id table to pass the device_id to the
> probe function. This id parameter is used by some device drivers to
> differentiate between model numbers.
> 
> When using ACPI this id parameter is NULL and the driver usually needs
> to do ACPI-specific differentiation.
> 
> This patch attempts to find a valid i2c_device_id when using ACPI with
> DT-like compatible strings.

So I don't really understand why it would be good idea to pass
i2c_device_id for devices which are matched against their ACPI/DT
tables. Apparently DT is already doing that so maybe there is some
reason.

Anyway, why not fill in the device name when it is first enumerated
if it uses DT compatible property? Just like DT does.
