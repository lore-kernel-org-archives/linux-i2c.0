From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: add generic I2C multiplexer using gpio api
Date: Tue, 20 Jul 2010 13:27:25 +0200
Message-ID: <8739vejsv6.fsf@macbook.be.48ers.dk>
References: <1278285584-13632-1-git-send-email-peter.korsgaard@barco.com>
	<87fwzejz1v.fsf@macbook.be.48ers.dk>
	<20100720115005.3b3fa865@hyperion.delvare>
	<87bpa2jwzy.fsf@macbook.be.48ers.dk>
	<20100720130417.5be0bb51@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100720130417.5be0bb51-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's
	message of "Tue, 20 Jul 2010 13:04:17 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

 Jean> The problem is exactly that your patch is independent. It _should_
 Jean> build on top of Michael's work, to avoid redundancy.

Why? We've discussed this for years, E.G.:

http://www.mail-archive.com/i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org/msg01539.html

None of the locking changes in core are needed when the MUX isn't
controlled through I2C. I guess I could use the i2c-mux.c functions, as
there's some overlap in the trivial gpiomux_xfer/gpiomux_func functions,
but that can easily be done once the mux stuff is merged.

-- 
Bye, Peter Korsgaard
