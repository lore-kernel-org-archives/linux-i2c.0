From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Thu, 16 Mar 2017 10:13:00 -0300
Message-ID: <5da325d0-59d4-92e8-350f-43c25310dabb@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
 <20170316130714.n42zkjdei7pm7vgw@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170316130714.n42zkjdei7pm7vgw@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 03/16/2017 10:07 AM, Wolfram Sang wrote:
> 
>>> I'd think we should fix the DTS files instead to contain a fallback we
>>> agree on. Say, we agree on "atmel,at24c01" as a the generic fallback,
>>> the DTS should contain:
>>>
>>> 	compatible = "<your_vendor>,<your_type>", "atmel,at24c01"
>>>
>>> And we shall only keep compatible values in the source file which differ
>>> in behaviour fromt the generic case.
>>>
>>
>> Do you know who that's familiar with this device and driver can do this? I've
> 
> Sorry, I don't understand your question. What do you mean?
> 

Sorry, for not explaining myself correctly. I meant to ask who can do what you
suggested before. I'm certainly not familiar with this driver to identify what
is the minimum set of compatible strings that can be used as generic fallback.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
