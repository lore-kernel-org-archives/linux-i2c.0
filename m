From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/5] dt-bindings: i2c: convert rockchip i2c bindings
 to yaml
Date: Thu, 12 Mar 2020 10:50:44 -0500
Message-ID: <20200312155044.GA25292@bogus>
References: <20200305143611.10733-1-jbx6244@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200305143611.10733-1-jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Jonker <jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu,  5 Mar 2020 15:36:07 +0100, Johan Jonker wrote:
> Current dts files with 'i2c' nodes are manually verified.
> In order to automate this process i2c-rk3x.txt
> has to be converted to yaml. In the new setup
> i2c-rk3x.yaml will inherit properties from
> i2c-controller.yaml.
> 
> Also change document name in MAINTAINERS.
> 
> Signed-off-by: Johan Jonker <jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  68 -----------
>  .../devicetree/bindings/i2c/i2c-rk3x.yaml          | 129 +++++++++++++++++++++
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 130 insertions(+), 69 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
> 

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
