From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv7 10/11] mfd: as3722: Rid driver of superfluous I2C device
 ID structure
Date: Mon, 7 Nov 2016 23:14:22 -0300
Message-ID: <ed57eb93-4818-bdf7-7abf-da86a6f86bca@osg.samsung.com>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-11-git-send-email-kieran@bingham.xyz>
 <1ac3a33e-a85c-e781-81b6-c39f3d533da8@osg.samsung.com>
 <20161107230931.GA1439@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34197
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752045AbcKHCPJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Nov 2016 21:15:09 -0500
In-Reply-To: <20161107230931.GA1439@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kieran Bingham <kieran@ksquared.org.uk>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com

Hello Wolfram,

On 11/07/2016 08:09 PM, Wolfram Sang wrote:
> 
>> Remember that i2c_device_uevent() always reports modalias of the form
>> MODALIAS=i2c:<foo> even when your series allows to match without a I2C
>> device ID table.
> 
> Not always. Can't we do something similar like ACPI does with

Right, I meant that it always report a platform I2C modalias for both OF
and legacy platform data I2C device registration mechanisms.

> acpi_device_uevent_modalias()?
>

Yes, doing that is trivial. I posted a RFC patch about a year ago that
changes i2c_device_uevent() to report a proper OF modalias [0] as a part
of a series that fixed module autoload in a bunch of I2C drivers [1].

What's tricky is to make sure that the change won't introduce regressions
in current I2C drivers. I enumerated the possible issues if the I2C core
starts reporting OF modaliases and fixed some of them in the same series.

> I mean the whole point of this series is to remove the need of having an
> I2C device ID table...
>

Agreed, one of the issues was that the I2C table was needed anyways for
the core to match and pass a struct i2c_device_id to the probe's function.

This series solves that so once it lands, I plan to address the possible
issues in the I2C drivers and re-send [0] as a proper patch.

[0]: https://patchwork.kernel.org/patch/6903991/
[1]: https://lkml.org/lkml/2015/7/30/519

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
