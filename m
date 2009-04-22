From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Wed, 22 Apr 2009 07:37:48 +0200
Message-ID: <49EEAD2C.7080303@gmx.de>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com>	 <49ED9132.9050806@gmx.de> <20090421115936.28656d09@hyperion.delvare>	 <49EDD423.3050302@gmx.de>	 <9e4733910904210900r4c5d1a8en178ad106134b7e6d@mail.gmail.com>	 <20090421183310.50ff7e0c@hyperion.delvare> <9e4733910904211218l8428128k1f8dd021c50c7846@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e4733910904211218l8428128k1f8dd021c50c7846-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Sang, Wolfram" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jon Smirl said the following:
> So a solution might lie down the path of having whatever catches the
> hotplug event (pci, usb, ..) run code that modifies the device tree
> and inserts the new i2c nodes. After the device tree has been modified
> trigger a rescan of devices so that the i2c drivers get loaded.  I've
> never tried doing that but it should be doable in theory.
> 
> Something has to trigger an interrupt (or the user types a command)
> indicating that new hardware has been added. The driver of that device
> can modify the device tree. The rescan of the device tree will cause
> the i2c modules to automatically load. This shouldn't require any
> changes to the current i2c sub-system.

This is an solution, although it feels a bit more complicated than
necessary. My original plan is to check the bus in intervals of some
seconds via /dev/i2c for a specific device. When the device is detected
its module is loaded and the driver/device initialized. A simple user
space script, running in background.

-- 
Regards,
Michael
