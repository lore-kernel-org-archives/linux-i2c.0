From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Fri, 24 Apr 2009 12:49:08 +0200
Message-ID: <49F19924.8020506@gmx.de>
References: <49ED6AD3.2060808@gmx.de>	<49ED6F03.5050107@grandegger.com>	<49ED9132.9050806@gmx.de>	<20090421095112.GB3100@pengutronix.de>	<49EDC487.8010201@gmx.de>	<20090424085256.GA26169@pengutronix.de> <20090424113527.4fb94f38@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090424113527.4fb94f38-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> While classes will stay for PC mainboards, it should be possible (and
> desirable) to stop using them completely on embedded systems.
> 
This means no probing on embedded systems, doesn't it?
Do you really expect a customized kernel space code to do that? IMHO
there should be at least a way for triggering from user space.

-- 
Regards,
Michael
