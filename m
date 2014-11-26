From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
Date: Wed, 26 Nov 2014 19:05:31 +0200
Message-ID: <5476085B.40009@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com> <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com> <20141126160407.GN4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141126160407.GN4431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 11/26/2014 06:04 PM, Uwe Kleine-K=F6nig wrote:
> On Wed, Nov 26, 2014 at 03:59:53PM +0200, Grygorii Strashko wrote:
>> Having a board where the I2C bus locks up occasionally made it clear
>> that the bus recovery in the i2c-davinci driver will only work on
>> some boards, because on regular boards, this will only toggle GPIO
>> lines that aren't muxed to the actual pins.
>>
>> The I2C controller on SoCs like da850 (and da830), Keystone 2 has th=
e
>> built-in capability to bit-bang its lines by using the ICPFUNC regis=
ters
>> of the i2c controller.
>> Implement the suggested procedure by toggling SCL and checking SDA u=
sing
>> the ICPFUNC registers of the I2C controller when present. Allow plat=
forms
>> to indicate the presence of the ICPFUNC registers with a has_pfunc p=
latform
>> data flag and add optional DT property "ti,has-pfunc" to indicate
>> the same in DT.
> On what does it depend if this pfunc stuff works or not? Only the SoC=
,
> or also on some board specific properties?

SoC / set of SoCs. Also, similar feature is supported by OMAP and AM335=
x/AM437x SoCs
using I2C_SYSTEST register.

> Given the former using the
> compatible string to detect its availability would be better. (In thi=
s
> case also sorry, didn't consider this case when requesting the proper=
ty
> in the last round.)
>=20
> The patch looks ok.

regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
