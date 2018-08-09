From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
Date: Thu, 9 Aug 2018 11:39:47 +0200
Message-ID: <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com>
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-2-hdegoede@redhat.com>
 <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 09-08-18 11:35, Rafael J. Wysocki wrote:
> On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Since commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to
>> initialize ACPI_TYPE_DEVICE devs") the status field of normal acpi_devices
>> gets set to 0 by acpi_bus_type_and_status() and filled with its actual
>> value later when acpi_add_single_object() calls acpi_bus_get_status().
>>
>> This means that any acpi_match_device_ids() calls in between will always
>> fail with -ENOENT.
>>
>> We already have a workaround for this, which temporary forces status to
>> ACPI_STA_DEFAULT in drivers/acpi/x86/utils.c: acpi_device_always_present()
>> and the next commit in this series adds another acpi_match_device_ids()
>> call between status being initialized as 0 and the acpi_bus_get_status()
>> call.
>>
>> Rather then adding another workaround, this commit makes
>> acpi_bus_type_and_status() initialize status to ACPI_STA_DEFAULT, this is
>> safe to do as the only code looking at status between the initialization
>> and the acpi_bus_get_status() call is those acpi_match_device_ids() calls.
>>
>> Note this does mean that we need to (re)set status to 0 in case the
>> acpi_bus_get_status() call fails.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> -New patch in v3 of this patch-set
>>
>> Changes in v4:
>> -This is not a fix for acpi_is_indirect_io_slave() as I thought at first,
>>   acpi_is_indirect_io_slave() calls acpi_match_device_ids() on its parent
>>   device, where status is already set properly. Rewrite the commit message
>>   accordingly.
> 
> I've applied the v4 of this patch and I don't think there are any
> changes from it here.

Correct, there were only changes to the 4th patch in the series.

> As for the rest of the series I'll wait from comments from Wolfram and
> the other reviewers.

Ok, note if you've taken patch 1 you may also want to take patch 3 which
is an ACPI code cleanup made possible by patch 1 and otherwise is
unrelated.

Regards,

Hans
