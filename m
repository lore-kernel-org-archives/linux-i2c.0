From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
 keeping  global state
Date: Sat, 30 Oct 2010 19:47:58 -0400
Message-ID: <1288482478.4570.23.camel@macbook.infradead.org>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
	 <20101030182458.0849f295@endymion.delvare>
	 <1288481663.4570.19.camel@macbook.infradead.org>
	 <20101030233930.GQ21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101030233930.GQ21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 2010-10-31 at 00:39 +0100, Ben Dooks wrote:
> On Sat, Oct 30, 2010 at 07:34:23PM -0400, David Woodhouse wrote:
> > On Sat, 2010-10-30 at 18:24 +0200, Jean Delvare wrote:
> > > An explanation why this change is needed would be nice.
> > 
> > Um, does it really need explaining? It's really poor form to keep driver
> > state in global variables rather than per-instance, even if you *don't*
> > actually have more than one device.
> 
> I always like to fill it in, it makes it easier for lazy folks who can't
> be bothered to read the patch itself.

The explanation fits in one line:
  "Handle multiple instances instead of keeping global state"

I could try adding a paragraph explaining further that this patch will
make the driver handle multiple instances of the device, by keeping its
state per-device instead of in global variables. But that seems
somewhat... redundant.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation
