From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Sat, 7 Jan 2017 01:43:31 +0200
Message-ID: <b5788d1d-c951-0fc3-eed8-88457df1f27e@mleia.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
 <73246c4a-504c-52d7-dde4-970a45dca0bd@mleia.com>
 <CAHp75Ve87TE3y6hg1bMxSFAPVcY3wPifGuvtpXNhBw5-eOnPrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:49883 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969904AbdAFXnf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Jan 2017 18:43:35 -0500
In-Reply-To: <CAHp75Ve87TE3y6hg1bMxSFAPVcY3wPifGuvtpXNhBw5-eOnPrg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro.Oliveira@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com

On 01/07/2017 12:45 AM, Andy Shevchenko wrote:
> On Fri, Jan 6, 2017 at 11:46 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>>> +     if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
>>
>> IS_BUILTIN(CONFIG_OF) looks excessive, check for non-NULL dev->of_node
>> should be sufficient.
> 
> Sorry, but you missed the point.
> This will enable compile time optimization and basically be collapsed to no-op.
> 

Good point, do you plan to add more "IS_BUILTIN(CONFIG_OF)" checks all
over the code to reduce the size of the built image? 

>>> +             }
>>> +     } else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
>>> +             dev_dbg(dev, "ACPI slave is not supported yet\n");
>>> +     }
>>
>> If so, then it might be better to drop else-if stub for now.
> 
> Please, don't.
> 

Why do you ask for this stub to be added?

--
With best wishes,
Vladimir
