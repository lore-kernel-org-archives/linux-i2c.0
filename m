From: Nuno Silva <nuno.silva-uOixanVlb7U@public.gmane.org>
Subject: PCA9665: Triggering i2c bus reset
Date: Thu, 8 Aug 2013 16:53:23 +0300
Message-ID: <20130808135323.GB2653@shadowfax>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I have been dealing with a PCA9665 controller for i2c. During
interactions with some hardware, it is common for the bus to get into a
unusable state (in this case, SCL is pulled low by a slave). But, even
after disconnecting all the slaves, I am not able to get the bus workin=
g
again.

Reading the algo code, I see there are reset features for both chips
supported by the driver, so I wonder if there is some way or tool to
trigger this reset on request (that is, after I have disconnected all
the slaves).

--=20
Nuno Silva (aka njsg)
Radiotieteen ja -tekniikan laitos
Aalto-yliopiston s=E4hk=F6tekniikan korkeakoulu
