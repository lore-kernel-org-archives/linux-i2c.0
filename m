From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Fri, 24 Apr 2009 11:35:27 +0200
Message-ID: <20090424113527.4fb94f38@hyperion.delvare>
References: <49ED6AD3.2060808@gmx.de>
	<49ED6F03.5050107@grandegger.com>
	<49ED9132.9050806@gmx.de>
	<20090421095112.GB3100@pengutronix.de>
	<49EDC487.8010201@gmx.de>
	<20090424085256.GA26169@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090424085256.GA26169-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, 24 Apr 2009 10:52:56 +0200, Wolfram Sang wrote:
> > And how do you want to implement setting the class attribute?
> 
> Not at all. I see ".class" as a reminiscent to overcome some flaws of
> the old binding model.

Not really. The old binding model didn't have this concept of class
originally, it was added later but never enforced and only sparsely
used.

Nowadays classes are an extension of the new binding model, used to
restrict the field of application of .detect() callbacks (because we
definitely do not want probing to be enabled by default.)

> If we finally got rid of that we can surely think
> of a more elegant way to enforce instanciation of clients run-time. And
> with that, probably get rid of .class altogether. D'accord, Jean?

In an ideal world, yes. In the real world, no. There are several
thousand PC mainboards out there with devices on the SMBus and we don't
have a list, and in most cases no way to ask the system about them.
Probing is the only realistic way there, so at least I2C_CLASS_HWMON,
I2C_CLASS_DDC and I2C_CLASS_SPD are there to stay. We should be able to
get rid of I2C_CLASS_TV_ANALOG and I2C_CLASS_TV_DIGITAL though.

While classes will stay for PC mainboards, it should be possible (and
desirable) to stop using them completely on embedded systems.

-- 
Jean Delvare
