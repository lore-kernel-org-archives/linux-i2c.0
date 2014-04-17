From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-pca954x: allow downstream bus numbers to be specified
 in the dts
Date: Thu, 17 Apr 2014 23:30:21 +0530
Message-ID: <535016B5.7060006@nvidia.com>
References: <532A1B12.8080400@yahoo.com> <1511928.3cA2QKoAZt@avalon> <534FF708.7040409@yahoo.com> <1736074.QFiloDzhqn@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1736074.QFiloDzhqn@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Frank Bormann <fbormann-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 17 April 2014 09:16 PM, Laurent Pinchart wrote:
> +       u32 fixed_bus_numbers[PCA954X_MAX_NCHANS] = { 0 };
>           int ret;
>
>           if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
> @@ -214,6 +215,17 @@ static int pca954x_probe(struct i2c_client *client,
>                           if (ret < 0)
>                                   return ret;
>                   }
> +
> +               /* Get fixed bus numbers */
> +               ret = of_property_read_u32_array(np, "fixed-bus-numbers",
> +                       fixed_bus_numbers, chips[id->driver_data].nchans);
> +               if (ret == -EINVAL)
> +                       ret = 0;        /* missing dtb node is not an error
> */ +               if (ret < 0) {
> +                       dev_err(&client->dev, "fixed-bus-numbers: "
> +                       "invalid format\n");
> +                       return ret;
> +               }
>           }
>

Hi Frank,
Why not you use aliases on DTS instead of changing driver?
You can alias the bus number with the child node name. On the following, 
the bus will be registerd as 6, 7, 8 and 9.
i2c-core already support this.

         aliases {
                 i2c6 = &pca9546_i2c0;
                 i2c7 = &pca9546_i2c1;
                 i2c8 = &pca9546_i2c2;
                 i2c9 = &pca9546_i2c3;
         };


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
