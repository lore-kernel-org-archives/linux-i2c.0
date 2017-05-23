From: Peter Rosin <peda@axentia.se>
Subject: Re: struct i2c_mux_pinctrl_platform_data for the i2c-mux-pinctrl
 driver
Date: Tue, 23 May 2017 08:49:19 +0200
Message-ID: <7c06a6f0-e8ef-3abc-3c68-dec7dedbf0ae@axentia.se>
References: <264eee82-8e0f-7d63-5c2f-e4070bf56c63@axentia.se>
 <71dc13f9-f723-fb4b-a101-f7be8caacf1c@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0097.outbound.protection.outlook.com ([104.47.2.97]:59744
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933142AbdEWGtf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 23 May 2017 02:49:35 -0400
In-Reply-To: <71dc13f9-f723-fb4b-a101-f7be8caacf1c@wwwdotorg.org>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2017-05-22 17:51, Stephen Warren wrote:
> On 05/22/2017 02:24 AM, Peter Rosin wrote:
>> Hi Stephen,
>>
>> I was looking at the i2c-mux-pinctrl driver and noticed that it has
>> code to feed it platform data from C code. There has never been any
>> in-kernel users of this interface and I would like to remove it. I
>> wonder if you added it way back when just because the i2c-mux-gpio
>> driver have such an interface or if, to your knowledge, any external
>> platform exists that depends on this?
>>
>> I.e. I'm talking about removing include/linux/i2c-mux-pinctrl.h and
>> the code supporting it in the driver, thus only allowing devicetree
>> as source for the platform data.
> 
> I'm not aware of any in- or out-of-tree users of that structure/feature.
> 
> I added it because at the time I wrote that driver, it was common place 
> to support both DT-based and platform-data-based 
> instantiation/configuration of devices, so I did the same. If you're 

That's what I suspected, thanks for confirming!

> removing pdata-based configuration, it would make sense to do a blanket 
> removal across the entire I2C subsystem (and other subsystems too) I 
> suspect, but that's LinusW's call in the end.

(Wolfram Sang is the I2C maintainer)

Well, a couple of other drivers I looked at still have in-tree users.
This driver stands out in that it never ever had any in-tree user, and
I find no traces of any out-of-tree user either. That last bit might
of course be due to lacking google-fu on my part or that the out-of-
tree user was never available online in the first place. But it is a
data point. Also, removing a third or so of the driver and at the same
time making it easier to follow the code sounds like something I want
to do.

Embarking on the bigger project is however not something I'm signing
up for, not that I don't think it would be worthwhile.

I'll send a patch when I have done some further tests with what I
have cooking...

Cheers,
peda
