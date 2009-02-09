From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2 1/2] i2c: add missing KERN_* constants to printks
Date: Mon, 9 Feb 2009 13:22:30 +0100
Message-ID: <20090209132230.66bc4730@hyperion.delvare>
References: <498C3EEA.5060508@suse.de>
	<498EE9C9.4080002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <498EE9C9.4080002-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, ukleinek-jNDFPZUTrfROceuj71AUlABBhMqQ4zRThC4ANOJQIlc@public.gmane.org, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>, fseidel-l3A5Bk7waGM@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 08 Feb 2009 15:18:49 +0100, Frank Seidel wrote:
> From: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
> 
> According to kerneljanitors todo list all printk calls (beginning
> a new line) should have an according KERN_* constant.
> Those are the missing pieces here for the i2c subsystem.
> 
> Signed-off-by: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pcf.c  |    2 +-
>  drivers/i2c/busses/i2c-pca-isa.c  |    5 +++--
>  drivers/i2c/busses/i2c-powermac.c |    3 ++-
>  drivers/i2c/busses/i2c-pxa.c      |    9 +++++----
>  4 files changed, 11 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Jean Delvare
