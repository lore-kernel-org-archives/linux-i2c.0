From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: rename "i2c_recover_bus" function
Date: Thu, 4 Apr 2013 22:42:41 +0200
Message-ID: <20130404204241.GA3514@the-dreams.de>
References: <201304041354.30024.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201304041354.30024.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 04, 2013 at 01:54:29PM +0000, Arnd Bergmann wrote:
> As of commit 5f9296ba "i2c: Add bus recovery infrastructure", there
> is now a global function with the same name, which clashes with
> the davinci specific one. The obvious solution is to rename the
> function with a davinci prefix.
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

adf68acf387a203d76315d72b36b829bde1d01b6 in linux-next of today.

Thanks!
