From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c-omap: Add new compatible for
 AM654 SoCs
Date: Fri, 12 Oct 2018 14:33:34 -0500
Message-ID: <20181012193334.GA29966@bogus>
References: <20180928052557.21663-1-vigneshr@ti.com>
 <20180928052557.21663-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928052557.21663-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>, Nishanth Menon <nm@ti.com>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 28 Sep 2018 10:55:56 +0530, Vignesh R wrote:
> AM654 SoCs have same I2C IP as OMAP SoCs. Add new compatible to
> handle AM654 SoCs. While at that reformat the existing compatible list
> for older SoCs to list one valid compatible per line.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> v2: Reformat compatible existing compatible list.
> 
>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
