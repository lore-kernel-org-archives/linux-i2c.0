From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: platform_data in i2c device drivers
Date: Fri, 21 Mar 2014 17:01:20 +0100
Message-ID: <3083300.Xj9oJdUK5O@avalon>
References: <532A1B12.8080400@yahoo.com> <2925352.e7jTXf8P58@avalon> <532C60EC.3060405@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <532C60EC.3060405-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Bormann <fbormann-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Friday 21 March 2014 11:55:24 Frank Bormann wrote:
> Hi Laurent,
> 
> Thank you again for explaining. One last question if that's okay.
> 
> If I have i2c_board_info being passed in to the probe function through the
> platform_data pointer and I also have the same, similar or maybe even
> conflicting configuration information in the DTB, is there any of the two
> that is supposed to take precedence or should that be an error case?

That shouldn't happen (except in very special cases using OF_DEV_AUXDATA, but 
you really should think twice before going that way). If the I2C device is 
instantiated in board code with i2c_board_info then there will be no DT node 
corresponding to the device (client->dev.of_node will be NULL). If the device 
is instead instantiated from DT there will be no platform data (client-
>dev.platform_data will be NULL).

> On 20/03/14 01:51 PM, Laurent Pinchart wrote:
> > On Thursday 20 March 2014 13:16:35 Frank Bormann wrote:
> >> Hi Ben,
> >> 
> >>> I think client->dev should be avoided if at-all possible. Many
> >>> drivers keep their own local copy of platform data or the pointer
> >>> to it in their driver private information.
> >> 
> >> I was thinking about that. But then again, I'd either have to copy the
> >> client->dev.platform_data pointer over to the private data, if it is
> >> non-null, or I would have to use some variation of
> >> 
> >> pdata = client->dev.platform_data ? client->dev.platform_data : priv_pd;
> >> 
> >> every time I want to access the configuration. Guess, that's not so bad
> >> though.
> > 
> > Most drivers store a pointer to the platform data or a copy of the
> > platform data in a per-device driver private structure. They populate that
> > pointer or copy from the platform data pointer (in the legacy case) or
> > from the device tree content. Outside of the probe function the driver
> > thus only accesses its private pointer or copy.

-- 
Regards,

Laurent Pinchart
