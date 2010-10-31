From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
 keeping  global state
Date: Sun, 31 Oct 2010 11:01:58 +0100
Message-ID: <20101031110158.1ff0f03c@endymion.delvare>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
	<20101030182458.0849f295@endymion.delvare>
	<1288481663.4570.19.camel@macbook.infradead.org>
	<20101030233930.GQ21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101030233930.GQ21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 31 Oct 2010 00:39:30 +0100, Ben Dooks wrote:
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
>  
> > It really isn't trouble. We're well into the 21st century now ??? even
> > akpm can cope with UTF-8 :)
> 
> I'd have to check what the kernel's default charset is...

For completeness... Documentation/email-clients.txt says:

"Email clients should not modify the character set encoding of the text.
Emailed patches should be in ASCII or UTF-8 encoding only.
If you configure your email client to send emails with UTF-8 encoding,
you avoid some possible charset problems."

I read this as: if you use non-ASCII, it has to be UTF-8. Not as: use
non-ASCII each time you can.

I would have enforced the use of ASCII only, but I'm not Linus, and I
need no non-ASCII character to spell my name, so my opinion probably
doesn't matter much as far as the whole kernel tree is concerned. But
it is still certainly valid for the part I maintain.

-- 
Jean Delvare
