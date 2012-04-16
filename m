From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: Re: [PATCH] i2c: Add support SuperH SH7734 I2C bus controller
Date: Mon, 16 Apr 2012 10:04:25 +0900
Message-ID: <4F8B7019.2030307@renesas.com>
References: <1334188641-14641-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <87d37d37ml.wl%kuninori.morimoto.gx@renesas.com>
 <CABMQnVKQAfdnQ+CfSuYSXQHmOyjQzPzngzTVLm6an2-haQAKZg@mail.gmail.com>
 <87y5q02cv2.wl%kuninori.morimoto.gx@renesas.com>
 <CABMQnVK8Jt1cZZA-w9xnfrMZNvRbe4r+Sjm3YeF3o6utX0g93Q@mail.gmail.com>
 <87aa2c7d2a.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <87aa2c7d2a.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Kuninori Morimoto =E3=81=95=E3=82=93=E3=81=AF=E6=9B=B8=E3=81=8D=E3=81=BE=
=E3=81=97=E3=81=9F:
> Hi Iwamatsu-san
>=20
>>> I guess R-Car is not same as this I2C.
>>> And sorry, SH7734 seems not same as SH-NAVI.
>>> Now I'm checking the series.
>>> Please wait.
>>>
>> I already checked SH7775 and SH7776. These are SH-NAVI series.
>> But these CPU's are constitution unlike I2C of SH7734.
>=20
> I got the information about it this morning.
> SH7734 I2C came from SH7266, and it came from SH-NaviJ3.
>=20

I comfirmed these, thanks.
OK, I will rename file and update description.

Best regards,
  Nobuhiro
