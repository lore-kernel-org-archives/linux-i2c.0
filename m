From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH 1/5] [ARM] pxa: lx: add PCON i2c driver
Date: Sun, 19 Apr 2009 12:11:14 +0100
Message-ID: <20090419111114.GA8569@sirena.org.uk>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <1240064452-14691-1-git-send-email-linux@arm.linux.org.uk> <20090418162900.0dc16531@hyperion.delvare> <20090418144234.GB1236@n2100.arm.linux.org.uk> <20090418173406.GA16195@sirena.org.uk> <20090418181030.GC1236@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090418181030.GC1236-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Apr 18, 2009 at 07:10:30PM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 18, 2009 at 06:34:06PM +0100, Mark Brown wrote:

> > > Maybe you can suggest a better place for it?

> > drivers/mfd?

> It's not a multifunction device.  It's a microcontroller.

Surely that's just an implementation detail?  As I understand your
description the microcontroller is hiding the control interfaces of the
other things it controls so the function is pretty similar.
