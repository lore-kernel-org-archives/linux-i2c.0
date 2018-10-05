From: "George G. Davis" <ggdavisiv@gmail.com>
Subject: Re: [PATCH] i2c: core: squelch error: uninitialized symbol 'ret'
Date: Fri, 5 Oct 2018 12:45:20 -0400
Message-ID: <20181005164520.GA2617@gandalf.middle.earth.net>
References: <20181005161826.2455-1-george_davis@mentor.com>
 <20181005162841.wy4uyespwcvffkpc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005162841.wy4uyespwcvffkpc@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "George G. Davis" <george_davis@mentor.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 05, 2018 at 06:28:41PM +0200, Wolfram Sang wrote:
> On Fri, Oct 05, 2018 at 12:18:25PM -0400, George G. Davis wrote:
> > The following smatch error was introduced by commit 7ca5f6be7900 ("i2c:
> > recovery: add get_bus_free callback"):
> > 
> > drivers/i2c/i2c-core-base.c:228 i2c_generic_scl_recovery() error: uninitialized symbol 'ret'.
> > 
> > Analysis of the code appears to show that the smatch error is a false
> > positive since 'ret' will in fact be initialized after exiting the
> > 'while()' loop.
> > 
> > Squelch the smatch error since it is a false positive.
> 
> What about fixing smatch?

That would perhaps be the better long term solution. Something tells me
that this topic comes up periodically. : ) For the record, I've
confirmed that this problem exists while using the latest version of
smatch [1] but I doubt my abilities to fix smatch. So I chose to squelch
it instead.

Feel free to ignore if this is a topic already discussed in other
threads. To be honest, I did not search the mailing list to determine if
this particular issue was already discussed.  


--
Regards,
George

[1] https://repo.or.cz/smatch.git/commit/79fe36620a7a3a45d1a51d62238da250fb8db920
> 
> > 
> > Fixes: 7ca5f6be7900 ("i2c: recovery: add get_bus_free callback")
> > Signed-off-by: George G. Davis <george_davis@mentor.com>
> > ---
> >  drivers/i2c/i2c-core-base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 9ee9a15e7134..7b25ecb6b616 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -185,7 +185,7 @@ static int i2c_generic_bus_free(struct i2c_adapter *adap)
> >  int i2c_generic_scl_recovery(struct i2c_adapter *adap)
> >  {
> >  	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
> > -	int i = 0, scl = 1, ret;
> > +	int i = 0, scl = 1, uninitialized_var(ret);
> >  
> >  	if (bri->prepare_recovery)
> >  		bri->prepare_recovery(adap);
> > -- 
> > 2.14.4
> > 
