From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v6] platform/x86: Add Intel Cherry Trail ACPI INT33FE
 device driver
Date: Fri, 7 Apr 2017 08:49:55 +0200
Message-ID: <66d4f7cc-4f4b-f912-ca8a-50fd248cc405@redhat.com>
References: <20170406072436.12898-1-hdegoede@redhat.com>
 <1491476636.24567.25.camel@linux.intel.com>
 <8b6df86e-06eb-5be8-ee8c-9af980691fa5@redhat.com>
 <20170406224815.GA13110@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170406224815.GA13110@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 07-04-17 00:48, Darren Hart wrote:
> On Thu, Apr 06, 2017 at 02:17:11PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 06-04-17 13:03, Andy Shevchenko wrote:
>>> On Thu, 2017-04-06 at 09:24 +0200, Hans de Goede wrote:
>>>> The INT33FE ACPI device has a CRS table with I2cSerialBusV2 resources
>>>> for
>>>> 3 devices: Maxim MAX17047 Fuel Gauge Controller, FUSB302 USB Type-C
>>>> Controller and PI3USB30532 USB switch.
>>>>
>>>> This commit adds a driver for this ACPI device which instantiates
>>>> i2c-clients for these, so that the standard i2c drivers for these
>>>> chips
>>>> can bind to the them.
>>>
>>> Given one more thought, if the devices should be present all to make it
>>> work, than you perhaps may use component framework.
>>
>> Actually the fuel-guage is completely independent, the PI3USB30532 USB
>> switch will get set based on extcon cable events from the FUSB302 USB
>> Type-C controller, but otherwise both drivers are independent and the
>> FUSB302 USB Type-C controller pretty much operates stand-alone.
>>
>>> In this case this so called "pseudo" device is not so pseudo, but
>>> "master".
>>
>> I think this is really some Windows weirdness, if I configure the BIOS
>> to boot "Android" the ACPI INT33FE device goes away and instead I
>> get 3 separate ACPI devices for the 3 chips.
>
> So if this is this case, what is the value in supporting "windows weirdness" if
> the end user can select "Android" and be presented with 3 separate devices?

Multiple reasons:

1) Multi-boot with windows without needing to toggle a BIOS option all the time
2) Many of these devices only ship with windows, the Android option is there
from the BIOS template code they used, but is untested, so this may give us
the 3 separate devices but at the same time break other stuff
3) On some devices the BIOS tries to autodetect the OS, overriding the BIOS option
4) On some devices, including the one I'm developing on, but I can "fix" this with
a BIOS downgrade, this option has been locked to avoid 2.
5) Users really should not need to touch BIOS settings ever

My main goal for Linux on Bay Trail / Cherrytrail devices is for everything to
just work independent of the OSID setting and I'm afraid that this is also
necessary to properly support al variants of hw out there. E.g. My cube iwork8
air does 3. from the above list, so if I do:

touch /boot/efi/EFI/BOOT/BOOTX64.EFI
reboot

OSID = 1 (BIOS thinks it is running Windows 8.1 / 10)

And if I then do:

rm /boot/efi/EFI/BOOT/BOOTX64.EFI
reboot

OSID = 4 (BIOS thinks it is running Android)

Independent of the option I select in the BIOS.

Also I would like to point out that the entire pseudo-driver including
copyright header is only 144 lines, so it is not like we need a crazy
amount of code to deal with this.

Regards,

Hans
