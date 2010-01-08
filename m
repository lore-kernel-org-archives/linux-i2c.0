From: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Subject: status of i2c-cpm and ds2482
Date: Fri, 8 Jan 2010 03:02:53 +0100
Message-ID: <20100108020253.GJ3388@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I have a 2.6.25.7 kernel working on my MPC885 board with i2c-cpm and
ds2482. I'm currently rebasing the board changes on a newer kernel. So
far I could get to 2.6.27.25 (with i2c-cpm and ds2482 from linux-2.6
git). Other parts of 2.6.27.25 work better with the board, so I'd like
to get the application (reportedly using the
/sys/devices/w1_bus_master1/* interface) working and have a couple of
questions.

What is the current state of i2c-cpm and ds2482 in 2.6 or 2.6.27 gits?
If I correctly understand the commit messages, those are maintained.
There are boot messages about both. Creating /dev/i2c-0 and reading from
it result in appropriate debug messages. However,
/sys/devices/w1_bus_master1 is not created; the path described in
http://marc.info/?l=linux-i2c&m=125365009130579&w=2 does not exist. What
is the fastest way to get the application running on 2.6.27.25?

Thanks in advance,
Baurzhan.
