From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v3] ACPI: Force I2C to be selected as a built-in module
Date: Thu, 25 Jan 2018 12:07:10 -0500
Message-ID: <8637b666-19ce-5382-adab-94a9382cf635@codeaurora.org>
References: <1516895011-17588-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0h2TOvoNGx5nYU0yVp_GJCxLTStSY=mp2YMbazhfq3x9g@mail.gmail.com>
 <ae7f4499-d697-6703-52d5-7ab6d7a4b150@codeaurora.org>
 <CAJZ5v0h_xQTQ48OgN9EdorYTjBhXk4JZ2HMfAYebC3FUqrGEOg@mail.gmail.com>
 <4aee44cd-4eb0-162c-3dcc-fbf6255109ac@codeaurora.org>
 <CAJZ5v0ji0pJTSR8Z9Yabgu-A_KJ2wx3hF-gzoSEeaKwFd2m+iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeAYRHN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 25 Jan 2018 12:07:13 -0500
In-Reply-To: <CAJZ5v0ji0pJTSR8Z9Yabgu-A_KJ2wx3hF-gzoSEeaKwFd2m+iw@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Eric Auger <eric.auger@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On 1/25/2018 11:57 AM, Rafael J. Wysocki wrote:
>> That was the original patch. Folks are saying that it breaks some systems.
>>
>> Conversation is here:
>>
>> https://patchwork.kernel.org/patch/10142425/
> Couldn't that be addressed by preventing the I2C module from being
> unloaded in the relevant cases?
> 

Maybe, I'll let Andy And Hans speak for themselves. It is not my code.

I listed the spec behavior and expectation from the OS in the link above.
Apparently, Linux isn't playing nice.

Hans is also raising a concern about driver load order that is not being
handled well between the I2C driver, its sub modules like PMIC and the ACPI support.

"Lets pretend that all DSTDs are perfect and that some device described in ACPI
has a _PS0 method which uses an opregion to turn on some regulator powering
the device through i2c, but only if the _REG method for that opregion has
been called. So now lets say that the driver for this device loads and
tries to bind before the i2c-module has loaded. Before the driver's probe
method gets called the driver-core will call _PS0 to power-up the device,
which is a nop (*). Then the drivers probe function tries to talk to the
device, but fails as the device is not powered, so it returns with -ENODEV."

I'd think that driver would return -EPROBE_DEFER in order to wait until its
dependencies come in place. Maybe, driver was not designed for this.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
