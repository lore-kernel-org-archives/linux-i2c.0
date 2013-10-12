From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Sat, 12 Oct 2013 15:45:15 +0200
Message-ID: <2878883.SYGmCkS5Bt@vostro.rjw.lan>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com> <2393462.4JRAMNeigd@vostro.rjw.lan> <20131012050413.GY3521@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131012050413.GY3521-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday, October 12, 2013 08:04:13 AM Mika Westerberg wrote:
> On Sat, Oct 12, 2013 at 12:16:02AM +0200, Rafael J. Wysocki wrote:
> > > I think that this is intentional. We don't want that the i2c modalias
> > > matches with the ACPI device (like with the i2c:INTABCD). Instead use ACPI
> > > IDs that are added to the driver to match with the ACPI device.
> > 
> > Well, I'm not really sure this was intentional, but I wonder how other bus
> > types work in that respect?
> 
> We have the same for platform bus, if that's what you are asking.
> 
> It probably doesn't hurt to have this patch applied but it might cause
> inadvertent match if for some reason there is an I2C client driver that
> happens to have INTABCD I2C id in its list.

Well, if they have that id in their lists, they are supposed to be able to
handle this device, aren't they?  What other reason may be there for them
to put that id into their lists?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
