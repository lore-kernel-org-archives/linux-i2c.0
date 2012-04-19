From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v4] i2c: Add device tree support to i2c-pnx.c
Date: Thu, 19 Apr 2012 18:32:12 +0200
Message-ID: <4F903E0C.6010604@antcom.de>
References: <1334850612-24151-1-git-send-email-stigge@antcom.de> <20120419160715.GD24987@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120419160715.GD24987-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 04/19/2012 06:07 PM, Wolfram Sang wrote:
>> + - clock-frequency: desired I2C bus clock frequency in Hz,
>> Default: 100000 Hz + - pnx,timeout: I2C bus timeout in
>> milliseconds, Default: 10 ms
> 
> I'd like to repeat my question to the devicetree folks here: Can we
> have timeout generic? It doesn't make sense to me to have that per
> vendor again and again.

Sounds completely reasonable.

To help make the devicetree conversion into 3.5, I would prefer to
integrate the "vendor,timeout" as-is if a longish standardization
process would block this, considering that we luckily only have 2-3 of
such timeout definitions currently.

I'd volunteer to clean up later by preparing a patch when there is a
standard timeout defined.

If we have a solution soon, I will prepare a new version of the patch,
of course, in the next days.

>> +	i2c2: i2c@400a8000 { +		compatible = "nxp,pnx-i2c"; +		reg =
>> <0x400a8000 0x100>; +		interrupt-parent = <&mic>; +		interrupts =
>> <50 0>; +		#address-cells = <1>; +		#size-cells = <0>; +
>> clock-frequency = <0x186a0>; +		pnx,timeout = <0x64>;
> 
> Did you change this, too? Timeouts are better readable in dec :)

Right. But even when removing the "0x" in the timeout line above, it's
still hex, see Documentation/devicetree/booting-without-of.txt

Or did I get sth. wrong?

Thanks,

Roland
