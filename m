From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Fix typo in ioctl name reference
Date: Thu, 10 Sep 2015 23:30:36 +0200
Message-ID: <20150910233036.0d2c9f35@endymion.delvare>
References: <20150908110549.411e99a8@endymion.delvare>
	<20150910180012.GA2893@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150910180012.GA2893@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 10 Sep 2015 20:00:12 +0200, Wolfram Sang wrote:
> On Tue, Sep 08, 2015 at 11:05:49AM +0200, Jean Delvare wrote:
> > The ioctl is named I2C_RDWR for "I2C read/write". But references to it
> > were misspelled "rdrw". Fix them.
> > 
> > Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> 
> Wow! Amazing how long this went unnoticed/unfixed.

Indeed :/

I don't think this constant was much (or ever) used in user-space
before i2ctransfer. That would be why.

> > -#define  I2C_RDRW_IOCTL_MAX_MSGS	42
> > +#define  I2C_RDWR_IOCTL_MAX_MSGS	42
> > +/* Originally defined with a typo, keep if for now for compatibility */
> 
> I would drop the 'for now' and keep it forever. A define doesn't hurt
> and if it increases backwards compatibility, why not? I will also do
> s/if/it/. No need to resend.

Sorry for the typo and thanks for catching it. "for now" or not is up
to you, my idea was that it probably wasn't used in user-space yet so
getting rid of it shouldn't hurt, while keeping it would encourage
people to use the wrong one instead of the good one. So on second
thought a better strategy may be to NOT keep the compatibility in the
first place.

It's not an ABI change anyway, and it's a minor thing really. Nobody is
ever going to hit this limit in practice, and if one does and did not
check beforehand, he/she will simply get -EINVAL from ioctl(), which
can be reported to the user just the same. IMHO I2C_RDWR_IOCTL_MAX_MSGS
should not have been made visible from user-space in the first place.

> > +#define  I2C_RDRW_IOCTL_MAX_MSGS	I2C_RDWR_IOCTL_MAX_MSGS

-- 
Jean Delvare
SUSE L3 Support
