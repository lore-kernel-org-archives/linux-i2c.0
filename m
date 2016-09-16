From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 3/3] i2c: expose adapter probe and remove probed functions
Date: Fri, 16 Sep 2016 16:09:02 -0500
Message-ID: <884a0040-7965-5384-5fe1-8204ba73ccb1@lechnology.com>
References: <1473108014-30787-1-git-send-email-david@lechnology.com>
 <1473108014-30787-4-git-send-email-david@lechnology.com>
 <20160916210315.GB2216@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:39768 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbcIPVJC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Sep 2016 17:09:02 -0400
In-Reply-To: <20160916210315.GB2216@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/16/2016 04:03 PM, Wolfram Sang wrote:
>
>> The intended use of these functions is for LEGO MINDSTORMS sensors. These
>> are hot-plugable I2C devices. When a sensor is connected, i2c_adapter_probe()
>> is called to automatically configure the sensor. When the sensor is
>> disconnected, i2c_adapter_remove_probed() is called to remove the
>> automatically configured device.
>
> How do you detect the hot-plug events?
>

There are "port" drivers that do this. An I2C adapter is assigned to 
each port via device-tree or platform data struct.

Port driver code if you are interested:
- 
https://github.com/ev3dev/lego-linux-drivers/blob/master/ev3/legoev3_ports_in.c
- 
https://github.com/ev3dev/lego-linux-drivers/blob/master/evb/evb_ports_in.c

In particular, here is where we call the new i2c_adapter_probe() 
function: 
https://github.com/ev3dev/lego-linux-drivers/blob/master/evb/evb_ports_in.c#L543
