From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: busses: i2c-pxa.c:  Fix for possible null pointer
 dereference
Date: Mon, 02 Jun 2014 10:55:43 +0900
Message-ID: <004801cf7e05$c3354c20$499fe460$%han@samsung.com>
References: <1400346848-25098-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <20140601202647.GD3853@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140601202647.GD3853@katana>
Content-language: ko
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Rickard Strandqvist' <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>, 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Grant Likely' <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rob Herring' <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Leilei Shang' <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, 'Daniel Drake' <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, June 02, 2014 5:27 AM, Wolfram Sang wrote:
> On Sat, May 17, 2014 at 07:14:08PM +0200, Rickard Strandqvist wrote:
> > There is otherwise a risk of a possible null pointer dereference.
> >
> > Was largely found by using a static code analysis program called cppcheck.
> 
> It is useful to put the output of the analyzer here.
> 
> >
> > Signed-off-by: Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-pxa.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> > index bbe6dfb..dbe5ebe 100644
> > --- a/drivers/i2c/busses/i2c-pxa.c
> > +++ b/drivers/i2c/busses/i2c-pxa.c
> > @@ -1269,7 +1269,9 @@ eremap:
> >  eclk:
> >  	kfree(i2c);
> >  emalloc:
> > -	release_mem_region(res->start, resource_size(res));
> > +	if(res) {
> > +		release_mem_region(res->start, resource_size(res));
> > +	}
> 
> The proper fix is to move the release to the proper place, before kfree.
> Even better would probably be a devm_* conversion.

+1

I agree with Wolfram Sang's opinion. Please call release_mem_region()
prior to kfree().

One more thing, don't use braces when a single statement
is used. Please refer to 'Chapter 3: Placing Braces and Spaces'
of 'Documentation/CodingStyle'.

Best regards,
Jingoo Han

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
