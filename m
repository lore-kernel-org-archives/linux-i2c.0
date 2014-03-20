From: Frank Bormann <fbormann-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: platform_data in i2c device drivers
Date: Thu, 20 Mar 2014 13:16:35 -0400
Message-ID: <532B2273.8040004@yahoo.com>
References: <532A1B12.8080400@yahoo.com> <1511928.3cA2QKoAZt@avalon> <532B1367.8050906@yahoo.com> <532B1689.3080202@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <532B1689.3080202-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

> I think client->dev should be avoided if at-all possible. Many
> drivers keep their own local copy of platform data or the pointer
> to it in their driver private information.

I was thinking about that. But then again, I'd either have to copy the 
client->dev.platform_data pointer over to the private data, if it is non-null, 
or I would have to use some variation of

pdata = client->dev.platform_data ? client->dev.platform_data : priv_pd;

every time I want to access the configuration. Guess, that's not so bad though.

Thanks,
Frank
