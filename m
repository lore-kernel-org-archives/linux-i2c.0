From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 0/5] i2c: i2c-piix4: set of coding style fixes
Date: Thu, 13 Oct 2016 13:40:29 +0200
Message-ID: <20161013134029.1828048b@endymion>
References: <20161011172441.7422-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753878AbcJMLnD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 13 Oct 2016 07:43:03 -0400
In-Reply-To: <20161011172441.7422-1-palminha@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de

Hi Carlos,

On Tue, 11 Oct 2016 18:24:36 +0100, Carlos Palminha wrote:
> This patchset fixes several coding style issues.
> 
> Carlos Palminha (5):
>   i2c: i2c-piix4: coding style fix - '*' adjacent to data name
>   i2c: i2c-piix4: coding style fix - assignment in if condition
>   i2c: i2c-piix4: coding style fix - long comments blocks
>   i2c: i2c-piix4: coding style fix - spaces with open parenthesis
>   i2c: i2c-piix4: coding style fix - quoted string split across lines
> 
>  drivers/i2c/busses/i2c-piix4.c | 144 +++++++++++++++++++++++------------------
>  1 file changed, 82 insertions(+), 62 deletions(-)

Except for the two issues which were already pointed out, I'm fine with
these changes, however there is no good reason to split them into 5
separate patches. Fixing the coding style is one goal, it should be all
done with a single patch. So, when you resubmit, please do so as a
single patch.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
