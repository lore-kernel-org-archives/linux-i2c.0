From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-stub: Add support for banked register ranges
Date: Thu, 10 Jul 2014 11:40:36 -0700
Message-ID: <20140710184036.GA6950@roeck-us.net>
References: <20140710124511.05108894@endymion.delvare>
 <20140710125659.015f1517@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140710125659.015f1517-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 10, 2014 at 12:56:59PM +0200, Jean Delvare wrote:
> Some chips implement banked register ranges. This allows implementing
> more registers than the limited 8-bit address space originally allows.
> In order to access a register on these chips, you must first select
> the proper bank. Add support for this mechanism to the i2c-stub driver
> so that such chips can be emulated. All the bank settings are passed
> as module parameters.
> 
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
> Tested successfully with:
> http://jdelvare.nerim.net/devel/lm-sensors/dumps/w83793-for-stub.dump
> 
Also with NCT7802Y.

Tested-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Would it make sense to use devm_ functions for memory allocations ?
That would simplify cleanup.

Thanks,
Guenter
