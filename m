From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH i2c-tools] tools/Module.mk: Add missing dependencies
Date: Thu, 14 Dec 2017 08:53:28 +0100
Message-ID: <20171214085328.4244e4d5@endymion>
References: <20171212213355.5f25754e@endymion>
        <CA+_SqVY_3mrB17KWFaJYJefb7wpeYi5MhRXpcMoyQfGi1eQ0fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbdLNHxb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 14 Dec 2017 02:53:31 -0500
In-Reply-To: <CA+_SqVY_3mrB17KWFaJYJefb7wpeYi5MhRXpcMoyQfGi1eQ0fQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Angelo Compagnucci <angelo@amarulasolutions.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>

On Wed, 13 Dec 2017 11:36:31 +0100, Angelo Compagnucci wrote:
> On Tue, Dec 12, 2017 at 9:33 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > Better build the library before building the tools which link against
> > it, otherwise parallel builds could run into a race and break.  
> 
> Tested-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> Acked-by: Angelo Compagnucci <angelo@amarulasolutions.com>

Thank you Angelo, your review and testing is highly appreciated :-)

Fix committed.

-- 
Jean Delvare
SUSE L3 Support
