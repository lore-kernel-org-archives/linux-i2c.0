From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
	keeping  global state
Date: Sun, 31 Oct 2010 00:39:30 +0100
Message-ID: <20101030233930.GQ21564@trinity.fluff.org>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com> <20101030182458.0849f295@endymion.delvare> <1288481663.4570.19.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1288481663.4570.19.camel-uXGAPMMVk8bAQYKIod7YupZV94DADvEd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Oct 30, 2010 at 07:34:23PM -0400, David Woodhouse wrote:
> On Sat, 2010-10-30 at 18:24 +0200, Jean Delvare wrote:
> > An explanation why this change is needed would be nice.
> 
> Um, does it really need explaining? It's really poor form to keep driver
> state in global variables rather than per-instance, even if you *don't*
> actually have more than one device.

I always like to fill it in, it makes it easier for lazy folks who can't
be bothered to read the patch itself.
 
> It really isn't trouble. We're well into the 21st century now ??? even
> akpm can cope with UTF-8 :)

I'd have to check what the kernel's default charset is...

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
