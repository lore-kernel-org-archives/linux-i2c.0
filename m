From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 6/6] dt-bindings: i2c: Add FSI-attached I2C master dt
 binding documentation
Date: Mon, 17 Jul 2017 11:49:37 -0500
Message-ID: <20170717164937.e5i63h2mndx5pilr@rob-hp-laptop>
References: <1500302157-14670-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1500302157-14670-7-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35664 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdGQQtk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 17 Jul 2017 12:49:40 -0400
Content-Disposition: inline
In-Reply-To: <1500302157-14670-7-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, gregkh@linuxfoundation.org, jk@ozlabs.org, joel@jms.id.au, andrew@aj.id.au, cbostic@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>

On Mon, Jul 17, 2017 at 09:35:57AM -0500, Eddie James wrote:
> From: "Edward A. James" <eajames@us.ibm.com>
> 
> Document the bindings.
> 
> Signed-off-by: Edward A. James <eajames@us.ibm.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-fsi.txt | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt

Where's v3? I acked v2. Please add acks when posting new versions of 
patches.

Rob
