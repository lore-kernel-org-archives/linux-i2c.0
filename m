From: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH v3 2/5] i2c: Add STM32F4 I2C driver
Date: Wed, 30 Nov 2016 17:23:53 +0100
Message-ID: <20161130162353.GC1441@katana>
References: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
 <1466439771-2741-3-git-send-email-cedric.madianga@gmail.com>
 <20160722070219.GB1605@katana>
 <CAOAejn0BZNH82kY_7UR1EjV7M1G+9jGihGb4-uCs9=XiPHUYxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOAejn0BZNH82kY_7UR1EjV7M1G+9jGihGb4-uCs9=XiPHUYxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> I was too busy in another project but now I am ready to complete the
> upstream of the STM32F4 I2C driver.

Nice.

> >> +static void stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     u32 clk_rate, cr2, freq;
> >> +
> >> +     cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> >> +     cr2 &= ~STM32F4_I2C_CR2_FREQ_MASK;
> >> +
> >> +     clk_rate = clk_get_rate(i2c_dev->clk);
> >> +     freq = clk_rate / MHZ_TO_HZ;
> >> +
> >> +     if (freq > STM32F4_I2C_MAX_FREQ)
> >> +             freq = STM32F4_I2C_MAX_FREQ;
> >> +     if (freq < STM32F4_I2C_MIN_FREQ)
> >> +             freq = STM32F4_I2C_MIN_FREQ;
> >
> > clamp() to enforce the range?
> Sorry but what do you mean by "clamp()" ?

The kernel has a clamp() function which would fit this purpose, I think.

Regards,

   Wolfram


--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPv0ZAAoJEBQN5MwUoCm2SZIQAJTE3hJprlSgsvvRWdPtE9MW
4hwhZ22xtAvGEcPyZZdQdYAR6KR0zYqc2o7PHi9rFcF0RExJ4kKdKRJW+81+toHa
utVYhwEDtRSdcvoeJhslNlXS2RXIUGKJu/xKp8bNCmvqlF4tLUvBdRk7N8DoBhjK
1eTiYmei7d9cqY4vB8Fb/TJ/Jr59CNtN/1DFexznuG3Lmv6ZaDc4kdZTCauQLnoY
kJtZmGxweXKJW3JWRxstiKAylmG3NGJp9Fo70XR9r+T0kqlndqe4M8rGtxlLRUWA
hal08rqInImkrdVsExCQlXGtPfdNu15KhY4XLrABA03z1Vr1Bhkt1B4NUm6OaQ9y
1GPTzxSIb5TfRnNxq2d6IF++9cPYR7V5HoCntnc6nH9vk4/RupUDITTSpI39UGGp
YfKnkW7oKra3+M11GXeNfTnfSjJXlMCeSXtvyIwwGiOwRHzPLbE9JUWVCqkyKd1j
7S1P6J+tQgyNQ/HelBckdQNgE8a9K1XClzOtZFf2yFaBETyUJGQjyYOcMYz7E41e
BFkXa72sYAVR62e6xtbht1kAZAb3u6gysaj3Py0PpPls0bjbf+JGX84S7PQAYO7g
qo/aqGSwkuDnsFYeCBqbJrXvhZS6Mrx/ihoD1bXwhCLA5Bnpwho7yNprTazaSmf8
MPNsuER2yyjZ0MdYnRAR
=g3Ap
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
