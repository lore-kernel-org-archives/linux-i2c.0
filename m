From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V3] i2c: davinci: update to devm_* API
Date: Fri, 15 Feb 2013 20:09:43 +0100
Message-ID: <20130215190943.GB4351@the-dreams.de>
References: <1360241520-11476-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360241520-11476-1-git-send-email-manishv.b-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 07, 2013 at 06:22:00PM +0530, Vishwanathrao Badarkhe, Manish wrote:
> Update the code to use devm_* API so that driver
> core will manage resources.
> Also, if "devm_request_and_ioremap" fails return -EADDRNOTAVAIL
> instead of -EBUSY.
> 
> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b-l0cyMroinI0@public.gmane.org>

Basically OK, please resend when devm_ioremap_resource hits mainline in
3.9.

Thanks,

   Wolfram
