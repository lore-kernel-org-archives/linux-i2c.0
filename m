From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v9 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
Date: Mon, 9 Feb 2015 21:36:03 -0800
Message-ID: <54D998C3.4080006@broadcom.com>
References: <rjui@broadcom.com> <1423373126-30024-1-git-send-email-rjui@broadcom.com> <1423373126-30024-4-git-send-email-rjui@broadcom.com> <20150209121103.GC2491@katana> <54D99606.9070309@broadcom.com> <54D99848.2080205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54D99848.2080205-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 2/9/2015 9:34 PM, Florian Fainelli wrote:
> Le 09/02/2015 21:24, Ray Jui a =C3=A9crit :
>>
>>
>> On 2/9/2015 4:11 AM, Wolfram Sang wrote:
>>> On Sat, Feb 07, 2015 at 09:25:26PM -0800, Ray Jui wrote:
>>>> Add I2C device nodes and its properties in bcm-cygnus.dtsi but kee=
p
>>>> them disabled there. Individual I2C devices can be enabled in boar=
d
>>>> specific dts file when I2C slave devices are enabled in the future
>>>>
>>>> Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>>> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>>> Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>
>>> I usually don't take DTS patches. They should go via arm-soc. Pleas=
e say
>>> so if there are reasons I should take them.
>>>
>> Okay. I'll send this as an individual patch to arm-soc.
>=20
> Could you put in  in a branch somewhere on github.com=C3=B9/cygnus-li=
nus.git
> so it's easy for me to pull from there?
> --
> Florian
>=20
Hi Florian,

It's in branch cygnus-i2c-v9.

Thanks!

Ray
