From: "Chuck Kamas" <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Subject: RE: How to manually call i2c_client's probe from i2c-dev.c ioctl
Date: Thu, 17 Sep 2009 09:38:13 -0700
Message-ID: <C62896630644CE43BF64B0FF0AC27F0E181607@mail.ad.skymv.com>
References: <C62896630644CE43BF64B0FF0AC27F0E18153F@mail.ad.skymv.com><20090916225247.2094619b@hyperion.delvare><C62896630644CE43BF64B0FF0AC27F0E1815B9@mail.ad.skymv.com><20090917092612.53327f80@hyperion.delvare><C62896630644CE43BF64B0FF0AC27F0E1815EC@mail.ad.skymv.com> <20090917180407.5460bf33@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20090917180407.5460bf33-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean,

I am trying to have the chip drivers probe for new chips after init.  I
would like to do this by adding to the ioctl a PROBE function. So in the
old model how do I manually call the probe function of a chip driver and
have it properly register with the i2c subsystem?

Chuck
 
