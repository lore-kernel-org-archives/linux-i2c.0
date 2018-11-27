From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date: Tue, 27 Nov 2018 15:48:38 +0000
Message-ID: <cba730e8-d76b-6cc4-a6df-3aa79d86e580@axentia.se>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
 <20181127125050.GO1107@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127125050.GO1107@kunai>
Content-Language: en-US
Content-ID: <FBFB5628175A3C46B4E5B3652103CD4F@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2018-11-27 13:50, Wolfram Sang wrote:
> On Fri, Nov 23, 2018 at 01:51:38PM +0100, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> The "at," prefix was never correct for Atmel, so fix the few occurrences
>> that got it wrong. Use "atmel," instead.
>>
>> While at it, remove the at,24c08 compatible string from the list of
>> trivial devices because it is already documented in eeprom/at24.txt.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Peter, I'd assume you are okay with me applying the patch directly?

Absolutely, go ahead.

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
