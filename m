From: Rory Filer <rfiler-usJ8hg9QsBLWpu6QEFMNjNBPR1lH4CV8@public.gmane.org>
Subject: RE: Newbie Question About Dev-Interface Method
Date: Fri, 8 Oct 2010 19:03:27 -0700
Message-ID: <8F90F944E50427428C60E12A34A309D2308DAD1B7F@carmd-exchmb01.sierrawireless.local>
References: <1286480883-25589-1-git-send-email-rklein@nvidia.com>
	<8F90F944E50427428C60E12A34A309D2308DA559B4@carmd-exchmb01.sierrawireless.local>
 <20101008085758.2f06dbad@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101008085758.2f06dbad-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > I'm assuming that a kernel space chip driver like our gpio expander
> (pca953x.c) also uses the same adapter driver as my user-space
> application since that expander chip is on the same bus.
> 
> Let's clarify right away: i2c-dev (which handles /dev/i2c-* nodes) is
> NOT an adapter driver. It is a bridge driver between user-space and
> your adapter driver. Your adapter driver is most likely one living in
> drivers/i2c/busses, and depends on the actual hardware you run on.

OK, thanks that's clear. I was confused by the terminology in the 
dev-interface document. When it said to open an adapter, I thought
that meant I was using the associated adapter driver.

> 
> Incorrect. The address isn't written to the adapter, it is a setting
> local to i2c-dev and even specific to the file handle you got when
> opening a /dev/i2c-* node. Each subsequent read, write or smbus call in
> your user-space driver automatically includes the slave address, which
> is only valid for the read, write or smbus call in question.

Excellent! - in the words of a famous Swiss restaurant's wine menu, this
leaves me nothing to hope for!

Jean, thank you for your help, it saved me a ton pouring over source 
code and allowed me to get on with the job at hand. Much appreciated.

Regards,

Rory
