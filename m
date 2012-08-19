From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: pnx: Fix bit definitions
Date: Sun, 19 Aug 2012 10:47:26 +0200
Message-ID: <5030A81E.5090508@antcom.de>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de> <20120818095108.GB24812@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120818095108.GB24812-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kevin.wells-3arQi8VN3Tc@public.gmane.org, vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org, aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 18/08/12 11:51, Wolfram Sang wrote:
> On Wed, Aug 08, 2012 at 09:42:31AM +0200, Roland Stigge wrote:
>> The I2C Control Register bits RFDAIE and RFFIE were mixed up. In
>> addition to this fix, this patch adds the missing bit DRSIE for
>> completeness.
>> 
>> Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
>> 
>> --- Applies to v3.6-rc1
>> 
>> This patch for i2c-pnx affects PNX4008 and LPC32xx (and LPC31xx,
>> not yet in mainline). Can you please test and double-check the
>> manuals of PNX4008 and LPC31xx? I only found this via the manual
>> of LPC32xx but assume it's the same for the others, also.
>> 
>> Thanks in advance!
> 
> Kevin, since the other manuals seem to be not easily available, can
> you please check?

Yes, would be great if someone at NXP could confirm that PNX actually
uses the same IP core for the I2C controller as LPCs do (which is
currently assumed by Linux anyway).

Thanks in advance,

Roland
