From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] libi2c: Add a manual page to document the API
Date: Thu, 23 Jan 2020 11:17:40 +0100
Message-ID: <20200123111740.728666a7@endymion>
References: <20200123105246.67732e33@endymion>
        <20200123110355.4cb793ce@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgAWKRn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Jan 2020 05:17:43 -0500
In-Reply-To: <20200123110355.4cb793ce@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Lei YU <mine260309@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Luca Ceresoli <luca@lucaceresoli.net>

On Thu, 23 Jan 2020 11:03:55 +0100, Jean Delvare wrote:
> It is good practice for a library to come with a complete API description.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>  lib/libi2c.3 |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> (...)

I just realized I forgot the integration with the Makefile so that the
manual page will get installed. Sorry about that, I'll fix that in v2.

-- 
Jean Delvare
SUSE L3 Support
