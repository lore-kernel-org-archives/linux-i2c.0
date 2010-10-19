From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCHv4 0/5] BH1770GLC, SFH7770 and APDS990x als / proximity
 sensor drivers
Date: Tue, 19 Oct 2010 16:20:20 -0700
Message-ID: <20101019162020.954cd059.akpm@linux-foundation.org>
References: <1287472188-10101-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287472188-10101-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Oct 2010 10:09:43 +0300
Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:

> Patch set contains two drivers. One for BH1770GLC / SFH7770 chips and
> one for APDS990X chip.
> 
> Both drivers have similar sysfs based interface. Both supports
> pm_runtime and regulator frame work. There is short documentation
> for both drivers.
> 
> Unfortunately I can't promise data sheets to public access.
> 
> Changes since patch set version 3:
> 
> - acked-by added to patches 1, 3 and 5
> - Documentation clean up (extra lines removed, LUX changed to lux)
> 
> Patches 2 and 4 are not directly acked or I have missed something.
> However, all requested cleanups have been done to those patches.

That all looks quite nice.

I'll fold patch 2 into patch 1 and patch 4 into patch 3 before sending
the patches onwards - there isn't much point in separating the code
patch from the wire-it-up-to-kbuild patch.
