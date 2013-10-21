From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-designware-pci: Index Haswell ULT bus names from
 0
Date: Mon, 21 Oct 2013 09:58:04 +0300
Message-ID: <20131021065804.GX3521@intel.com>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
 <1382326010-4554-3-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382326010-4554-3-git-send-email-bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 20, 2013 at 08:26:50PM -0700, Benson Leung wrote:
> Rather than having the bus names be "i2c-designware-pci--1" because
> we have set the .bus_num to -1 to force dynamic allocation, lets have
> the busses named "i2c-designware-pci-0" and "i2c-designware-pci-1"
> to correspond to the correct names of these busses.
> 
> The adapter number will still be dynamically assigned.

Is there any real value in having names like "i2c-designware-pci-0"
available? I would just drop the whole naming dance instead...
