From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Mon, 1 Feb 2016 08:46:08 -0600
Message-ID: <20160201144608.GA26606@rob-hp-laptop>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32886 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418AbcBAOqO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Feb 2016 09:46:14 -0500
Content-Disposition: inline
In-Reply-To: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, wsa@the-dreams.de, laurent.pinchart@ideasonboard.com, lars@metafoo.de, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>

On Sun, Jan 31, 2016 at 04:33:00PM +0100, Jean-Michel Hautbois wrote:
> Some I2C devices have multiple addresses assigned, for example each address
> corresponding to a different internal register map page of the device.
> So far drivers which need support for this have handled this with a driver
> specific and non-generic implementation, e.g. passing the additional address
> via platform data.
> 
> This patch provides a new helper function called i2c_new_secondary_device()
> which is intended to provide a generic way to get the secondary address
> as well as instantiate a struct i2c_client for the secondary address.
> 
> The function expects a pointer to the primary i2c_client, a name
> for the secondary address and an optional default address. The name is used
> as a handle to specify which secondary address to get.
> 
> The default address is used as a fallback in case no secondary address
> was explicitly specified. In case no secondary address and no default
> address were specified the function returns NULL.
> 
> For now the function only supports look-up of the secondary address
> from devicetree, but it can be extended in the future
> to for example support board files and/or ACPI.
> 
> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
> ---
> v2: adding some DT bindings documentation (more than one year later...)
> 
>  Documentation/devicetree/bindings/i2c/i2c.txt |  7 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/i2c/i2c-core.c                        | 42 +++++++++++++++++++++++++++
>  include/linux/i2c.h                           |  5 ++++
>  3 files changed, 54 insertions(+)
