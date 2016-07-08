From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] i2c: imx: add retries for i2c-0 on Ventana boards
Date: Fri, 8 Jul 2016 12:49:04 -0700
Message-ID: <CAJ+vNU2QLTh7-tbLB_b2S04+pMg3VFjN2kk8T2d6x1okdmbx1A@mail.gmail.com>
References: <1467900229-5262-1-git-send-email-tharvey@gateworks.com> <20160708062846.GI16643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160708062846.GI16643@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Fabio Estevam <fabio.estevam@freescale.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 7, 2016 at 11:28 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Tim,
>
> On Thu, Jul 07, 2016 at 07:03:49AM -0700, Tim Harvey wrote:
>> Gateworks Ventana IMX6 based boards have a Gateworks System Controll=
er [1]
>> (gsc) device that can NAK i2c transactions when its busy in an ADC l=
oop. As
>> this is always on i2c-0 we will add retries for that bus for any Ven=
tana
>> board.
>
> The right thing is to fix the drivers IMHO.
>

Hi Uwe,

Thanks for the feedack!

The issue I have is that the i2c device emulates several other devices
with existing drivers (pca953x, ds1672, at24) and those drivers don't
have any retry mechanism in place for a retry.

Maybe if I converted those drivers to use regmap I could implement a
regmap with retries in the mfd driver for my device?

Regards,

Tim
