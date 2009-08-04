From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data vs scheduled routine calls
 (add_timer) - kernel crash
Date: Tue, 4 Aug 2009 21:35:56 +0100
Message-ID: <20090804203556.GI4342@sirena.org.uk>
References: <4A788121.8020601@seti.kr.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A788121.8020601-z9XQkeP78BxUq1AO9QMCaQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NiTr0 <nitr0-z9XQkeP78BxUq1AO9QMCaQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 04, 2009 at 09:42:41PM +0300, NiTr0 wrote:

> All variables are declared as static, all data is prepared correctly
> - so IMHO trouble is outside of my driver.
> There is a part of code:

The problem is that your driver is trying to do I2C/SMBus I/O from a
timer, which is run from an interrupt context.  Since I2C buses are
generally very slow the controllers are interrupt driven and the read
and write operations on them will sleep waiting for operations to
complete.  If the code waited for the I/O to complete in an interrupt
context it would cause serious performance problems in the rest of the
system.

You should do the actual I/O from another context, such as a workqueue.
schedule_delayed_work() may be helpful here.
