From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 2/5] i2c: davinci: query STP always when NACK is received
Date: Wed, 26 Nov 2014 18:31:22 +0200
Message-ID: <5476005A.6090207@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com> <1417010393-30598-3-git-send-email-grygorii.strashko@ti.com> <20141126155711.GL4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141126155711.GL4431@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mike Looijmans <milo-software@users.sourceforge.net>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-i2c@vger.kernel.org

On 11/26/2014 05:57 PM, Uwe Kleine-K=F6nig wrote:
> Hello,
>
> I don't understand your use of "query" in the subject and later in th=
e
> commit log. Do you mean "send"?

will change to "generate". Ok?

>
> On Wed, Nov 26, 2014 at 03:59:50PM +0200, Grygorii Strashko wrote:
>> According to I2C specification the NACK should be handled as folows:
> s/folows/follows/
ok.

Can I assume that you are ok with this patch in general?

regards,
-grygorii
