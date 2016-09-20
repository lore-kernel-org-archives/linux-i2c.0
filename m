From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v2] i2c / ACPI: Do not touch an I2C device if it belongs to another adapter
Date: Tue, 20 Sep 2016 20:49:37 +0200
Message-ID: <87y42mxv7i.fsf@gmail.com>
References: <874m5ax3o4.fsf@gmail.com>
        <20160920135925.45450-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160920135925.45450-1-mika.westerberg@linux.intel.com> (Mika
        Westerberg's message of "Tue, 20 Sep 2016 16:59:25 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Nicolai Stange <nicstange@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> When enumerating I2C devices connected to an I2C adapter we scan the whole
> namespace (as it is possible to have devices anywhere in that namespace,
> not just below the I2C adapter device) and add each found device to the I2C
> bus in question.
>
> Now after commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI
> reconfigure notifications") checking of the adapter handle to the one found
> in the I2cSerialBus() resource was moved to happen after resources of the
> I2C device has been parsed. This means that if the I2cSerialBus() resource
> points to an adapter that does not exists in the system we still parse
> those resources. This is problematic in particular because
> acpi_dev_resource_interrupt() tries to configure GSI if the device also has
> an Interrupt() resource. Failing to do that results errrors like this to be
> printed on the console:
>
>   [   10.409490] ERROR: Unable to locate IOAPIC for GSI 37
>
> To fix this we pass the I2C adapter to i2c_acpi_get_info() and make sure
> the handle matches the one in the I2cSerialBus() resource before doing
> anything else to the device.
>
> Reported-and-tested-by: Nicolai Stange <nicstange@gmail.com>

I've just retested this v2 explicitly and it works like a charm.

Also,

  Reviewed-by: Nicolai Stange <nicstange@gmail.com>

if you want.


Thanks,

Nicolai
