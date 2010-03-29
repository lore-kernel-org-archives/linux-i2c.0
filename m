From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Mon, 29 Mar 2010 16:31:49 +0200
Message-ID: <20100329163149.41df7f10@hyperion.delvare>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
	<20100317135223.GD4153@pengutronix.de>
	<f69abfc31003170826j18fa0fddq1c46b8bcebf75c57@mail.gmail.com>
	<f69abfc31003180201m5c5e167enf8256c4843e0c6ba@mail.gmail.com>
	<20100318091917.GA27165@pengutronix.de>
	<f69abfc31003180251q53c96f8chc6b96d29c2ceec6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f69abfc31003180251q53c96f8chc6b96d29c2ceec6d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolram, Yegor,

On Thu, 18 Mar 2010 10:51:09 +0100, Yegor Yefremov wrote:
> On Thu, Mar 18, 2010 at 10:19 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> >> If I don't redirect syslog to a remote host I get i2c fail. So here you are:
> >
> > Thanks!
> >
> > [...]
> >
> >> As far as I can tell the last transaction lacks "=== STOP" state.
> >
> > Yes. The bus-status being 0x58 instead of 0xf8 says that, too. I wanted to
> > check if there is something flaky before. Will have a look, but will probably
> > be the weekend. You said it does not appear when you use 2.6.26, right?
> 
> Right. Either it is so seldom, that I don't notice it or it doesn't
> occur. But with 2.6.33 it is really frequent.

Any progress on this? If this is a regression, we want to fix it
quickly.

Thanks,
-- 
Jean Delvare
