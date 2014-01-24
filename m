From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Standardize log messages
Date: Fri, 24 Jan 2014 18:01:39 +0100
Message-ID: <20140124180139.2ed5c598@endymion.delvare>
References: <20140123165938.493ea62c@endymion.delvare>
	<20140124165154.GC2629@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140124165154.GC2629@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 24 Jan 2014 17:51:54 +0100, Wolfram Sang wrote:
> On Thu, Jan 23, 2014 at 04:59:38PM +0100, Jean Delvare wrote:
> > Use exactly the same log messages in the legacy setup function and the
> > SB800+ setup function. This way strings can be reused, which saves
> > some bytes in the generated binary.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
> 
> Subject is wrong. This is about piix4, not i801.
> Fixed and applied to for-current, thanks!

D'oh! Working too much on the same driver over the years I guess.
Anyway, thanks for catching my mistake.

-- 
Jean Delvare
