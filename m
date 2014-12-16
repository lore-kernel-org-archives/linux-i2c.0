From: arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org (Arnaud Ebalard)
Subject: Re: [PATCHv1 1/7] dt-bindings: use isil prefix for Intersil
Date: Tue, 16 Dec 2014 19:44:28 +0100
Message-ID: <87bnn3e8oj.fsf@natisbad.org>
References: <cover.1418688042.git.arno@natisbad.org>
	<8e8a6eff40822083c0510f6c2787639ee819ef45.1418688042.git.arno@natisbad.org>
	<20141216081913.GC13486@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141216081913.GC13486-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> ("Uwe \=\?utf-8\?Q\?Klein\?\=
 \=\?utf-8\?Q\?e-K\=C3\=B6nig\=22's\?\=
	message of "Tue, 16 Dec 2014 09:19:13 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Hayato Suzuki <hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Antony Pavlov <antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Uwe,

Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:

> On Tue, Dec 16, 2014 at 01:22:27AM +0100, Arnaud Ebalard wrote:
>> This patch fixes DT documentation to reference isil (NASDAQ symbol a=
nd
>> the most used prefix inside the kernel) for all Intersil products.
>>=20
>> It reverts both 7c75c1d5e72b ("dt-bindings: Document deprecated devi=
ce
>> vendor name to fix related warning") and b2ea3f82e798 ("dt-bindings:
>> Document correct and deprecated vendor-prefix with device isl29028")=
=2E
> Unrelated to this patch I wonder if checkpatch could be improved to n=
ot
> warn about unknown vendor prefixes in compatibility strings that only
> exist for compatibility. This assumes that it's not necessary to also
> document deprecated vendor prefixes, not sure about this
> one. Thoughts?

AFAICT, we want checkpatch to detect mistakes in patches which are abou=
t
to be merged. I think checkpatch will work as expected for those new
patches, i.e. warn someone if she tries and use an unknown vendor prefi=
x
or a deprecated one ... as long as deprecated prefixes are not in
vendor-prefixes.txt. IMHO, that's the reason it is a bad idea to put
deprecated prefixes in vendor-prefixes.txt, it make checkpatch silent
about the use of a deprecated prefix.

=46or existing files, I think checkpatch can be useful in order to do t=
he
work I did in this series (for Intersil) for unknown vendors. A quick
run gives a value of 237 vendors prefix issues on the 527 arm .dts
files ;-)


>> Signed-off-by: Arnaud Ebalard <arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 3 +--
> I guess it's OK to keep the two changes in one patch, but formally th=
ey
> are maintained by different people. Should this patch be split?

I'll send a new batch for the space issue you point below. I will take
take the opportunity to split those.


>>  2 files changed, 3 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.t=
xt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> index 9f4e3824e71e..0aaff72065bf 100644
>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> @@ -58,9 +58,8 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Code=
c
>>  gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog wit=
h Two-Wire Interface
>>  infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, =
max 100khz)
>>  infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400k=
hz)
>> -isl,isl12057		Intersil ISL12057 I2C RTC Chip
>> -isil,isl29028           (deprecated, use isl)
>> -isl,isl29028            Intersil ISL29028 Ambient Light and Proximi=
ty Sensor
>> +isil,isl12057		Intersil ISL12057 I2C RTC Chip
>> +isil,isl29028           Intersil ISL29028 Ambient Light and Proximi=
ty Sensor
> Here is some tab vs space issue. The surrounding lines (in the contex=
t)
> all use tab.

will tabify those.


>>  maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
>>  maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>>  maxim,max6625		9-Bit/12-Bit Temperature Sensors with I=C2=B2C-Compa=
tible Serial Interface
>
> Best regards
> Uwe
