From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Date: Tue, 27 Nov 2018 10:16:25 +0100
Message-ID: <98674437-9374-32d4-4b25-dedd0cad5bea@redhat.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-6-andriy.shevchenko@linux.intel.com>
 <20181127090432.GK2296@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127090432.GK2296@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 27-11-18 10:04, Mika Westerberg wrote:
> On Mon, Nov 26, 2018 at 05:08:50PM +0200, Andy Shevchenko wrote:
>> The caller would like to know the reason why the i2c_acpi_new_device() fails.
>> For example, if adapter is not available, it might be in the future and we
>> would like to re-probe the clients again. But at the same time we would like to
>> bail out if the error seems unrecoverable, such as out of memory condition.
>> To achieve this, return error pointer in some cases.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/i2c/i2c-core-acpi.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
>> index 32affd3fa8bd..af4b5bd5d973 100644
>> --- a/drivers/i2c/i2c-core-acpi.c
>> +++ b/drivers/i2c/i2c-core-acpi.c
>> @@ -387,6 +387,7 @@ struct notifier_block i2c_acpi_notifier = {
>>    * Also see i2c_new_device, which this function calls to create the i2c-client.
>>    *
>>    * Returns a pointer to the new i2c-client, or NULL if the adapter is not found.
>> + * In some cases might return an error pointer.
> 
> I would rather make it return error pointer always. Then the caller can
> just check for IS_ERR() and not need to deal with the possible NULL. It
> is also more consistent that way than saying "some cases might return an
> error pointer" (but some cases you get NULL or even pointer to the
> created object) ;-)

Good one, that will allow for a nice cleanup of the callers, we can make
i2c_acpi_new_device return -EPROBE_DEFER when the i2c_acpi_find_adapter_by_handle()
call fails, which is exactly the case when we want to defer.

One problem is that i2c_new_device() currently simply returns NULL on all
errors. Andy, you could take a look how much work it is to make that return
an ERR_PTR too, or just check its return value and return ERR_PTR(-ENXIO) if
it fails for now...

Regards,

Hans
