From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-pca954x: allow downstream bus numbers to be specified in the dts
Date: Thu, 17 Apr 2014 22:42:38 +0200
Message-ID: <8371876.lo7y6gzeI1@avalon>
References: <532A1B12.8080400@yahoo.com> <1548213.kKeUuTimZc@avalon> <CAE6_GsvJpajY==6MJExo3T7FrVF_LNGcoozq0N5KEBho9y5NWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAE6_GsvJpajY==6MJExo3T7FrVF_LNGcoozq0N5KEBho9y5NWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Bormann <frankbormann0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Thursday 17 April 2014 16:26:04 Frank Bormann wrote:
> A user-space application, which is being configured with the first mux bus
> number, executes i2cget/i2cset commands, specifying the i2c bus number and
> expecting them to be incremental from the first number.

I won't venture to comment on whether bus numbering has ever been considered 
to be a kernel ABI, other people should be able to comment on that. Any chance 
to fix the application to find the bus numbers dynamically ?

> On Thu, Apr 17, 2014 at 4:15 PM, Laurent Pinchart wrote:
> > On Thursday 17 April 2014 13:54:44 Frank Bormann wrote:
> > > Hi Laurent,
> > > 
> > > I have a pca9546 on one of my i2c buses. This will create four mux buses
> > > in Linux. One of those mux buses then has a pca9542 connected to it,
> > > creating another two mux buses on top of the first ones.
> > > 
> > > The 3.8 kernel, I was initially using enumerated, this as:
> > > 
> > > pca9546: 3, 4, 5, 6
> > > pca9542: 7, 8
> > > 
> > > However, the new 3.12 kernel, I am using now, has changed that
> > > enumeration to:
> > > 
> > > pca9546: 3, 4, 7, 8
> > > pca9542: 5, 6
> > > 
> > > As you may imagine, the pca9542 is connected to bus 4. Apparently,
> > > previously, it would finish the initalization of pca9546 before dealing
> > > with the pca9542. Now it seems to do the pca9542 initialization as soon
> > > as it sees it on mux bus 4. My application however expects the pca9546
> > > buses to be on incremental bus numbers.
> > 
> > I understand that the bus numbers changed, but you still haven't explain
> > *why* you need to have fixed bus numbers. Why do you need to know the bus
> > number at all ?

-- 
Regards,

Laurent Pinchart
