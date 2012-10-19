From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
Date: Fri, 19 Oct 2012 10:55:42 +0200
Message-ID: <5081158E.4040308@free-electrons.com>
References: <1350569623-4699-1-git-send-email-maxime.ripard@free-electrons.com> <1350569623-4699-2-git-send-email-maxime.ripard@free-electrons.com> <50808481.6040501@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50808481.6040501-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Le 19/10/2012 00:36, Stephen Warren a =E9crit :
> On 10/18/2012 08:13 AM, Maxime Ripard wrote:
>> Allow the i2c-mux-gpio to be used by a device tree enabled device. T=
he
>> bindings are inspired by the one found in the i2c-mux-pinctrl driver=
=2E
>=20
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
>=20
>> +Optional properties:
>> +- idle-state: value to set to the muxer when idle. When no value is
>> +  given, it defaults to the first value in the array.
>=20
> That's inconsistent with the following text that appears later (and
> describes what the driver actually does):

Ah, right, sorry

Maxime

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
