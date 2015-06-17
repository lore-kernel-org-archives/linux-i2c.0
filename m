From: York Sun <yorksun@freescale.com>
Subject: Re: [Patch v3] driver/clk/clk-si5338: Add common clock framework
 driver for si5338
Date: Wed, 17 Jun 2015 10:18:25 -0700
Message-ID: <5581ABE1.3030501@freescale.com>
References: <1434472269-27601-1-git-send-email-yorksun@freescale.com> <1434533368.2069.135.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434533368.2069.135.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: mturquette@baylibre.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Andrey Filippov <andrey@elphel.com>
List-Id: linux-i2c@vger.kernel.org



On 06/17/2015 02:29 AM, Paul Bolle wrote:
> On Tue, 2015-06-16 at 09:31 -0700, York Sun wrote:
>> COMMON_CLK in Kconfig is changed from bool to tristate so all common
>> clock framework drivers can be selected by users.
> 
> A bool to tristate change isn't needed to make it possible to set a
> symbol manually. That's achieved by adding a prompt (which the patch
> also does).
> 
> This change adds a prompt to the symbol that enables the framework. But,
> as far as I can see, clock drivers depending on that framework already
> can be set manually. So that's another reason the above looks incorrect
> to me.
> 
> Note that the "help" of COMMON_CLK contains:
>     Architectures utilizing the common struct clk should select
>     this option.
> 
> Does the architecture this patch targets perhaps not select COMMON_CLK?
> If that's the case, it seems you should change that architecture
> instead.

Paul,

I did check the mechanism to select COMMON_CLK. It doesn't fit my application.
But it is not in the scope of this patch. I will discuss at the end of this email.

> 
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
> 
>>  config COMMON_CLK
>> -	bool
>> +	tristate "Common Clock"
>>  	select HAVE_CLK_PREPARE
>>  	select CLKDEV_LOOKUP
>>  	select SRCU
> 
> I told you yesterday that setting this to tristate allows over a dozen
> new modules to be created. I'd be surprised if that doesn't break stuff
> left and right without additional changes (which this patch lacks).

Yes you did. I checked over and over and believe enabling this option doesn't
break anything. By enabling it, a dozen modules are built either in the kernel,
or as modules (depending on y or m). They support fix-rate clock and others.

Here is what I am going to do. I will separate the Kconfig from this patch so it
doesn't block this patch from going forward. I will continue exploring the
correct way to enable common clock framework, for my application and for general
use.

York
