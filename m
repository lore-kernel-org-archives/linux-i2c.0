From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: pnx: Fix bit definitions
Date: Mon, 20 Aug 2012 18:47:58 +0200
Message-ID: <50326A3E.9070607@antcom.de>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de> <20120818095108.GB24812@pengutronix.de> <5030A81E.5090508@antcom.de> <083DF309106F364B939360100EC290F823A0354A3D@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <083DF309106F364B939360100EC290F823A0354A3D-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Bakki <srinivas.bakki-3arQi8VN3Tc@public.gmane.org>, "aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 08/20/2012 06:26 PM, Kevin Wells wrote:
>>>> This patch for i2c-pnx affects PNX4008 and LPC32xx (and LPC31xx,
>>>> not yet in mainline). Can you please test and double-check the
>>>> manuals of PNX4008 and LPC31xx? I only found this via the manual
>>>> of LPC32xx but assume it's the same for the others, also.
>>>>
>>>> Thanks in advance!
>>>
>>> Kevin, since the other manuals seem to be not easily available, can
>>> you please check?
>>
>> Yes, would be great if someone at NXP could confirm that PNX actually
>> uses the same IP core for the I2C controller as LPCs do (which is
>> currently assumed by Linux anyway).
> 
> I've never had my hands on a PNX4008 chip at NXP, but I do believe they
> are the same IP. That specific I2C IP was used in a number of NXP/Phillips
> chips besides the PNX4008/LPC32xx. I don't think there are any PNX4008's in
> the wild, and even working in NXP, I can't find any non-marketing reference
> material for that part (including the user manual).

Considering this, it might be a good idea to remove support for PNX4008
(arch/arm/mach-pnx4008/) altogether. It's hard to maintain support for
hardware which isn't available, even at NXP. It would also simplify
maintenance of mach-lpc32xx because the overlap currently makes me
always wonder if the respective changes still work with mach-pnx4008.

Any opposition?

Roland


PS: I just wonder how mach-pnx4008 came into the kernel at all...
