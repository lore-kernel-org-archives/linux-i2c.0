From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [RESEND PATCH v6 5/6] i2c: designware: add SLAVE mode functions
Date: Fri, 17 Mar 2017 11:24:03 +0000
Message-ID: <4296eedb-aede-649c-8035-56342b096d9c@synopsys.com>
References: <cover.1488383202.git.lolivei@synopsys.com>
 <07463ebe12af8c88c21c24601cf54b0cd2077e07.1488383202.git.lolivei@synopsys.com>
 <be10879b-a81b-9047-6c67-45916a85ef31@linux.intel.com>
 <d6183e8c-5ff8-32c9-44ff-bef038ee0baa@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:45332 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdCQL0m (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Mar 2017 07:26:42 -0400
In-Reply-To: <d6183e8c-5ff8-32c9-44ff-bef038ee0baa@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 02-Mar-17 15:17, Luis Oliveira wrote:
> On 02-Mar-17 14:33, Jarkko Nikula wrote:
>> On 03/01/17 17:59, Luis Oliveira wrote:
>>> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
>>> - Slave functions added to core library file
>>> - Slave abort sources added to common source file
>>> - New driver: i2c-designware-slave added
>>> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>>>   when supported by the architecture.
>>>
>>> All the SLAVE flow is added but it is not enabled via platform
>>> driver.
>>>
>>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>>> ---
>>> V5->V6
>>> - Enable Slave mode using a different option (kbuild reported an error)
>>> - Identation fixes needed
>>> - Changed debug prints to dev_vdbg
>>> - Fixed slave enumeration
>>>
>>>  drivers/i2c/busses/Kconfig                 |  14 +-
>>>  drivers/i2c/busses/Makefile                |   1 +
>>>  drivers/i2c/busses/i2c-designware-common.c |   7 +
>>>  drivers/i2c/busses/i2c-designware-core.h   |   3 +
>>>  drivers/i2c/busses/i2c-designware-slave.c  | 403 +++++++++++++++++++++++++++++
>>>  5 files changed, 427 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/i2c/busses/i2c-designware-slave.c
>>>
>> ...
>>> diff --git a/drivers/i2c/busses/i2c-designware-common.c
>>> b/drivers/i2c/busses/i2c-designware-common.c
>>> index 6357c7c78f6d..24641635aa20 100644
>>> --- a/drivers/i2c/busses/i2c-designware-common.c
>>> +++ b/drivers/i2c/busses/i2c-designware-common.c
>>> @@ -56,6 +56,13 @@ static char *abort_sources[] = {
>>>          "trying to use disabled adapter",
>>>      [ARB_LOST] =
>>>          "lost arbitration",
>>> +    [ABRT_SLAVE_FLUSH_TXFIFO] =
>>> +        "read command so flush old data in the TX FIFO",
>>> +    [ABRT_SLAVE_ARBLOST] =
>>> +        "slave lost the bus while transmitting data to a remote master",
>>> +    [ABRT_SLAVE_RD_INTX] =
>>> +        "slave request for data to be transmitted and there is a 1 in "
>>> +        "bit 8 of IC_DATA_CMD",
>>>  };
>>
>> I know ABRT_SLAVE_RD_INTX case is from the specification but I would prefer here
>> one-line error text so it will be easier to grep from sources.
>>
>> I would like it to be also be more understandable. I don't know did I understood
>> it correctly but does it occur when attempting to read controller while
>> transmitting or something like that?
> 
> It happens in the "slave-transmitter" mode, when the processor side responds to
> a request for data to be transmitted and at the same time someone writes 1 to
> the bit 8 of the IC_DATA_CMD. This bit in "slave-transmitter" mode has to be "0"
> to indicate the data is to be transmitted.
> 
> In "slave-receiver" mode it has no purpose since writes to this register are not
> required.

If you agree for the v7 I can change it to "incorrect slave-transmitter mode
configuration", it's not as clear but it gives a clue of where the error comes from.

> 
>>
>>> diff --git a/drivers/i2c/busses/i2c-designware-core.h
>>> b/drivers/i2c/busses/i2c-designware-core.h
>>> index b620d76ffc8d..6c70945cccea 100644
>>> --- a/drivers/i2c/busses/i2c-designware-core.h
>>> +++ b/drivers/i2c/busses/i2c-designware-core.h
>>> @@ -277,6 +277,7 @@ struct dw_i2c_dev {
>>>      void            (*disable)(struct dw_i2c_dev *dev);
>>>      void            (*disable_int)(struct dw_i2c_dev *dev);
>>>      int            (*init)(struct dw_i2c_dev *dev);
>>> +    bool            mode;
>>>  };
>>>
>>
>> As I mentioned add here comment for "mode" not in patch 4/6.
>>
> Ok, I will.
> Thanks.
> 
