From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Fri, 5 Mar 2010 09:50:40 +0100
Message-ID: <20100305095040.6ab4612c@hyperion.delvare>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>
	<20100305071130.GB21925@pengutronix.de>
	<4B90B341.9000601@windriver.com>
	<20100305074155.GD21925@pengutronix.de>
	<4B90B888.6060005@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B90B888.6060005-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Yang, Wolfram,

On Fri, 05 Mar 2010 15:53:44 +0800, Yang Shi wrote:
> Wolfram Sang =E5=86=99=E9=81=93:
> >>> Is the use of 'eeprom' instead of 'at24' intentional?
> >>>  =20
> >>>      =20
> >> Unfortunately, at24 driver can't work on this board, I must use le=
gacy
> >> eeprom.
> >>    =20
> >
> > Well, you are of course free to choose here :)
> >
> > I'd just be interested if there is a software limitation which prev=
ents you from
> > using AT24. Because, it _should_ work with all kind of eeproms the =
legacy driver
> > deals with. Otherwise it is probably a bug which needs to be fixed.
> >  =20
>=20
> Thanks to point out this. Let me take a look at this.

One limitation of the at24 driver is that it needs the underlying
controller to support either raw I2C access or at least I2C block
transactions. Konstantin Lazarev complained about that one month ago
already.

I am currently working on improving the at24 driver so that it falls
back to byte transactions when block transactions are not available. I
might also add word transaction support (as the eeprom driver has) as
it is often the best performance/compatibility trade-off. I'll post the
patch when I'm done.

I'm not yet sure what will happen to the legacy eeprom driver in the
long run, but I would prefer new designs to not rely on it.

--=20
Jean Delvare
