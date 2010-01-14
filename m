From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c-designware: Allow mixed endianness
Date: Thu, 14 Jan 2010 06:45:01 +0000
Message-ID: <20100114064501.GR3738@trinity.fluff.org>
References: <20100113193224.753273000@octasic.com> <4B4E6815.9050908@necel.com> <20100114010905.GJ3738@trinity.fluff.org> <390831ED3DF58E41A3D2FB82591E2C36047AF627@MAILEXCH.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <390831ED3DF58E41A3D2FB82591E2C36047AF627-Jh1kU4MlLDZ5rAAhGZPdxVaTQe2KTcn/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 13, 2010 at 10:06:31PM -0500, Jean-Hugues Deschenes wrote:
> > > In the commit ed5e1dd5 (i2c-designware: Consolidate to use 32-bit
> > > word accesses), I tried to sort out the I/O endian issue, but it
> > > seems doesn't work for your environment, R/W data is swapped :-(
> > 
> > I think this one of those weird cases where you have _both_ types of
> > endianess of peripherals where anything in readl/writel isn't going
> > to help you out.
> 
> Actually, the specific case I'm interested in is one where I have an
> SOC built around an ARM core running in little-endian mode, in which
> the Designware IP has been instantiated and hooked up (to the internal
> data bus) in big endian format.
> 
> This patch could also come in handy, for example, if someone were to
> run an armeb kernel on an SOC where the DW IP has been instantiated
> and hooked up in little endian format (as is probably the case for
> most ARM-based SOCs out there).

I think this is currently an oditity, most ARM systems are still armel,
especiailly since very few distributions do armeb

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
