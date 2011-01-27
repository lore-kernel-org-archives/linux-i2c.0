From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c-core: Add trace events for
 i2c_master_send()/i2c_master_recv()
Date: Thu, 27 Jan 2011 13:33:21 +0100
Message-ID: <20110127133321.589ff095@endymion.delvare>
References: <1296126066-15951-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1296126066-15951-1-git-send-email-dp-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dimitris Papastamos <dp-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 27 Jan 2011 11:01:06 +0000, Dimitris Papastamos wrote:
> Add basic trace events for i2c_master_send() and i2c_master_recv() so we
> can observe the I2C activity without filling up the dmesg ring buffer.  It
> also makes it easy to enable and disable tracing of the i2c-core.

This doesn't make sense. If you want to trace something, trace
i2c_transfer(). i2c_master_send() and i2c_master_recv() are only helpers
for the most simple cases, so tracing only them is pointless.

Note that even with this, you'll miss calls to i2c_smbus_xfer(), which
is the other access point to I2C/SMBus controllers. So I guess you want
to trace it as well.

-- 
Jean Delvare
