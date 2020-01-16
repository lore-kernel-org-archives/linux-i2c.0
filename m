From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 04/26] docs: i2c: call it "I2C" consistently
Date: Thu, 16 Jan 2020 10:39:29 +0100
Message-ID: <20200116103929.366c14e0@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-4-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgAPJjc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 16 Jan 2020 04:39:32 -0500
In-Reply-To: <20200105225012.11701-4-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 23:49:50 +0100, Luca Ceresoli wrote:
> Uppercase "I2C" is used almost everywhere in the docs, but the lowercase
> version "i2c" is used somewhere. Use the uppercase form consistently.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Acked-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/i2c/dev-interface.rst         | 18 +++---
>  Documentation/i2c/dma-considerations.rst    |  2 +-
>  Documentation/i2c/i2c-protocol.rst          |  4 +-
>  Documentation/i2c/i2c-topology.rst          | 66 ++++++++++-----------
>  Documentation/i2c/instantiating-devices.rst |  2 +-
>  Documentation/i2c/old-module-parameters.rst |  6 +-
>  Documentation/i2c/slave-interface.rst       |  4 +-
>  Documentation/i2c/writing-clients.rst       |  4 +-
>  8 files changed, 53 insertions(+), 53 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
