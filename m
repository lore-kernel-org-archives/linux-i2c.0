From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: Please pull bjdoo ks' i2c-fixes
Date: Thu, 18 Dec 2008 10:06:35 +0000
Message-ID: <20081218100635.GH8032@fluff.org.uk>
References: <E1LChEf-0000Ts-53@teyla.home.fluff.org> <4948E89A.7080703@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4948E89A.7080703-NIgtFMG+Po8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 17, 2008 at 12:55:06PM +0100, Jochen Friedrich wrote:
> Hi Ben,
> 
> > Mike Ditto (1):
> >       i2c-cpm: Detect and report NAK right away instead of timing out
> 
> Could you also have a look at http://patchwork.ozlabs.org/patch/7452/ ?
> (Discussion at http://patchwork.ozlabs.org/patch/6666/ )
> 
> IIRC, Kumar prefers to push this via your tree.

Ok, but this isn't really a fix, so I'll look at putting it into my
i2c-next tree, not i2c-fixes.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
