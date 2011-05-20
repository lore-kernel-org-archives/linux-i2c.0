From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: How to use one I2C device from two modules?
Date: Fri, 20 May 2011 10:07:19 +0200
Message-ID: <20110520100719.4107397a@endymion.delvare>
References: <20110513104650.3d1b3ea6@endymion.delvare>
	<184526.31465.qm@web30201.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <184526.31465.qm-hgS9n0fW3jyvuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars Michael <lh_post-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lars,

On Mon, 16 May 2011 01:10:22 -0700 (PDT), Lars Michael wrote:
> --- On Fri, 13/5/11, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > No, this doesn't seem right. A given system may have more
> > than one PCA950x chip. And symbol dependencies are a hell
> > to handle as soon as things get more complex. Such an export
> > will never be accepted upstream.
> 
> You are right, and this quick solution was not meant to be submitted.
>  
> > I can think of 2 ways to handle your problem.
> > 
> > If neither works for you for whatever reason, maybe we can
> > add a helper function to i2c-core to retrieve an i2c_client
> > by bus number and address. Maybe others would find it useful
> > as well.
> 
> I was looking for such a function, it could be very handy. And btw
> a get adapter by id already exists. 

This function could certainly be added if someone ever really needs it.
But in your case, it seems better to write a proper gpio driver for your
device and then have your subdrivers cleanly request the GPIO pins they
need. And you don't need to access the i2c_client from the subdrivers
if you do this.

-- 
Jean Delvare
