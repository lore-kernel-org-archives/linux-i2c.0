From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] eeprom: at24: use devm_i2c_new_dummy_device()
Date: Mon, 20 May 2019 08:14:23 +0200
Message-ID: <CAMpxmJW=T_hZAkyhsE+Wi7qhJBE2bviNfaGCJJta0s8g85+9Pg@mail.gmail.com>
References: <20190519204012.31861-1-brgl@bgdev.pl> <20190519204012.31861-2-brgl@bgdev.pl>
 <20190519205235.GA19630@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190519205235.GA19630@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

niedz., 19 maj 2019 o 22:52 Wolfram Sang <wsa@the-dreams.de> napisa=C5=82(a=
):
>
>
> > Now that it's upstream, use the resource managed version
> > of i2c_new_dummy().
>
> That was fast :)
>
> > -     dummy_client =3D i2c_new_dummy(base_client->adapter,
> > -                                  base_client->addr + index);
> > +     dummy_client =3D devm_i2c_new_dummy_device(dev, base_client->adap=
ter,
> > +                                              base_client->addr + inde=
x);
> >       if (!dummy_client) {
>
> Oh well, the confusion starts already :/ devm_i2c_new_dummy_device()
> returns an ERR_PTR.
>

Ugh, sorry for that, especially since I followed the discussion on
that series. :(

I should not be sending out patches late on Sundays I guess.

Bart
