From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/scx200_*: replace printks with pr_<level>s, rev2
 checkpatch clean
Date: Sat, 22 Sep 2012 16:14:08 +0200
Message-ID: <20120922161408.520ea802@endymion.delvare>
References: <1347768201-11910-1-git-send-email-jim.cromie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347768201-11910-1-git-send-email-jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jim,

On Sat, 15 Sep 2012 22:03:21 -0600, Jim Cromie wrote:
> Replace printks with pr_<level>s, add pr_fmt()s to replace NAMEs
> 
> Signed-off-by: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/scx200_acb.c | 22 +++++++++++-----------
>  drivers/i2c/busses/scx200_i2c.c | 13 +++++++------
>  2 files changed, 18 insertions(+), 17 deletions(-)

This looks good, thanks for the cleanup. But you can go one step
further and remove the NAME defines, as they are no longer used
anywhere in the drivers.

I did that for you, no need to resend. Patch applied.

-- 
Jean Delvare
