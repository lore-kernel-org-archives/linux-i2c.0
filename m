From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH 0/1] Portable Device Tree Connector -- conceptual
Date: Mon, 4 Jul 2016 11:15:44 -0700
Message-ID: <577AA7D0.7050402@gmail.com>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
 <20160704152226.GJ6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33911 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGDSP4 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Jul 2016 14:15:56 -0400
In-Reply-To: <20160704152226.GJ6247@sirena.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: robh+dt@kernel.org, david@gibson.dropbear.id.au, pantelis.antoniou@konsulko.com, stephen.boyd@linaro.org, grant.likely@secretlab.ca, mark.rutland@arm.com, mporter@konsulko.com, koen@dominion.thruhere.net, linux@roeck-us.net, marex@denx.de, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, panto@antoniou-consulting.com

On 07/04/16 08:22, Mark Brown wrote:
> On Sat, Jul 02, 2016 at 04:55:49PM -0700, frowand.list@gmail.com wrote:
> 
>> This is an extremely simple example to illustrate the concepts.  It is not
>> meant to represent the complexity of a real board.
>>
>> To start with, assume that the device that will eventually be on a daughter
>> board is first soldered onto the mother board.  The mother board contains
>> two devices connected via bus spi_1.  One device is described in the .dts
>> file, the other is described in an included .dtsi file.
>> Then the device tree files will look like:
> 
> Can I suggest not using SPI as an example here?  It's particularly
> messy since addresses are essentially just a random signal that can be
> totally separate to the controller hardware which might be adding more
> complexity early on in building up your model than is really desirable.
> It will need to be dealt with but perhaps not right now.  I2C might be
> easier.
> 
> The initial issue with SPI is that you really need to do something like
> bring out individual slots on the bus rather than the bus as a whole
> since you're going to need a remapping layer to map chip selects on the
> module to chip selects on the host board.
> 

Yes, thank you for pointing that out.

For the purposes of the mental model, when thinking about what I wrote,
just change SPI to I2C everywhere.

-Frank
