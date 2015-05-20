From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 20 May 2015 17:37:28 +0200
Message-ID: <20150520153728.GT24769@pengutronix.de>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150520085715.GA17078@pengutronix.de>
 <1432127020.20394.15.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432127020.20394.15.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>, Mark Rutland <mark.rutland@arm.com>, Xudong Chen <xudong.chen@mediatek.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Liguo Zhang <liguo.zhang@mediatek.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, May 20, 2015 at 09:03:40PM +0800, Yingjoe Chen wrote:
> On Wed, 2015-05-20 at 10:57 +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > > +	if (i2c->speed_hz > MAX_HS_MODE_SPEED)
> > > +		return -EINVAL;
> > According to the plan to tune for the highest possible rate <=3D
> > i2c->speed_hz, you should handle the case (i2c->speed_hz >
> > MAX_HS_MODE_SPEED) like i2c->speed_hz =3D=3D MAX_HS_MODE_SPEED.
> > Well, you might want to prevent an overflow in the calculation belo=
w
> > however.
>=20
> The check here means we don't support speed > MAX_HS_MODE_SPEED. This=
 is
> different then slightly slower bus speed due to rounding error.
Well from outside there no difference between asking for 100 with
getting 98 or asking for 405 with getting 400. IMHO the expectation is
that you set the maximal possible rate when something too big for you i=
s
requested. Consider a communication with a i2c device that supports 600
kHz. You have the choice to communicate with 400 kHz with that or not a=
t
all.

> > > +	best_mul =3D MAX_SAMPLE_CNT_DIV * max_step_cnt;
> > > +
> > > +	for (sample_cnt =3D 1; sample_cnt <=3D MAX_SAMPLE_CNT_DIV; samp=
le_cnt++) {
> > > +		step_cnt =3D (min_div + sample_cnt - 1) / sample_cnt;
> > DIV_ROUND_UP
> >=20
> > > +		cnt_mul =3D step_cnt * sample_cnt;
> > > +		if (step_cnt > max_step_cnt)
> > > +			continue;
> > I think it can happen that you have step_cnt > max_step_cnt here, b=
ut
> > that (sample_cnt, max_step_cnt) still is a good pair to consider. S=
o:
>=20
> If step_cnt > max_step_cnt, then sample_cnt * max_step_cnt < min_div.
> This means (sample_cnt, max_step_cnt) is not a valid.
You're right.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
