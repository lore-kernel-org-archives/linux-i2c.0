From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] i2c: core: don't try to OF populate DDC i2c buses
Date: Wed, 30 Nov 2016 15:54:29 +0200
Message-ID: <d31d7cd0-4b00-4db0-2a51-cf3e553e6df8@mleia.com>
References: <20161130115005.11508-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:60218 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753217AbcK3Nyd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Nov 2016 08:54:33 -0500
In-Reply-To: <20161130115005.11508-1-l.stach@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de

Hello Lucas,

On 11/30/2016 01:50 PM, Lucas Stach wrote:
> DDC buses are manually managed by their consumers to communicate
> with the display. There is no need to try to populate OF childs.
> 
> This gets rid of the device create failed warning caused by the
> core trying to populate a DDC bus below a OF device, which has
> other childs nodes, that aren't i2c devices.

what kind of devices on a DDC bus represended by children nodes
do you reference here?

--
With best wishes,
Vladimir
