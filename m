From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] i2c: piix4: Use usleep_range()
Date: Mon, 12 Feb 2018 13:35:26 -0800
Message-ID: <1518471326.22190.8.camel@perches.com>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
         <1514652658-6228-2-git-send-email-linux@roeck-us.net>
         <20180212115336.4b828ab8@endymion> <20180212205959.GA27573@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180212205959.GA27573@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, =?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?= <zboszor@pr.hu>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2018-02-12 at 12:59 -0800, Guenter Roeck wrote:
> On Mon, Feb 12, 2018 at 11:53:36AM +0100, Jean Delvare wrote:
> > On Sat, 30 Dec 2017 08:50:58 -0800, Guenter Roeck wrote:
> > > The piix4 i2c driver is extremely slow. Replacing msleep()
> > > with usleep_range() increases its speed substantially.
[]
> > > diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
[]
> > > @@ -467,13 +467,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
> > >  
> > >  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
> > >  	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
> > > -		msleep(2);
> > > +		usleep_range(2000, 2000);

usleep_range without a range isn't particularly useful.
Perhaps a 100 uSec range would allow better scheduling.

		usleep_range(2000, 2100);
