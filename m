From: "Brian Tompson" <brian.tompson-4c4C/Gi1/tVWk0Htik3J/w@public.gmane.org>
Subject: Looking for help writing an i2c client for i2c-core
Date: Mon, 22 Jun 2009 21:02:40 -0700
Message-ID: <7BD054A954B148E7B69442B1AC498484@footfall>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

In my i2c searches I stumbled upon this list.=A0 I hope this message is
appropriate here.

I am trying to write an i2c client driver for the i2c core, using the L=
inux
Driver Model (new style driver).
I am looking for a list of steps I need to take to accomplish this.

I have been looking for a list something like this:

Load this i2c-core structure with this information.
Call this i2c-core function to register your driver.
Call this i2c-core function to connect to the adapter or bus or algorit=
hm
(don=92t know which)
Write a probe function that does this.
Write a remove function that does this.
Call this i2c-core function to write raw i2c data (not SMBus) to your d=
evice
Call this i2c-core function to read raw i2c data from your device.
Call this i2c-core function to disconnect from the adapter or bus or
algorithm

Or whatever the actual steps should be.

I have started writing a driver and have used i2c_add_driver() to regis=
ter
my driver with i2c_core.
Now what?=A0 Probe, attach, send, remove, =85?=A0 Is there a resource a=
vailable
that simply lays out these facts?=A0 I think a resource like that would=
 be
very useful to someone trying to develop a client driver for the i2c-co=
re
using the Linux Driver Model.


Thank you for your time,
Brian Tompson
