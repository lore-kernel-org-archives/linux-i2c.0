From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCHv2 RESEND] i2c: designware-pci: set ideal HCNT, LCNT and
 SDA hold time value
Date: Tue, 11 Mar 2014 13:11:02 +0200
Message-ID: <20140311111102.GZ5018@intel.com>
References: <1394537625-27205-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394537625-27205-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Lim Lee Booi <lee.booi.lim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 11, 2014 at 07:33:45PM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> On Intel BayTrail, there was case whereby the resulting fast mode
> bus speed becomes slower (~20% slower compared to expected speed)
> if using the HCNT/LCNT calculated in the core layer. Thus, this
> patch is added to allow pci glue layer to pass in optimal
> HCNT/LCNT/SDA hold time values to core layer since the core
> layer supports cofigurable HCNT/LCNT/SDA hold time values now.
> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
