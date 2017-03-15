From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Wed, 15 Mar 2017 07:58:26 -0300
Message-ID: <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170315075835.GA1438@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 03/15/2017 04:58 AM, Wolfram Sang wrote:
> 
>> So there isn't an agreement if is better to just rely in the current behavior
>> (and have a superfluous I2C device ID table) or fix the I2C core (and need a
>> OF device ID table).
> 
> For at24, the i2c_device_id table is not superfluous! It is used outside
> the DT world as well.
>

Yes, I know. I was trying to explain to Andy what's the problem that I want to
solve in general, not talking about this particular driver. Sorry if that was
confusing.
 
>> Indeed, but these all are compatible strings used by DTS in mainline and so
>> should be in the OF device ID table in order to be matched and the proper
>> modalias reported (once the I2C core is fixed).
> 
> I'd think we should fix the DTS files instead to contain a fallback we
> agree on. Say, we agree on "atmel,at24c01" as a the generic fallback,
> the DTS should contain:
> 
> 	compatible = "<your_vendor>,<your_type>", "atmel,at24c01"
> 
> And we shall only keep compatible values in the source file which differ
> in behaviour fromt the generic case.
>

Do you know who that's familiar with this device and driver can do this? I've
been trying to fix all the drivers that are relying on having an I2C ID table
but whose devices are registered via DT and I've now posted patches for all.

I wanted to do that so this patch can finally land [0] but to be honest I'm
about to give up on this... it seems is causing a lot of churn to maintainers
and many don't see the benefit on having the I2C core to report a proper OF
modalias, and don't think the current behavior is particularly bad.

Unfortunately some maintainers do and don't accept patches adding I2C tables
only to have module autoloading working so I still think it should be fixed.

[0]: https://patchwork.kernel.org/patch/6903991/

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
