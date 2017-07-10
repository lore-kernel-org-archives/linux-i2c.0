From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
Date: Mon, 10 Jul 2017 09:47:05 +0200
Message-ID: <CABxcv==J_QwoivZ0PRWMoG-weAp7F-LpEXkBxw_9jwH3ENKjsw@mail.gmail.com>
References: <20170615185418.13980-1-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35135 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbdGJHrL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 10 Jul 2017 03:47:11 -0400
Received: by mail-it0-f65.google.com with SMTP id v193so12020840itc.2
        for <linux-i2c@vger.kernel.org>; Mon, 10 Jul 2017 00:47:11 -0700 (PDT)
In-Reply-To: <20170615185418.13980-1-javier@dowhile0.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Florian Larysch <fl@n621.de>, David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>, Dinh Nguyen <dinguyen@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Scott Wood <oss@buserror.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joachim Eastwood <manabian@gm>

Hello Wolfram,

On Thu, Jun 15, 2017 at 8:54 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> This series is a follow-up to patch [0] that added an OF device ID table
> to the at24 EEPROM driver. As you suggested [1], this version instead of
> adding entries for every used <vendor,device> tuple, only adds a single
> entry for each chip type using the "atmel" vendor as a generic fallback.
>
> The first patch documents in the DT binding what's the correct vendor to
> use and what are the ones that are being deprecated. The second one adds
> the OF device ID table for the at24 driver and the next patches use this
> vendor in the compatible string to each DTS that defines a compatible I2C
> EEPROM device node.
>
> Patches can be applied independently since the DTS changes without driver
> changes are no-op and the OF table won't be used without the DTS changes.
>
> [0]: https://lkml.org/lkml/2017/3/14/589
> [1]: https://lkml.org/lkml/2017/3/15/99
>

Are you planning to pick this series? It has been in the list for
months and were resent many times...

Best regards,
Javier
