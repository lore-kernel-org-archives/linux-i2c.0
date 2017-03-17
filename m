From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RESEND PATCH v6 5/6] i2c: designware: add SLAVE mode functions
Date: Fri, 17 Mar 2017 15:29:17 +0200
Message-ID: <885561e7-ef1e-172d-fe39-7b9effecf175@linux.intel.com>
References: <cover.1488383202.git.lolivei@synopsys.com>
 <07463ebe12af8c88c21c24601cf54b0cd2077e07.1488383202.git.lolivei@synopsys.com>
 <be10879b-a81b-9047-6c67-45916a85ef31@linux.intel.com>
 <d6183e8c-5ff8-32c9-44ff-bef038ee0baa@synopsys.com>
 <4296eedb-aede-649c-8035-56342b096d9c@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4296eedb-aede-649c-8035-56342b096d9c-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/17/17 13:24, Luis Oliveira wrote:
> On 02-Mar-17 15:17, Luis Oliveira wrote:
>> On 02-Mar-17 14:33, Jarkko Nikula wrote:
>>> On 03/01/17 17:59, Luis Oliveira wrote:
>>>> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
>>>> - Slave functions added to core library file
>>>> - Slave abort sources added to common source file
>>>> - New driver: i2c-designware-slave added
>>>> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>>>>   when supported by the architecture.
>>>>
>>>> All the SLAVE flow is added but it is not enabled via platform
>>>> driver.
>>>>
>>>> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>> V5->V6
>>>> - Enable Slave mode using a different option (kbuild reported an error)
>>>> - Identation fixes needed
>>>> - Changed debug prints to dev_vdbg
>>>> - Fixed slave enumeration
>>>>
>>>>  drivers/i2c/busses/Kconfig                 |  14 +-
>>>>  drivers/i2c/busses/Makefile                |   1 +
>>>>  drivers/i2c/busses/i2c-designware-common.c |   7 +
>>>>  drivers/i2c/busses/i2c-designware-core.h   |   3 +
>>>>  drivers/i2c/busses/i2c-designware-slave.c  | 403 +++++++++++++++++++++++++++++
>>>>  5 files changed, 427 insertions(+), 1 deletion(-)
>>>>  create mode 100644 drivers/i2c/busses/i2c-designware-slave.c
>>>>
>>> ...
>>>> diff --git a/drivers/i2c/busses/i2c-designware-common.c
>>>> b/drivers/i2c/busses/i2c-designware-common.c
>>>> index 6357c7c78f6d..24641635aa20 100644
>>>> --- a/drivers/i2c/busses/i2c-designware-common.c
>>>> +++ b/drivers/i2c/busses/i2c-designware-common.c
>>>> @@ -56,6 +56,13 @@ static char *abort_sources[] = {
>>>>          "trying to use disabled adapter",
>>>>      [ARB_LOST] =
>>>>          "lost arbitration",
>>>> +    [ABRT_SLAVE_FLUSH_TXFIFO] =
>>>> +        "read command so flush old data in the TX FIFO",
>>>> +    [ABRT_SLAVE_ARBLOST] =
>>>> +        "slave lost the bus while transmitting data to a remote master",
>>>> +    [ABRT_SLAVE_RD_INTX] =
>>>> +        "slave request for data to be transmitted and there is a 1 in "
>>>> +        "bit 8 of IC_DATA_CMD",
>>>>  };
>>>
>>> I know ABRT_SLAVE_RD_INTX case is from the specification but I would prefer here
>>> one-line error text so it will be easier to grep from sources.
>>>
>>> I would like it to be also be more understandable. I don't know did I understood
>>> it correctly but does it occur when attempting to read controller while
>>> transmitting or something like that?
>>
>> It happens in the "slave-transmitter" mode, when the processor side responds to
>> a request for data to be transmitted and at the same time someone writes 1 to
>> the bit 8 of the IC_DATA_CMD. This bit in "slave-transmitter" mode has to be "0"
>> to indicate the data is to be transmitted.
>>
>> In "slave-receiver" mode it has no purpose since writes to this register are not
>> required.
>
> If you agree for the v7 I can change it to "incorrect slave-transmitter mode
> configuration", it's not as clear but it gives a clue of where the error comes from.
>
I'm fine with it. I think it's more understandable.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
