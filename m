From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 6/6] Documentation/devicetree: Add FSI-attached I2C master
 dt bindings
Date: Wed, 28 Jun 2017 11:08:17 +0800
Message-ID: <bcd64ad6-2cb0-b3ba-b577-2fabf253084b@ozlabs.org>
References: <1498505375-1454-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1498505375-1454-7-git-send-email-eajames@linux.vnet.ibm.com>
 <ec4a5fec-fea0-09a7-8559-99d8eb071093@ozlabs.org>
 <901bb9e4-a7b1-ce24-c68b-d96b61e1b274@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:50395 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbdF1DIV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Jun 2017 23:08:21 -0400
In-Reply-To: <901bb9e4-a7b1-ce24-c68b-d96b61e1b274@linux.vnet.ibm.com>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, gregkh@linuxfoundation.org, joel@jms.id.au, andrew@aj.id.au, "Edward A. James" <eajames@us.ibm.com>

Hi Eddie,

>> Those child nodes represent the downstream i2c buses, and so also
>> contain the i2c slave devices, right? If so, you may want to document
>> that, and/or add a simple device to that example (say, an EEPROM).
> 
> Yes, good point, but the driver currently wouldn't do anything with that
> device information. It doesn't keep a list of populated devices on the
> bus or anything. Still worth adding them to the device tree?

Surely the i2c core needs this to be able to find i2c slave devices on
the bus though?

[You'll need to set i2c_adapter->dev.of_node for this to work though,
which I don't think you are with the current patch set]

Cheers,


Jeremy
