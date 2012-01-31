From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
Date: Tue, 31 Jan 2012 08:31:26 +0100
Message-ID: <4F2798CE.1090804@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-6-git-send-email-hs@denx.de> <4F1DC480.4010603@gmail.com>
 <4F1E5B44.4090200@denx.de> <4F1E7F36.50505@samsung.com>
 <20120130201307.GV28397@ponder.secretlab.ca>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20120130201307.GV28397-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Grant,

Grant Likely wrote:
> On Tue, Jan 24, 2012 at 10:51:50AM +0100, Sylwester Nawrocki wrote:
>> Hello Heiko,
>>
>> On 01/24/2012 08:18 AM, Heiko Schocher wrote:
>>>> On 01/23/2012 09:56 AM, Heiko Schocher wrote:
>>>>> add of support for the davinci i2c driver.
>>>>>
>>>>> Signed-off-by: Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>
>>>>> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>>>>> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>>> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
>>>>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>>>>> Cc: Wolfram Sang<w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>>>> Cc: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>>>> Cc: Sekhar Nori<nsekhar-l0cyMroinI0@public.gmane.org>
>>>>> Cc: Wolfgang Denk<wd-ynQEQJNshbs@public.gmane.org>
>>>>> ---
>>>>>   .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
>>>>>   drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
>>>>>   2 files changed, 82 insertions(+), 0 deletions(-)
>>>>>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
[...]
>> Moreover you seem to overwrite platform device name and id,
>>
>> 		if (!of_property_read_u32(pdev->dev.of_node, "id",
>> +			&prop)) {
>> +			pdev->id = prop;
>> +			pdev->dev.init_name = kzalloc(20, GFP_KERNEL);
>> +			sprintf((char *)pdev->dev.init_name,
>> +				"i2c_davinci.%d", pdev->id);
>>
>> I'm not sure if it is a good practice.
> 
> No, it is not good practice.  At this point the device is already
> registered.  Changing the value of pdev->id will cause problems in the
> core code because the /sysfs files will have already been created.
> 
>> If you want to pre-define platform
>> device name (likely for the clock API to work), it might be more appropriate
>> to use OF_DEV_AUXDATA in the machine code, until there are clock bindings
>> available.
> 
> Yes, use OF_DEV_AUXDATA, but *only* if you need it for hooking up
> clocks, regulators, or similar.  Don't use it just because you want
> the device to have a different name for cosmetic reasons.  The need
> for AUXDATA should go away once the DT clock binding code is merged.

I now use OF_DEV_AUXDATA in board code, "id" nor "cell-index" used:

struct of_dev_auxdata enbw_cmc_auxdata_lookup[] __initdata = {
        OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
        OF_DEV_AUXDATA("ti,davinci-i2c", 0x01e28000, "i2c_davinci.2", NULL),
        {}
};

This is needed for hooking up clocks, see:
arch/arm/mach-davinci/da850.c
static struct clk_lookup da850_clks
[...]
        CLK("i2c_davinci.1",    NULL,           &i2c0_clk),
[...]
        CLK("i2c_davinci.2",    NULL,           &i2c1_clk),

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
