From: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Subject: How to probe for pca954x multiplexers on a i2c-ocores bus?
Date: Fri, 14 Nov 2014 14:34:02 -0800
Message-ID: <CAB0SmAEOFJn2aTVm3nA9ttOME24FNWrwPDczQh+bLJipZAFedQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

We're in the process of developing a new hardware platform. It's built
around a COM-Express motherboard.  There will be four hot-pluggable
PCIe cards.  The pluggable cards have an FPGA that provides PCIe
connectivity with the motherboard.  We're planning to use the
OpenCores I2C controller combined with the i2c-ocores kernel driver
(Documentation/i2c/busses/i2c-ocores) to provide one or more i2c buses
out of the FPGA as shown in the crude diagram below.

There will be several variations of the pluggable cards. At this time
we don't know exactly how different these cards will be, but suffice
to say that some cards will have PCA954x i2c multiplexers hanging off
the i2c-ocores bus, and others may not have PCA954x muxes at all. It
would be nice if the PCA954x i2c mux buses could get enumerated
automatically by probing.  I'm not sure how to make this work however.

I read the i2c documentation, "instantiating-devices" and
"writing-clients", but it is still not clear to me how to do this.  In
"instantiating-devices", "Method 3: Probe an I2C bus for certain
devices" seems to be the way to go, but I'm still not sure how the
pca954x driver will get instantiated for each of the PCA954x
multiplexers.

Is what I'm describing possible?  Is there any code I can look at to
get an idea of how to do this?

+-----------------+
+------------------------------------------------------------------+
|                 |          | Pluggable
                         |
|                 |          |                   +---------+
                         |
|                 |          |                   |         |
+--------+                       |
|                 |          |  +------+         |         +---+
Device |   +---------+         |
|                 |          |  |      |         |         |
+--------+   |         +---- ... |
|                 |          |  |      +---I2C---+ pca954x |
     |         |         |
|                 |          |  |      |         |
+----------------+ pca954x +---- ... |
|                 |          |  |      |         |         |
+--------+   |         |         |
|                 |          |  |      |         |         +---+
Device |   |         +---- ... |
| Motherboard     +---PCIe---+--+ FPGA |         +---------+
+--------+   +---------+         |
|                 |          |  |      |
                         |
|                 |          |  |      |
+--------+                       |
|                 |          |  |      +---I2C---------+-------+
Device |                       |
|                 |          |  |      |               |
+--------+                       |
|                 |          |  +------+               |
+--------+                       |
|                 |          |                         +-------+
Device |                       |
|                 |          |
+--------+                       |
+-----------------+
+------------------------------------------------------------------+

Thanks,
Martin Belanger
