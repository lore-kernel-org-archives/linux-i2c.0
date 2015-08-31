From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RESEND PATCH 1/7] i2c: core: Export I2C module alias information
 in dummy driver
Date: Tue, 1 Sep 2015 00:30:22 +0200
Message-ID: <55E4D57E.7050708@osg.samsung.com>
References: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
 <1440484277-32675-2-git-send-email-javier@osg.samsung.com>
 <20150826165532.GC1521@katana> <55DE00F6.1070206@osg.samsung.com>
 <20150831203144.GC1544@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150831203144.GC1544@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 08/31/2015 10:31 PM, Wolfram Sang wrote:
> 
>>> The dummy driver is always loaded when the i2c core inits.
>>>
>>
>> Ok, I wondered if that was the case but I
>> was not sure so I posted it just in case.
> 
> Check the source code, this part is pretty obvious...
>

Yes, sorry for missing that obvious detail...

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
