From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: i2c-stm32f7: allow
 clock-frequency range
Date: Sat, 4 Apr 2020 11:18:20 -0600
Message-ID: <20200404171820.GA24040@bogus>
References: <1585226661-26262-1-git-send-email-alain.volmat@st.com>
 <1585226661-26262-2-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1585226661-26262-2-git-send-email-alain.volmat-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pierre-yves.mordret-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, alain.volmat-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 26 Mar 2020 13:44:20 +0100, Alain Volmat wrote:
> For STM32F7, STM32H7 and STM32MP1 SoCs, if timing parameters
> match, the bus clock frequency can be from 1Hz to 1MHz.
> 
> Signed-off-by: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
> ---
> v2: identical to v1
> 
>  Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
