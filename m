From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v6] eeprom: at24: Add OF device ID table
Date: Mon, 6 Nov 2017 10:13:45 +0100
Message-ID: <fec1c0d1-425d-542e-bb6c-402b47b46ceb@redhat.com>
References: <20171001104948.21663-1-javierm@redhat.com>
 <20171105215344.a5nyk7xmcdl22tpd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171105215344.a5nyk7xmcdl22tpd@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 11/05/2017 10:53 PM, Wolfram Sang wrote:
> On Sun, Oct 01, 2017 at 12:49:48PM +0200, Javier Martinez Canillas wrote:
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
>>
>> To maintain backward compatibility with old Device Trees, only use the OF
>> device ID table .data if the device was registered via OF and the OF node
>> compatible matches an entry in the OF device ID table.
>>
>> Suggested-by: Wolfram Sang <wsa@the-dreams.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>
> 
> Applied to for-next, thanks for keeping at it!
> 

Great, thanks a lot for your feedback and suggestions on this series.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
