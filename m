From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-core: fix some coding style issues in i2c-core.c
Date: Sun, 18 Apr 2010 12:53:51 +0200
Message-ID: <20100418125351.58c97bca@hyperion.delvare>
References: <1271580067-13619-1-git-send-email-farid.hammane@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1271580067-13619-1-git-send-email-farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, giometti-k2GhghHVRtY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Farid,

On Sun, 18 Apr 2010 10:41:07 +0200, Farid Hammane wrote:
> This is a patch to the i2c-core.c file that fixes up coding style issues found by the checkpatch.pl tool
> 
> Signed-off-by: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   86 ++++++++++++++++++++++++------------------------
>  1 files changed, 43 insertions(+), 43 deletions(-)

Ironically, your patch itself triggers 5 checkpatch errors. I'll fix
them. Thanks for the patch, consider it applied.

-- 
Jean Delvare
