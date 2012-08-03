From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Fri, 3 Aug 2012 08:33:42 +0200
Message-ID: <20120803083342.76f0df3b@endymion.delvare>
References: <1343683421-12504-1-git-send-email-bill.e.brown@intel.com>
	<1343954343.24204.5.camel@bebrown-nhm1.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343954343.24204.5.camel-ttzMDwopN+0VpfeQ83dqLK2pdiUAq4bhAL8bYrjMMd8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bill,

On Thu, 02 Aug 2012 17:39:03 -0700, Bill Brown wrote:
> On Mon, 2012-07-30 at 14:23 -0700, Bill Brown wrote:
> > The iSMT (Intel SMBus Message Transport) supports multi-master I2C/SMBus,
> > as well as IPMI.  It's operation is DMA-based and utilizes descriptors to
> > initiate transactions on the bus.
> > 
> > The iSMT hardware can act as both a master and a target, although this
> > driver only supports being a master.
> > 
> > Signed-off-by: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> I haven't seen any activity on this yet...good to go, or has anyone had
> a chance to review it yet?  I'd like to get it into the 3.6 kernel if
> possible.

Summer time is when when people take vacation, this increases review
delays.

I'm afraid it's too late for 3.6, rc1 is already out. In order to get a
patch in a kernel version, you must have it in linux-next before the
merge window opens.

-- 
Jean Delvare
