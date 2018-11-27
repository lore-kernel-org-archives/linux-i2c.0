From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Date: Tue, 27 Nov 2018 16:24:41 +0100
Message-ID: <beaa7a4d-4548-7be9-604d-f9b80dee3980@redhat.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-6-andriy.shevchenko@linux.intel.com>
 <20181127090432.GK2296@lahna.fi.intel.com>
 <98674437-9374-32d4-4b25-dedd0cad5bea@redhat.com>
 <20181127114953.GQ2296@lahna.fi.intel.com>
 <20181127134623.GR10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127134623.GR10650@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 27-11-18 14:46, Andy Shevchenko wrote:
> On Tue, Nov 27, 2018 at 01:49:53PM +0200, Mika Westerberg wrote:
>> On Tue, Nov 27, 2018 at 10:16:25AM +0100, Hans de Goede wrote:
>>> One problem is that i2c_new_device() currently simply returns NULL on all
>>> errors. Andy, you could take a look how much work it is to make that return
>>> an ERR_PTR too, or just check its return value and return ERR_PTR(-ENXIO) if
>>> it fails for now...
>>
>> I would use -ENODEV here and -EINVAL in case there is no ACPI companion :)
> 
> Sounds more traditional than ENXIO.
> I would go the way Mika proposed if there is no objection.

Works for me, go for it.

Regards,

Han
