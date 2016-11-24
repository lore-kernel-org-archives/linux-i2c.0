From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v4 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Wed, 23 Nov 2016 16:45:05 -0800
Message-ID: <CAFd5g47boqUMcmjPPwYw9aEhof-mjhjVKxA69UDQkC1vbn+xWQ@mail.gmail.com>
References: <1478311099-6771-1-git-send-email-brendanhiggins@google.com>
 <1478311099-6771-2-git-send-email-brendanhiggins@google.com>
 <28078e6d-f5e4-da59-e226-baa9a60a4b19@kaod.org> <584151479839034@web17g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33871 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935162AbcKXApQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Nov 2016 19:45:16 -0500
Received: by mail-qt0-f180.google.com with SMTP id n6so27193952qtd.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Nov 2016 16:45:06 -0800 (PST)
In-Reply-To: <584151479839034@web17g.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

> I would like to add my five cents here. Do not limit the bus_clk with 400kHz (FM) while HighSpeed is above
> 1MHz (above FM+ devices). I've successfully tested FM+ (1Mhz) in a quite big i2c network (a number of
> pca9600, pca9675, pca9848) with at least eight AST2150 SoCs on the common bus.

Interesting point, on one hand I would argue that we should force
people to use either FM or FM+ in a conformant manner. But on the
other hand, I suppose a device may not support FM+'s electrical
characteristics, but could run at a higher clock rate, and it is
better to allow that than forcing FM+. Maybe I should remove any kind
of restriction, and just allow the clock to be set to any conformant
frequency and expose FM+ as a separate option in device tree.
Thoughts?

> BTW. Just a lame question. If the device isn't designed to work on the higher speed (like standard of FM)
> while the bus selected as FM+, would those kind of devices just unoperate or may have undefined behavior
> and disturb the SDA/SCL? Just wondering to dynamically slowdown down to 100Khz (if needed) for the
> specific slave, but keep high rate (FM+) at the normal operation.

I have never tried this myself, but I suspect there may be other
issues with running an FM device on an FM+ bus: FM+ uses a higher
current to make the rise times on the line faster. A bigger problem:
if a master wanted to select a high speed capable slave, it could
write the address at a high speed which might look like a different
address to a low speed slave that is incapable of sampling the address
properly. So I do not think that supporting dynamically slowing down
an I2C bus makes much sense. An interesting idea, though.
