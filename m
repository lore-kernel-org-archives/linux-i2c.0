From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Only include slave support if selected
Date: Mon, 26 Jan 2015 19:53:21 +0100
Message-ID: <20150126195321.7f85e616@endymion.delvare>
References: <20150126190047.7bc44f26@endymion.delvare>
	<20150126180508.GB25317@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150126180508.GB25317@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 26 Jan 2015 19:05:09 +0100, Wolfram Sang wrote:
> On Mon, Jan 26, 2015 at 07:00:47PM +0100, Jean Delvare wrote:
> > Make the slave support depend on CONFIG_I2C_SLAVE. Otherwise it gets
> > included unconditionally, even when it is not needed.
> > 
> > Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > ---
> > Changes since v1:
> > * Let I2C_RCAR select I2C_SLAVE
> > 
> > Wolfram, you mentioned i2c-sh_mobile but that driver doesn't seem to
> > implement slave support in v3.19-rc6 so I did not include it. Feel free
> > to add more selects to drivers/i2c/busses/Kconfig to match the current
> > state of your i2c tree.
> 
> Sorry, my bad. I meant the RCAR driver which you spotted. What about the
> function pointers in the algo struct?

Doh, forgot about them once again. Stay tuned, patch v3 is coming...

-- 
Jean Delvare
SUSE L3 Support
