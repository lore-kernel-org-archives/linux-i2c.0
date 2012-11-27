From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Tue, 27 Nov 2012 11:19:09 +0530
Message-ID: <CAKohpokgcvaSHNDoN2epnsxSmpKJ6GaWph0EW+rrkCfXjBrUyA@mail.gmail.com>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
	<50B20670.5070509@pcserviceselectronics.co.uk>
	<CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com>
	<50B35642.7030104@pcserviceselectronics.co.uk>
	<CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA@mail.gmail.com>
	<20121126202003.GA3384@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121126202003.GA3384-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 27 November 2012 01:50, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> In reply to a more detailed problem report that should be addressed b=
y
> this series on spear-devel I asked a few questions to rule out 6/ and
> 7/. I cannot find it in an public accessible archive though. It's abo=
ut
> a sta529 codec. When switching sample rates the codec then holds down
> SDA. After an additional clock pulse the device and bus are OK again.

Thanks for adding these here :)
