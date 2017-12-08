From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 1/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 16:39:09 +0100
Message-ID: <e68cff80-c8b8-ba32-fc40-5ff20a077480@axentia.se>
References: <1512576272-25563-1-git-send-email-svendev@arcx.com>
 <1512576272-25563-2-git-send-email-svendev@arcx.com>
 <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
 <CAGngYiWdnE9Ztu3uGeqAS+Ksag6-W84AORJnWb1Xzc7EMBwZNg@mail.gmail.com>
 <CAMRc=Mf6e=O_M40Vaq4jygBwPHB8-X6wyDVG8Ee7qw+PjLTXUA@mail.gmail.com>
 <CAGngYiXpwcjndtFhtCFhESagN9CRWiS0jFdndiNE2oupBQdDSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGngYiXpwcjndtFhtCFhESagN9CRWiS0jFdndiNE2oupBQdDSw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sven Van Asbroeck <svendev@arcx.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2017-12-08 16:28, Sven Van Asbroeck wrote:
> Bartosz wrote:
>> Just make it accept two parameters: the string and the data object
>> name. For example:
>>
>> AT24_OF_DEVICE_ID("atmel,24c01", 24c01);
>>
> 
> I don't want to do too much bikeshedding,
> but one last comment.
> 
> Is it a good idea to have duplicated information?
> Do you think the risk of a typo mismatch is acceptable? E.g.
> AT24_OF_DEVICE_ID("atmel,24c01", 24c02);
> 
> At least the original syntax is not susceptible to this problem,
> but of course as you say, it hides the of_ compatible string:
> AT24_OF_DEVICE_ID(atmel, 24c01);
> /* hides 'atmel,24c01' */

It's nice to be able to grep for compatible strings.

$.02

/peda
