From: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 4/5] i2c: st: Make of_device_id array const
Date: Wed, 7 May 2014 11:05:04 +0200
Message-ID: <5369F740.5010308@st.com>
References: <022101cf69d1$f1311200$d3933600$%han@samsung.com> <022601cf69d2$ef8ba9f0$cea2fdd0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <022601cf69d2$ef8ba9f0$cea2fdd0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jingoo,

On 05/07/2014 11:01 AM, Jingoo Han wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.
>

Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>

> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-st.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
> index 8720161..95b94767 100644
> --- a/drivers/i2c/busses/i2c-st.c
> +++ b/drivers/i2c/busses/i2c-st.c
> @@ -847,7 +847,7 @@ static int st_i2c_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> -static struct of_device_id st_i2c_match[] = {
> +static const struct of_device_id st_i2c_match[] = {
>   	{ .compatible = "st,comms-ssc-i2c", },
>   	{ .compatible = "st,comms-ssc4-i2c", },
>   	{},
>

Thanks!
Maxime
