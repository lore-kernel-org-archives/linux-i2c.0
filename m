From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 01/26] docs: i2c: sort index logically
Date: Mon, 20 Jan 2020 10:22:07 +0100
Message-ID: <e5d3656d-04a1-dd1b-e847-fb063e56a987@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
 <20200120100850.001e032b@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200120100850.001e032b@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On 20/01/20 10:08, Jean Delvare wrote:
> Hi Luca,
> 
> On Sun,  5 Jan 2020 23:49:47 +0100, Luca Ceresoli wrote:
>> The index page currently lists sections in alphabetical file order without
>> caring about their content. Sort sections based on their content logically,
>> according to the following structure:
>>
>>  * Intro to I2C/SMBus and their usage in Linux: summary, i2c-protocol,
>>    smbus-protocol, instantiating-devices, busses/index, i2c-topology,
>>    muxes/i2c-mux-gpio
>>  * Implementing drivers: writing-clients, dev-interface,
>>    dma-considerations, fault-codes, functionality
>>  * Debugging: gpio-fault-injection, i2c-stub
>>  * Slave I2C: slave-interface, slave-eeprom-backend
>>  * Advanced: ten-bit-addresses
>>  * Obsolete info: upgrading-clients, old-module-parameters
> 
> Good idea. I wonder, would there be a way to materialize these group
> names in the documentation itself? I found it useful when reviewing the
> patch, but in the long term it would be even more useful if the end
> readers would see them too.

I had the same idea, but didn't find an obvious way to do it with the
ReST/Sphynx syntax. I have also browsed through a few index pages for
other subsystems and they all have a flat list too, so for the moment I
gave up.

Anybody has hints on how to do this in a clean way?

>> diff --git a/Documentation/i2c/index.rst b/Documentation/i2c/index.rst
>> index a0fbaf6d0675..bd0ff9d00793 100644
>> --- a/Documentation/i2c/index.rst
>> +++ b/Documentation/i2c/index.rst
>> @@ -7,27 +7,26 @@ I2C/SMBus Subsystem
>>  .. toctree::
>>     :maxdepth: 1
>>  
>> +   summary
>> +   i2c-protocol
>> +   smbus-protocol
>> +   instantiating-devices
>> +   busses/index
>> +   i2c-topology
>> +   muxes/i2c-mux-gpio
>> +   writing-clients
>>     dev-interface
>>     dma-considerations
>>     fault-codes
>>     functionality
>>     gpio-fault-injection
>> -   i2c-protocol
>>     i2c-stub
>> -   i2c-topology
>> -   instantiating-devices
>> -   old-module-parameters
>> -   slave-eeprom-backend
>>     slave-interface
>> -   smbus-protocol
>> -   summary
>> +   slave-eeprom-backend
>>     ten-bit-addresses
>>     upgrading-clients
>> -   writing-clients
>> -
>> -   muxes/i2c-mux-gpio
>> +   old-module-parameters
>>  
>> -   busses/index
>>  
> 
> You end up with 2 blank lines in a row here, ideally there should be
> only one left.

Good catch, thanks, will fix in v2.

-- 
Luca
