From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 4/4] platform/x86: Add ACPI i2c-multi-instantiate
 pseudo driver
Date: Thu, 9 Aug 2018 13:55:01 +0200
Message-ID: <CAJZ5v0jbNTGEXWJ+CtPOKSM=AyB5-3hV-tMCYehj5w87i_2znA@mail.gmail.com>
References: <20180809114046.21366-1-hdegoede@redhat.com> <20180809114046.21366-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809114046.21366-5-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 9, 2018 at 1:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
> i2c-device.
>
> But in some rare cases the manufacturer has decided to describe multiple
> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>
> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
> code to support this corner-case.
>
> This commit introduces a new i2c-multi-instantiate driver which fixes this
> in a different way. This new driver can be built as a module which will
> only loaded on affected systems.
>
> This driver will instantiate a new i2c-client per I2cSerialBus resource,
> using the driver_data from the acpi_device_id it is binding to to tell it
> which chip-type (and optional irq-resource) to use when instantiating.
>
> Note this driver depends on a platform device being instantiated for the
> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Rebase on top of 4.18-rc2
>
> Changes in v3:
> -Change from an i2c-driver using a hack to allow having multiple i2c clients
>  at the same address to a platform-driver
>
> Changes in v4:
> -Tweak MAINTAINERS entry a bit
>
> Changes in v5:
> -s/no_clients/num_clients/
> -Change patch Subject prefix to platform/x86
>
> Changes in v6:
> -s/irq_idx/gpio_irq_idx/

And this is the only patch that has changed in v6, right?

Anyway, if you have further updates on top of this series, please send
them as incremental patches.

Thanks,
Rafael
