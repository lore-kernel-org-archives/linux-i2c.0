From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2 1/5] dt-bindings: add bindings for i2c-pca-platform
Date: Thu, 22 Jun 2017 21:20:59 +0000
Message-ID: <e121e9ad4afe49008e34b5b4a76b22c6@svr-chch-ex1.atlnz.lc>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170620011837.14010-2-chris.packham@alliedtelesis.co.nz>
 <20170622082230.wf4r2ylyevidizkd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59564 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbdFVVVD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Jun 2017 17:21:03 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

On 22/06/17 20:23, Wolfram Sang wrote:=0A=
> =0A=
>> + - reset-gpios : gpio specifier for gpio connected to RESET_N pin.=0A=
> =0A=
> What about the 'active' state that Rob mentioned in his last review?=0A=
> =0A=
=0A=
My intention was that by saying it is connected to the RESET_N bin the =0A=
active state is covered.=0A=
=0A=
I personally always get a little confused when talking about reset =0A=
lines. The _N denotes that the line is active low but because it is a =0A=
reset line writing 1 releases the reset so from a what-the-user-wants =0A=
perspective it's active high.=0A=
=0A=
dt-binding-wise what we want here is GPIO_ACTIVE_HIGH, as in the driver =0A=
writes 1 to release reset so don't do any polarity inversion. I'd be =0A=
happy do add something to that effect in a v3 but I actually felt saying =
=0A=
the gpio is connected to RESET_N was less ambiguous.=0A=
