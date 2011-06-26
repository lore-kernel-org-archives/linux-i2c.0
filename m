From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: multiple byte read/write to I2C device
Date: Sun, 26 Jun 2011 22:47:07 +0200
Message-ID: <20110626224707.14c447a3@endymion.delvare>
References: <BANLkTi=VObOHgC3HsXuOF2rRVzNwbvGHsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTi=VObOHgC3HsXuOF2rRVzNwbvGHsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xianghua Xiao <xiaoxianghua-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 24 Jun 2011 16:34:15 -0500, Xianghua Xiao wrote:
> It appears i2cget/i2cset can only handle up to 2 bytes at once, I have
> an I2C device that needs to send 4 bytes R/W, can i2cget/i2cset do
> that?

The SVN version of i2cset has support for block writes. This was
contributed by Guenter Roeck in:
http://www.lm-sensors.org/changeset/5911/i2c-tools/trunk/tools

i2cget indeed still lacks support for block reads, but that shouldn't
be too hard to implement, now that the way got paved by i2cset. In the
meantime you may be able to abuse i2cdump's "i" mode and grep the
output, but performance will suffer.

-- 
Jean Delvare
