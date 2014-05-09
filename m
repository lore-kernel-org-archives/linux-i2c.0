From: Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>
Subject: Re: [PATCH] i2c: qup: Fix pm_runtime_get_sync usage
Date: Fri, 9 May 2014 09:51:59 -0700
Message-ID: <CAJAp7OgN8rmnC9zsmt7FFcWUauebbfCg30_FC9BhgS3GkeZEFw@mail.gmail.com>
References: <1399082069-6666-1-git-send-email-agross@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399082069-6666-1-git-send-email-agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 2, 2014 at 6:54 PM, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
[...]
> @@ -479,7 +479,7 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
>         int ret, idx;
>
>         ret = pm_runtime_get_sync(qup->dev);
> -       if (ret)
> +       if (ret < 0)
>                 goto out;

Sorry about that, thought I tested that path properly.
Wolfram, please pick this up as soon as possible as it renders the
driver useless if one enables pm runtime.

Acked-by: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>

Regards,
Bjorn
