From: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
Date: Tue, 02 Dec 2008 17:44:51 -0800
Message-ID: <4935E493.9050402@consentry.com>
References: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org> <49347317.5080600@consentry.com> <200812021207.06140.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200812021207.06140.laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Laurent,

> While the problem seems to be similar to CPM98, I don't understand how it 
> could happen on the first character of the first I2C transfer.

I agree, that is hard to explain given that i2c-cpm keeps the controller
shut off until the very moment of the first transfer.  Can you check that
the bus is really idle (SCL is high) when the timeout happens?  If one of
the slave devices is in a bad state and pulling SCL low, I think the
behavior you see is expected (CPM will wait forever for the bus to be
idle).  The same is probably true if a GPIO pin is mis-configured.

> As explained in my previous mail to Joakim, I spent some more time last Friday 
> investigating the problem, and it seems the baud rate generator configuration 
> plays an important role. The default configuration (60kHz nominal => 65.104kHz 
> using a 25MHz brg clock and a /32 predivider) leads to timeouts, while I 
> haven't been able to reproduce the problem with the i2c-mpc8260.c 
> configuration (100kHz nominal => 104.167kHz using a 25MHz brg clock and a /8 
> predivider).

It would be interesting to try each driver with the other's clock settings.

					-=] Mike [=-
