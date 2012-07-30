From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v6] ARM: davinci: i2c: add OF support
Date: Mon, 30 Jul 2012 09:02:14 +0200
Message-ID: <50163176.3000408@denx.de>
References: <1342514447-30810-1-git-send-email-hs@denx.de>
 <20120720105208.GB5971@pengutronix.de>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20120720105208.GB5971-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 20.07.2012 12:52, Wolfram Sang wrote:
> Hi,
>
> On Tue, Jul 17, 2012 at 10:40:47AM +0200, Heiko Schocher wrote:
>> add of support for the davinci i2c driver.
>>
>> Signed-off-by: Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>
>> Signed-off-by: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
>> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Cc: Wolfram Sang<w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Cc: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> Cc: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
>> Cc: Wolfgang Denk<wd-ynQEQJNshbs@public.gmane.org>
>> Cc: Sylwester Nawrocki<s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>
>> ---
>> - changes for v2:
>> - add comments from Sylwester Nawrocki<s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
>>    - use "cell-index" instead "id"
>>    - OF_DEV_AUXDATA in the machine code, instead pre-define platform
>>      device name
>> - add comment from Grant Likely:
>>    - removed "id" resp. "cell-index" completely
>>    - fixed documentation
>>    - use of_match_ptr()
>>    - use devm_kzalloc() for allocating plattform data mem
>>    - fixed a whitespace issue
>> - no changes for v3
>> - changes for v4
>>    remove "pinmux-handle" property as discussed here:
>>    http://www.spinics.net/lists/arm-kernel/msg175701.html
>>    with Nori Sekhar
>>
>> - changes for v5
>>    add comments from Grant Likely:
>>    - do not change value of dev->dev->platform_data, instead
>>      hold a copy in davinci_i2c_dev.
>>
>> - changes for v6:
>>    add comments from Sekhar Nori:
>>    - removed unneccessary include
>>    - merge patch from Sekhar Nori:
>>      setup the newly introduced dev->pdata member correctly once in
>>      probe ->  i2c_get_plattformdata(() not needed, remove a lot of
>>      checks for pdata in code
>>    - add Signed-off-by: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
>>    - patch no longer in patchserie, as it has no dependencies.
>> ---
>>   .../devicetree/bindings/arm/davinci/i2c.txt        |   31 ++++++++++++
>>   drivers/i2c/busses/i2c-davinci.c                   |   50 +++++++++++++++----
>>   2 files changed, 70 insertions(+), 11 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>> new file mode 100644
>> index 0000000..e98a025
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>
> This should go bindings/i2c/...

Ok, done.

>> @@ -0,0 +1,31 @@
>> +* Texas Instruments Davinci I2C
>> +
>> +This file provides information, what the device node for the
>> +davinci i2c interface contain.
>> +
>> +Required properties:
>> +- compatible: "ti,davinci-i2c";
>> +- reg : Offset and length of the register set for the device
>> +
>> +Recommended properties :
>> +- interrupts :<a>  standard interrupt property.
>> +- clock-frequency : desired I2C bus clock frequency in Hz.
>> +
>> +Optional properties:
>> +- bus-delay: bus delay in usec
>
> See my mail to Andrew regarding the timeout property in the mv64xxx
> driver. I'd like to skip the binding discussion for now in order to make
> it into 3.6. Is it okay for you to drop this binding and use a sane
> default?

Hmm.. current none of code uses 0 as default. This works for the
enbw_cmc board. So I use 0 as default, and remove this property.

>
> Rest looks good (from a visual review),

Thanks for the review.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
