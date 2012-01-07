From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Use memdup_user
Date: Sat, 7 Jan 2012 11:00:39 +0100
Message-ID: <20120107110039.6b4142f0@endymion.delvare>
References: <1313223430.16820.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1313223430.16820.14.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Thomas,

Sorry for the late reply.

On Sat, 13 Aug 2011 10:17:06 +0200, Thomas Meyer wrote:
> From: Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>
> 
>  Use kmemdup_user rather than duplicating its implementation
>  This is a little bit restricted to reduce false positives
> 
>  The semantic patch that makes this output is available
>  in scripts/coccinelle/api/memdup_user.cocci.
> 
>  More information about semantic patching is available at
>  http://coccinelle.lip6.fr/
> 
> Signed-off-by: Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>

Applied, thanks.

-- 
Jean Delvare
