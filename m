From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: Convert UniPhier I2C controller to
 json-schema
Date: Wed, 26 Feb 2020 10:46:41 -0600
Message-ID: <20200226164641.GA17311@bogus>
References: <20200221025535.30311-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200221025535.30311-1-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 21 Feb 2020 11:55:33 +0900, Masahiro Yamada wrote:
> Convert the UniPhier I2C controller (FIFO-less) binding to DT schema
> format.
> 
> There are two types of I2C controllers used on the UniPhier platform.
> This is the legacy one without FIFO support, which is used on the
> sLD8 SoC or older.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> ---
> 
> When I search for a subsystem-common schema, I need to
> look in both dt-schema project and the kernel tree.
> 
> For example,
> the i2c-controller.yaml is located in the dt-schema project.
> dt-schema/schemas/i2c/i2c-controller.yaml
> 
> The dma-controller.yaml is located in the kernel tree.
> Documentation/devicetree/bindings/dma/dma-controller.yaml
> 
> I am still wondering about the policy...
> 
> As far as I understood, the schema written by Rob
> tend to go in the dt-schma project. Is this correct?
> 
> 
>  .../devicetree/bindings/i2c/i2c-uniphier.txt  | 25 ----------
>  .../bindings/i2c/socionext,uniphier-i2c.yaml  | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/socionext,uniphier-i2c.yaml
> 

Applied, thanks.

Rob
