From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH 2/3] drivers: misc: eeprom: at24: support reading mac
 eeprom from different addresses
Date: Thu, 29 Jun 2017 14:56:03 +0300
Message-ID: <CAHp75Vf_SL3ReKLK0=8v3bDwHs5qwi2qc9p=XzJK9BXzOsLKLA@mail.gmail.com>
References: <1498736351-9021-1-git-send-email-claudiu.beznea@microchip.com> <1498736351-9021-3-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35348 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbdF2L4F (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 29 Jun 2017 07:56:05 -0400
In-Reply-To: <1498736351-9021-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>

On Thu, Jun 29, 2017 at 2:39 PM, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
> Add support for reading from different offsets of EEPROM.
> The offset is initialized via device tree. If nothing is
> given as input the old value, 0x90, is used. In this way
> the driver could be used as generic driver for different
> vendor memories by only changing the reading offset via
> device tree.

> +       err = device_property_read_u8(dev, "start-offset", &chip->offset);

This property has to be documented.

Moreover, the name looks too broad (I checked current use of
"*-offset" type of properties and they either vendor specific, or data
type specific.

Taking above into consideration mac-offset sounds better to me.

-- 
With Best Regards,
Andy Shevchenko
