From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH 0/3] i2c-axxia: support Sequence command
Date: Mon, 10 Dec 2018 15:00:17 +0000
Message-ID: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <C803EC27A8711D44BDD9335C563E21C2@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

Hi Woflram,

This patch was based on your i2c/for-current branch as it adds to my
patch you incuded there. First two patches are just preparations and the
3rd one which is the actual change. It allows us using hardware mode to
send i2c transfers consisting for a write followed by read without the
need of the CPU interaction inbetween which is an opportunity to trigger
25ms SMbus timeout and abort transaction.

--------------------------------------------------------------------
Krzysztof Adamski (3):
  i2c-axxia: dedicated function to set client addr
  i2c-axxia: check for error conditions first
  i2c-axxia: support sequence command mode

 drivers/i2c/busses/i2c-axxia.c | 159 ++++++++++++++++++++++++++-------
 1 file changed, 126 insertions(+), 33 deletions(-)

--=20
2.17.2
