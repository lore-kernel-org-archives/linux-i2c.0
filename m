From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Fri, 6 Jan 2017 17:46:33 +0000
Message-ID: <c73ee9ab-64a1-0419-314d-21d4575ca7bf@synopsys.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
 <CAHp75VdB+pApFgjFOwWYYQFUmxv5k6OYKgB4fstuy=3=2QesBQ@mail.gmail.com>
 <475d9c2a-da11-97d0-d0b6-37ccd4990f18@synopsys.com>
 <CAHp75Vdv3daVnkFmGc7gXWoqcy+CNgyqdtRXkvTJQpjyJX3eDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:52358 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdAFRqi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 6 Jan 2017 12:46:38 -0500
In-Reply-To: <CAHp75Vdv3daVnkFmGc7gXWoqcy+CNgyqdtRXkvTJQpjyJX3eDg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro.Oliveira@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com

On 06-Jan-17 17:17, Andy Shevchenko wrote:
> On Fri, Jan 6, 2017 at 7:15 PM, Luis Oliveira
> <Luis.Oliveira@synopsys.com> wrote:
>> On 06-Jan-17 16:29, Andy Shevchenko wrote:
>>> On Thu, Jan 5, 2017 at 7:24 PM, Luis Oliveira
> 
>>> Please, add kernel doc description here, important thing is to explain
>>> return codes in Return: section of it.
>>>
>>>> +int i2c_slave_mode_detect(struct device *dev)
> 
> Just to make sure you didn't miss this one.
> 
> 
Yes, I saw it. You were talking of something like this, right?

/**
 * i2c_slave_mode_detect - detect operation mode
 * @dev:  The device owning the bus
 *
 * This checks the device nodes for a I2C slave by checking the address
 * used.
 *
 * Returns true if a I2C slave is detected, otherwise returns false.
 */
