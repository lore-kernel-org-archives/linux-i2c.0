From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] i2c: allow DT nodes without 'compatible'
Date: Wed, 26 Feb 2020 10:30:54 -0600
Message-ID: <20200226163054.GA26533@bogus>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
 <20200220172403.26062-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200220172403.26062-4-wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i3c-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kieran Bingham <kieran-7hKh/agyDeatmTQ+vhA3Yw@public.gmane.org>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Luca Ceresoli <luca-ep08DiM7hqZH3+C6az13tg@public.gmane.org>, Jacopo Mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 20 Feb 2020 18:23:59 +0100, Wolfram Sang wrote:
> Sometimes, we have unknown devices in a system and still want to block
> their address. For that, we allow DT nodes with only a 'reg' property.
> These devices will be bound to the "dummy" driver but with the name
> "reserved". That way, we can distinguish them and even hand them over to
> the "dummy" driver later when they are really requested using
> i2c_new_ancillary_device().
> 
> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 1 -
>  Documentation/devicetree/bindings/i2c/i2c.txt        | 4 +++-
>  drivers/i2c/i2c-core-base.c                          | 1 +
>  drivers/i2c/i2c-core-of.c                            | 8 +++-----
>  drivers/i2c/i2c-core.h                               | 1 +
>  5 files changed, 8 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
