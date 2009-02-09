From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2 2/2] i2c: adapt debug macros for KERN_* constants
Date: Mon, 9 Feb 2009 16:16:44 +0100
Message-ID: <20090209161644.35e3154d@hyperion.delvare>
References: <498C3EEA.5060508@suse.de>
	<498EE9C9.4080002@suse.de>
	<498EEA2F.5050601@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <498EEA2F.5050601-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, ukleinek-jNDFPZUTrfROceuj71AUlABBhMqQ4zRThC4ANOJQIlc@public.gmane.org, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>, Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 08 Feb 2009 15:20:31 +0100, Frank Seidel wrote:
> From: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
> 
> According to kerneljanitors todo list all printk calls (beginning
> a new line) should have an according KERN_* constant.
> Those are the changes to the debug macros in the i2c subsystem
> to meet this requirement. Also changing no-debug statements
> to raw printks again.
> 
> Signed-off-by: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pca.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Applied, thanks.

Wolfram, I would appreciate if you could test the patch and confirm it
doesn't break anything:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-algo-pca-adapt-debug-macros-for-KERN-constants.patch

Thanks,
-- 
Jean Delvare
