From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 17:09:22 +0100
Message-ID: <bb50db91-f37a-46da-138d-826237ac69f7@redhat.com>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
 <20180124055615.c3qwhwnj7spmcr3w@ninjato>
 <20180124062725.GK27654@lahna.fi.intel.com>
 <f498c1ef-0e15-3956-8e70-bca53ec2cac4@codeaurora.org>
 <CAHp75VexHQS20azPFO5uv+sBQ4QYVXL+yhT56EhT+QmNZfzMFg@mail.gmail.com>
 <54ef10bd-6209-6983-1d3a-ddf7d7fea252@redhat.com>
 <f918bbf3-1f9a-df63-9906-7147620ee6cf@codeaurora.org>
 <26d6761c-17c9-73d8-42d6-25815b58bc87@redhat.com>
 <17f80dc5-126e-bf1e-8bcc-95a1e66cd271@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38748 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934067AbeAXQJZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 24 Jan 2018 11:09:25 -0500
Received: by mail-wm0-f68.google.com with SMTP id 141so9555318wme.3
        for <linux-i2c@vger.kernel.org>; Wed, 24 Jan 2018 08:09:24 -0800 (PST)
In-Reply-To: <17f80dc5-126e-bf1e-8bcc-95a1e66cd271@codeaurora.org>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

On 24-01-18 16:37, Sinan Kaya wrote:
> On 1/24/2018 10:23 AM, Hans de Goede wrote:
>>> There must be a middle ground somewhere.
>>
>> One thing which comes to mind is to simply not allow building i2c as a module
>> when ACPI is selected, something like this should work I think:
>>
>>   config I2C
>>           tristate "I2C support"
>>           select RT_MUTEXES
>>           select IRQ_DOMAIN
>> +        # force building I2C in on ACPI systems, for opregion availability
>> +        depends on y || !ACPI
> 
> This works for me.

OK, so feel free to turn it into a proper patch and submit it
upstream.

Regards,

Hans
