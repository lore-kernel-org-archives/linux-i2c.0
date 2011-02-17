From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: How to deal with pending signals in an i2c bus driver in a correct manner?
Date: Thu, 17 Feb 2011 17:44:35 +0100
Message-ID: <201102171744.35972.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

some i2c bus drivers are checking if a signal is pending and aborting a 
current i2c transfer. This seems reasonable to go back to userland as fast as 
possible.
But yesterday I tried to run a simple 'cat' command on a device node which 
does its transfers via an i2c bus. When the command receives a SIGINT, 
someone (kernel? glibc?) closes the open file descriptor. This calls the 
device's close routine, but as this point of time the signal is still pending 
and no further i2c communication is possible ... the driver fails to shutdown 
the i2c device.
What is the correct or expected behaviour of an i2c bus driver when a signal 
is pending?

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
