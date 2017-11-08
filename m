From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools: i2cbusses: Avoid buffer overflows in sysfs paths
Date: Wed, 8 Nov 2017 22:14:20 +0100
Message-ID: <20171108221420.29f38dca@endymion>
References: <20171031081604.18a9ca54@endymion>
        <20171106120426.lyo6azbrxxok4gan@pengutronix.de>
        <20171108095752.300e95c6@endymion>
        <20171108092959.a5niuh3z4ftgzj53@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50953 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753048AbdKHVOX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 8 Nov 2017 16:14:23 -0500
In-Reply-To: <20171108092959.a5niuh3z4ftgzj53@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>

On Wed, 8 Nov 2017 10:29:59 +0100, Uwe Kleine-König wrote:
> Hello Jean,
> 
> On Wed, Nov 08, 2017 at 09:57:52AM +0100, Jean Delvare wrote:
> > > > --- a/tools/i2cbusses.c
> > > > +++ b/tools/i2cbusses.c
> > > > @@ -220,18 +220,18 @@ struct i2c_adap *gather_i2c_busses(void)
> > > >  
> > > >  		/* this should work for kernels 2.6.5 or higher and */
> > > >  		/* is preferred because is unambiguous */
> > > > -		sprintf(n, "%s/%s/name", sysfs, de->d_name);
> > > > +		snprintf(n, NAME_MAX, "%s/%s/name", sysfs, de->d_name);    
> > > 
> > > OK, now instead of running in a buffer overflow in sprintf you might
> > > call fopen with a partial (maybe unterminated?) filename. While this is
> > > definitively better, you should check the return value of snprintf to be
> > > completely safe here.  
> > 
> > To be honest, I never thought the buffer overflows could ever happen,
> > my motivation to fix them was to allow the code to build in OBS, where
> > FORTIFY_SOURCE is enabled. So I went for the most simple change that
> > made gcc happy.
> > 
> > That being said, I have no problem additionally checking the value
> > returned by snprintf. Something like this?
> > 
> > From: Jean Delvare
> > Subject: i2cbusses: Check the return value of snprintf
> > 
> > It's very unlikely that these paths will ever be truncated, but
> > better safe than sorry.
> > ---
> >  tools/i2cbusses.c |   34 ++++++++++++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> > 
> > --- i2c-tools.orig/tools/i2cbusses.c	2017-11-02 16:17:50.698383029 +0100
> > +++ i2c-tools/tools/i2cbusses.c	2017-11-08 09:49:40.365339644 +0100
> > @@ -137,7 +137,7 @@ struct i2c_adap *gather_i2c_busses(void)
> >  	FILE *f;
> >  	char fstype[NAME_MAX], sysfs[NAME_MAX], n[NAME_MAX];
> >  	int foundsysfs = 0;
> > -	int count=0;
> > +	int len, count = 0;
> >  	struct i2c_adap *adapters;
> >  
> >  	adapters = calloc(BUNCH, sizeof(struct i2c_adap));
> > @@ -220,18 +220,32 @@ struct i2c_adap *gather_i2c_busses(void)
> >  
> >  		/* this should work for kernels 2.6.5 or higher and */
> >  		/* is preferred because is unambiguous */
> > -		snprintf(n, NAME_MAX, "%s/%s/name", sysfs, de->d_name);
> > +		len = snprintf(n, NAME_MAX, "%s/%s/name", sysfs, de->d_name);
> > +		if (len >= NAME_MAX) {
> > +			fprintf(stderr, "%s: path truncated\n", n);
> > +			continue;
> > +		}  
> 
> According to C99 snprintf et al return "the number of characters which
> would have been written to the final string if enough space had been
> available". Up to glibc 2.0.6 -1 was returned though if the output was
> truncated. Does one still have to show consideration for a libc that
> old? Hmm, probably not.

I think we don't care, especially when nothing terribly bad would
happen then - simply back to the old behavior.

> Then your change looks fine.

Thanks for the review, I'll commit it.

-- 
Jean Delvare
SUSE L3 Support
