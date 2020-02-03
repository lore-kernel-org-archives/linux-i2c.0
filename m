From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] dt-bindings: i2c: i2c-stm32f7: add st,stm32mp15-i2c
 compatible
Date: Mon, 3 Feb 2020 12:23:52 +0000
Message-ID: <20200203122352.GA26745@bogus>
References: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
 <1579795970-22319-3-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1579795970-22319-3-git-send-email-alain.volmat-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pierre-yves.mordret-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, alain.volmat-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Jan 2020 17:12:47 +0100, Alain Volmat wrote:
> Add a new stm32mp15 specific compatible to handle FastMode+
> registers which are different on the stm32mp15 compared
> to the stm32f7 or stm32h7.
> 
> Signed-off-by: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
