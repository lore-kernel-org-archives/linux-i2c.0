From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: ocores: rework clk code to handle NULL cookie
Date: Fri, 20 Feb 2015 19:51:44 +0300
Message-ID: <CAMo8Bf+=Ny-uc+wmr9OsKh9kUhYqVXLw-nM4h+y_OMKx_FpCHg@mail.gmail.com>
References: <1424363824-6093-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424363824-6093-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Feb 19, 2015 at 7:37 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
> For, !HAVE_CLK the clk API returns a NULL cookie. Rework the
> initialization code to handle that. If clk_get_rate() delivers 0, we use
> the fallback mechanisms. The patch is pretty easy when ignoring white
> space issues (git diff -b).
>
> Suggested-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> ---
>
> Max, can you please test/review. I can only compile-test. This is the outcome
> of this thread: https://lkml.org/lkml/2015/2/5/544

I've tested it with and without HAVE_CLK, both work well for me.

-- 
Thanks.
-- Max
