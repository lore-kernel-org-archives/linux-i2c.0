From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: Cleanly intercepting suspend/resume of specific i2c clients?
Date: Thu, 15 Dec 2011 08:30:05 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE922AB@HQMAIL01.nvidia.com>
References: <CADkCAuteSObrXMnmN--8AG84-V_aWWudt_EXwBNPZfG6GHG2hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADkCAuteSObrXMnmN--8AG84-V_aWWudt_EXwBNPZfG6GHG2hA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Linus Walleij (linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org)" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Bill Gatliff wrote at Wednesday, December 14, 2011 10:36 PM:
> I need to catch the suspend and resume events sent to specific i2c
> clients, so that I can do platform-specific reconfigurations after the
> target client has been suspended/before the target client is resumed.
> These reconfigurations include GPIO tweaks that I don't want to appear
> in the driver for the i2c client, due to their being highly
> platform-specific.

This sounds like something the new pinctrl subsystem will eventually grow
to address.

The basic idea is that drivers will be able to request the pinctrl system
place their pins into a certain configuration when they desire. This could
be at probe, but also suspend/resume, runtime PM, etc. The definition of
what the suspend/resume states mean is provided to the pinctrl subsystem
by board-specific code or device tree; the driver using this scheme need
not be aware of the details of each state, just request them.

That said, this aspect of pinctrl isn't something that's fleshed out yet
(I think I saw LinusW post a patch to start discussions of multiple
configurations yesterday), and there's still debate over how/whether to
integrate this "pin configuration" aspect into the existing "pin
multiplexing" tables.

Still, pinctrl is worth looking at, and it sounds like you can provide
a lot of real-world examples that'd help while defining this aspect.

-- 
nvpublic
