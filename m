From: Frank Bormann <frankbormann0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-pca954x: allow downstream bus numbers to be specified
 in the dts
Date: Tue, 22 Apr 2014 17:46:04 -0400
Message-ID: <5356E31C.6000304@gmail.com>
References: <532A1B12.8080400@yahoo.com> <1511928.3cA2QKoAZt@avalon> <534FF708.7040409@yahoo.com> <1736074.QFiloDzhqn@avalon> <535016B5.7060006@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <535016B5.7060006-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 17/04/14 02:00 PM, Laxman Dewangan wrote:
> Hi Frank,
> Why not you use aliases on DTS instead of changing driver?
> You can alias the bus number with the child node name. On the following, the bus
> will be registerd as 6, 7, 8 and 9.
> i2c-core already support this.
>
>          aliases {
>                  i2c6 = &pca9546_i2c0;
>                  i2c7 = &pca9546_i2c1;
>                  i2c8 = &pca9546_i2c2;
>                  i2c9 = &pca9546_i2c3;
>          };

Well, this seems to work indeed for newer kernels. I was originally working on 
3.8 that did not yet have this feature. However, this is kind of an hard to find 
feature. I didn't see any references in the i2c device tree bindings 
documentation. So, unless you actually read the i2c core code, it is very easy 
to miss.

Anyway, feel free to disregard my patch.

Frank
