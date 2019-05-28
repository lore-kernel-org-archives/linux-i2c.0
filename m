From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/2] eeprom: at24: use devm_i2c_new_dummy_device()
Date: Tue, 28 May 2019 17:57:50 +0200
Message-ID: <CAMRc=MdcY0Qx2ZDM7ogwc8BH-cT61ovukg=U6G8k9ZDgR488UQ@mail.gmail.com>
References: <20190520071042.21072-1-brgl@bgdev.pl> <20190520071042.21072-2-brgl@bgdev.pl>
 <20190520130837.iglqohsyi5kyj55y@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520130837.iglqohsyi5kyj55y@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

pon., 20 maj 2019 o 15:08 Wolfram Sang <wsa@the-dreams.de> napisa=C5=82(a):
>
> On Mon, May 20, 2019 at 09:10:41AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Now that it's upstream, use the resource managed version
> > of i2c_new_dummy_device().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Looks good now (not tested, though):
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Thanks!
>

Applied.

Bart
