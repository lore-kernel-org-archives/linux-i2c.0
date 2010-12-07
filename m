From: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Tue, 7 Dec 2010 02:26:54 +0000 (GMT)
Message-ID: <alpine.LFD.2.00.1012070148050.17185@eddie.linux-mips.org>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com> <20101206173040.GA18372@ericsson.com> <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org> <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 6 Dec 2010, Matt Turner wrote:

> > =A0Matt, thanks for keeping your eye on these bits and reviving the=
m; I've
> > meant to do so for a long time now, but never came to it. =A0Please=
 note
> > however, as I'm the original author, my original Signed-off-by mark=
ups
> > continue to apply and you should be quoting them with the submissio=
ns.
> > You should only add your own Signed-off-by annotation if you made a=
ny
> > changes and it would make sense to state what these changes were.
>=20
> Sure thing. Will fix. For patches 2 and 3 of the other series, I don'=
t
> think I was ever 100% sure that you were the author, since they were
> living on OpenWRT.org and I couldn't find them in any mailing list
> archives. Can you confirm that these 4 patches are all yours?

 All the relevant submissions should be present here:

http://www.linux-mips.org/archives/linux-mips/2008-05/threads.html

Specifically:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=3Dlinux-mips&i=3DPine.LNX.=
4.55.0805180447210.10067%40cliff.in.clinika.pl

(5th of a series of 6), and:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=3Dlinux-mips&i=3DPine.LNX.=
4.55.0805070054440.16173%40cliff.in.clinika.pl

(3rd of a series of 4), and:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=3Dlinux-mips&i=3DPine.LNX.=
4.55.0805130353250.535%40cliff.in.clinika.pl

(individual submission).

The "clean up SWARM RTC setup" change seems to be modified (lacking e.g=
=2E a=20
proper read_persistent_clock() implementation) compared to my proposal=20
(second above) and most likely came from someone else and the lm90 chan=
ge=20
definitely comes from someone else.

 Note that for IRQ support you may have to investigate dependencies in =
the=20
other two series as the patch (third above) was intended to apply on to=
p=20
of the two series (select the date sort for easier identification of th=
e=20
series).  I'd have to dig into that code for further details and I cann=
ot=20
afford the time right now, sorry.

  Maciej
