From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [RFC PATCH 2/3] drivers: misc: eeprom: at24: support reading mac
 eeprom from different addresses
Date: Wed, 5 Jul 2017 12:31:37 +0300
Message-ID: <c9ee02db-f364-7ac4-dbb5-12fed48ae489@microchip.com>
References: <1498736351-9021-1-git-send-email-claudiu.beznea@microchip.com>
 <1498736351-9021-3-git-send-email-claudiu.beznea@microchip.com>
 <CAHp75Vf_SL3ReKLK0=8v3bDwHs5qwi2qc9p=XzJK9BXzOsLKLA@mail.gmail.com>
 <20170629133029.fq6jjivu5cx22j6q@rfolt0960.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:32880 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbdGEJbo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 5 Jul 2017 05:31:44 -0400
In-Reply-To: <20170629133029.fq6jjivu5cx22j6q@rfolt0960.corp.atmel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>



On 29.06.2017 16:30, Ludovic Desroches wrote:
> On Thu, Jun 29, 2017 at 02:56:03PM +0300, Andy Shevchenko wrote:
>> On Thu, Jun 29, 2017 at 2:39 PM, Claudiu Beznea
>> <claudiu.beznea@microchip.com> wrote:
>>> Add support for reading from different offsets of EEPROM.
>>> The offset is initialized via device tree. If nothing is
>>> given as input the old value, 0x90, is used. In this way
>>> the driver could be used as generic driver for different
>>> vendor memories by only changing the reading offset via
>>> device tree.
>>
>>> +       err = device_property_read_u8(dev, "start-offset", &chip->offset);
>>
>> This property has to be documented.
Sure! In this patch series it was documented in patch 2 from series.
Are you talking about documenting it in another place?

>>
>> Moreover, the name looks too broad (I checked current use of
>> "*-offset" type of properties and they either vendor specific, or data
>> type specific.
>>
>> Taking above into consideration mac-offset sounds better to me.
Ok, I will use that name.
> 
> I agree, it sounds better to me too.
Ok, I will use that name.
Thanks,
Claudiu
> 
> Regards
> 
> Ludovic
> 
