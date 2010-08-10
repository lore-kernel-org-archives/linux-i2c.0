From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: exclusive access to I2C device
Date: Tue, 10 Aug 2010 13:03:07 +0200
Message-ID: <20100810130307.1249dc7e@hyperion.delvare>
References: <84d4a6d51003041006i1b619d2l942d21ce1a9a069e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <84d4a6d51003041006i1b619d2l942d21ce1a9a069e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pete.flugstad-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Pete,

Sorry for the late answer.

On Thu, 4 Mar 2010 12:06:23 -0600, Pete Flugstad wrote:
> Hi!  We're running Linux 2.6.27 with i2c tools 3.0.2.
> 
> We have a number of userspace program using the raw i2c_smbus interface

This is rather vague, I have no clue what it is that you name "the raw
i2c_smbus interface".

> to talk to a variety of devices. Right now, it seems like every program can open
> up the device and issue commands, which interferes with an already running
> command.

Define "interfere". The i2c core has proper locking to ensure that a
given I2C controller only processes one request at a time (in other
words, transactions are serialized.) So at the lower level, commands do
not interfere with each other. At higher levels, they may, but it
depends on what you're doing exactly.

> 
> I see the code in open_i2c_bus using:
> 
>     	sprintf(filename, "/dev/i2c/%d", i2cbus);
> 	file = open(filename, O_RDWR);
> 
> Would adding O_EXCL to this open help to make things exclusive?  Or is there a
> better way to do what I want.

I know for sure that i2c-dev doesn't handle O_EXCL. And even if it did
(or another part of the kernel does), this won't protect you against
in-kernel accesses to the same I2C bus controller. We would need
explicit handling of this case in the i2c-dev _and_ i2c-core modules to
handle this properly.

I am only mildly convinced that this would be a good thing to have,
BTW. Blocking all (other) traffic to an I2C controller from user-space
without any timeout seems very dangerous.

> Right now we're going to set up a daemon to arbitrate access to the I2C bus,
> but it would be nice if we had something simpler, since now all apps have to
> talk to the daemon.  I was thinking something along the lines of just telling
> userspace to loop opening the device exclusively until that succeeds, run the
> command,  then close the device.

You didn't give enough detail for me to comment on this.

-- 
Jean Delvare
