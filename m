From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 20/26] docs: i2c: instantiating-devices: fix internal
 hyperlink
Date: Tue, 21 Jan 2020 11:07:41 +0100
Message-ID: <20200121110741.347bad7a@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-20-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAUKHo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Jan 2020 05:07:44 -0500
In-Reply-To: <20200105225012.11701-20-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 23:50:06 +0100, Luca Ceresoli wrote:
> Use ReST syntax so that a proper hyperlink is generated.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/instantiating-devices.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/i2c/instantiating-devices.rst b/Documentation/i2c/instantiating-devices.rst
> index cf5d9828e823..5debaafef64d 100644
> --- a/Documentation/i2c/instantiating-devices.rst
> +++ b/Documentation/i2c/instantiating-devices.rst
> @@ -86,7 +86,7 @@ Method 1c: Declare the I2C devices via ACPI
>  -------------------------------------------
>  
>  ACPI can also describe I2C devices. There is special documentation for this
> -which is currently located at Documentation/firmware-guide/acpi/enumeration.rst.
> +which is currently located at :doc:`../firmware-guide/acpi/enumeration` .

You have an extra space before the dot, I don't think the ReST syntax
requires that?

>  
>  
>  Method 2: Instantiate the devices explicitly

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
