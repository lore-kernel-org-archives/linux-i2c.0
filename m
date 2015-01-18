From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 18 Jan 2015 12:17:59 +0100
Message-ID: <20150118111759.GG22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1421451737-7107-1-git-send-email-rjui@broadcom.com>
 <1421451737-7107-3-git-send-email-rjui@broadcom.com>
 <54BB795C.6040402@broadcom.com>
 <20150118094741.GE22880@pengutronix.de>
 <20150118110658.GA1113@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150118110658.GA1113@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Arend van Spriel <arend@broadcom.com>, Ray Jui <rjui@broadcom.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Christian Daudt <bcm@fixthebug.org>, Russell King <linux@arm.linux.org.uk>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Matt Porter <mporter@linaro.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On Sun, Jan 18, 2015 at 12:06:58PM +0100, Wolfram Sang wrote:
> On Sun, Jan 18, 2015 at 10:47:41AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sun, Jan 18, 2015 at 10:14:04AM +0100, Arend van Spriel wrote:
> > > On 01/17/15 00:42, Ray Jui wrote:
> > > >+	complete_all(&iproc_i2c->done);
> > >=20
> > > Looking over this code it seems to me there is always a single
> > > process waiting for iproc_i2c->done to complete. So using complet=
e()
> > > here would suffice.
> > Yeah, there is always only a single thread waiting. That means both
> > complete and complete_all are suitable. AFAIK there is no reason to=
 pick
> > one over the other in this case.
>=20
> Clarity?
And which do you consider more clear? complete_all might result in the
question: "Is there >1 waiter?" and complete might yield to "What about
the other waiters?". If you already know there is only one, both are on
par on clarity. Might only be me?! I don't care much.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
