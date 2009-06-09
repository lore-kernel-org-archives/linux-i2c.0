From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH, RFC] Freescale STMP: i2c driver
Date: Tue, 9 Jun 2009 09:46:06 +0200
Message-ID: <20090609094606.18f04523@hyperion.delvare>
References: <1244059155.4074.19.camel@hp.diimka.lan>
	<20090608225034.GA20446@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090608225034.GA20446-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 8 Jun 2009 23:50:34 +0100, Ben Dooks wrote:
> On Wed, Jun 03, 2009 at 11:59:15PM +0400, dmitry pervushin wrote:
> > +static const u32 I2C_READ = 1,
> > +		 I2C_WRITE = 0;
> 
> do you really want to be defining things with a prefix of I2C, that
> might end up clashing with the i2c core?

Definitely not. Please just use I2C_SMBUS_READ and I2C_SMBUS_WRITE
which are already defined by <linux/i2c.h>.

(One might argue these are unfortunate names, but that's what we have
at the moment so let's just use it.)

-- 
Jean Delvare
