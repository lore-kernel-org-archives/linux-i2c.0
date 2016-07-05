From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: portable device tree connector -- problem statement
Date: Tue, 5 Jul 2016 07:24:12 -0700
Message-ID: <577BC30C.10105@gmail.com>
References: <577ACE0D.9050700@gmail.com> <20160705083152.GM6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36500 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbcGEOYX (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jul 2016 10:24:23 -0400
In-Reply-To: <20160705083152.GM6247@sirena.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Rob Herring <robh+dt@kernel.org>, david@gibson.dropbear.id.au, stephen.boyd@linaro.org, grant.likely@secretlab.ca, Mark Rutland <mark.rutland@arm.com>, mporter@konsulko.com, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, panto@antoniou-consulting.com

On 07/05/16 01:31, Mark Brown wrote:
> On Mon, Jul 04, 2016 at 01:58:53PM -0700, Frank Rowand wrote:
> 
>> On the other hand, I have no previous detailed knowledge of the beagle
>> family.
> 
> This is in no way specific to the BeagleBones, there's plenty of other
> boards out there with similar setups like the Raspberry Pi and its
> derivatives.

Yes, absolutely.  I'm just picking on the beaglebones because that is
what Pantelis has recently used for examples.  (He has mentioned other
connector types and expansion boards in his presentations.)

And we need to think beyond beaglebone, pi, arduino, and grove 
type of connectors.

Some other connectors that are obvious are pci and possibly usb.


>>     - for bones with the same pinout:
>>       - the pins are routed to different function blocks on the
>>         SOC because different bones may have different SOCs?
>>         - the different functional blocks are compatible or not?
> 
> This is the general case, there will be a substantial level of
> compatibility between different base boards by virtue of the pinouts
> being the same but obviously there will be some variation in the
> specifics (and even where that exists it may not be enough to be visible
> at the DT level for the most part).  That said there will doubtless be
> some plug in modules that want to rely on the specifics of a given base
> board rather than remain compatible with general users of the interface.
> 
