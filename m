From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c: Fix Kconfig indentation
Date: Mon, 25 Nov 2019 16:01:35 +0000
Message-ID: <63e3fe9d-93c5-1e82-5a4e-c8b7cc6ff301@axentia.se>
References: <1574306363-29424-1-git-send-email-krzk@kernel.org>
 <20191125145849.GD2412@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191125145849.GD2412@kunai>
Content-Language: en-US
Content-ID: <E5E6E30E572B324596C4B965AFD3C903@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2019-11-25 15:58, Wolfram Sang wrote:
> On Thu, Nov 21, 2019 at 04:19:23AM +0100, Krzysztof Kozlowski wrote:
>> Adjust indentation from spaces to tab (+optional two spaces) as in
>> coding style with command like:
>> 	$ sed -e 's/^        /\t/' -i */Kconfig
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Fix also 7-space and tab+1 space indentation issues.
>> ---
>>  drivers/i2c/busses/Kconfig | 22 +++++++++++-----------
>>  drivers/i2c/muxes/Kconfig  | 18 +++++++++---------
>=20
> Peter, I'd like to apply this for 5.5. so we don't have to deal with
> whitespace conflicts during the next cycle. Are you fine with me picking
> it up for muxes?

Absolutely!

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
