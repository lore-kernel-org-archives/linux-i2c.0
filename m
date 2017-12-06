From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 2/2] eeprom: at24: use a common prefix for all symbols
 in at24.c
Date: Wed, 6 Dec 2017 18:27:25 +0100
Message-ID: <ea0eb0b0-89bd-77d2-c2db-8b87c266de92@axentia.se>
References: <20171206130131.13438-1-brgl@bgdev.pl>
 <20171206130131.13438-3-brgl@bgdev.pl>
 <5cffa160-7371-c71a-d3b7-ba01edb408e3@axentia.se>
 <CAMRc=MfjGSo0bsmoLJGU_vFyp=E8b6-JJwmS5N5vorDpWhEB-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MfjGSo0bsmoLJGU_vFyp=E8b6-JJwmS5N5vorDpWhEB-Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2017-12-06 15:29, Bartosz Golaszewski wrote:
> 2017-12-06 14:40 GMT+01:00 Peter Rosin <peda@axentia.se>:
>> Hi!
>>
>> Some nits...
>>
>> On 2017-12-06 14:01, Bartosz Golaszewski wrote:
>>> There are a couple symbols defined in the driver source file which are
>>> missing the at24_ prefix. This patch fixes that.
>>>
>>> For module params: use module_param_named() in order not to break the
>>> userspace.
>>
>> I'd write that as "...in order to not break userspace"
>>
> 
> I would love to hear an English native speaker's opinion on that. :)

"not to" or "to not" is a matter of style/taste. I mainly wanted to point
out that the definite article of "userspace" should be removed, because
you are not talking about one particular userspace.

Cheers,
peda
