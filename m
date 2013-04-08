From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c: mux: Add i2c-arbitrator-cros-ec 'mux' driver
Date: Mon, 8 Apr 2013 11:55:25 +0200
Message-ID: <20130408095525.GB3496@the-dreams.de>
References: <1360957573-864-1-git-send-email-dianders@chromium.org>
 <1363192583-26363-1-git-send-email-dianders@chromium.org>
 <CAD=FV=UW4wGFqsg2B3MmC24jhnba5PSvCh8Wck-V6iuYk+Xifw@mail.gmail.com>
 <20130329115821.GC6359@the-dreams.de>
 <515F2E28.2090105@wwwdotorg.org>
 <20130406182957.GA11630@roeck-us.net>
 <20130406201132.GA3936@the-dreams.de>
 <20130407181028.GA28029@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130407181028.GA28029-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Guenter,

> I think there is a difference between a bad driver or underlying hardware. To
> me, "shipped" applies to hardware or firmware which can not be upgraded, not to
> the software running on it.

OK. Valuable distinction.

> "board support hosted in the I2C directory". But that is exactly what I am
> talking about, isn't it ? I have board specific multiplexers and a board
> specific I2C controller, and that is just talking about the I2C code.

Yes and no. I think I can accept that some hardware has GPIOs wired to
handle I2C arbitration. I still have problems in having arbitrator
drivers per board, each one with various ideas how to do it. That would
be a maintenance horror and has nothing to do with I2C, strictly
speaking. What I would love to see is a few generic arbitrator drivers,
e.g. utilizing a timeout-based scheme (as proposed here). Or like the
old SCSI method putting IDs on the wire and the lowest wins. Stuff like
that.

> A better example might be Kontron board support. They implement gpio, I2C mux,
> and a watchdog in a PLD. They too have an access arbitration scheme where
> one has to acquire a hardware mutex before accessing the pld, if I understand
> correctly because some microcontroller might need to access it as well.
> Leaving the actual code aside, would you reject that too if you don't like
> the arbitration scheme, or because you don't want to have board support
> in the i2c directory ?

If I understood correctly, getting the mutex would be done in some
platform code and the I2C driver will simply call the necessary function
to obtain and release the mutex. Or maybe the MFD layer can help, dunno.
Both are fine with me and I don't care about the actual PLD arbitration.

Thanks,

   Wolfram
