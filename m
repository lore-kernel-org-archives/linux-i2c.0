From: =?iso-8859-1?Q?=22Andersson=2C_Bj=F6rn=22?=
	<Bjorn.Andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Subject: Re: [PATCH] i2c: qup: use proper type fro clk_freq
Date: Thu, 3 Apr 2014 11:52:21 +0200
Message-ID: <CF62FA60.4537C%bjorn.andersson@sonymobile.com>
References: <1396517774-8400-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396517774-8400-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Of course, sorry about that.

Acked-by: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>

On 4/3/14 11:36 AM, "Wolfram Sang" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:

>It is used with of_property_read_u32(), so it should be u32.
>
>Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>---
> drivers/i2c/busses/i2c-qup.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
>index ee409803fd94..1b4cf14f1106 100644
>--- a/drivers/i2c/busses/i2c-qup.c
>+++ b/drivers/i2c/busses/i2c-qup.c
>@@ -562,7 +562,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
> 	u32 io_mode, hw_ver, size;
> 	int ret, fs_div, hs_div;
> 	int src_clk_freq;
>-	int clk_freq = 100000;
>+	u32 clk_freq = 100000;
> 
> 	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
> 	if (!qup)
>-- 
>1.9.0
>
