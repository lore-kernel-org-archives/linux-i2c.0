From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] i2c: piix4: Use usleep_range()
Date: Mon, 12 Feb 2018 12:59:59 -0800
Message-ID: <20180212205959.GA27573@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <1514652658-6228-2-git-send-email-linux@roeck-us.net>
 <20180212115336.4b828ab8@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180212115336.4b828ab8@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Mon, Feb 12, 2018 at 11:53:36AM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sat, 30 Dec 2017 08:50:58 -0800, Guenter Roeck wrote:
> > The piix4 i2c driver is extremely slow. Replacing msleep()
> > with usleep_range() increases its speed substantially.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/i2c/busses/i2c-piix4.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> > index 78dd5951d6e7..52a8b1c5c110 100644
> > --- a/drivers/i2c/busses/i2c-piix4.c
> > +++ b/drivers/i2c/busses/i2c-piix4.c
> > @@ -467,13 +467,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
> >  
> >  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
> >  	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
> > -		msleep(2);
> > +		usleep_range(2000, 2000);
> 
> Isn't this exactly the same? I'm fine using the same function for
> consistency, just curious.
> 
No, it isn't. msleep() tends to sleep much longer then requested.
uspeep_range() tends to be much more accurate.

> >  	else
> > -		msleep(1);
> > +		usleep_range(500, 1000);
> 
> Were you able to test this on older hardware? Unfortunately, the

No, the only AMD CPUs I have are Ryzen.

> specification errata of the original Intel PIIX4 is quite vague on the
> amount of time you must wait before checking the Host Busy bit:
> 
> "Note that there may be moderate latency before the transaction begins
> and the Host Busy bit gets set."
> 
> I guess we made it 1 ms at the time because it was the minimum we could
> sleep anyway.
> 
> One option if you really care about the performance of the i2c-piix4
> driver on recent hardware would be to lower the initial delay even more
> for ATI and AMD chipsets. The errata was for Intel chipsets originally,
> and while we know that at least some of the ServerWorks implementations
> suffered from the same problem (worse actually) I don't think that
> anybody ever bothered checking if it applied to more recent
> implementations by other vendors.
> 
> For reference, at 93.75 kHz (the default SMBus frequency or the SB800),
> an SMBus Quick transaction would be completed in 117 us, so I guess an
> initial delay of 150 or 200 us would be optimum. And an SMBus Read Byte
> transaction completes in 416 ms. I think this is the most popular SMBus
> transaction, so ensuring that it is as fast as possible would make
> sense.
> 
> And it might even work on older Intel chipsets, who knows. Plus I doubt
> anyone is still using them anyway, so you have my approval to lower the
> delays to whatever works for you.
> 
> As a comparison point, in the i2c-i801 driver we use:
> 
> 	usleep_range(250, 500);
> 
> for both the initial sleep and the waiting loop.
> 
> >  
> >  	while ((++timeout < MAX_TIMEOUT) &&
> >  	       ((temp = inb_p(SMBHSTSTS)) & 0x01))
> > -		msleep(1);
> > +		usleep_range(200, 500);
> 
> Note that you are also drastically reducing the effective timeout value
> here, because it is a counter and not an overall time. Beforehand, we
> would wait for at least 501 ms for the transaction to complete. Now
> this could be down to only 100 ms. That being said, if my math is
> right, the longest supported transaction (Block Read) at the slowest
> allowed SMBus clock speed (10 kHz) would be done in 33 ms, so we are
> still good.
> 
> >  
> >  	/* If the SMBus is still busy, we give up */
> >  	if (timeout == MAX_TIMEOUT) {
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
Not sure I follow, overall. What changes, if any, do you expect me to make ?

Thanks,
Guenter

> -- 
> Jean Delvare
> SUSE L3 Support
