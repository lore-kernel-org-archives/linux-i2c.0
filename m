From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Driver for pca9541 bus master selector
Date: Tue, 28 Sep 2010 07:33:02 -0700
Message-ID: <20100928143302.GA7593@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

I am in the process of writing a driver for the pca9541 bus master selector. 
I using the i2c multiplexer framework, which fits the requirements quite nicely.

If anyone happens to know about an existing driver for this chip, please let me know.
I would love to get some input for the arbitration mechanism needed to determine
if and when to switch bus ownership from one master to the other.

Thanks,
Guenter
