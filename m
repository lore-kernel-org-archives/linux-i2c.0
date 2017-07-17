From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/6] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Mon, 17 Jul 2017 16:11:23 +0200
Message-ID: <20170717141123.GA13295@kroah.com>
References: <1499711882-12918-1-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdGQOL2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 17 Jul 2017 10:11:28 -0400
Content-Disposition: inline
In-Reply-To: <1499711882-12918-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, jk@ozlabs.org, joel@jms.id.au, andrew@aj.id.au, cbostic@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>

On Mon, Jul 10, 2017 at 01:37:56PM -0500, Eddie James wrote:
> From: "Edward A. James" <eajames@us.ibm.com>
> 
> This series adds an algorithm for an I2C master physically located on an FSI
> slave device. The I2C master has multiple ports, each of which may be connected
> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
> 
> Due to the multi-port nature of the I2C master, the driver instantiates a new
> I2C adapter for each port connected to a slave. The connected ports should be
> defined in the device tree under the I2C master device.
> 
> Changes since v1:

I have 2 "v2" series in my inbox, and they are different :(

Please resend a "v4" so I know exactly which ones to pick up...

thanks,

gre k-h
