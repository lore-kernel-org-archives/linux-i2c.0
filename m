From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Q: I2C multiplexer support
Date: Mon, 7 Dec 2009 12:57:37 +0100
Message-ID: <20091207125737.3da7bd3b@hyperion.delvare>
References: <4B1CC5EA.7040902@gmx.de>
	<20091207105132.6926bf19@hyperion.delvare>
	<20091207100000.GD3647@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091207100000.GD3647-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 7 Dec 2009 11:00:00 +0100, Rodolfo Giometti wrote:
> On Mon, Dec 07, 2009 at 10:51:32AM +0100, Jean Delvare wrote:
> > 
> > In all honesty, I did not look at Rodolfo's code at all. When he sent
> > it originally, I didn't have the time, being in the middle of major
> > i2c-core changes and cleanups. After 2.6.31 was released, I finally had
> > the time to look into it. But as I knew the recent i2c-core changes
> > would require Rodolfo's patches to be rebased, I asked him to do that
> > first. But now it's apparently Rodolfo's time to be busy :( If you want
> > to help, you're welcome.
> 
> I should have some spare time during december... however I cannot test
> the code anymore due lack of hardware. :'(

I don't have any hardware to test either, but I hope Michael does?

I am also considering adding some kind of multiplexing support to
i2c-stub, so that testing can be done without real hardware at hand.
Not sure what it would look like though, nor how much work would be
needed.

> Please, coordinate ourself and try to finish this job!

What is most needed now is to port your work on top of kernel 2.6.32
(or Linus' latest) so that the patches do apply and build again and can
get some testing. It is also easier for me to review patches and keep
track of them when they apply.

-- 
Jean Delvare
