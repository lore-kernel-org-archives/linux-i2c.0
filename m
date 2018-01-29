From: Peter Rosin <peda@axentia.se>
Subject: Re: Patch proposal for risky i2c addresses in i2c-tools
Date: Mon, 29 Jan 2018 14:39:37 +0100
Message-ID: <41030382-9a57-81bb-d7da-f7c853817dc1@axentia.se>
References: <20180105150248.3170-1-romain.porte@nokia.com>
 <20180126180330.3ep65ongfdgffbmu@ninjato>
 <f81d1aa9-39c0-20d9-c4a4-4a00fd9b891f@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0124.outbound.protection.outlook.com ([104.47.2.124]:45281
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751909AbeA2Njs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 Jan 2018 08:39:48 -0500
In-Reply-To: <f81d1aa9-39c0-20d9-c4a4-4a00fd9b891f@nokia.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Porte <romain.porte@nokia.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, jdelvare@suse.de

On 2018-01-29 13:26, Romain Porte wrote:
> Hello Wolfram,
> 
> On 26/01/2018 19:03, Wolfram Sang wrote:
>> This handles only part of the risky addresses. I once worked on a device
>> having an EEPROM using 32(!) addresses in the range from 0x00(!!)-0x1f.
>> And yes, because it was the only device on the bus, that actually worked.
>>
>> So, the lower boundary should also be removed IMO.
> 
> Good to know, I will send a new patchset which takes the lower bound 
> into account.
> 
>> And I'd much prefer a flag like 'R' which represents 'risky' better.
> 
> I disagree here, the i2cdetect program is already using the '-a' option 
> for scanning risky addresses. I think we should keep consistency between 
> options and keep this option named '-a' for the other tools. As per 
> i2cdetect's man page:
> 
> -a    Force scanning of non-regular addresses. Not recommended

However, you could rename the variables and rewrite the docs to put
more emphasis on "all" rather than "risky". Then it would be easier
to remember the short option.

$.02

Cheers,
Peter

> Best regards,
> 
> Romain.
> 
