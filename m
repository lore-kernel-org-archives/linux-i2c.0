From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch v2] i2c: imx: implement bus recovery
Date: Mon, 7 Sep 2015 10:00:32 +0200
Message-ID: <20150907080032.GO9999@pengutronix.de>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
 <20150813081528.GA9999@pengutronix.de>
 <CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
 <20150819070218.GE9999@pengutronix.de>
 <CACRpkdYy3xQ3N7199GcV83-HrgOERnffNLh=qak8K8hpcAHs1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYy3xQ3N7199GcV83-HrgOERnffNLh=qak8K8hpcAHs1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hallo Linus,

On Tue, Aug 25, 2015 at 04:18:16PM +0200, Linus Walleij wrote:
> On Wed, Aug 19, 2015 at 9:02 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > On Wed, Aug 19, 2015 at 03:44:49AM +0000, Gao Pandy wrote:
> >> From: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> S=
ent: Thursday, August 13, 2015 4:15 PM
> >> > > +static void i2c_imx_prepare_recovery(struct i2c_adapter *adap=
) {
> >> > > + struct imx_i2c_struct *i2c_imx;
> >> > > +
> >> > > + i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapte=
r);
> >> > > + if (i2c_imx->pins.sda && i2c_imx->pins.scl) {
> >> > > +         pinctrl_pm_select_sleep_state(&adap->dev);
> >> >
> >> > Your requirement that the sleep state should configure the pins =
as gpio
> >> > is strange. Maybe better introduce a dedicated state for recover=
y? At
> >> > least you should document this requirement.
> >>
> >> In general, pinctrl sleep mode is gpio function. I will add this i=
n binding doc. Thanks.
> >
> > Linus, do you have to say something here? It might be right to have=
 the
> > gpio function as configuration for sleep mode, but it doesn't look =
right
> > for me to use this for recovery purposes.
>=20
> What it usually means is that the pin has a function mode such
> that an asynchronous edge detector is connected to it on the
> outer pad ring, maybe in tristate or some pull-up/down configuration.
> This makes is possible for the system to power
> off completely until an event occurs there with only some
> very peripheral electronics powered up.
>=20
> I think the terminology depend on the use case. See the section
> "GPIO mode pitfalls" in Documentation/pinctrl.txt
>=20
> If the use case is around the i2c traffic, it is a mode related to I2=
C,
> and if this mode is called "GPIO mode" in the data sheet
> is irrelevant, because it is obviously not used for the generic
> input/output but the specific I2C. The terminology should be
> made familiar to whoever needs to go in and read the code later.
The background info that was obviously missing from the part of the
thread I sent to you is that pinctrl_pm_select_sleep_state is used to
prepare bitbanging on the i2c bus to do bus recovery. (The controller
doesn't implement this, so we have to resort to manually drive the
pins.)

Is this good enough? I'd like to see implemented a separate pinctrl set
for bitbanging instead of relying on the sleep state being the right
thing to enable gpio functionality.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
