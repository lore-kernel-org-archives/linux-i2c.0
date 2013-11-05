From: Naveen Krishna Ch <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: exynos5: Use reinit_completion instead of INIT_COMPLETION
Date: Tue, 5 Nov 2013 15:08:46 +0530
Message-ID: <CAHfPSqBaiTTifRk_pZQEBbrMuyot6ibZdmh-YHK+hecFOU-YpA@mail.gmail.com>
References: <1383643630-5036-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383643630-5036-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 5 November 2013 14:57, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> INIT_COMPLETION was replaced by reinit_completion vide commit 2c9627cca471
> ("tree-wide: use reinit_completion instead of INIT_COMPLETION"). Use it to
> avoid the following build error:
> drivers/i2c/busses/i2c-exynos5.c:538:9: error:
> undefined identifier 'INIT_COMPLETION'
>
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Thanks for figuring this out pretty soon.

> Cc: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>


> ---
>  drivers/i2c/busses/i2c-exynos5.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index aca3991b7636..d4193000643d 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -535,7 +535,7 @@ static int exynos5_i2c_xfer_msg(struct exynos5_i2c *i2c,
>         i2c->msg_ptr = 0;
>         i2c->trans_done = 0;
>
> -       INIT_COMPLETION(i2c->msg_complete);
> +       reinit_completion(&i2c->msg_complete);
>
>         exynos5_i2c_message_start(i2c, stop);
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)
