From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Fix SMBus ENXIO on resume from suspend.
Date: Mon, 20 Nov 2017 10:15:14 +0100
Message-ID: <20171120101514.62239b4f@endymion>
References: <20171115170156.21532-1-alban.browaeys@gmail.com>
        <1510777525.21208.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbdKTJPR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Nov 2017 04:15:17 -0500
In-Reply-To: <1510777525.21208.4.camel@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alban Browaeys <alban.browaeys@gmail.com>, Volker =?UTF-8?B?UsO8bWVs?= =?UTF-8?B?aW4=?= <vr_qemu@t-online.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Wed, 15 Nov 2017 21:25:25 +0100, Alban Browaeys wrote:
> This fix is a partial one: it only fixes the issue once
> we unload then reload i2c-i801 .
> This as when we load a second time  orig_hstcfg is set to the value the
> first module load leftover.
> Thus I will investigate the initial orig_hstcfg at boot to further the
> fix.
> I bet this only a few missing bits like HST_EN.

Volker, I think you had a fix for that one? But I can't find it in the
list archive :-(

-- 
Jean Delvare
SUSE L3 Support
