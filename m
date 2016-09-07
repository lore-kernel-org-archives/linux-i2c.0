From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
Date: Wed, 7 Sep 2016 07:55:47 +0200
Message-ID: <20160907055547.opp57zyxhlplhxhm@pengutronix.de>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
 <20160906185849.27pjhawadca5pwow@pengutronix.de>
 <CADRPPNQ+1qBNL5WA=Jo_keE7BPnoOs7a2T6CpTuciiF16qK6xQ@mail.gmail.com>
 <87ca69fb85848a0a86b34a9a9037a57b@agner.ch>
 <CADRPPNSPye45bmFshfwb+gDA0x0ygs4Ofa6HMYbKt9ER0oeccg@mail.gmail.com>
 <CAChUvXOGjTn6K5588UVgjbRWUY+weDtk2qbOU-NM4=kA2znh=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAChUvXOGjTn6K5588UVgjbRWUY+weDtk2qbOU-NM4=kA2znh=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tracy Smith <tlsmith3777@gmail.com>
Cc: Leo Li <pku.leo@gmail.com>, Stefan Agner <stefan@agner.ch>, Gao Pan <pandy.gao@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, lkml <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, linux-gpio@vger.kernel.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Tue, Sep 06, 2016 at 06:35:38PM -0500, Tracy Smith wrote:
> >The patch makes it really optional that
> >the probe function won't bailout but just disable the bus recovery function
> >when pinctrl is not available.
> 
> in the case of the LS1043A and LS1021A, if the bus recovery function is
> disabled, how will bus recovery occur?  Is there no option to recover the
> bus for the LS1021a and LS1043a?

Right. That's the situation that we had for all drivers some time ago.
Most of the time this is no problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
