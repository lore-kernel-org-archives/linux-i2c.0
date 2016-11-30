From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] i2c: core: don't try to OF populate DDC i2c buses
Date: Wed, 30 Nov 2016 22:18:58 +0200
Message-ID: <f259bd4b-788c-0bc2-25b8-7e0a735af859@mleia.com>
References: <20161130115005.11508-1-l.stach@pengutronix.de>
 <d31d7cd0-4b00-4db0-2a51-cf3e553e6df8@mleia.com>
 <1480514806.2258.68.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:33097 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754166AbcK3UTC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Nov 2016 15:19:02 -0500
In-Reply-To: <1480514806.2258.68.camel@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de

On 11/30/2016 04:06 PM, Lucas Stach wrote:
> Am Mittwoch, den 30.11.2016, 15:54 +0200 schrieb Vladimir Zapolskiy:
>> Hello Lucas,
>>
>> On 11/30/2016 01:50 PM, Lucas Stach wrote:
>>> DDC buses are manually managed by their consumers to communicate
>>> with the display. There is no need to try to populate OF childs.
>>>
>>> This gets rid of the device create failed warning caused by the
>>> core trying to populate a DDC bus below a OF device, which has
>>> other childs nodes, that aren't i2c devices.
>>
>> what kind of devices on a DDC bus represended by children nodes
>> do you reference here?
> 
> None. The device registering the DDC i2c adapter might have an of_node.
> The children of this device are not i2c devices, but for example port
> nodes for the of_graph binding.

Port node shall not be a child of any DDC bus device node, otherwise it
contradicts to the hierarchy of hardware blocks. It is a common practice
to describe port nodes and DDC bus adapter as siblings (devices which
share the same display controller / encoder device). Do I miss something?

> The same issue can be worked around if we make it explicit by placing an
> "i2c-bus" subnode with no children into the parent device OF node. But
> as the OF probing of devices on a DDC bus just doesn't make sense I
> figured it would be good to just skip all this.
> 

Right, as a micro optimization the change makes sense (*), but the second
paragraph in the commit message is questionable.

In my opinion it makes sense to include the change, and the warning
you mention in the commit message needs its own attention as an indicator
of potentially wrongly chosen representation of the device hierarchy.

(*) experimentally I successfully performed test communications with
AT24 connected to DW HDMI DDC lines on i.MX6Q, so I can imagine exotic
boards, where DDC bus operates as an extra I2C bus. I'm unaware of any
such real cases, but if they exist your commit breaks them.

--
With best wishes,
Vladimir
