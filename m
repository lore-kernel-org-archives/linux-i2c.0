From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: i2c: add bindings for nxp,pca9541
Date: Fri, 29 Jul 2016 16:27:21 -0500
Message-ID: <20160729212721.GA11963@rob-hp-laptop>
References: <1469609010-23049-1-git-send-email-peda@axentia.se>
 <1469609010-23049-5-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33369 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbcG2V1X (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 29 Jul 2016 17:27:23 -0400
Content-Disposition: inline
In-Reply-To: <1469609010-23049-5-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>

On Wed, Jul 27, 2016 at 10:43:27AM +0200, Peter Rosin wrote:
> Fill the gap for this pre-existing driver.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/i2c/nxp,pca9541.txt        | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt

Acked-by: Rob Herring <robh@kernel.org>
