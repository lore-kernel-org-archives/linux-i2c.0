From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Tue, 14 Mar 2017 21:15:39 -0300
Message-ID: <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44733
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751033AbdCOAPt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Mar 2017 20:15:49 -0400
In-Reply-To: <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Hello Andy,

On 03/14/2017 07:59 PM, Andy Shevchenko wrote:
> On Tue, Mar 14, 2017 at 5:16 PM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
> 
> I'm bot sure this patch does something useful right now. Can we
> survive without it? I think we may.
> 

Yes, we can survive without it for now. But the problem is that with current
I2C core, DT-only I2C drivers must have an I2C device table in order to have
module auto-load working. That's because the core always reports as modalias
i2c:<foo> regardless if the device was registered via DT or legacy mechanism.

And some maintainers don't accept patches doing this duplication and instead
ask for the core to be fixed, i.e [0]. But to make sure that fixing the core
won't add regressions in drivers that are relying in the current behavior,
patches like $SUBJECT are needed.

So there isn't an agreement if is better to just rely in the current behavior
(and have a superfluous I2C device ID table) or fix the I2C core (and need a
OF device ID table). I personally prefer the latter since that means that an
DT-only driver will only need a OF table, and only drivers that supports both
will need both tables.

>>  drivers/misc/eeprom/at24.c | 189 ++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 188 insertions(+), 1 deletion(-)
> 
> It's a huge! It will increase not only driver code base but memory
> footprint for almost no benefit.
>

Indeed, but these all are compatible strings used by DTS in mainline and so
should be in the OF device ID table in order to be matched and the proper
modalias reported (once the I2C core is fixed).

One option is to add #ifdef CONFIG_OF guards for the OF device table definition
but again there's no agreement on that one since some maintainers say the it is
better to always build the OF ID table than having #ifdefery in C code...

[0]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1321026.html

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
