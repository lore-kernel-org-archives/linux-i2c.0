From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c-powermac: Simplify pmac_i2c_adapter_to_bus
Date: Thu, 05 Nov 2009 20:29:23 +1100
Message-ID: <1257413363.13611.112.camel@pasglop>
References: <20091014165743.279789a4@hyperion.delvare>
	 <1257382888.13611.81.camel@pasglop>
	 <20091105101627.0a086c04@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091105101627.0a086c04-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2009-11-05 at 10:16 +0100, Jean Delvare wrote:
> 
> i2c-powermac-01-multiple-msg-not-supported.patch
> i2c-powermac-02-refactor-xfer.patch
> i2c-powermac-03-report-errors.patch
> i2c-powermac-04-include-adapter-in-bus.patch
> i2c-powermac-05-simplify-pmac_i2c_adapter_to_bus.patch
> i2c-powermac-06-no-temp-buffer-for-name.patch
> 
> I only have a formal ack from you for patch 01. Patches 01, 02 and 03
> have been in linux-next for about a month now. I will delete patch 05
> now. This leaves us with 4 patches still waiting for your ack (02, 03,
> 04 and 06.) I'm not sure which ones you tested so far?

I tested 4,5 and 6 though 5 will be dropped. 1 is acked. I think 2 and 3
slipped through the cracks. Where do I find your patch queue ? I'll test
tomorrow.

Cheers,
Ben.
