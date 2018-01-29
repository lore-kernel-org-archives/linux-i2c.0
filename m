From: Romain Porte <romain.porte@nokia.com>
Subject: Re: Patch proposal for risky i2c addresses in i2c-tools
Date: Mon, 29 Jan 2018 13:26:48 +0100
Message-ID: <f81d1aa9-39c0-20d9-c4a4-4a00fd9b891f@nokia.com>
References: <20180105150248.3170-1-romain.porte@nokia.com>
 <20180126180330.3ep65ongfdgffbmu@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr40118.outbound.protection.outlook.com ([40.107.4.118]:18624
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751297AbeA2M04 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 Jan 2018 07:26:56 -0500
In-Reply-To: <20180126180330.3ep65ongfdgffbmu@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, jdelvare@suse.de

Hello Wolfram,

On 26/01/2018 19:03, Wolfram Sang wrote:
> This handles only part of the risky addresses. I once worked on a device
> having an EEPROM using 32(!) addresses in the range from 0x00(!!)-0x1f.
> And yes, because it was the only device on the bus, that actually worked.
>
> So, the lower boundary should also be removed IMO.

Good to know, I will send a new patchset which takes the lower bound 
into account.

> And I'd much prefer a flag like 'R' which represents 'risky' better.

I disagree here, the i2cdetect program is already using the '-a' option 
for scanning risky addresses. I think we should keep consistency between 
options and keep this option named '-a' for the other tools. As per 
i2cdetect's man page:

-a    Force scanning of non-regular addresses. Not recommended

Best regards,

Romain.
