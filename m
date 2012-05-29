From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v4 5/7] ARM: davinci: i2c: add OF support
Date: Tue, 29 May 2012 15:28:21 +0200
Message-ID: <4FC4CEF5.2030206@denx.de>
References: <1337694920-8925-1-git-send-email-hs@denx.de>
 <1337694920-8925-6-git-send-email-hs@denx.de>
 <20120526060854.A9BB93E2E10@localhost>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20120526060854.A9BB93E2E10@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Grant,

Am 26.05.2012 08:08, Grant Likely wrote:
> On Tue, 22 May 2012 15:55:18 +0200, Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>  wrote:
>> add of support for the davinci i2c driver.
>>
>> Signed-off-by: Heiko Schocher<hs-ynQEQJNshbs@public.gmane.org>
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
>> ---
>>   .../devicetree/bindings/arm/davinci/i2c.txt        |   31 +++++++++++++++++++
>>   drivers/i2c/busses/i2c-davinci.c                   |   32 ++++++++++++++++++++
>>   2 files changed, 63 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
[...]
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index a76d85f..c1783bb 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
[...]
>> @@ -676,6 +685,26 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>   	dev->irq = irq->start;
>>   	platform_set_drvdata(pdev, dev);
>>
>> +	if ((dev->dev->platform_data == NULL)&&
>> +		(pdev->dev.of_node)) {
>> +		struct davinci_i2c_platform_data *pdata;
>> +		u32 prop;
>> +
>> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> +		if (!pdata) {
>> +			r = -ENOMEM;
>> +			goto err_free_mem;
>> +		}
>> +		memcpy(pdata,&davinci_i2c_platform_data_default,
>> +			sizeof(*pdata));
>> +		dev->dev->platform_data = pdata;
>
> This is actually illegal.  Drivers must not change the value of
> dev->dev->platform_data.  It messes up unbinding/rebinding drivers.
> You'll need to have a copy of the pointer in davinci_i2c_dev.

fixed.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
