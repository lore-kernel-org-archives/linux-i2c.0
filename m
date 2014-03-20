From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: platform_data in i2c device drivers
Date: Thu, 20 Mar 2014 18:51:49 +0100
Message-ID: <2925352.e7jTXf8P58@avalon>
References: <532A1B12.8080400@yahoo.com> <532B1689.3080202@codethink.co.uk> <532B2273.8040004@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <532B2273.8040004-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Bormann <fbormann-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Thursday 20 March 2014 13:16:35 Frank Bormann wrote:
> Hi Ben,
> 
> > I think client->dev should be avoided if at-all possible. Many
> > drivers keep their own local copy of platform data or the pointer
> > to it in their driver private information.
> 
> I was thinking about that. But then again, I'd either have to copy the
> client->dev.platform_data pointer over to the private data, if it is
> non-null, or I would have to use some variation of
> 
> pdata = client->dev.platform_data ? client->dev.platform_data : priv_pd;
> 
> every time I want to access the configuration. Guess, that's not so bad
> though.

Most drivers store a pointer to the platform data or a copy of the platform 
data in a per-device driver private structure. They populate that pointer or 
copy from the platform data pointer (in the legacy case) or from the device 
tree content. Outside of the probe function the driver thus only accesses its 
private pointer or copy.

-- 
Regards,

Laurent Pinchart
