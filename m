From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: Portable Device Tree Connector -- conceptual
Date: Fri, 1 Jul 2016 10:10:09 -0700
Message-ID: <5776A3F1.5040905@gmail.com>
References: <5775B2FD.2000103@gmail.com> <57769DFC.3050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35418 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbcGARWZ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Jul 2016 13:22:25 -0400
In-Reply-To: <57769DFC.3050503@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>
Cc: Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, linux@roeck-us.net, Marek Vasut <marex@denx.de>, wsa@the-dreams.de, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Pantelis Antoniou <panto@antoniou-consulting.com>

On 07/01/16 09:44, Frank Rowand wrote:
> On 06/30/16 17:02, Frank Rowand wrote:
>> Hi All,
>>
>> I've been trying to wrap my head around what Pantelis and Rob have written
>> on the subject of a device tree representation of a connector for a
>> daughter board to connect to (eg a cape or a shield) and the representation
>> of the daughter board.  (Or any other physically pluggable object.)
>>
>> After trying to make sense of what had been written (or presented via slides
>> at a conference - thanks Pantelis!), I decided to go back to first principals
>> of what we are trying to accomplish.  I came up with some really simple bogus
>> examples to try to explain what my thought process is.
> 
> I was trying to keep the example as simple as possible because I wanted to
> focus on the concept.  I was trying to avoid getting into a big discussion
> about implementation details until getting feedback on the concepts.
> 
> Secondly, thinking through the whole thing was complex enough for me that
> I missed some obvious answers to my hand waving.
> 
> So in this reply, I will add the obvious fix to my hand waving, and add
> some complexity with one more important implementation detail.

< big snip >


>> Of course the overlay loader will also have to be modified to understand
>> the new information.
>>
>> Exact format of the __symbols__ and __fixups__ are implementation
>> details, I am just trying to present the model.
>>
>> Ignoring device tree source syntax and dtc implementation issues, does
>> this conceptual model look more straight forward and a better direction
>> for how to represent connectors?
>>
>> -Frank
>>
> 
> One more detail is how to ensure that a host board connector and a
> daughter board connector match (pin meaning, electrical characteristics,
> etc).  Both the host board connector .dtb node and the daughter board
> connector .dtbo node would have a compatible property that was specific
> to a connector specification.  For instance, there could be a
> "96boards,40-pin-connector" and a "96boards,60-pin-connector".  If a
> new incompatible version of the connector spec was created, a new
> compatible would have to be created, for example "96boards,40-pin-connector-gen2".

One more detail.

What if the host board has two identical connectors and you want to plug two
identical daughter boards into the two host board connectors.

The host board dts will have to have two different connector nodes,
because the connector nodes connect to whatever host board hardware
they connect to.

The daughter board dts _should_ be identical for each of the daughter
boards.  The only difference is which connector node on the host
board the daughter board connecter node has to be remapped to.  This
could be specified by remapping info supplied to the overlay manager,
such as "map overlay node 'connector_1' to host node 'connector_7'".
Of course the true implementation would not be this verbose and
hard to parse - I'm just trying to show the concept here.

-Frank
