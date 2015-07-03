From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC 1/3] of: make of_mutex public
Date: Thu, 2 Jul 2015 23:43:30 -0500
Message-ID: <CAL_Jsq+-Tx=hwj9ScXBXeGxNwHhq-Lpe-5Kzd-Tu_SNue2aWTA@mail.gmail.com>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de> <1435700651-3543-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435700651-3543-2-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

+Pantelis

On Tue, Jun 30, 2015 at 4:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> If we want to use OF_DYNAMIC features outside the of framework, we need
> to access this lock. If OF maintainers don't like exporting, we can
> maybe create accessor functions that we can use?

It looks like you are just taking the mutex around various
of_changeset_* calls. We should either split the mutex into of_mutex
for core and changesets and an overlay mutex for overlays, or we need
to do the typical pattern of having changeset functions having locked
and unlocked versions for external and internal (overlays) use.

Rob

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/of/of_private.h | 1 -
>  include/linux/of.h      | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 8e882e706cd8c6..f92ec41efb5dfd 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -31,7 +31,6 @@ struct alias_prop {
>         char stem[0];
>  };
>
> -extern struct mutex of_mutex;
>  extern struct list_head aliases_lookup;
>  extern struct kset *of_kset;
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index b871ff9d81d720..f0464efcbdc5aa 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -32,6 +32,8 @@
>  typedef u32 phandle;
>  typedef u32 ihandle;
>
> +extern struct mutex of_mutex;
> +
>  struct property {
>         char    *name;
>         int     length;
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
