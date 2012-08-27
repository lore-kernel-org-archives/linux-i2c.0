From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Mon, 27 Aug 2012 15:32:11 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,<503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>,<503B623C.4030304@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BC0F374A1C27184AB96177CDFEC2F54225ECD36E-rZDk5e4OVTsRAxgRyUl6SBEi2Xg3O0b1@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Yanes Martinez Adrian' <adrian.yanes-uOixanVlb7U@public.gmane.org>, "'ludovic.desroches'" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org'" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "'balbi-l0cyMroinI0@public.gmane.org'" <balbi-l0cyMroinI0@public.gmane.org>, "'h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org'" <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "'rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org'" <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "'carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org'" <carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Adian,

Yanes Martinez Adrian wrote on Monday, August 27, 2012 2:46 PM:
> Le 08/27/2012 12:40 PM, Yanes Martinez Adrian a =E9crit :
>> Hi Ludovic,
>>
>>> Tested on at91rm9200, at91sam9261, at91sam9g20 and at91sam9m10 with
>>> eeprom, temperature sensor and rtc devices (and wolfson chip for
>>> sam9g20).
>>
>> concerning the at91rm9200, what was the amount of bytes you
> transmitted?
>>
>=20
>> I have only checked that I can communicate with i2c devices so the
>> amount is very low (1-4 bytes).
>=20
> IIRC it was from >7 bytes when the issues appeared.
>=20
>> Some months ago I performed some testing[1] with the previous versio=
n of
>> the patch and the main conclusion was that the absence of PDC in the
>> AT91RM9200 made this driver unusable in such platform.

I didn't get your last post  in that thread. In my opinion RM9200 shoul=
d really
be excluded from being configured with this driver, what's your opinion
Ludovic?

Regards,
Niko
