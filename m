From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Wed, 17 Mar 2010 16:26:09 +0100
Message-ID: <f69abfc31003170826j18fa0fddq1c46b8bcebf75c57@mail.gmail.com>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
	 <20100317135223.GD4153@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100317135223.GD4153-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>> Could this be the reason for such behavior? Any idea?
>
> Can you set the algo-module parameter i2c_debug to 3 and post the log for the
> transfer that failed, please?

I've increased i2c_debug to 3 and now I get a lot of debug messages,
but the error doesn't occur. These debug messages seem to influence
the timing.

Regards,
Yegor
