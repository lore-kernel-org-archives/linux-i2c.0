From: Rob Herring <robh@kernel.org>
Subject: Re: [v6,1/3] dt-bindings: i2c: support property idle-state
Date: Mon, 2 Dec 2019 17:15:44 -0600
Message-ID: <20191202231544.GA19159@bogus>
References: <20191129092222.2706-1-biwen.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191129092222.2706-1-biwen.li@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: peda@axentia.se, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, 29 Nov 2019 17:22:20 +0800, Biwen Li wrote:
> This supports property idle-state
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v6:
> 	- none
> 
> Change in v5:
> 	- none
> 
> Change in v4:
> 	- none
> 
> Change in v3:
> 	- update subject and description
> 	- add some information for property idle-state
> 
> Change in v2:
> 	- update subject and description
> 	- add property idle-state
> 
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
