From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: make i2c xfers non-interruptible
Date: Fri, 7 Jun 2013 08:25:55 +0300
Message-ID: <20130607052555.GC11878@intel.com>
References: <1370526216-10060-1-git-send-email-christian.ruppert@abilis.com>
 <1370526216-10060-2-git-send-email-christian.ruppert@abilis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370526216-10060-2-git-send-email-christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 06, 2013 at 03:43:36PM +0200, Christian Ruppert wrote:
> When the process at the source of an i2c transfer is killed in the
> middle of the transfer, the transfer is interrupted. Interrupted
> transfers might cause buggy slaves on the bus (or higher level drivers)
> to go haywire.
> This patch forces ongoing i2c transfers to finish properly, even if the
> initiating process is killed.

I already sent a similar patch ;-)

https://patchwork.kernel.org/patch/2601241/

However, it is not yet picked by Wolfram.
