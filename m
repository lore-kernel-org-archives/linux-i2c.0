From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 0/3] LEGO MINDSTORMS I2C support
Date: Fri, 16 Sep 2016 15:05:45 -0500
Message-ID: <35c2d50b-4d1e-deb4-9b9e-a9f8b33a7f36@lechnology.com>
References: <1473108014-30787-1-git-send-email-david@lechnology.com>
 <20160915200045.GE7863@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:59340 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965171AbcIPUGC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Sep 2016 16:06:02 -0400
In-Reply-To: <20160915200045.GE7863@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/15/2016 03:00 PM, Wolfram Sang wrote:
> On Mon, Sep 05, 2016 at 03:40:11PM -0500, David Lechner wrote:
>> I'm working on getting LEGO MINDSTORMS[1] support in the Linux kernel.
>>
>> They have a system of modular sensors that are hot-plugable, some of which use
>> I2C communications. Unfortunately, these don't necessary follow standard I2C
>> conventions, but they do have a well-defined register layout, so they are
>> easy to detect.
>>
>> This set of patches addresses the hot-plugability of the sensors.
>>
>> [1]: http://mindstorms.lego.com
>
> Thanks!
>
> For a review, I'd need users of this functionality. In this case, a
> master driver and probably a sensor driver.

Work in progress drivers:

master: 
https://github.com/ev3dev/lego-linux-drivers/blob/master/ev3/legoev3_i2c.c
master: 
https://github.com/ev3dev/lego-linux-drivers/blob/master/evb/evb_pru_i2c.c
sensor: 
https://github.com/ev3dev/lego-linux-drivers/blob/master/sensors/nxt_i2c_sensor_core.c

> Can any regular I2C master
> talk to these devices if they support talking to addresses 0x00-0x7f?

Yes. I've tested this with the SoC I2C on Raspberry Pi. There are 
several 3rd party LEGO MINDSTORMS compatible addon boards for RPi that 
use the SoC I2C with LEGO sensors, which is part of my motivation for 
this patchset.

> My first impression is that using a class is not the proper approach
> because classes were used to limit access to devices, not to extend.
> However, I'd need to see more code to check if that holds true.
>

I'm certainly open to other suggestions. This just seemed like the 
obvious way to me.
