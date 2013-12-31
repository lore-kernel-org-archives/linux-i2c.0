From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Openblocks AX3-4 i2c bus lockup
Date: Tue, 31 Dec 2013 12:08:56 +0100
Message-ID: <52C2A5C8.7040201@free-electrons.com>
References: <20131221164151.GF20115@lunn.ch> <CADx9zJDbzUmgHCRn9K=8m_d_uiSAYoW3y_NVfLFiDq4WzS3C0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADx9zJDbzUmgHCRn9K=8m_d_uiSAYoW3y_NVfLFiDq4WzS3C0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On 22/12/2013 00:06, Gregory CLEMENT wrote:
> Hi Andrew,
>=20
> I am away this weekend (Christmas with the first part of the family).
>=20
> But I remember having few issue on i2c with the first AX3-4 I receive=
d. With the second one (using a B0 steping CPU), I didn't remember havi=
ng any issues. As I thought the first AX3-4 I
> received was an early release I didn't paid more attention. The last =
i2c patches I sent were tested on the AX3-4 CPU rev B.
>=20
> Could you tell me what kind of command did you do to get your issues =
? Then I will try to reproduce it on Monday on both revision
>=20
> Thanks,
>=20
> Gregory


Sorry to not have answered earlier but when I investigated it I found
an unexpected issue.

=46irst I wanted to be sure that there the issue was not introduce by a
commit so reverted one by one the commits on the file
drivers/i2c/busses/i2c-mv64xxx.c. I tested it on both version of the
OpenBlock AX-4 (with CPU A0 and B0). After each commit the kernel
continue to work on the B0 version as expected, but it was when I
reverted the commit "i2c: mv64xxx: Add I2C Transaction Generator
support" that it worked also on the A0 version.

Then I had a look on the errata datasheet and I found issues that I
missed when I worked on it. This issues were fixed in B0 version.

The fix should be pretty simple: disabling the offload_enabled flag whe=
n
an A0 version of the CPU is used. For this there are 2 solutions:
introducing a new compatible string or trying to detect the CPU
stepping at runtime. I would prefer the second solution and I am lookin=
g
for a way to get this information.

Thanks,

Gregory


>=20
> Le 21 d=E9c. 2013 17:43, "Andrew Lunn" <andrew-g2DYL2Zd6BY@public.gmane.org <mailto:andrew=
@lunn.ch>> a =E9crit :
>=20
>     Hi Nobuhiro
>=20
>     You added I2C into the Openblocks AX3-4 device tree and the subno=
de
>     for the RTC. Did you have any problems with I2C? I'm having lots =
of
>     problems with my AX3-4 and i2c. I get i2c errors and the bus bein=
g
>     locked and then the whole machine locks solid.
>=20
>     Gregory, did you test your I2C patches for 370/XP on an Openblock=
s
>     AX3-4?
>=20
>     Thanks
>             Andrew
>=20
>     _______________________________________________
>     linux-arm-kernel mailing list
>     linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org <mailto:linux-arm-kernel@lis=
ts.infradead.org>
>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20


--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
