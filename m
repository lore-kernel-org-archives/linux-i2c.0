From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH RESEND 2/2] i2c: pnx: Fix read transactions of >= 2 bytes
Date: Sun, 19 Aug 2012 10:45:20 +0200
Message-ID: <5030A7A0.3080308@antcom.de>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de> <1344411752-23469-2-git-send-email-stigge@antcom.de> <20120818095212.GC24812@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120818095212.GC24812-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org, aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 18/08/12 11:52, Wolfram Sang wrote:
> On Wed, Aug 08, 2012 at 09:42:32AM +0200, Roland Stigge wrote:
>> On transactions with n>=2 bytes, the controller actually wrongly
>> clocks in n+1 bytes. This is caused by the (wrong) assumption
>> that RFE in the Status Register is 1 iff there is no byte already
>> ordered (via a dummy TX byte). This lead to the implementation of
>> synchronized byte ordering, e.g.:
>> 
>> Dummy-TX - RX - Dummy-TX - RX - ...
>> 
>> But since RFE actually stays high after some Dummy-TX, it rather
>> looks like:
>> 
>> Dummy-TX - Dummy-TX - RX - Dummy-TX - RX - (RX)
>> 
>> The last RX byte is clocked in by the bus controller, but ignored
>> by the kernel when filling the userspace buffer.
>> 
>> This patch fixes the issue by asking for RX via Dummy-TX
>> asynchronously. Introducing a separate counter for TX bytes.
>> 
>> Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
>> 
>> --- Applies to v3.6-rc1
>> 
>> This patch for i2c-pnx affects PNX4008 and LPC32xx (and LPC31xx,
>> not yet in mainline). Can you please test?
>> 
>> Thanks in advance!
> 
> I assume you checked this on LPC32xx?

Yes.

The bug surfaced when we debugged unexpected behaviour with I2C
clients. A colleague noticed that sometimes, there were more bytes
transferred than expected, confusing some I2C clients.

The patch fixes exactly that.

Thanks,

Roland
