From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
 filter.
Date: Thu, 06 Nov 2008 12:27:45 +0100
Message-ID: <4912D4B1.7020503@scram.de>
References: <49124EAD.8090508@consentry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49124EAD.8090508-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Mike Ditto schrieb:
> This patch adds the ability to enable the digital filter in the device
> tree (with the "clock-filter" boolean property) and automates the
> predivider selection according to the clock-frequency and clock-filter
> properties.  This allows use of a wider range of I2C bus frequencies.
> 
> Signed-off-by:  Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>

Acked-by: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
