From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 11:10:33 -0500
Message-ID: <657b80d6-a880-e504-7f85-6a2dc47e0f8a@codeaurora.org>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
 <20180124055615.c3qwhwnj7spmcr3w@ninjato>
 <20180124062725.GK27654@lahna.fi.intel.com>
 <f498c1ef-0e15-3956-8e70-bca53ec2cac4@codeaurora.org>
 <CAHp75VexHQS20azPFO5uv+sBQ4QYVXL+yhT56EhT+QmNZfzMFg@mail.gmail.com>
 <54ef10bd-6209-6983-1d3a-ddf7d7fea252@redhat.com>
 <f918bbf3-1f9a-df63-9906-7147620ee6cf@codeaurora.org>
 <26d6761c-17c9-73d8-42d6-25815b58bc87@redhat.com>
 <17f80dc5-126e-bf1e-8bcc-95a1e66cd271@codeaurora.org>
 <bb50db91-f37a-46da-138d-826237ac69f7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bb50db91-f37a-46da-138d-826237ac69f7@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 1/24/2018 11:09 AM, Hans de Goede wrote:
>>>> There must be a middle ground somewhere.
>>>
>>> One thing which comes to mind is to simply not allow building i2c as a module
>>> when ACPI is selected, something like this should work I think:
>>>
>>>   config I2C
>>>           tristate "I2C support"
>>>           select RT_MUTEXES
>>>           select IRQ_DOMAIN
>>> +        # force building I2C in on ACPI systems, for opregion availability
>>> +        depends on y || !ACPI
>>
>> This works for me.
> 
> OK, so feel free to turn it into a proper patch and submit it
> upstream.

OK. Let me do some build tests.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
