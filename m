From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH] i2c: at91: add a sanity check on i2c message length
Date: Mon, 5 Nov 2012 07:08:29 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EFB340B@wm021.weinmann.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de> <5093A8CD.60006@atmel.com>
 <20121102111432.GD21313@pengutronix.de> <5093EE2B.8080005@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5093EE2B.8080005-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "'ludovic.desroches'" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, 'Wolfram Sang' <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ludovic.desroches wrote on Friday, November 02, 2012 5:01 PM:
> Le 11/02/2012 12:14 PM, Wolfram Sang a =E9crit :
> > On Fri, Nov 02, 2012 at 12:04:45PM +0100, ludovic.desroches wrote:
> >> Hi Wolfram,
> >>
> >> Le 11/01/2012 11:29 PM, Wolfram Sang a =E9crit :
> >>> On Wed, Oct 10, 2012 at 04:25:58PM +0200,
> ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> >>>> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >>>>
> >>>> If the i2c message length is zero, i2c-at91 will directly return=
 an error
> >>>> instead of trying to send a zero-length message.
> >>>>
> >>>> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >>>
> >>> What happens if you send a 0 byte message? Some hardware is able =
to
> do
> >>> this and it will be used in SMBUS QUICK which the driver states t=
o
> >>> support according to at91_twi_func().
> >>
> >> Without this I had some data corruption when writing to / reading
> >> from a serial eeprom (depending on the IP version).
> >>
> >> Yes SMBUS quick command is supported but is not managed in the
> >> driver, we have to tell explicitly the IP that we want to send thi=
s
> >> command.
> >
> > Ok, so unless you want to implement the support, please update this
> > patch with a comment that SMBUS_QUICK is a TODO and remove the
> > SMBUS_QUICK capability.
> >
>=20
> Implementation should not be a huge task, only one bit to set in a
> register but I have no device to test it.
> So I will choose to remove the SMBUS_QUICK capability.
>=20
> Hi Nikolaus,
>=20
> Did you test the driver with SMBus compatible devices? Can I keep oth=
er
> SMBus capabilities from SMBUS_EMUL?

Hi Ludovic,

yes, I use this driver with the sbs driver to query a smbus-attached
battery with a TI bq chip (I actually wrote this driver only for this
purpose). I implemented and tested SMBUS_BLOCK but not
SMBUS_QUICK...

Niko
