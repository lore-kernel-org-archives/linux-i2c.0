From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7] i2c: Add support for NXP PCA984x family.
Date: Tue, 26 Dec 2017 11:58:43 -0600
Message-ID: <CAL_Jsq+GWGLFujL8kBub=f41NCC=uTWRQzVOr8obsm9bzUnLJQ@mail.gmail.com>
References: <20171220182745.lo6i27ucfhjekmjp@rob-hp-laptop> <20171225212646.8062-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171225212646.8062-1-adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 25, 2017 at 3:26 PM, Adrian Fiergolski
<adrian.fiergolski-vJEk5272eHo@public.gmane.org> wrote:
> This patch extends the current i2c-mux-pca954x driver and adds support for
> a newer PCA984x family of the I2C switches and multiplexers from NXP.
>
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
> ---
> Following Rob's and Peter's remarks, bindings contain now one valid
> combination of compatibles per line.
>
>  .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    | 13 ++++++--
>  drivers/i2c/muxes/Kconfig                          |  6 ++--
>  drivers/i2c/muxes/i2c-mux-pca954x.c                | 38 +++++++++++++++++++---
>  3 files changed, 48 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
