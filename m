From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V3] i2c-algo-pca: fix coding style issues in
 i2c-algo-pca.c
Date: Sun, 25 Apr 2010 14:07:30 +0200
Message-ID: <20100425140730.555f76de@hyperion.delvare>
References: <1272119654-8976-1-git-send-email-farid.hammane@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272119654-8976-1-git-send-email-farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Enrik.Berkhan-JJi787mZWgc@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Farid,

On Sat, 24 Apr 2010 16:34:14 +0200, Farid Hammane wrote:
> This patch fixes up some coding style issues. i2c-algo-pca.c has been
> build successfully after applying this patch and the binary object is
> still exactly the same.
> Other issues found by checkpatch.pl were voluntarily not fixed, either
> to keep readability, or because of false positive errors.
> 
> Signed-off-by: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pca.c |   36 ++++++++++++++++++------------------
>  1 files changed, 18 insertions(+), 18 deletions(-)

Applied, thanks.

-- 
Jean Delvare
