From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
Date: Tue, 25 Nov 2014 15:32:17 +1100
Message-ID: <1416889937.4998.54.camel@kernel.crashing.org>
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
	 <546DF910.4060802@linux.vnet.ibm.com> <20141124121803.GH3733@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141124121803.GH3733@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-11-24 at 13:18 +0100, Wolfram Sang wrote:
> 
> I think there are now 3 drivers in my queue which are not fully I2C
> compatible but more supporting the very minimum to, say, read an
> eeprom.
> I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
> think about ways how to communicate deficiencies like "only 255 byte"
> or
> "only WRRD messages" to users of that I2C controller. This is most
> likely not happening before 3.19. But assistance is very welcome.

There are drivers doing that already, this is afaik common practice.

Please don't gate the merging process to some hypothetical rework that
will imply reworking also a number of user space tools and in-kernel i2c
device drivers. Basically that would mean "your platform won't be
supported upstream for the next year and btw, rewrite all userspace".

By all means let's create new "smbus" APIs for >1 bytes offset but let's
not make it a gate to merging drivers using the existing way of doing
things that has been so far perfectly functional.

Cheers,
Ben.
