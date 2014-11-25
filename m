From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio for bus
 recovery
Date: Tue, 25 Nov 2014 15:04:30 +0200
Message-ID: <54747E5E.8070204@ti.com>
References: <1416477788-5544-6-git-send-email-grygorii.strashko@ti.com> <20141123170400.GC4431@pengutronix.de> <54732F8E.4080105@ti.com> <20141124194533.GU4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141124194533.GU4431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>, Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,
On 11/24/2014 09:45 PM, Uwe Kleine-K=F6nig wrote:
> On Mon, Nov 24, 2014 at 03:15:58PM +0200, Grygorii Strashko wrote:
>> On 11/23/2014 07:04 PM, Uwe Kleine-K=F6nig wrote:
>>> On Thu, Nov 20, 2014 at 12:03:08PM +0200, Grygorii Strashko wrote:
>>>> @@ -664,6 +759,7 @@ static int davinci_i2c_probe(struct platform_d=
evice *pdev)
>>>>    		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency=
",
>>>>    			&prop))
>>>>    			dev->pdata->bus_freq =3D prop / 1000;
>>>> +		dev->pdata->has_pfunc =3D true;
>>> I don't understand this. Why does this ICPFUNC recovery work if the=
 bus
>>> is probed by oftree, but doesn't if not?
>>
>> I've mentioned this in commit message:
>>   Allow platforms to indicate the presence of the ICPFUNC registers =
with a has_pfunc
>>   platform data flag and enable this mode for platforms which suppor=
ts DT (da850 and
>>   Keystone 2 are two SoCs which support DT now and they also support=
 ICPFUNC registers).
> Ah, so you assume that in the dt case the pfunc functionality is
> available. I didn't understand if it's bad or not if this assumption =
is
> wrong, but I suggest to only use the pfunc stuff if the device node h=
as
> a given property (e.g. ti,has_pfunc).

Agree. I'll add it.

regards,
-grygorii
