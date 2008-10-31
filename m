From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
 filter.
Date: Fri, 31 Oct 2008 12:43:10 +0100
Message-ID: <490AEF4E.2020105@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[resent to correct i2c list]

Hi Mike,

> This patch adds the ability to enable the digital filter in the device
> tree (with the "clock-filter" boolean property) and automates the
> predivider selection according to the clock-frequency and clock-filter
> properties.

looks good.

David, is "clock-filter" an appropriate dts property for this purpose or
would you prefer a different name?

What needs to be done though is to document this change in
Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt.

Thanks,
Jochen
