From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2 0/3] i2c-designware: Allow mixed endianness
Date: Sun, 24 Jan 2010 15:41:21 +0000
Message-ID: <20100124154121.GD28675@fluff.org.uk>
References: <20100119140234.689304000@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100119140234.689304000-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 19, 2010 at 09:02:34AM -0500, Jean-Hugues Deschenes wrote:
> 
> This is the v2 version of the patch which adds support
> for the i2c Designware controller when its endianness
> differs from that of the cpu.

apart from the one comment on the {}. the rest is fine.
 
> ---
> Changelog v1->v2
> - rename i2c_dw_(read|write)l to dw_(read|write)l (Shinya Kuribayashi)
> - rename dw_(read|write)l's addr argument to offset (Shinya Kuribayashi)
> - replace (if constant == x) with (if x == constant) (Ben Dooks)
> ---
> 
> 
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
> 
> 
> -- 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
