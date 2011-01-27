From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c-core: Add trace events for
	i2c_master_send()/i2c_master_recv()
Date: Thu, 27 Jan 2011 14:19:51 +0000
Message-ID: <20110127141951.GB11937@sirena.org.uk>
References: <1296126066-15951-1-git-send-email-dp@opensource.wolfsonmicro.com> <20110127133321.589ff095@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110127133321.589ff095-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Dimitris Papastamos <dp-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 27, 2011 at 01:33:21PM +0100, Jean Delvare wrote:
> On Thu, 27 Jan 2011 11:01:06 +0000, Dimitris Papastamos wrote:

> > Add basic trace events for i2c_master_send() and i2c_master_recv() so we
> > can observe the I2C activity without filling up the dmesg ring buffer.  It
> > also makes it easy to enable and disable tracing of the i2c-core.

> This doesn't make sense. If you want to trace something, trace
> i2c_transfer(). i2c_master_send() and i2c_master_recv() are only helpers
> for the most simple cases, so tracing only them is pointless.

> Note that even with this, you'll miss calls to i2c_smbus_xfer(), which
> is the other access point to I2C/SMBus controllers. So I guess you want
> to trace it as well.

Might also be interesting to do start/stop tracing - I2C is relatively
slow and causes scheduling.  Dunno if it's worth it, though you could
always turn on only one of the events if it was too boring to have both.
