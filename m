From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-designware: Fix compilation warning
Date: Tue, 21 May 2013 10:07:30 +0300
Message-ID: <20130521070730.GJ11878@intel.com>
References: <2512686.216921369094149829.JavaMail.weblogic@epml25>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2512686.216921369094149829.JavaMail.weblogic@epml25>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: EUNBONG SONG <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 20, 2013 at 11:55:50PM +0000, EUNBONG SONG wrote:
> 
> Fix the following compilation warning when CONFIG_PM_RUNTIME is not enabled:
> 
> drivers/i2c/busses/i2c-designware-pcidrv.c:188: warning: 'i2c_dw_pci_runtime_idle' defined but not used
> 
> Signed-off-by: EunBong Song <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Thanks for fixing this!

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
