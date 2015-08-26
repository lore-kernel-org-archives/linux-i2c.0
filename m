From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RESEND PATCH 1/7] i2c: core: Export I2C module alias information
 in dummy driver
Date: Wed, 26 Aug 2015 20:09:58 +0200
Message-ID: <55DE00F6.1070206@osg.samsung.com>
References: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
 <1440484277-32675-2-git-send-email-javier@osg.samsung.com>
 <20150826165532.GC1521@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150826165532.GC1521@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 08/26/2015 06:55 PM, Wolfram Sang wrote:
> On Tue, Aug 25, 2015 at 08:31:11AM +0200, Javier Martinez Canillas wrote:
>> The I2C core always reports the MODALIAS uevent as "i2c:<modalias>"
>> regardless of the mechanism that was used to register the device
>> (i.e: OF or board code) and the table that is used later to match
>> the driver with the device (i.e: I2C id table or OF match table).
>>
>> So drivers needs to export the I2C id table and this be built into
>> the module or udev won't have the necessary information to autoload
>> the needed driver module when the device is added.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> The dummy driver is always loaded when the i2c core inits.
> 

Ok, I wondered if that was the case but I
was not sure so I posted it just in case.

Then this patch should be dropped.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
