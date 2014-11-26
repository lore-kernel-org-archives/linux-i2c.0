From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/5] i2c: davinci: query STP always when NACK is
 received
Date: Wed, 26 Nov 2014 18:15:19 +0100
Message-ID: <20141126171519.GP4431@pengutronix.de>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-3-git-send-email-grygorii.strashko@ti.com>
 <20141126155711.GL4431@pengutronix.de>
 <5476005A.6090207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5476005A.6090207@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, linux-i2c@vger.kernel.org, Mike Looijmans <milo-software@users.sourceforge.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello Grygorii,

On Wed, Nov 26, 2014 at 06:31:22PM +0200, Grygorii Strashko wrote:
> On 11/26/2014 05:57 PM, Uwe Kleine-K=F6nig wrote:
> >I don't understand your use of "query" in the subject and later in t=
he
> >commit log. Do you mean "send"?
>=20
> will change to "generate". Ok?
yes that would be better understandable

> Can I assume that you are ok with this patch in general?
Yeah, your argument that being able to send a Sr is not sensible made
sense to me. If Wolfram is happy with your patch so am I.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
