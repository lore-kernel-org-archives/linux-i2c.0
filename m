From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Wed, 15 Mar 2017 08:39:19 -0300
Message-ID: <1bfce335-7a66-9905-b196-47366bf73d37@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
 <CAHp75VeU76YZUA45BO6uBrERfCqoZOow=oLvxauy8WY5adGZ+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeU76YZUA45BO6uBrERfCqoZOow=oLvxauy8WY5adGZ+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Andy,

On 03/15/2017 08:21 AM, Andy Shevchenko wrote:
> On Wed, Mar 15, 2017 at 12:58 PM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> On 03/15/2017 04:58 AM, Wolfram Sang wrote:
> 
>> Unfortunately some maintainers do and don't accept patches adding I2C tables
>> only to have module autoloading working so I still think it should be fixed.
> 
> Wait, how does it work for now?!
>

It only works if you have an I2C device ID table, but that may not be the case
for DT-only drivers that could only have an OF device ID table. In the latter
case module autoload won't work.

> Sounds for me you are trying to solve non-existing issue.
>

It's an existing issue. You _must_ have an I2C device ID table if you want to
autload a device driver which is superfluous for DT-only drivers.

In other words, if you register an I2C device using OF the modalias will be:

$ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
i2c:maxtouch

While the correct thing to report should be:

$ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
of:NtrackpadT<NULL>Catmel,maxtouch

>> [0]: https://patchwork.kernel.org/patch/6903991/
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
