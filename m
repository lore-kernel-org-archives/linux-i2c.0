From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Thu, 16 Mar 2017 09:28:16 -0300
Message-ID: <722860e3-290c-7854-ad4c-14d14dcad3c2@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
 <CAHp75VeU76YZUA45BO6uBrERfCqoZOow=oLvxauy8WY5adGZ+Q@mail.gmail.com>
 <1bfce335-7a66-9905-b196-47366bf73d37@osg.samsung.com>
 <CAHp75Vc1D7EYS0chi6nuZQzsqeLMZJEE6wwNayZhm=AKjuJFWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:53217
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752518AbdCPM20 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Mar 2017 08:28:26 -0400
In-Reply-To: <CAHp75Vc1D7EYS0chi6nuZQzsqeLMZJEE6wwNayZhm=AKjuJFWQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org

Hello Andy,

On 03/15/2017 07:43 PM, Andy Shevchenko wrote:
> On Wed, Mar 15, 2017 at 1:39 PM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> Hello Andy,
>>
>> On 03/15/2017 08:21 AM, Andy Shevchenko wrote:
>>> On Wed, Mar 15, 2017 at 12:58 PM, Javier Martinez Canillas
>>> <javier@osg.samsung.com> wrote:
>>>> On 03/15/2017 04:58 AM, Wolfram Sang wrote:
>>>
>>>> Unfortunately some maintainers do and don't accept patches adding I2C tables
>>>> only to have module autoloading working so I still think it should be fixed.
>>>
>>> Wait, how does it work for now?!
> 
>> It only works if you have an I2C device ID table, but that may not be the case
>> for DT-only drivers that could only have an OF device ID table. In the latter
>> case module autoload won't work.
> 
> OK.
> 
>>> Sounds for me you are trying to solve non-existing issue.
> 
>> It's an existing issue. You _must_ have an I2C device ID table if you want to
>> autload a device driver which is superfluous for DT-only drivers.
> 
> Okay, can you scope only affected drivers then? Looking to spread
> patches from you over all drivers I dunno they are all affected right
> now.
>

That's what I did. I've only posted patches for drivers that have DT support
but don't have an OF device ID table since module autoload will be broken for
those if the I2C core is fixed to report a proper OF modalias.

And drivers/misc/eeprom/at24.c is one of those drivers.
 
> P.S. Personally I agree with maintainers who do *not* apply this. Sorry.
> 

So what's your suggestion to solve the issue then? When I said that some
maintainers don't want a superfluous device table to be added I was talking
about I2C device ID table for DT-only drivers, but $SUBJECT is the opposite.

I've the impression that you are nacking $SUBJECT without fully understanding
what the problem is and how this patch + the patch for I2C core are fixing it.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
