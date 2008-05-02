From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: driver support for smbus mux
Date: Fri, 2 May 2008 09:47:46 +0200
Message-ID: <20080502094746.57f9a445@hyperion.delvare>
References: <d4d59c9a0804291600s744e27bfta8144d376824ea58@mail.gmail.com>
	<Pine.LNX.4.58.0804301428150.9894@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0804301428150.9894-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Darren Zhang <darrentw-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Darren, hi Trent,

On Wed, 30 Apr 2008 14:38:52 -0700 (PDT), Trent Piepho wrote:
> On Tue, 29 Apr 2008, Darren Zhang wrote:
> > In my system the I2C bus is multiplexed into 4 segments using an analog
> > multiplexer.

Is it by any chance a Tyan motherboard?

> > When I use i2cdetect, only devices before the i2c mux can be detected.
> > I wonder if this kind of hardware configuration is supported in the latest
> > 2.6 kernal
> > s.t. I can use i2ctools (i2cdetect/i2cdump/i2cset) to access devices behind
> > the i2c mux?
> > Any suggestion appreciated.
> 
> Lot of DVB cards have the same issue, with stuff behind a i2c gateway to
> shield it from the noise of i2c traffic for other chips.

Gates and muxes are different. Of course you can think of a gate as a
one-segment mux, but at least it is relatively easy to use handle gates with
the current i2c core code (as the DVB subsystem does) while handling
muxes is more difficult and ugly, because you have to take into account
the case where multiple segments have chips sharing an I2C address
(which is the reason #1 for using a mux in the first place.)

> 
> You could always program the MUX (with i2c-dev or write a driver), scan
> the bus, change the mux, scan again, etc.

Just for scanning, it works, but you can't register multiple i2c
clients at the same address, so you are quickly stuck.

> 
> I've thought that it might be useful in some cases to create a "virtual"
> i2c bus for what's behind the i2c gate or on each branch of the mux.
> 
> What you do is write a driver for the mux chip that registers four new i2c
> busses.  This driver's i2c transfer function just sets the mux to the
> proper channel (if it's not already there) and then passes on it's
> arguments to the i2c transfer of the bus the mux is on.
> 
> You'd need to make sure the mux driver has a common mutex for all four
> virtual busses, as I think the i2c layer mutex is per bus and wouldn't stop
> simultaneous transactions on multiple virtual busses at once.

We clearly need better infrastructure in i2c-core to handle these
cases. This is one of the next big things I want to work on. I've
always delayed it so far because we lacked explicit I2C device
registration, and a GPIO subsystem. Now that we have both, it'll be
finally worth looking at. The only remaining problem is that I still
don't have a motherboard with such a multiplexed SMBus, so I won't be
able to test my (or someone else's) patches.

For now, the only SMBus mux we support is the one on the Tyan S4882
(with a dedicated driver i2c-amd756-s4882), but it's everything but
nice. I also have a similar driver for the Tyan S4985 which I wrote a
few days ago but isn't upstream yet.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
