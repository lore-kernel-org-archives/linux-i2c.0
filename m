From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
Date: Mon, 18 Jan 2016 09:37:04 +0100
Message-ID: <20160118083704.GQ24441@pengutronix.de>
References: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
 <20160115075356.GI24441@pengutronix.de>
 <CADRPPNT=+amxRcea=N7m96=wKgdbRmU8R5cBACvTn7XffKofzQ@mail.gmail.com>
 <20160115090343.GK24441@pengutronix.de>
 <CADRPPNR2YDj43XjJUQszEUkKDj256L6p=N2QYteFG8uAfBYdMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADRPPNR2YDj43XjJUQszEUkKDj256L6p=N2QYteFG8uAfBYdMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: Gao Pan <pandy.gao@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, linux-gpio@vger.kernel.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hello Leo,

On Mon, Jan 18, 2016 at 04:22:51PM +0800, Li Yang wrote:
> On Fri, Jan 15, 2016 at 5:03 PM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Jan 15, 2016 at 04:46:06PM +0800, Li Yang wrote:
> >> On Fri, Jan 15, 2016 at 3:53 PM, Uwe Kleine-K=F6nig
> >> <u.kleine-koenig@pengutronix.de> wrote:
> >> >> -     i2c_imx_init_recovery_info(i2c_imx, pdev);
> >> >> +     if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
> >> >
> >> > I'd prefer to set i2c_imx->pinctrl to NULL if it's not used and =
then use
> >> >
> >> >         if (!i2c_imx->pinctrl)
> >> >
> >> > here. (Or maybe make i2c_imx_init_recovery_info aware of this si=
tuation
> >> > to keep the caller simple?)
> >>
> >> Setting not used pointer to NULL might be a good coding practice
> >> generally.  But in this case neither the driver nor gpio framework
> >> checks if the pinctrl is NULL before accessing it.  We still need =
the
> >> driver to make sure pinctrl is not used in this situation.  The
> >> benefit of the proposed change seems to be pretty limited.  :)
> >
> > At least it gets rid of IS_ERR_OR_NULL which is used wrongly more o=
ften
> > than not.
>=20
> It's true that this API is not used a lot.  Are you suggesting that i=
t
> is poorly designed and probably should be removed?  But I still don't
> quite get the point why it tends to be wrongly used.  Do you consider
> the use in this patch a wrongly used case?

See http://permalink.gmane.org/gmane.linux.ports.arm.omap/97874 for an
earlier discussion. Having said that, I think at the moment there is no
such bug in this case, still I agree with Russell that IS_ERR_OR_NULL
isn't nice and so would prefer not to add new instances.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
