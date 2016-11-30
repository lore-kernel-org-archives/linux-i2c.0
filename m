From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] i2c: core: don't try to OF populate DDC i2c buses
Date: Wed, 30 Nov 2016 15:06:46 +0100
Message-ID: <1480514806.2258.68.camel@pengutronix.de>
References: <20161130115005.11508-1-l.stach@pengutronix.de>
         <d31d7cd0-4b00-4db0-2a51-cf3e553e6df8@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60483 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753639AbcK3OGs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Nov 2016 09:06:48 -0500
In-Reply-To: <d31d7cd0-4b00-4db0-2a51-cf3e553e6df8@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de

Am Mittwoch, den 30.11.2016, 15:54 +0200 schrieb Vladimir Zapolskiy:
> Hello Lucas,
> 
> On 11/30/2016 01:50 PM, Lucas Stach wrote:
> > DDC buses are manually managed by their consumers to communicate
> > with the display. There is no need to try to populate OF childs.
> > 
> > This gets rid of the device create failed warning caused by the
> > core trying to populate a DDC bus below a OF device, which has
> > other childs nodes, that aren't i2c devices.
> 
> what kind of devices on a DDC bus represended by children nodes
> do you reference here?

None. The device registering the DDC i2c adapter might have an of_node.
The children of this device are not i2c devices, but for example port
nodes for the of_graph binding.

The same issue can be worked around if we make it explicit by placing an
"i2c-bus" subnode with no children into the parent device OF node. But
as the OF probing of devices on a DDC bus just doesn't make sense I
figured it would be good to just skip all this.

Regards,
Lucas
