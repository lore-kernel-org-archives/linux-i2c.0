From: =?UTF-8?B?U3Zlbm5pbmcgU8O4cmVuc2Vu?= <sss-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: scx200_acb: avoid I2C bus overclocking.
Date: Tue, 12 May 2015 23:09:53 +0200
Message-ID: <55526C21.5070801@secomea.com>
References: <553955C6.3030000@secomea.com> <20150512201919.GL4449@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512201919.GL4449-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 12-05-2015 22:19, Wolfram Sang wrote:
> On Thu, Apr 23, 2015 at 10:27:50PM +0200, Svenning S=C3=B8rensen wrot=
e:
>> According to I2C spec, max SCL rate is 100 kHz, but SCx200/CS5536
>> controller is currently driving it at 214 kHz according to my math.
>>
>> SCL is derived from an input clock of 48 MHz, which must be divided
>> by 480 (240 cycles for each SCL high/low state) to be within spec.
>>
>> Signed-off-by: Svenning Soerensen <sss-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>
>=20
> So, did you test/measure the actual frequency? Or is this patch based=
 on
> specs only? Thanks for caring about this old driver, though!
>=20

Unfortunately I don't have any scope, so it is based on datasheet only.

I noticed sporadic i2c errors reading the temperature on some of my
PC Engines Alix.2 boards (with LM86 sensor chip) so started digging
the datasheets and driver for an explanation.

I haven't noticed any problems after this change.
