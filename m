From: Naveen Krishna Ch <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: exynos5: Remove incorrect clk_disable_unprepare
Date: Fri, 8 Nov 2013 10:56:23 +0530
Message-ID: <CAHfPSqDaxAETbJOkBNWk7T6u6Y7D5+sj1T01My0shL62s3ir+Q@mail.gmail.com>
References: <1383730758-1771-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383730758-1771-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6 November 2013 15:09, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> clk_disable_unprepare in remove causes an imbalance and hence gives
> the below crash on module remove. While at it also remove some
> duplicate code from probe.
>
> / $ rmmod i2c-exynos5
> [    6.996374] ------------[ cut here ]------------
> [    6.999523] WARNING: CPU: 2 PID: 1137 at drivers/clk/clk.c:842 clk_disable+0x18/0x24()
> [    7.007403] Modules linked in: i2c_exynos5(-)
> [    7.011747] CPU: 2 PID: 1137 Comm: rmmod Not tainted 3.12.0-next-20131105-00083-g16f4799-dirty #21
> [    7.020696] [<c0014e0c>] (unwind_backtrace+0x0/0xf4) from [<c0011784>] (show_stack+0x10/0x14)
> [    7.029190] [<c0011784>] (show_stack+0x10/0x14) from [<c037acd4>] (dump_stack+0x7c/0xb0)
> [    7.037255] [<c037acd4>] (dump_stack+0x7c/0xb0) from [<c001e0ac>] (warn_slowpath_common+0x6c/0x88)
> [    7.046190] [<c001e0ac>] (warn_slowpath_common+0x6c/0x88) from [<c001e164>] (warn_slowpath_null+0x1c/0x24)
> [    7.055818] [<c001e164>] (warn_slowpath_null+0x1c/0x24) from [<c02dcde4>] (clk_disable+0x18/0x24)
> [    7.064670] [<c02dcde4>] (clk_disable+0x18/0x24) from [<bf0002d4>] (exynos5_i2c_remove+0x1c/0x34 [i2c_exynos5])
> [    7.074736] [<bf0002d4>] (exynos5_i2c_remove+0x1c/0x34 [i2c_exynos5]) from [<c02274a8>] (__device_release_driver+0x58/0xb0)
> [    7.085836] [<c02274a8>] (__device_release_driver+0x58/0xb0) from [<c0227b88>] (driver_detach+0xac/0xb0)
> [    7.095291] [<c0227b88>] (driver_detach+0xac/0xb0) from [<c02271c0>] (bus_remove_driver+0x4c/0xa0)
> [    7.104227] [<c02271c0>] (bus_remove_driver+0x4c/0xa0) from [<c00725dc>] (SyS_delete_module+0x124/0x194)
> [    7.113682] [<c00725dc>] (SyS_delete_module+0x124/0x194) from [<c000e2e0>] (ret_fast_syscall+0x0/0x30)
> [    7.122957] ---[ end trace 23bb6e4e0bf52196 ]---
> [    7.127591] ------------[ cut here ]------------
> [    7.132187] WARNING: CPU: 2 PID: 1137 at drivers/clk/clk.c:751 clk_unprepare+0x14/0x1c()
> [    7.140259] Modules linked in: i2c_exynos5(-)
> [    7.144560] CPU: 2 PID: 1137 Comm: rmmod Tainted: G        W    3.12.0-next-20131105-00083-g16f4799-dirty #21
> [    7.154493] [<c0014e0c>] (unwind_backtrace+0x0/0xf4) from [<c0011784>] (show_stack+0x10/0x14)
> [    7.163006] [<c0011784>] (show_stack+0x10/0x14) from [<c037acd4>] (dump_stack+0x7c/0xb0)
> [    7.171052] [<c037acd4>] (dump_stack+0x7c/0xb0) from [<c001e0ac>] (warn_slowpath_common+0x6c/0x88)
> [    7.179984] [<c001e0ac>] (warn_slowpath_common+0x6c/0x88) from [<c001e164>] (warn_slowpath_null+0x1c/0x24)
> [    7.189616] [<c001e164>] (warn_slowpath_null+0x1c/0x24) from [<c02ddcc4>] (clk_unprepare+0x14/0x1c)
> [    7.198639] [<c02ddcc4>] (clk_unprepare+0x14/0x1c) from [<bf0002dc>] (exynos5_i2c_remove+0x24/0x34 [i2c_exynos5])
> [    7.208876] [<bf0002dc>] (exynos5_i2c_remove+0x24/0x34 [i2c_exynos5]) from [<c02274a8>] (__device_release_driver+0x58/0xb0)
> [    7.219978] [<c02274a8>] (__device_release_driver+0x58/0xb0) from [<c0227b88>] (driver_detach+0xac/0xb0)
> [    7.229434] [<c0227b88>] (driver_detach+0xac/0xb0) from [<c02271c0>] (bus_remove_driver+0x4c/0xa0)
> [    7.238369] [<c02271c0>] (bus_remove_driver+0x4c/0xa0) from [<c00725dc>] (SyS_delete_module+0x124/0x194)
> [    7.247824] [<c00725dc>] (SyS_delete_module+0x124/0x194) from [<c000e2e0>] (ret_fast_syscall+0x0/0x30)
> [    7.257104] ---[ end trace 23bb6e4e0bf52197 ]---
>
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-exynos5.c |    5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index d419300..c1ef228 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -702,10 +702,6 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, i2c);
>
> -       clk_disable_unprepare(i2c->clk);
> -
> -       return 0;
> -
>   err_clk:
>         clk_disable_unprepare(i2c->clk);
>         return ret;
> @@ -716,7 +712,6 @@ static int exynos5_i2c_remove(struct platform_device *pdev)
>         struct exynos5_i2c *i2c = platform_get_drvdata(pdev);
>
>         i2c_del_adapter(&i2c->adap);
> -       clk_disable_unprepare(i2c->clk);
>
>         return 0;
>  }
> --
> 1.7.9.5
Thanks for the testing and fix.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)
