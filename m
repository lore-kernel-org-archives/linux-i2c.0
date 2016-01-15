From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
Date: Fri, 15 Jan 2016 10:03:43 +0100
Message-ID: <20160115090343.GK24441@pengutronix.de>
References: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
 <20160115075356.GI24441@pengutronix.de>
 <CADRPPNT=+amxRcea=N7m96=wKgdbRmU8R5cBACvTn7XffKofzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADRPPNT=+amxRcea=N7m96=wKgdbRmU8R5cBACvTn7XffKofzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: Li Yang <leoyang.li@nxp.com>, Gao Pan <pandy.gao@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hello Li,

On Fri, Jan 15, 2016 at 04:46:06PM +0800, Li Yang wrote:
> On Fri, Jan 15, 2016 at 3:53 PM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >> -     i2c_imx_init_recovery_info(i2c_imx, pdev);
> >> +     if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
> >
> > I'd prefer to set i2c_imx->pinctrl to NULL if it's not used and the=
n use
> >
> >         if (!i2c_imx->pinctrl)
> >
> > here. (Or maybe make i2c_imx_init_recovery_info aware of this situa=
tion
> > to keep the caller simple?)
>=20
> Setting not used pointer to NULL might be a good coding practice
> generally.  But in this case neither the driver nor gpio framework
> checks if the pinctrl is NULL before accessing it.  We still need the
> driver to make sure pinctrl is not used in this situation.  The
> benefit of the proposed change seems to be pretty limited.  :)

At least it gets rid of IS_ERR_OR_NULL which is used wrongly more often
than not.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
