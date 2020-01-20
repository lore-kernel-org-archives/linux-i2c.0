From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 02/26] docs: i2c: summary: extend introduction
Date: Mon, 20 Jan 2020 22:54:06 +0100
Message-ID: <4a772de1-cb81-37bb-4170-9d19d56aaaac@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
 <20200105225012.11701-2-luca@lucaceresoli.net>
 <20200120102730.4eb9116b@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200120102730.4eb9116b@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On 20/01/20 10:27, Jean Delvare wrote:
> On Sun,  5 Jan 2020 23:49:48 +0100, Luca Ceresoli wrote:
>> - state the "official" name (I²C, not I2C, according to the spec) at
>>    the beginning but keep using the more practical I2C elsewhere
>>  - mention some known different names
>>  - add link to the specification document
> 
> Indentation is inconsistent.

Weird, this looks OK in my git log and my inbox, wrong on patchwork.
Perhaps starting an e-mail with a space breaks something? I'll try to
avoid that in the future.

>> diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
>> index 3a24eac17375..b7d3e620155b 100644
>> --- a/Documentation/i2c/summary.rst
>> +++ b/Documentation/i2c/summary.rst
>> @@ -2,12 +2,18 @@
>>  I2C and SMBus
>>  =============
>>  
>> -I2C (pronounce: I squared C) is a protocol developed by Philips. It is a
>> -slow two-wire protocol (variable speed, up to 400 kHz), with a high speed
>> -extension (3.4 MHz).  It provides an inexpensive bus for connecting many
>> -types of devices with infrequent or low bandwidth communications needs.
>> -I2C is widely used with embedded systems.  Some systems use variants that
>> -don't meet branding requirements, and so are not advertised as being I2C.
>> +I²C (pronounce: I squared C and written I2C in the kernel documentation) is
>> +a protocol developed by Philips. It is a slow two-wire protocol (variable
>> +speed, up to 400 kHz), with a high speed extension (3.4 MHz).  It provides
>> +an inexpensive bus for connecting many types of devices with infrequent or
>> +low bandwidth communications needs.  I2C is widely used with embedded
>> +systems.  Some systems use variants that don't meet branding requirements,
>> +and so are not advertised as being I2C but with different names, e.g. TWI
>> +(Two Wire Interface), IIC.
> 
> Maybe that's just me but "but with different names" sounds strange to
> me in the sentence construct. Maybe "but come under different names"
> instead?

What I mean is "...are not advertised as being I2C but [are advertised]
with different names". Looks equally clear to me, but since it has to be
clear to readers, I'll take your suggestion for v2.

Thanks for all the review work. I'm not going to reply to each e-mail
individually, but each of your suggestions will be taken in v2 unless I
reply differently.

-- 
Luca
