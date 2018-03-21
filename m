From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 3/3] i2c: mux: pca9541: prepare for PCA9641 support
Date: Wed, 21 Mar 2018 09:09:50 +0100
Message-ID: <7ad08be1-fe73-061f-b0ad-e29a4a074506@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-4-peda@axentia.se>
 <bc464354-660a-00ed-e713-eec987407695@mleia.com>
 <3cfc6e53-a86d-8ef1-b83d-9f3c1b3d7b9c@roeck-us.net>
 <67f0b5fb-5df7-0354-bfd6-5969b6fc7bb1@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <67f0b5fb-5df7-0354-bfd6-5969b6fc7bb1@mleia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Ken Chen <chen.kenyy@inventec.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, joel@jms.id.au, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-03-21 08:01, Vladimir Zapolskiy wrote:
> On 03/21/2018 03:19 AM, Guenter Roeck wrote:
>> On 03/20/2018 04:17 PM, Vladimir Zapolskiy wrote:
>>> Hi Peter, Ken,
>>>
>>> On 03/20/2018 11:32 AM, Peter Rosin wrote:
>>>> Make the arbitrate and release_bus implementation chip specific.
>>>>
>>>
>>> by chance I took a look at the original implementation done by Ken, and
>>> I would say that this 3/3 change is an overkill as a too generic one.
>>> Is there any next observable extension? And do two abstracted (*arbitrate)
>>> and (*release_bus) cover it well? Probably no.
>>>
>>> At first it would be simpler to add a new chip id field into struct pca9541
>>> (struct rename would be needed of course), and do a selection of specific
>>> pca9x41_arbitrate() and pca9x41_release_bus() depending on it:
>>>
>>
>> FWIW, I very much prefer Peter's code. I think it is much cleaner.
> 
> Peter's code is generic, and it makes the change about 3 times longer in lines
> of code, and the following pca9641 change on top of it will be larger as well,
> because generalization requires service.
> 
> My main concern is that if such generalization is really needed in the driver.

I just did a comparison of what would happen if I took the same shortcuts
you did, and I got 18 new lines and 3 changed lines (and some moved lines
that could have been a separate patch). You have 12 new lines and 5 changed
lines.

So, the big difference is that I add the of_match_device call while you
do not. So, it looks like you are comparing apples and oranges. Do you
have a reason for not calling of_match_device? Or were you punting that
for the patch adding PCA9641 support? That's odd, because the point of
the patch is to prepare for smooth addition of that support.

Also, I think my code allows adding support for PCA9641 with only new
lines, while your version requires changing of code.

So, I'm rejecting your arguments that your patch is significantly simpler.
And while I'm obviously a tad bit biased, I do agree with Guenter that
my structure is cleaner.

Cheers,
Peter
