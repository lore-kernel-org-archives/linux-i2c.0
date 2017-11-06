From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4] i2c: aspeed: Deassert reset in probe
Date: Mon, 6 Nov 2017 12:40:21 +1100
Message-ID: <CACPK8Xf0pr6tw=7RDpcVCL0-sKAP=N25ntU-5a=t0G0mqNkoPA@mail.gmail.com>
References: <20171101002330.24981-1-joel@jms.id.au> <20171105124949.ct4ity6htxqgvvfp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:55831 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdKFBko (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 5 Nov 2017 20:40:44 -0500
In-Reply-To: <20171105124949.ct4ity6htxqgvvfp@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, Philipp Zabel <philipp.zabel@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Nov 5, 2017 at 11:49 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Wed, Nov 01, 2017 at 10:53:30AM +1030, Joel Stanley wrote:
>> In order to use i2c from a cold boot, the i2c peripheral must be taken
>> out of reset. We request a shared reset controller each time a bus
>> driver is loaded, as the reset is shared between the 14 i2c buses.
>>
>> On remove the reset is asserted, which only touches the hardware once
>> the last i2c bus is removed.
>>
>> The reset is required as the I2C buses will not work without releasing
>> the reset. Previously the driver only worked with out of tree hacks
>> that released this reset before the driver was loaded. Update the
>> device tree bindings to reflect this.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> v4:
>>   - Make reset required and update device tree bindings
>
> For that change, I'd like to have an ack from Rob first. Won't that
> cause problems when you update only the kernel and keep the "old"
> devicetree?

In theory, yes.

In practice, the consumers of the Aspeed port are using a downstream
fork that I maintain as part of the OpenBMC project:

  https://github.com/openbmc/linux/

None of the machines that use this kernel take a copy of the dtb and
place it in flash, for example.

My goal is to make the upstream port fully functional so we don't need
the downstream any more.

Cheers,

Joel
