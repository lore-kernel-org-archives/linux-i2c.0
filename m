From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Mon, 20 Mar 2017 13:45:03 -0300
Message-ID: <181e4010-98e4-359c-998b-312920a59084@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
 <20170316130714.n42zkjdei7pm7vgw@ninjato>
 <5da325d0-59d4-92e8-350f-43c25310dabb@osg.samsung.com>
 <20170316133645.3nlr75gjhx7io7mv@ninjato>
 <b4e993ce-4630-6d89-077b-e2f18fadef02@osg.samsung.com>
 <20170316150549.GA3988@katana>
 <21663b26-8581-b8d6-7bab-7e7b65798a6a@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21663b26-8581-b8d6-7bab-7e7b65798a6a@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieranbingham@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

On 03/16/2017 12:39 PM, Javier Martinez Canillas wrote:
> On 03/16/2017 12:05 PM, Wolfram Sang wrote:

[snip]

>>
>> Next time, maybe do a wiki page and point people to it? That being said,
>> we should probably create a wiki page on the I2C wiki anyhow.
>> Documenting the current state of affairs. That I would do when I finally
>> get around to brush up I2C wiki.
>>
> 
> Agreed, I can help writing such a wiki page if you want. I've already requested for
> an account at https://i2c.wiki.kernel.org.
> 

FYI, I've added a page to the wiki explaining the current issues with the I2C core
MODALIAS uevent reporting and OF match:

https://i2c.wiki.kernel.org/index.php/OF_Modalias

And also linked to the main page in the work-in-progress section:

https://i2c.wiki.kernel.org/index.php/Main_Page#Work_in_progress

Please feel free to add/remove/change anything that you think is missing or isn't
correct for you.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
