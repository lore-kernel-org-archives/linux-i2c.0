From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 15:21:52 +0100
Message-ID: <20090123152152.41a201dc@hyperion.delvare>
References: <20090122150230.GA10952@enneenne.com>
	<20090123095110.7b0c7b82@hyperion.delvare>
	<200901230139.38785.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901230139.38785.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Fri, 23 Jan 2009 01:39:38 -0800, David Brownell wrote:
> On Friday 23 January 2009, Jean Delvare wrote:
> > David, can you please comment on the proposed change?
> 
> If it's a legacy driver, it will already have been decoupled
> from devices, so the nastiest bit of stuff will have gotten
> the protection it needs.  New-style drivers shouldn't care
> about the legacy stuff at all.  So that much looks plausible.
> 
> But I don't have the patience to really analyse the other
> locking implications; there were some rude and un-obvious
> things lurking there, including abuse of complete() for
> the legacy i2c_client lifecycle.

This was my conclusion as well.

I think I'll try Rodoflo's patch locally and see if anything breaks. If
things appear to work, I am ready to push the patch upstream, but
obviously if anyone reports a locking issue after that, it would have
to be reverted.

In the meantime I will try to find time again to convert more legacy
drivers. My feeling is that we won't do much progress on multiplexing
before we get rid of legacy drivers and their custom locking model.

-- 
Jean Delvare
