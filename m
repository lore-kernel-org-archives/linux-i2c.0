From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: i2c: add support for 'i2c-mux' subnode
Date: Fri, 29 Jul 2016 16:17:32 -0500
Message-ID: <20160729211732.GA6288@rob-hp-laptop>
References: <1469609010-23049-1-git-send-email-peda@axentia.se>
 <1469609010-23049-2-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34135 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbcG2VRe (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 29 Jul 2016 17:17:34 -0400
Content-Disposition: inline
In-Reply-To: <1469609010-23049-2-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>

On Wed, Jul 27, 2016 at 10:43:24AM +0200, Peter Rosin wrote:
> Similar to the new optional 'i2c-bus' subnode from Jon Hunter, this
> adds an optional 'i2c-mux' subnode, for similar reasons. I.e. it is
> bad of the i2c mux core to assume that any subnode of an i2c mux device
> is a potential (when the 'reg' property matches) i2c-mux child bus,
> given that i2c mux devices might do more than mux i2c traffic.
> 
> So, if an 'i2c-mux' subnode is present, dictate that all i2c-mux child
> buses exist beneath that subnode.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mux.txt | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
