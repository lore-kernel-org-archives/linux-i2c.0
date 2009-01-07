From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] rtc-ds1307: True SMBus compatibility
Date: Wed, 7 Jan 2009 14:24:26 +0100
Message-ID: <20090107142426.4be04d4d@hyperion.delvare>
References: <1231177261.13443.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1231177261.13443.20.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ed Swierk <eswierk-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ed,

On Mon, 05 Jan 2009 09:41:01 -0800, Ed Swierk wrote:
> [Resent to correct linux-i2c address]
> 
> Following up to Sebastien Barre's recent patch, here I go one step
> further, replacing i2c block transfers with SMBus byte transfers.

Please, no. Adding a compatibility quirk may be acceptable, but forcing
everyone to use it instead of the more efficient original code is not
fair.

> Sticking to pure SMBus makes the driver work on our board, which has an
> nVidia SMBus controller driving a DS1339; nforce2 controllers
> unfortunately don't support any flavor of i2c block transfer.

Are you certain the nForce2 controllers can't do it? The i2c-nforce2
driver doesn't implement it, but this doesn't mean the hardware can't
do it. I don't have any datasheet for these chips, but I know their
SMBus implementation is very similar to those of the AMD 8111, and
i2c-amd8111 has support for I2C block reads and writes. I think it
would be worth giving it a try, by copying the i2c-amd8111
implementation into the i2c-nforce2 driver and seeing if it happens to
just work. If it works, that would be more elegant than your proposed
hack to the rtc-ds1307 driver.

> Reading or writing registers repeatedly until they stick is rather
> nauseating but I'm aiming for correctness if not elegance.  I would
> appreciate any suggestions for improvement.

See above.

-- 
Jean Delvare
