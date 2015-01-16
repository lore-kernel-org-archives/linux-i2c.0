From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
Date: Fri, 16 Jan 2015 11:24:09 -0800
Message-ID: <54B96559.1010007@broadcom.com>
References: <rjui@broadcom.com> <1421274213-3544-1-git-send-email-rjui@broadcom.com> <1421274213-3544-4-git-send-email-rjui@broadcom.com> <20150115084456.GO22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115084456.GO22880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 1/15/2015 12:44 AM, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Wed, Jan 14, 2015 at 02:23:33PM -0800, Ray Jui wrote:
>> Add I2C device nodes and its properties in bcm-cygnus.dtsi but keep
>> them disabled there. Individual I2C devices can be enabled in board
>> specific dts file when I2C slave devices are enabled in the future
> s/$/./
>=20
>>
>> Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/bcm-cygnus.dtsi |   20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/b=
cm-cygnus.dtsi
>> index 5126f9e..f7d6c1d 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -70,6 +70,26 @@
>>  		};
>>  	};
>> =20
>> +	i2c0: i2c@18008000 {
>> +		compatible =3D "brcm,iproc-i2c";
> in patch 2 you wrote the driver is for a family of SoCs, right? Then =
I'd
> make this:
>=20
> 	compatible =3D "brcm,$mysoc-iproc-i2c", "brcm,iproc-i2c";
>=20
Sorry could you please help to explain the intention here? Note the
iProc I2C IP can be found in various iProc family of SoCs, but to my
best knowledge, there hasn't been any changes of the IP in any of those
SoCs.

Is the compatible ID "brcm,$mysoc-iproc-i2c" only to clarify that it's
for a specific SoC? If so, what should the compatible ID array look
like? Should it be changed to the following?

static const struct of_device_id bcm_iproc_i2c_of_match[] =3D {
	{ .compatible =3D "brcm,iproc-i2c" },
	{ .compatible =3D "brcm,$mysoc-iproc-i2c" },
	{},
};


> (or maybe s/$mysoc-iproc-i2c/$mysoc-i2c/).
>=20
> Best regards
> Uwe
>=20
