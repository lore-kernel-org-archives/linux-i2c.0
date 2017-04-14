From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 0/4] i2c-core improvements for acpi devices + ACPI
 INT33FE driver
Date: Fri, 14 Apr 2017 14:34:16 +0200
Message-ID: <1a01f3d0-3d14-9f93-e789-cf1f0232becc@redhat.com>
References: <20170404220335.9815-1-hdegoede@redhat.com>
 <20170413190933.GA9783@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170413190933.GA9783@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 13-04-17 21:09, Darren Hart wrote:
> On Wed, Apr 05, 2017 at 12:03:31AM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Here is v5 of my patch-set for my i2c-core improvements for acpi
>> devices + the ACPI INT33FE platform driver.
>>
>> New in this version are some minor fixed to the INT33FE driver.
>>
>> The INT33FE driver depends on the i2c-core changes, so if
>> it is ok with Darren / Andy I believe it would be best for
>> this driver to be merged through the i2c subsys tree (with
>> their ack).
>
> Is there an immutable i2c branch I can merge with these changes in order to add
> the Cherry Trail driver on top of those?

The i2c-core patches have been reviewed, but to the best of my
knowledge they have not been merged yet.

Wolfram, what is the status of this ?

Regards,

Hans
