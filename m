From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch v2] i2c: imx: implement bus recovery
Date: Tue, 8 Sep 2015 22:22:58 +0200
Message-ID: <20150908202258.GY14598@pengutronix.de>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
 <20150813081528.GA9999@pengutronix.de>
 <CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
 <20150819070218.GE9999@pengutronix.de>
 <CACRpkdYy3xQ3N7199GcV83-HrgOERnffNLh=qak8K8hpcAHs1Q@mail.gmail.com>
 <20150907080032.GO9999@pengutronix.de>
 <CACRpkdaRu0jLJUddpjVvO9cBCRfHJpzAm0K1v825dCiSy0Zweg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaRu0jLJUddpjVvO9cBCRfHJpzAm0K1v825dCiSy0Zweg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Tue, Sep 08, 2015 at 04:18:41PM +0200, Linus Walleij wrote:
> On Mon, Sep 7, 2015 at 10:00 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > [Me]
>=20
> >> If the use case is around the i2c traffic, it is a mode related to=
 I2C,
> >> and if this mode is called "GPIO mode" in the data sheet
> >> is irrelevant, because it is obviously not used for the generic
> >> input/output but the specific I2C. The terminology should be
> >> made familiar to whoever needs to go in and read the code later.
> >
> > The background info that was obviously missing from the part of the
> > thread I sent to you is that pinctrl_pm_select_sleep_state is used =
to
> > prepare bitbanging on the i2c bus to do bus recovery. (The controll=
er
> > doesn't implement this, so we have to resort to manually drive the
> > pins.)
>=20
> I don't understand. What does "manually" mean in this context?
> Code examples for "manual" and "automatic"?

Normally i2c operations are done using the i2c core in the SoC and usin=
g
the i2c function of the respective pins. Recovery
however must be done (manually) by configuring the lines as GPIO and
using a sequence of calls to gpio_[gs]et_value.

The sleep state of the i2c bus device (usually?) configures the i2c
lines as GPIO. Is it ok to (ab)use the sleep state to prepare for the
recovery procedure or should we better introduce a dedicated gpio mode
pinctrl?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
