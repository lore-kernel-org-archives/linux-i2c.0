From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 01/26] docs: i2c: sort index logically
Date: Mon, 20 Jan 2020 14:56:18 +0100
Message-ID: <9073e6c2-1f82-6067-0d2a-3e8d32dca89a@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
 <20200120100850.001e032b@endymion>
 <e5d3656d-04a1-dd1b-e847-fb063e56a987@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e5d3656d-04a1-dd1b-e847-fb063e56a987@lucaceresoli.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 20/01/20 10:22, Luca Ceresoli wrote:
> Hi Jean,
> 
> On 20/01/20 10:08, Jean Delvare wrote:
>> Hi Luca,
>>
>> On Sun,  5 Jan 2020 23:49:47 +0100, Luca Ceresoli wrote:
>>> The index page currently lists sections in alphabetical file order without
>>> caring about their content. Sort sections based on their content logically,
>>> according to the following structure:
>>>
>>>  * Intro to I2C/SMBus and their usage in Linux: summary, i2c-protocol,
>>>    smbus-protocol, instantiating-devices, busses/index, i2c-topology,
>>>    muxes/i2c-mux-gpio
>>>  * Implementing drivers: writing-clients, dev-interface,
>>>    dma-considerations, fault-codes, functionality
>>>  * Debugging: gpio-fault-injection, i2c-stub
>>>  * Slave I2C: slave-interface, slave-eeprom-backend
>>>  * Advanced: ten-bit-addresses
>>>  * Obsolete info: upgrading-clients, old-module-parameters
>>
>> Good idea. I wonder, would there be a way to materialize these group
>> names in the documentation itself? I found it useful when reviewing the
>> patch, but in the long term it would be even more useful if the end
>> readers would see them too.
> 
> I had the same idea, but didn't find an obvious way to do it with the
> ReST/Sphynx syntax. I have also browsed through a few index pages for
> other subsystems and they all have a flat list too, so for the moment I
> gave up.

The best way I could find is in Documentation/core-api/index.rst
(https://www.kernel.org/doc/html/latest/core-api/index.html). I don't
like very much how the .rst source looks like, but AFAICT this seems
like "the" way of doing it.

Unless there are better options, I'll try this syntax in v2.

-- 
Luca
