From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] at24: Fall back to byte or word reads if needed
Date: Mon, 8 Mar 2010 14:12:42 +0000
Message-ID: <20100308141241.GB15071@fluff.org.uk>
References: <20100308085008.366915c3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100308085008.366915c3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 08, 2010 at 08:50:08AM +0100, Jean Delvare wrote:
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Subject: at24: Fall back to byte or word reads if needed
> 
> Increase the portability of the at24 driver by letting it read from
> EEPROM chips connected to cheap SMBus controllers that support neither
> raw I2C messages nor even I2C block reads. All SMBus controllers
> should support either word reads or byte reads, so read support
> becomes universal, much like with the legacy "eeprom" driver.
> 
> Obviously, this only works with EEPROM chips up to AT24C16, that use
> 8-bit offset addressing. 16-bit offset addressing is almost impossible
> to support on SMBus controllers.
> 
> I did not add universal support for writes, as I had no immediate need
> for this, but it could be added later if needed (with the same
> performance issue as byte and word reads have, of course.)

It would be worth sorting out which i2c busses are exporting the
correct functionality, I think for example the i2c-s3c2410.c driver
is missing the I2C block functionality.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
