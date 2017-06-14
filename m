From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH v11 5/6] i2c: designware: add SLAVE mode functions
Date: Wed, 14 Jun 2017 14:06:45 +0100
Message-ID: <6e332d71-1891-21aa-4479-b91a7550f8af@synopsys.com>
References: <cover.1497025304.git.lolivei@synopsys.com>
 <bef9f237bed23f0ea05499b085103f7eea9058a1.1497025304.git.lolivei@synopsys.com>
 <CAHp75VeHoUrq-PfayNZYGP0f-bbnKQQEN4uMBg6ZASJs46b_PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:36856 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdFNNH1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Jun 2017 09:07:27 -0400
In-Reply-To: <CAHp75VeHoUrq-PfayNZYGP0f-bbnKQQEN4uMBg6ZASJs46b_PQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com

On 14-Jun-17 13:20, Andy Shevchenko wrote:
> On Wed, Jun 14, 2017 at 1:43 PM, Luis Oliveira
> <Luis.Oliveira@synopsys.com> wrote:
>> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
>> - Slave functions added to core library file
>> - Slave abort sources added to common source file
>> - New driver: i2c-designware-slave added
>> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>>   when supported by the architecture.
>>
>> All the SLAVE flow is added but it is not enabled via platform
>> driver.
> 
>> +       //~ if (stat & DW_IC_INTR_TX_OVER)
>> +               //~ dw_readl(dev, DW_IC_CLR_TX_OVER);
> 
> If you are going to ignore reviewers' comments you will delay your
> work to be applied.
> 
Im so sorry. I was doing some tests on the irq_handler and used the wrong branch
to create the patchset.
Believe me I've looked for mistakes like this but I've read the code so many
times I don't think I can see the obvious anymore.

> Certainly you are about to miss v4.13.
> 
