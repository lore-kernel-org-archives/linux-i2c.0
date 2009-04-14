From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Q: Where to initialize class attribute of adapter
Date: Tue, 14 Apr 2009 11:30:42 +0200
Message-ID: <49E457C2.1010706@gmx.de>
References: <49E43E3E.1020200@gmx.de> <20090414102820.07b930b3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090414102820.07b930b3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> Hallo Michael,
> 
> On Tue, 14 Apr 2009 09:41:50 +0200, Michael Lawnick wrote:
>> on update to kernel to 2.6.29 I've run into the issue that I2C
>> adapter's class attribute in struct i2c_adapter wasn't set and so
>> no client driver could be loaded. Currently I initialize .class in
>> the struct declaration part, but this is main code for all boards
>> that use this adapter :-( I'm now searching for a place where to do
>> it in a board specific way like device tree. Any suggestions?
> 
> Which architecture is this, which bus driver?

We are based on PowerPC MPC8548, adapter code is i2c-mpc.c
We use the adapter compiled-in.

> I think I would pass the class value as platform data to the i2c bus
> driver, and in this driver copy the value from platform data to
> struct i2c_adapter.
> 

Hmm, I'm not sure whether I really understand you.
You propose modification of C-code that is part of board unspecific
source tree, correct?
IMHO, as this is a board specific parameter, there should be a way to do
it in something like a config file. Probably in Kconfig (if this is
possible at all) or device tree or ...? An alternative could be a
writable sysFs-entry for dynamic reconfiguration.

For more understanding of my view:
I get a preconfigured/patched kernel tree from another co-worker in our
project. I don't know what he has done in detail to the original source
code. I just verified that there is no modification below drivers/i2c.
So if there is a board specific initialization file I've overseen, just
tell me, perhaps this is the solution.

BTW: Why has I2C_CLASS_ALL been dropped?
-- 
Kind Regards,
Michael
