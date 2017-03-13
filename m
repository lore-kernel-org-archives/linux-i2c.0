From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [i2c-tools PATCH v2] i2ctransfer: add new tool
Date: Mon, 13 Mar 2017 13:07:25 +0100
Message-ID: <20170313120725.43uy64azuixdt5qz@pengutronix.de>
References: <20170306142931.10457-1-wsa@the-dreams.de>
 <20170306195038.6d6a5y5luyuuy7jv@pengutronix.de>
 <20170313110140.GA2476@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33679 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750952AbdCMMH3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 13 Mar 2017 08:07:29 -0400
Content-Disposition: inline
In-Reply-To: <20170313110140.GA2476@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Hello,

On Mon, Mar 13, 2017 at 12:01:40PM +0100, Wolfram Sang wrote:
> Hi Uwe,
> 
> thanks for the review!
> 
> > > +.RI [ data ]
> > > +.RI [ desc
> > > +.RI [ data ]]
> > 
> > You could join the previous two lines.
> 
> Try it. You will miss some spaces, then.

It works fine with quoting:

	.RI [ "desc " [ data "]] ..."

. But ok, it's at least arguable if this is better than your solution.

> > > +Also, you cannot be interrupted by another I2C master during one transfer, but it might happen between multiple transfers.
> > 
> > Well, unless you loose arbitration. Maybe this is too picky to be
> > relevant here?
> 
> I wonder: will another I2C master start a transfer on a repeated start?
> Need to investigate.

I'd say it must not. It should have logic to detect bus busy and delay
any transfers until the bus becomes idle. With a repeated start the bus
doesn't become idle between two transfers.

> > > +	for (i = 0; i <= nmsgs; i++)
> > > +		free(msgs[i].buf);
> > > +
> > > +	exit(1);
> > 
> > return EXIT_FAILURE; ?
> > 
> > Apart from the exit code this is exactly the trailer of the good path,
> > so these could share code.
> 
> No! One has '< nmsgs', the other one '<= nmsgs'. Friendly rant: It was
> all easier and less subtle before Jean wanted the 'don't rely on the OS
> for cleanup' additions ;)

ah, ok. BTW, I like tools that clean up after themselves. This way
debugging is much easier if you look for lost memory. And yes, this
doesn't matter much for short-living programs like i2c-tools, but I like
being consistent here and also do the cleanup for this this type of
program.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
