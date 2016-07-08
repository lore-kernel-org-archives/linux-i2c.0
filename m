From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH 0/1] Portable Device Tree Connector -- conceptual
Date: Fri, 8 Jul 2016 12:20:11 -0700
Message-ID: <577FFCEB.9010600@gmail.com>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
 <20160707071548.GV14675@voom.fritz.box>
 <2D8CFA9A-C317-4C02-9893-169B4B77E01E@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33537 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbcGHTU2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Jul 2016 15:20:28 -0400
In-Reply-To: <2D8CFA9A-C317-4C02-9893-169B4B77E01E@konsulko.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: robh+dt@kernel.org, stephen.boyd@linaro.org, broonie@kernel.org, Grant Likely <grant.likely@secretlab.ca>, mark.rutland@arm.com, Matt Porter <mporter@konsulko.com>, koen@dominion.thruhere.net, linux@roeck-us.net, marex@denx.de, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>

On 07/08/16 00:26, Pantelis Antoniou wrote:
> Hi David,
>=20
>> On Jul 7, 2016, at 10:15 , David Gibson <david@gibson.dropbear.id.au=
> wrote:
>>

< snip >

>> Given that we're going to need new code to support this new connecto=
r
>> model, I think we should also fix some of the uglies in the current
>> overlay format while we're at it.
>>
>=20
> We need to keep compatibility with the old format. There are 5 millio=
n
> RPIs sold, half a million beaglebones and C.H.I.P. is coming out too.
> They all use overlays in one form or another.
>=20
> That=E2=80=99s not counting all the custom boards that actively use t=
hem.
>=20
> We have a user base now.

Please not that I AM NOT suggesting the we remove compatibility with
the old format!!!

But I need to push back on the idea that we have a user base that we
need to keep compatibility with.  If I understand correctly, that
user base is based on using much code that is not in mainline, includin=
g
an altered dtc and a cape manager.

People using out of tree code can not use the fact that code exists and
is being widely used to force us to mainline that out of tree code.
That is the risk of using out of tree code.

I do not want to start a big discussion about this now since there is
no plan to remove the compatibility at this point.

-Frank
