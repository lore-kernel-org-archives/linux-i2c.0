From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 3/5] dt-bindings: i2c: i2c-rk3x: add description for
 rk3368
Date: Thu, 12 Mar 2020 10:51:29 -0500
Message-ID: <20200312155129.GA26550@bogus>
References: <20200305143611.10733-1-jbx6244@gmail.com>
 <20200305143611.10733-3-jbx6244@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41615 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgCLPvb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Mar 2020 11:51:31 -0400
Content-Disposition: inline
In-Reply-To: <20200305143611.10733-3-jbx6244@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Johan Jonker <jbx6244@gmail.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu,  5 Mar 2020 15:36:09 +0100, Johan Jonker wrote:
> The description below is already in use for rk3368.dtsi,
> but was somehow never added to a document, so add
> "rockchip,rk3368-i2c", "rockchip,rk3288-i2c"
> for i2c nodes on a rk3368 platform to i2c-rk3x.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
