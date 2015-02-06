From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: designware-pci: shrink dw_pci_controllers
 array
Date: Fri, 06 Feb 2015 12:50:08 +0200
Message-ID: <1423219808.31903.430.camel@linux.intel.com>
References: <1422014045-20584-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1422014045-20584-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150123124155.GA1906@katana> <20150123124805.GP1850@lahna.fi.intel.com>
	 <1422018246.31903.162.camel@linux.intel.com> <20150124041914.GA1190@katana>
	 <20150126121508.GE1052@katana> <20150205192136.GE15307@katana>
	 <20150205225651.GA1022@psi-dev26.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150205225651.GA1022-UmZa8NLUsbhHELxPJs4m+1DQ4js95KgL@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2015-02-05 at 14:56 -0800, David Cohen wrote:
> On Thu, Feb 05, 2015 at 08:21:36PM +0100, Wolfram Sang wrote:

> > > > > I think better to ask David who is closer to that Intel MID area.
> > > > 
> > > > OK, waiting for a reply from him here.
> > > 
> > > @David: ping
> > 
> > David: ping again
> 
> Pong. Sorry for the delay.
> 
> There are actually few products based on Medfield reference board and
> clovertrail+ as well uses medfield code. We need to keep the bus_num
> there for these SFI platforms.


Wolfram, I remove this patch and re-do and resend the former 4/4.


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy
