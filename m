From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width property
Date: Mon, 9 Jul 2018 10:52:44 +0200
Message-ID: <CAMRc=Mc4s6tJw6dAHYCPQdsPox9V8sBTqY3LHi5XMWALwOZdyA@mail.gmail.com>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
 <1530522740-2798-2-git-send-email-alanx.chiang@intel.com> <20180705212204.GA10449@rob-hp-laptop>
 <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain> <0772C36F3434E145A062D024A4869A09010B1E4D@PGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0772C36F3434E145A062D024A4869A09010B1E4D@PGSMSX101.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chiang, AlanX" <alanx.chiang@intel.com>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, Rob Herring <robh@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Yeh, Andy" <andy.yeh@intel.com>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "tfiga@chromium.org" <tfiga@chromium.org>, "jcliang@chromium.org" <jcliang@chromium.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.ker
List-Id: linux-i2c@vger.kernel.org

2018-07-09 5:12 GMT+02:00 Chiang, AlanX <alanx.chiang@intel.com>:
> Hi Robert,
>
>> -----Original Message-----
>> From: Robert P. J. Day [mailto:rpjday@crashcourse.ca]
>> Sent: Friday, July 6, 2018 4:24 AM
>> To: Rob Herring <robh@kernel.org>
>> Cc: Chiang, AlanX <alanx.chiang@intel.com>; linux-i2c@vger.kernel.org; Yeh,
>> Andy <andy.yeh@intel.com>; sakari.ailus@linux.intel.com;
>> andriy.shevchenko@linux.intel.com; Shevchenko, Andriy
>> <andriy.shevchenko@intel.com>; Mani, Rajmohan
>> <rajmohan.mani@intel.com>; andy.shevchenko@gmail.com;
>> tfiga@chromium.org; jcliang@chromium.org; brgl@bgdev.pl;
>> mark.rutland@arm.com; arnd@arndb.de; gregkh@linuxfoundation.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
>> property
>>
>> On Thu, 5 Jul 2018, Rob Herring wrote:
>>
>> > On Mon, Jul 02, 2018 at 05:12:19PM +0800, alanx.chiang@intel.com wrote:
>> > > From: Alan Chiang <alanx.chiang@intel.com>
>> > >
>> > > The AT24 series chips use 8-bit address by default. If some chips
>> > > would like to support more than 8 bits, the at24 driver should be
>> > > added the compatible field for specfic chips.
>> > >
>> > > Provide a flexible way to determine the addressing bits through
>> > > address-width in this patch.
>> > >
>> > > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
>> > > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
>> > > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> > >
>> > > ---
>> > > since v1:
>> > > -- Remove the address-width field in the example.
>> > > since v2:
>> > > -- Remove redundant space.
>> > > since v3:
>> > > -- Add Acked-by.
>> > >
>> > > ---
>> > >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>> > >  1 file changed, 2 insertions(+)
>> >
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>>
>>   "... should be added the compatible field ..."??
>>
>> rday
>
> Maybe I should modify the sentence as below that makes it clear.
> "The compatible field should be added in the at24.c for specific chips.".
>
> I quote Andy's words in patch v2:
> "The current at24 driver has no address width support, thus, reusing same
> (allocated) IDs (non-DT case) is hard."
>
> This is the reason that I submitted the patch.
>
> Thanks
>

Make it something like:

Currently the only way to use a variant of a supported model with
a different address width is to define a new compatible string and the
corresponding chip data structure.

Provide a flexible way to specify the size of the address pointer by
defining a new property: address-width.

Best regards,
Bartosz Golaszewski

>>
>> --
>>
>> ==========================================================
>> ==============
>> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>>                   http://crashcourse.ca/dokuwiki
>>
>> Twitter:                                       http://twitter.com/rpjday
>> LinkedIn:                               http://ca.linkedin.com/in/rpjday
>> ==========================================================
>> ==============
