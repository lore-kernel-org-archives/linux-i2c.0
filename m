From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
Date: Fri, 6 Jan 2017 23:34:24 +0200
Message-ID: <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:49616 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934243AbdAFVe0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Jan 2017 16:34:26 -0500
In-Reply-To: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wsa@the-dreams.de, soren.brinkmann@xilinx.com, michal.simek@xilinx.com

Hello Mike,

On 01/05/2017 12:47 PM, Mike Looijmans wrote:
> The driver calls i2c_add_adapter before writing to config registers,
> resulting in dmesg output like this, where devices fail to initialize:
> 
> cdns-i2c ff030000.i2c: timeout waiting on completion
> pca953x 1-0041: failed reading register
> pca953x: probe of 1-0041 failed with error -110
> at24 1-0050: 512 byte 24c04 EEPROM, writable, 1 bytes/write
> cdns-i2c ff030000.i2c: 100 kHz mmio ff030000 irq 197
> 
> The adapter is being used before it completed the "probe". To fix
> this, make "i2c_add_adapter" the last thing it calls in probe.
> It also makes sense to show the adapter initialization before
> the devices on the bus.

commonly "it also" in a commit message means a change, which should be done
separately, and this is the case here as well.

Because the adapter registration i2c_add_adapter() can fail, information
about the adapter initialization would be expected only in case of
successful registration.

The information sent to the kernel log buffer here is quite trivial,
probably dev_info() can be just removed, but in any case it should be
a separate change.

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

--
With best wishes,
Vladimir
