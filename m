From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Thu, 16 Mar 2017 00:43:44 +0200
Message-ID: <CAHp75Vc1D7EYS0chi6nuZQzsqeLMZJEE6wwNayZhm=AKjuJFWQ@mail.gmail.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com> <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com> <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com> <CAHp75VeU76YZUA45BO6uBrERfCqoZOow=oLvxauy8WY5adGZ+Q@mail.gmail.com>
 <1bfce335-7a66-9905-b196-47366bf73d37@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1bfce335-7a66-9905-b196-47366bf73d37@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 15, 2017 at 1:39 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Andy,
>
> On 03/15/2017 08:21 AM, Andy Shevchenko wrote:
>> On Wed, Mar 15, 2017 at 12:58 PM, Javier Martinez Canillas
>> <javier@osg.samsung.com> wrote:
>>> On 03/15/2017 04:58 AM, Wolfram Sang wrote:
>>
>>> Unfortunately some maintainers do and don't accept patches adding I2C tables
>>> only to have module autoloading working so I still think it should be fixed.
>>
>> Wait, how does it work for now?!

> It only works if you have an I2C device ID table, but that may not be the case
> for DT-only drivers that could only have an OF device ID table. In the latter
> case module autoload won't work.

OK.

>> Sounds for me you are trying to solve non-existing issue.

> It's an existing issue. You _must_ have an I2C device ID table if you want to
> autload a device driver which is superfluous for DT-only drivers.

Okay, can you scope only affected drivers then? Looking to spread
patches from you over all drivers I dunno they are all affected right
now.

P.S. Personally I agree with maintainers who do *not* apply this. Sorry.

-- 
With Best Regards,
Andy Shevchenko
