From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/5] dt-bindings: i2c: convert rockchip i2c bindings
 to yaml
Date: Thu, 12 Mar 2020 10:54:40 -0500
Message-ID: <20200312155440.GA29613@bogus>
References: <20200305143611.10733-1-jbx6244@gmail.com>
 <20200312155044.GA25292@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39518 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgCLPyn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Mar 2020 11:54:43 -0400
Content-Disposition: inline
In-Reply-To: <20200312155044.GA25292@bogus>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Johan Jonker <jbx6244@gmail.com>
Cc: heiko@sntech.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:50:44AM -0500, Rob Herring wrote:
> On Thu,  5 Mar 2020 15:36:07 +0100, Johan Jonker wrote:
> > Current dts files with 'i2c' nodes are manually verified.
> > In order to automate this process i2c-rk3x.txt
> > has to be converted to yaml. In the new setup
> > i2c-rk3x.yaml will inherit properties from
> > i2c-controller.yaml.
> > 
> > Also change document name in MAINTAINERS.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  68 -----------
> >  .../devicetree/bindings/i2c/i2c-rk3x.yaml          | 129 +++++++++++++++++++++
> >  MAINTAINERS                                        |   2 +-
> >  3 files changed, 130 insertions(+), 69 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

As this series is all binding changes, I'll take it via the DT tree.

Rob
