From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 26/26] docs: i2c: rename sections so the overall picture
 is clearer
Date: Thu, 16 Jan 2020 10:49:07 +0100
Message-ID: <20200116104907.3f2de4d0@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200106074905.14438-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbgAPJtL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 16 Jan 2020 04:49:11 -0500
In-Reply-To: <20200106074905.14438-1-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

On Mon,  6 Jan 2020 08:49:05 +0100, Luca Ceresoli wrote:
> Some of the section names are not very clear. Reading those names in the
> index.rst page does not help much in grasping what the content is supposed
> to be.
> 
> Rename those sections to clarify their content, especially when reading
> the index page.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Acked-by: Peter Rosin <peda@axentia.se>
> ---
> 
> Note: here checkpatch complains:
> 
>   WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 
> Thas's because those files have no license line. I would gladly add a
> proper license line, but what it the correct license here? Should I ask the
> authors? GPLv2-only as the kernel default?
> 
> I'd appreciate a guidance here, thanks in advance.

I don't think we need a license for such documentation files, so I
would just ignore checkpatch.

> ---
>  Documentation/i2c/dev-interface.rst         | 6 +++---
>  Documentation/i2c/i2c-protocol.rst          | 6 +++---
>  Documentation/i2c/i2c-topology.rst          | 6 +++---
>  Documentation/i2c/old-module-parameters.rst | 6 +++---
>  Documentation/i2c/smbus-protocol.rst        | 6 +++---
>  Documentation/i2c/summary.rst               | 6 +++---
>  Documentation/i2c/writing-clients.rst       | 6 +++---
>  7 files changed, 21 insertions(+), 21 deletions(-)
> (...)
> diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
> index fc69d9567d9d..ae3bbb9fd8f1 100644
> --- a/Documentation/i2c/summary.rst
> +++ b/Documentation/i2c/summary.rst
> @@ -1,6 +1,6 @@
> -=============
> -I2C and SMBus
> -=============
> +==============================
> +Introductions to I2C and SMBus
> +==============================

I would use "Introduction", singular.

>  
>  I²C (pronounce: I squared C and written I2C in the kernel documentation) is
>  a protocol developed by Philips. It is a slow two-wire protocol (variable
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
