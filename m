From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] i2c: xiic: Support disabling multi-master in DT
Date: Tue, 25 Feb 2020 15:44:18 +0100
Message-ID: <4557a127-833d-d829-1490-e76912f099dd@xilinx.com>
References: <20200218135627.24739-1-ext-jaakko.laine@vaisala.com>
 <481fe028-0ec6-eca3-7436-ebbb8527f3d8@xilinx.com>
 <AM0PR06MB518514EE9C057CB129079825D4ED0@AM0PR06MB5185.eurprd06.prod.outlook.com>
 <20200225141357.GE3677@ninjato>
 <AM0PR06MB5185341478B6919A9CC22271D4ED0@AM0PR06MB5185.eurprd06.prod.outlook.com>
 <20200225143245.GF3677@ninjato>
 <431d520b-24a1-687c-1f4b-4ebe95181a2b@xilinx.com>
 <20200225144146.GG3677@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26478
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730849AbgBYOof (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Feb 2020 09:44:35 -0500
In-Reply-To: <20200225144146.GG3677@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Michal Simek <michal.simek@xilinx.com>
Cc: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shubhrajyoti Datta <shubhraj@xilinx.com>

On 25. 02. 20 15:41, Wolfram Sang wrote:
> On Tue, Feb 25, 2020 at 03:37:21PM +0100, Michal Simek wrote:
>> On 25. 02. 20 15:32, Wolfram Sang wrote:
>>>
>>>>> My favourite is to change alignment to be just one space. Then, we have
>>>>> a bit of overhead now, but never again in the future.
>>>>
>>>> Ok, I will add that change as separate patch to V2 patch series.
>>>
>>> Perfect, thanks!
>>>
>>
>> Wolfram: Any option about that multi-master property?
> 
> Not yet.

What does that mean? Do you need time to dig into it or you don't mind?

Thanks,
Michal
