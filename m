From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 0/3] i2c: Hookup typec power-negotation to the PMIC and
 charger
Date: Sat, 14 Oct 2017 14:04:11 +0200
Message-ID: <e875d3d3-d62c-7363-e596-9c0dbeadce5d@redhat.com>
References: <20171011094121.6108-1-hdegoede@redhat.com>
 <CAHp75VeqskRsmedvA3eAx27o8WeZzH44880T=Q=+1mD+1nSSAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeqskRsmedvA3eAx27o8WeZzH44880T=Q=+1mD+1nSSAg@mail.gmail.com>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 14-10-17 12:45, Andy Shevchenko wrote:
> On Wed, Oct 11, 2017 at 12:41 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi All,
>>
>> These are the last 3 patches from all my work to add support for
>> USB PD charging to Intel Cherry Trail devices with a Whiskey Cove PMIC
>> and fusb302 Type-C controller.
>>
>> With these 3 patches these devices change from slowly discharging
>> at 5V 0.5A to actually charging at 12V 2A, so getting these upstream
>> is important for users of these devices.
>>
>> Wolfram does not really have time to review the first 2 patches, so if
>> someone else (from the people in the Cc) can review the first 2 patches
>> and esp. the first patch, so that we can get this merged for 4.15, then
>> that would be great.
> 
> The person comes to my mind is Heikki,
> Though I dunno he has time either.

The first patch, although it is an i2c-core change, is really
quite simple. I believe anyone can review it. But it does need
someone other then me to take a proper look (and not just do
a code only review) because it is a core change. Maybe there
is another way to solve the problem (persistent / predictable
device-names for i2c devices instantiated through board-data),
but I don't think so.

Also note this is all kernel internal stuff, so we can always
change it later. Although it would be better to get it right in
one go.

Regards,

Hans
