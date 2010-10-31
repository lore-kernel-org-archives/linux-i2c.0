From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
 keeping  global state
Date: Sun, 31 Oct 2010 10:15:51 -0400
Message-ID: <1288534551.4570.36.camel@macbook.infradead.org>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
	 <20101030182458.0849f295@endymion.delvare>
	 <1288481663.4570.19.camel@macbook.infradead.org>
	 <20101030233930.GQ21564@trinity.fluff.org>
	 <20101031110158.1ff0f03c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101031110158.1ff0f03c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 2010-10-31 at 11:01 +0100, Jean Delvare wrote:
> "Email clients should not modify the character set encoding of the text.
> Emailed patches should be in ASCII or UTF-8 encoding only.
> If you configure your email client to send emails with UTF-8 encoding,
> you avoid some possible charset problems."
> 
> I read this as: if you use non-ASCII, it has to be UTF-8. Not as: use
> non-ASCII each time you can. 

I read that differently; I read it simply as "Everything is UTF-8".

ASCII is just a legacy subset of UTF-8, and (in my reading of the above)
is mentioned only to avoid confusion.

If someone only happens to be sending ASCII, we don't want to confuse
them by making them think there's some conversion needed to turn that
into UTF-8. So we mention explicitly that ASCII is acceptable, even
though that would be implicit if we mentioned only UTF-8.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation
