From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: driver support for smbus mux
Date: Wed, 30 Apr 2008 14:38:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0804301428150.9894@shell4.speakeasy.net>
References: <d4d59c9a0804291600s744e27bfta8144d376824ea58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <d4d59c9a0804291600s744e27bfta8144d376824ea58-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Darren Zhang <darrentw-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 29 Apr 2008, Darren Zhang wrote:
> In my system the I2C bus is multiplexed into 4 segments using an analog
> multiplexer.
> When I use i2cdetect, only devices before the i2c mux can be detected.
> I wonder if this kind of hardware configuration is supported in the latest
> 2.6 kernal
> s.t. I can use i2ctools (i2cdetect/i2cdump/i2cset) to access devices behind
> the i2c mux?
> Any suggestion appreciated.

Lot of DVB cards have the same issue, with stuff behind a i2c gateway to
shield it from the noise of i2c traffic for other chips.

You could always program the MUX (with i2c-dev or write a driver), scan
the bus, change the mux, scan again, etc.

I've thought that it might be useful in some cases to create a "virtual"
i2c bus for what's behind the i2c gate or on each branch of the mux.

What you do is write a driver for the mux chip that registers four new i2c
busses.  This driver's i2c transfer function just sets the mux to the
proper channel (if it's not already there) and then passes on it's
arguments to the i2c transfer of the bus the mux is on.

You'd need to make sure the mux driver has a common mutex for all four
virtual busses, as I think the i2c layer mutex is per bus and wouldn't stop
simultaneous transactions on multiple virtual busses at once.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
