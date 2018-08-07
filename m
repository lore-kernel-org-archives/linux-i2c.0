From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/4] ACPI / scan: Fix acpi_is_indirect_io_slave()
 always returning false
Date: Tue, 7 Aug 2018 12:41:26 +0200
Message-ID: <7d0cb757-a1a1-27bd-170c-87f602d5c22c@redhat.com>
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-2-hdegoede@redhat.com>
 <03dae627-a888-317a-ed43-6c374b1b54eb@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <03dae627-a888-317a-ed43-6c374b1b54eb@huawei.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Dann Frazier <dann.frazier@canonical.com>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 07-08-18 12:05, John Garry wrote:
> On 07/08/2018 09:05, Hans de Goede wrote:
>> Since commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to
>> initialize ACPI_TYPE_DEVICE devs") the status field of normal acpi_devices
>> gets set to 0 by acpi_bus_type_and_status() and filled with its actual
>> value later when acpi_add_single_object() calls acpi_bus_get_status().
>>
>> This means that status is 0 when acpi_device_enumeration_by_parent()
>> gets called which makes the acpi_match_device_ids() call in
>> acpi_is_indirect_io_slave() always return -ENOENT.
> 
> For for the (child) device the status may be zero, but how about the parent device (which is what we care about)? As I see, we would have set the parent device status present field at this stage.

Ah I did not notice you were calling acpi_match_device_ids() on the parents.
Yes I think you are right. This commit is still a necessary part of the
series, but it needs a completely new commit message no longer
referencing acpi_is_indirect_io_slave().

I will submit a v4 of this patch-set with new commit message for this patch.

Regards,

Hans






> 
> Thanks,
> John
> 
>>
>> This commit fixes this by making acpi_bus_type_and_status() set status to
>> ACPI_STA_DEFAULT until acpi_add_single_object() calls acpi_bus_get_status()
>>
>> Fixes: dfda4492322e ("ACPI / scan: Do not enumerate Indirect IO host children")
>> Cc: stable@vger.kernel.org
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Dann Frazier <dann.frazier@canonical.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/scan.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 970dd87d347c..6799d00dd790 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1612,7 +1612,8 @@ static int acpi_add_single_object(struct acpi_device **child,
>>       * Note this must be done before the get power-/wakeup_dev-flags calls.
>>       */
>>      if (type == ACPI_BUS_TYPE_DEVICE)
>> -        acpi_bus_get_status(device);
>> +        if (acpi_bus_get_status(device) < 0)
>> +            acpi_set_device_status(device, 0);
>>
>>      acpi_bus_get_power_flags(device);
>>      acpi_bus_get_wakeup_device_flags(device);
>> @@ -1690,7 +1691,7 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
>>           * acpi_add_single_object updates this once we've an acpi_device
>>           * so that acpi_bus_get_status' quirk handling can be used.
>>           */
>> -        *sta = 0;
>> +        *sta = ACPI_STA_DEFAULT;
>>          break;
>>      case ACPI_TYPE_PROCESSOR:
>>          *type = ACPI_BUS_TYPE_PROCESSOR;
>>
> 
> 
