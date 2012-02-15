From: Mind Spawn <mndspwn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: serial port over i2c
Date: Wed, 15 Feb 2012 01:02:18 -0600
Message-ID: <CAAzok3rXyjF9i7SgtTYurUcbqN6p2Ed6qxZm_SD9JdoufLbDMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

For an embedded project, I have 10-15 ARM based Linux systems (slaves)
connected to a another ARM based Linux system (master) via the i2c
bus.

I would like to be able to create a serial console from the master to
each of the slaves using only the i2c bus. Is there a way to do this
with the existing i2c code in the kernel i.e. any way to create a
virtual serial port that runs over the i2c bus? If such a method
exists, does it support any sort of software flow control?

If no such method exists, is there any reason why such an
implementation is not feasible?
