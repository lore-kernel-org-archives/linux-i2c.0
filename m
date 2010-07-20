From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: add generic I2C multiplexer using gpio api
Date: Tue, 20 Jul 2010 13:29:13 +0200
Message-ID: <87y6d6ie7q.fsf@macbook.be.48ers.dk>
References: <1278285584-13632-1-git-send-email-peter.korsgaard@barco.com>
	<87fwzejz1v.fsf@macbook.be.48ers.dk>
	<20100720115005.3b3fa865@hyperion.delvare>
	<87bpa2jwzy.fsf@macbook.be.48ers.dk> <4C4583F3.8080807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C4583F3.8080807-Mmb7MZpHnFY@public.gmane.org> (Michael Lawnick's message of "Tue, 20
	Jul 2010 13:09:39 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Michael" == Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> writes:

 >> But this patch is independent from that work as the mux access isn't
 >> through I2C, hence no changes to i2c-core needed.

 Michael> i2c-mux patch does not expect path control via i2c.
 Michael> Your scenario fits perfectly.

Hmm, I'll take a closer look at the last version then - sorry. In the
past it afaik did. What is the point of the i2c-core changes if path
control isn't via i2c?

-- 
Bye, Peter Korsgaard
