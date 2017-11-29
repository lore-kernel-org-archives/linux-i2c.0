From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools: library licensing issues
Date: Wed, 29 Nov 2017 07:35:24 +0100
Message-ID: <20171129073524.5596967f@endymion>
References: <20171125164717.kg5vv6zsuztr3vkn@aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60525 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbdK2Gf1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Nov 2017 01:35:27 -0500
In-Reply-To: <20171125164717.kg5vv6zsuztr3vkn@aurel32.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-i2c@vger.kernel.org

Hi Aurélien,

On Sat, 25 Nov 2017 17:47:17 +0100, Aurelien Jarno wrote:
> I have been reviewing the i2c-tools licensing, and it seems there is a
> contradiction between README and lib/smbus.c about the library
> licensing:
> 
> From README:
> | The library is released under the LGPL version 2.1 or later, while most
> | tools are released under the GPL version 2 or later, but there are a few
> | exceptions.
> 
> From lib/smbus.c:
> | This program is free software; you can redistribute it and/or modify
> | it under the terms of the GNU General Public License as published by
> | the Free Software Foundation; either version 2 of the License, or
> | (at your option) any later version.
> 
> On the other hand, the license in lib/Module.mk matches the one from
> README.
> 
> I guess one of README or lib/smbus.c has to be fixed. Can someone
> clarify that? In meantime I think the library as a whole should be
> considered as GPL v2 or later.

Thanks for pointing out this inconsistency, which I missed. 


-- 
Jean Delvare
SUSE L3 Support
